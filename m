Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWADPEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWADPEA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWADPEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:04:00 -0500
Received: from nm02mta.dion.ne.jp ([61.117.3.71]:54023 "HELO
	nm02omta023.dion.ne.jp") by vger.kernel.org with SMTP
	id S1750817AbWADPD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:03:59 -0500
Date: Thu, 05 Jan 2006 00:04:05 +0900
From: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
To: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
Subject: Re: [PATCH] fix to clock running too fast
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "Jordan T." <jordant@blue-ferret.com.au>
In-Reply-To: <20051125024530.88F8.AKIRA-T@s9.dion.ne.jp>
References: <20051124144613.GC1060@elte.hu> <20051125024530.88F8.AKIRA-T@s9.dion.ne.jp>
Message-Id: <20060104232516.9987.AKIRA-T@s9.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw my previous one line fix for fast clock problems under 32 bits, 
included in 2.4 kernel, 
but not on 2.6 yet. Please apply the following patch.

This patch will avoid clock running too fast on many ATI IXP and nforce boards.

Firstly, motherboard and bios should give the right irq pin info, but if it fails
It should be tweaked inside kernel by chipset id and etc, but if it fails,
my patch will works as a general purpose fail safe.

Under amd 64 bits, many people have been already working on tweaking 
irq pins detection and seems to be ok on most motherboard now, 
but not so many people working on 32 bits or 2.4 kernel.

I have ATI IXP chipset with Pentium M CPU, so the fast clock problem is not 
AMD64 specific.

It is not a optimal solution to use i8259A IRQ, but better than not working right.


On Fri, 25 Nov 2005 02:49:19 +0900
Akira Tsukamoto <akira-t@s9.dion.ne.jp> mentioned:
> 
> Ingo Molnar <mingo@elte.hu> mentioned:
> > 
> > * Akira Tsukamoto <akira-t@s9.dion.ne.jp> wrote:
> > 
> > > This one line patch adds upper bound testing inside timer_irq_works() 
> > > when evaluating whether irq timer works or not on boot up.
> > > 
> > > It fix the machines having problem with clock running too fast.
> > > 
> > > What this patch do is, if  timer interrupts running too fast through 
> > > IO-APIC IRQ then falls back to i8259A IRQ.
> > 
> > thanks - looks good to me.
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> > 
> > 	Ingo
> 
> Thanks,
> I regenerated my patch to the latest kernel.
> 
> Signed-off-by: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
> 
> --- linux-2.6.15-rc2-atiix/arch/i386/kernel/io_apic.c.orig	2005-11-20 12:25:03.000000000 +0900
> +++ linux-2.6.15-rc2-atiix/arch/i386/kernel/io_apic.c	2005-11-25 02:43:40.000000000 +0900
> @@ -1877,7 +1877,7 @@ static int __init timer_irq_works(void)
>  	 * might have cached one ExtINT interrupt.  Finally, at
>  	 * least one tick may be lost due to delays.
>  	 */
> -	if (jiffies - t1 > 4)
> +	if (jiffies - t1 > 4 && jiffies - t1 < 16)
>  		return 1;
>  
>  	return 0;
> 
> 
> 
> 
> -- 
> Akira Tsukamoto <akira-t@s9.dion.ne.jp> <>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Akira Tsukamoto <akira-t@s9.dion.ne.jp> <at541@columbia.edu>


