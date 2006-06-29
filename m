Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbWF2VAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWF2VAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWF2VAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:00:20 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:22792 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932614AbWF2VAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:00:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 29 Jun 2006 21:00:16.0272 (UTC) FILETIME=[05A9F100:01C69BBF]
Content-class: urn:content-classes:message
Subject: Re: i8259.c dummy I/O operation?
Date: Thu, 29 Jun 2006 17:00:15 -0400
Message-ID: <Pine.LNX.4.61.0606291635340.4165@chaos.analogic.com>
In-Reply-To: <20060629202956.GA2718@rhlx01.fht-esslingen.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: i8259.c dummy I/O operation?
thread-index: AcabvwWx5JEeL4lZSQq5oTfSavjZJA==
References: <20060629202956.GA2718@rhlx01.fht-esslingen.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Cc: "kernel list" <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2006, Andreas Mohr wrote:

> Hi all,
>
> I just wanted to direct attention to further somewhat wasteful aspects
> in kernel code ;)
>
> Since this extra inb() is in IRQ handler hotpath (called at least a
> couple hundred times per second without dynticks patch),
> it hurts quite obviously, potentially with several hundred CPU cycles
> per I/O due to slow PIC access (haven't actually profiled it, though).
>
> This dummy op can be found in i8259.c of i386/, x86_64/ and mips/.
>
> There seem to be no adverse effects on three systems that I tested it on:
> - P4 HT
> - P3/700
> - Athlon on VIA chipset
>
> Comments?
> Further testing on various chipsets by more people would also be useful,
> I think...
> (however testing might be dangerous, of course, since it's a quite invasive
> change and might even corrupt data or so!)
>
> Thanks,
>
> Andreas Mohr
>
> P.S.: the outb() change is just a minor comment correction...
>
>
> diff -urN linux-2.6.17-mm4.orig/arch/i386/kernel/i8259.c linux-2.6.17-mm4.my/arch/i386/kernel/i8259.c
> --- linux-2.6.17-mm4.orig/arch/i386/kernel/i8259.c	2006-06-29 11:57:11.000000000 +0200
> +++ linux-2.6.17-mm4.my/arch/i386/kernel/i8259.c	2006-06-29 21:17:33.000000000 +0200
> @@ -191,13 +191,13 @@
> 	cached_irq_mask |= irqmask;
>
> handle_real_irq:
> +	/* we used to first do a dummy inb() on PIC_SLAVE_IMR/PIC_MASTER_IMR
> +	   here, but this doesn't seem to actually be necessary... */
> 	if (irq & 8) {
> -		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
> 		outb(cached_slave_mask, PIC_SLAVE_IMR);
> 		outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
> 		outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' to master-IRQ2 */
> 	} else {
> -		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
> 		outb(cached_master_mask, PIC_MASTER_IMR);
> 		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
> 	}
> @@ -272,7 +272,7 @@
> 	 * out of.
> 	 */
> 	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
> -	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
> +	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
> 	return 0;
> }
>

Well you know that the last one to touch the interrupt controller
code gets blamed for all future problems. Any fast (read modern)
machines will not be using these two cascaded controllers anyway
so any changes will result in absolutely zero gain.

Any 'extra' stuff you see was added after thousands of hours of
testing on hundreds of PC clones, just to make them work. The
problem is that we have two cascaded controllers that are running
in edge mode. There needs to be distinct edges propagating between
these chips that are within the setup and hold times of the chips,
during the worst-case scenario. So, there are some 'dummy' reads
that produce about 300 ns delay on older PCs and somewhat less
on newer ones.

If you touch that code, be prepared to get out your scope and
go through all the '486 clones that still exist in the world.

Note the comments written by Linus; "Careful! The 8259A is a
fragile beast..."


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
