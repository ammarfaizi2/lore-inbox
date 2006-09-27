Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWI0Qfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWI0Qfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWI0Qfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:35:52 -0400
Received: from xenotime.net ([66.160.160.81]:40163 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751206AbWI0Qfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:35:51 -0400
Date: Wed, 27 Sep 2006 09:36:59 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: arnd Bergmann <arnd@arndb.de>, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Message-Id: <20060927093659.1636e3d8.rdunlap@xenotime.net>
In-Reply-To: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com>
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 12:25:17 -0400 Robin Getz wrote:

> Arnd wrote:
> >Ok, looks good now. Just a few details that don't impact the
> >functionality:
> 
> [snip]
> 
> What I committed (to our source) is:
> 
> +++ process.c   27 Sep 2006 15:32:46 -0000      1.42
> @@ -101,10 +101,10 @@
>   {
>          while (!need_resched()) {
>                  leds_switch(LED_OFF);
> -             __asm__("nop;\n\t \
> -                         nop;\n\t \
> -                         nop;\n\t \
> -                         idle;\n\t": : :"cc");
> +               local_irq_disable();
> +               if (likely( !need_resched()))
> +                       idle_with_irq_disabled();
> +               local_irq_enable();
>                  leds_switch(LED_ON);
>          }
>   }
> 
> And in system.h, this was added (because this is where all the other 
> inlines is which messes with the interrupts are - and irq_flags is already 
> defined here)
> 
> +++ system.h    27 Sep 2006 15:32:51 -0000      1.24
> 
> +#define idle_with_irq_disabled() do {   \
> +        __asm__ __volatile__ (          \
> +                "nop; nop;\n"           \
> +                ".align 8;\n"           \
> +                "sti %0; idle;\n"       \
> +                ::"d" (irq_flags));     \
> +} while (0)
> 
> It seems to work OK.
> 
> Thanks for your help on this.
> 
> I think we have been weeding through everyone's comments, and have most 
> things fixed up.

except for coding style nits.  E.g., the patch above:
a.  uses spaces instead of tabs for indentation
b.  has an extra (unwanted) space in:
> +               if (likely( !need_resched()))
                             ^

> Are there any other major issues that you can see (that have not been 
> pointed out).

---
~Randy
