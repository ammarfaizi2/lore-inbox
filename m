Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275671AbRJAWU0>; Mon, 1 Oct 2001 18:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275664AbRJAWUR>; Mon, 1 Oct 2001 18:20:17 -0400
Received: from [128.55.19.167] ([128.55.19.167]:42188 "EHLO lanshark.nersc.gov")
	by vger.kernel.org with ESMTP id <S275669AbRJAWUB>;
	Mon, 1 Oct 2001 18:20:01 -0400
Message-ID: <3BB8EBD6.6C912E2E@lbl.gov>
Date: Mon, 01 Oct 2001 15:19:02 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: endless APIC error messages..
In-Reply-To: <3BB8DCD5.A2CF293D@lbl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before anyone sends me any more messages to junk the hardware, I quote
from the SMP-HOWTO at http://www.linuxdoc.org/HOWTO/SMP-HOWTO-3.html

"APIC error interrupt on CPU#n, should never happen" messages in logs 

A message like: 


APIC error interrupt on CPU#0, should never happen.
... APIC ESR0: 00000002
... APIC ESR1: 00000000

 indicates a 'receive checksum error'. This cannot be caused by Linux as
the APIC message checksumming part is completely in hardware. It might
be marginal hardware. As long as you dont see any instability, they are
not a problem - APIC messages are retried until delivered. (Ingo Molnar) 


I am NOT seeing instability, just tons of these messages.

Thomas Davis wrote:
> 
> Yes, I know, I've got a busted ABIT-BP2 system board.
> 
> Running 2.4, I get thousands of the APIC error messages, which fill my
> syslog.
> 
> Is there a reason for this constant spewing?  The short little patch,
> that simply does stops the system from complaining any more - it's
> busted - we know that.
> 
> --- linux/arch/i386/kernel/apic.c       Mon Oct  1 14:12:50 2001
> +++ linux-2.4.9-ac16/arch/i386/kernel/apic.c    Mon Oct  1 14:10:19 2001
> @@ -37,6 +37,8 @@
>  int prof_old_multiplier[NR_CPUS] = { 1, };
>  int prof_counter[NR_CPUS] = { 1, };
> 
> +static int apic_error_count = 50;
> +
>  int get_maxlvt(void)
>  {
>         unsigned int v, ver, maxlvt;
> @@ -1061,8 +1063,11 @@
>            6: Received illegal vector
>            7: Illegal register address
>         */
> -       printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
> -               smp_processor_id(), v , v1);
> +       if (apic_error_count != 0) {
> +               apic_error_count--;
> +               printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
> +                smp_processor_id(), v , v1);
> +       }
>  }
> 
>  /*
> 
> --
> ------------------------+--------------------------------------------------
> Thomas Davis            | ASG Cluster guy
> tadavis@lbl.gov         |
> (510) 486-4524          | "80 nodes and chugging Captain!"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
