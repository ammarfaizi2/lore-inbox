Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRGBJxI>; Mon, 2 Jul 2001 05:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbRGBJw7>; Mon, 2 Jul 2001 05:52:59 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:39186 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S262609AbRGBJwj>;
	Mon, 2 Jul 2001 05:52:39 -0400
Message-ID: <009801c102dc$c42d7a60$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Richard Henderson" <rth@twiddle.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru>
Subject: Re: alpha - generic_init_pit - why using RTC for calibration?
Date: Mon, 2 Jul 2001 13:52:53 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan, thanks. I will minorly adjust the patch, prepare it for 2.2.x series
and then post it.

Thanks,
    Oleg.

P.S. Richard, any thoughts?

----- Original Message -----
From: "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>
To: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
Cc: "Richard Henderson" <rth@twiddle.net>; <linux-kernel@vger.kernel.org>
Sent: Friday, June 29, 2001 9:19 PM
Subject: Re: alpha - generic_init_pit - why using RTC for calibration?


> On Fri, Jun 29, 2001 at 04:20:59PM +0400, Oleg I. Vdovikin wrote:
> >     we've a bunch of UP2000/UP2000+ boards (similar to DP264) with
666MHz
> > EV67 Alphas (we're building large Alpha cluster). And we're regulary see
> > "HWRPB cycle frequency bogus" and the measured value for the speed in
the
> > range of 519 MHz - 666 MHz. And this value changes in this range from
boot
> > to boot. So why this happens???
>
> This is known problem with Cypress cy82c693 SIO. The RTC on this chip
> sometimes need a very long time (up to several minutes) to settle down
> after reset/power-up. But I thought it's fixed on newer systems with
> "ub" revision of the chip... :-(
>
> >     So, the final question: why we're not using the aproach which is
used by
> > x86 time.c? I.e. why not to use CTC channel 2 for calibration?
>
> Good idea. The patch below works reliably on my sx164.
>
> Ivan.
>
> --- 2.4.6-pre5/arch/alpha/kernel/time.c Mon Nov 13 06:27:11 2000
> +++ linux/arch/alpha/kernel/time.c Fri Jun 29 20:58:09 2001
> @@ -169,6 +169,63 @@ common_init_rtc(void)
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
> +calibrate_cc(void)
> +{
> + int cc;
> + unsigned long count = 0;
> +
> +       /* Set the Gate high, disable speaker */
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
> +bad_ctc:
> + return 0;
> +}
> +
>  void __init
>  time_init(void)
>  {
> @@ -176,6 +233,9 @@ time_init(void)
>   unsigned long cycle_freq, one_percent;
>   long diff;
>
> + /* Calibrate CPU clock -- attempt #1. If this fails, use RTC. */
> + if (!est_cycle_freq)
> + est_cycle_freq = calibrate_cc();
>   /*
>   * The Linux interpretation of the CMOS clock register contents:
>   * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
>

