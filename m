Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUIJVX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUIJVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUIJVX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:23:26 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1290 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267882AbUIJVXX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:23:23 -0400
Date: Fri, 10 Sep 2004 23:23:20 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
In-Reply-To: <20040902192820.GA6427@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl>
References: <20040902192820.GA6427@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, Chris Wedgwood wrote:

> i386 hardware can (and does) see spurious interrupts from time to
> tome.  Ideally I would like the printk removed completely but this is
> probably good enough for now.
> 
> Singed-of-By: Chris Wedgwood <cw@f00f.org>
> 
> ===== arch/i386/kernel/apic.c 1.58 vs edited =====
> --- 1.58/arch/i386/kernel/apic.c	2004-08-26 23:30:31 -07:00
> +++ edited/arch/i386/kernel/apic.c	2004-09-02 12:19:19 -07:00
> @@ -1190,7 +1190,7 @@
>  	   6: Received illegal vector
>  	   7: Illegal register address
>  	*/
> -	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
> +	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",
>  	        smp_processor_id(), v , v1);
>  	irq_exit();
>  }

 This should probably be KERN_ERR even.  This is a serious condition -- if
you ever get such a message, then inter-APIC messages get corrupted and
this affects system's stability.  E.g. with a badly corrupted message you
may get one or more of your processors halted if the matching destinations
misinterpret the delivery mode as a result.  You certainly want to know
about these errors and perhaps get your hardware replaced (starting with
the PSU as they've been repeatedly reported to be the causers).

> ===== arch/i386/kernel/i8259.c 1.36 vs edited =====
> --- 1.36/arch/i386/kernel/i8259.c	2004-08-23 12:48:32 -07:00
> +++ edited/arch/i386/kernel/i8259.c	2004-09-02 12:20:49 -07:00
> @@ -226,7 +226,7 @@
>  		 * lets ACK and report it. [once per IRQ]
>  		 */
>  		if (!(spurious_irq_mask & irqmask)) {
> -			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
> +			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
>  			spurious_irq_mask |= irqmask;
>  		}
>  		atomic_inc(&irq_err_count);

 You may ever get a single message per system boot from this line.  It
encourages to have a look at the ERR counter in /proc/interrupts to check
for possible problems, though admittedly the suggestion isn't especially
clear.

  Maciej
