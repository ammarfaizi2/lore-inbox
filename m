Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbRFBTC7>; Sat, 2 Jun 2001 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRFBTCt>; Sat, 2 Jun 2001 15:02:49 -0400
Received: from host213-123-127-165.btopenworld.com ([213.123.127.165]:45324
	"EHLO argo.dyndns.org") by vger.kernel.org with ESMTP
	id <S262662AbRFBTCk>; Sat, 2 Jun 2001 15:02:40 -0400
X-test: X
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: lk@mailandnews.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: CUV4X-D lockup on boot
In-Reply-To: <E156E44-0001sS-00@the-village.bc.nu>
Date: 02 Jun 2001 20:02:37 +0100
In-Reply-To: Alan Cox's message of "Sat, 2 Jun 2001 17:15:48 +0100 (BST)"
Message-ID: <m3vgmepuwi.fsf@fork.man2.dom>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I have an ASUS CUV4X-D Dual Processor Mainboard based on a VIA
> > 694XDP chipset. I notice from the archives that someone else
> > has also reported a lockup with the m/b when using two cpus
> > and have some info that may be useful to track it down.
> > 
> > Using kernel 2.4.5 the kernel locks up sporadically at boot
> > time. When I enable the NMI watchdog it occasionally gets
> > enabled prior to the lockup and perhaps can be useful for
> > debugging the problem. Here's what happens:
> 
> At minimum you need the 1007 bios and to run noapic. As yet we don't know why
> or what the newer BIOS has done to make it boot at all

I had already replaced 1004 with 1007 and it didn't make any
difference. I'd rather solve the problem than work around it,
as it does boot, it just might take a couple of resets to do
so.

I've done a bit more printk tracing and now it consistently
hangs following this path in arch/i386/kernel/io_apic.c

 1454           printk(KERN_INFO "..TIMER: vector=%d pin1=%d pin2=%d\n", vector, pin1, pin2);   
 1462                   unmask_IO_APIC_irq(0);
 1463   printk("io %d\n", __LINE__);
 1464                   if (timer_irq_works()) {
->
 1076   static int __init timer_irq_works(void)
 1077   {
 1078           unsigned int t1 = jiffies;
 1079
 1080   printk("io %d\n", __LINE__);
 1081           sti();
 1082   printk("io %d\n", __LINE__);
 1083           /* Let ten ticks pass... */
 1084   printk("io %d\n", __LINE__);
 1085           mdelay((10 * 1000) / HZ);
Following line isn't executed:
 1086   printk("io %d\n", __LINE__);

Further details to follow...

Paul
