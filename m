Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266644AbRGEHO6>; Thu, 5 Jul 2001 03:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266641AbRGEHOs>; Thu, 5 Jul 2001 03:14:48 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:46601 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S266640AbRGEHOn>;
	Thu, 5 Jul 2001 03:14:43 -0400
Message-ID: <003e01c10522$1c9cf580$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: "Richard Henderson" <rth@twiddle.net>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>, <alan@redhat.com>,
        <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <20010704114530.A1030@twiddle.net>
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for calibration?
Date: Thu, 5 Jul 2001 11:14:19 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard, thanks. But please use calibrate_cc version which I've submited
as a patch - it gives more accuracy with maximum latch we can ever use and
has cc's type changed to 'unsigned int' to prevent problems when rpcc
overflows.

Oleg.

----- Original Message -----
From: "Richard Henderson" <rth@twiddle.net>
To: "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>; <alan@redhat.com>;
<torvalds@transmeta.com>
Cc: "Oleg I. Vdovikin" <vdovikin@jscc.ru>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 04, 2001 10:45 PM
Subject: [patch] Re: alpha - generic_init_pit - why using RTC for
calibration?


> On Fri, Jun 29, 2001 at 09:19:31PM +0400, Ivan Kokshaysky wrote:
> > Good idea. The patch below works reliably on my sx164.
>
> Reasonable.  Here I've cleaned up time_init a tad as well.
>
>
> r~
>
>
>
> --- arch/alpha/kernel/time.c.orig Fri Jun 29 11:24:03 2001
> +++ arch/alpha/kernel/time.c Fri Jun 29 11:35:52 2001
> @@ -169,6 +169,77 @@ common_init_rtc(void)
>   init_rtc_irq();
>  }
>
> +/*
> + * Calibrate CPU clock using legacy 8254 timer/counter. Stolen from
> + * arch/i386/time.c.
> + */
> +
> +#define CALIBRATE_LATCH (52 * LATCH)
> +#define CALIBRATE_TIME (52 * 1000020 / HZ)
> +
> +static unsigned long __init
> +calibrate_cc_with_pic(void)
> +{
> + int cc;
> + unsigned long count = 0;
> +
> + /* Set the Gate high, disable speaker */
> + outb((inb(0x61) & ~0x02) | 0x01, 0x61);
> +
> + /*
> + * Now let's take care of CTC channel 2
> + *
> + * Set the Gate high, program CTC channel 2 for mode 0,
> + * (interrupt on terminal count mode), binary count,
> + * load 5 * LATCH count, (LSB and MSB) to begin countdown.
> + */
> + outb(0xb0, 0x43); /* binary, mode 0, LSB/MSB, Ch 2 */
> + outb(CALIBRATE_LATCH & 0xff, 0x42); /* LSB of count */
> + outb(CALIBRATE_LATCH >> 8, 0x42); /* MSB of count */
> +
> + cc = rpcc();
> + do {
> + count++;
> + } while ((inb(0x61) & 0x20) == 0);
> + cc = rpcc() - cc;
> +
> + /* Error: ECTCNEVERSET */
> + if (count <= 1)
> + goto bad_ctc;
> +
> + /* Error: ECPUTOOFAST */
> + if (count >> 32)
> + goto bad_ctc;
> +
> + /* Error: ECPUTOOSLOW */
> + if (cc <= CALIBRATE_TIME)
> + goto bad_ctc;
> +
> + return ((long)cc * 1000000) / CALIBRATE_TIME;
> +
> + /*
> + * The CTC wasn't reliable: we got a hit on the very first read,
> + * or the CPU was so fast/slow that the quotient wouldn't fit in
> + * 32 bits..
> + */
> + bad_ctc:
> + return 0;
> +}
> +
> +/* The Linux interpretation of the CMOS clock register contents:
> +   When the Update-In-Progress (UIP) flag goes from 1 to 0, the
> +   RTC registers show the second which has precisely just started.
> +   Let's hope other operating systems interpret the RTC the same way.  */
> +
> +static unsigned long __init
> +rpcc_after_update_in_progress(void)
> +{
> + do { } while (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP));
> + do { } while (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
> +
> + return rpcc();
> +}
> +
>  void __init
>  time_init(void)
>  {
> @@ -176,24 +247,15 @@ time_init(void)
>   unsigned long cycle_freq, one_percent;
>   long diff;
>
> - /*
> - * The Linux interpretation of the CMOS clock register contents:
> - * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
> - * RTC registers show the second which has precisely just started.
> - * Let's hope other operating systems interpret the RTC the same way.
> - */
> - do { } while (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP));
> - do { } while (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
> + /* Calibrate CPU clock -- attempt #1.  */
> + if (!est_cycle_freq)
> + est_cycle_freq = calibrate_cc_with_pic();
>
> - /* Read cycle counter exactly on falling edge of update flag */
> - cc1 = rpcc();
> + cc1 = rpcc_after_update_in_progress();
>
> + /* Calibrate CPU clock -- attempt #2.  */
>   if (!est_cycle_freq) {
> - /* Sometimes the hwrpb->cycle_freq value is bogus.
> -    Go another round to check up on it and see.  */
> - do { } while (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP));
> - do { } while (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
> - cc2 = rpcc();
> + cc2 = rpcc_after_update_in_progress();
>   est_cycle_freq = cc2 - cc1;
>   cc1 = cc2;
>   }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

