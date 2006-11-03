Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWKCXWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWKCXWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 18:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWKCXWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 18:22:01 -0500
Received: from mail.ggsys.net ([69.26.161.131]:12988 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S932491AbWKCXWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 18:22:00 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061103205223.GC7240@procyon.home>
References: <1162576973.3967.10.camel@w100>
	 <20061103220018.577ded43.vsu@altlinux.ru> <1162585327.3967.18.camel@w100>
	 <20061103205223.GC7240@procyon.home>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Fri, 03 Nov 2006 17:21:54 -0600
Message-Id: <1162596114.5520.11.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 23:52 +0300, Sergey Vlasov wrote:
> On Fri, Nov 03, 2006 at 02:22:07PM -0600, Alberto Alonso wrote:
> > On Fri, 2006-11-03 at 22:00 +0300, Sergey Vlasov wrote: 
> > > On Fri, 03 Nov 2006 12:02:53 -0600 Alberto Alonso wrote:
> > > 
> > > > I have a Pacific Digital qstor card on irq 193. I am using kernel
> > > > 2.6.17.13 SMP
> > > > 
> > > > 
> > > > irq 193: nobody cared (try booting with the "irqpoll" option)
> > > 
> > > Did you try this option?  It may decrease performance, but in some cases
> > > IRQ routing is so screwed that only irqpoll helps.
> > 
> > I have now switched to using that option. Will kick in after I reboot.
> 
> Actually, it might be better to wait with this - it is the last resort
> option, if there is nothing else to try.


I'll wait then. This is a file server with 6 active HD controllers and 
14 drives. For what I can figure out reading LKML irqpoll would really
have a bad effect.

> 
> > 0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
> >         Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
> >         Flags: bus master, medium devsel, latency 64, IRQ 10
> >         Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]
> 
> Can you try with ohci-hcd loaded (and without irqpoll)?  USB
> controllers might cause such problems, because BIOSen often do weird
> things with them for legacy emulation; however, loading a proper
> driver should make BIOS stop messing with the hardware behind the back
> of the OS.
> 
> After loading ohci-hcd look which IRQ does the USB controller use - if
> it is the same IRQ as the qstor card, you should keep ohci-hcd loaded
> to avoid problems.  (If it is on some other IRQ, loading ohci-hcd
> might still help - the code for enabling the PCI device calls ACPI
> BIOS, which might change interrupt routing setup in the chipset.)

I have now compiled and enabled the ohci-hcd module. It ended up 
in IRQ10

> 
> Also look for something like "USB Keyboard Support" and maybe "USB
> Mouse Support" in BIOS setup - some BIOS versions have severe problems
> with this emulation, so it may be better to disable it unless you
> really need it.
> 
> Disabling USB in the BIOS setup if you really don't need might be
> another option.
> 
> > 0000:01:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
> >         Subsystem: Gateway 2000: Unknown device 1040
> >         Flags: medium devsel
> >         I/O ports at 1000 [disabled] [size=256]
> >         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
> >         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
> >         Capabilities: [40] Power Management version 2
> > 
> > 0000:01:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
> >         Subsystem: Gateway 2000: Unknown device 1040
> >         Flags: medium devsel
> >         I/O ports at 1400 [disabled] [size=256]
> >         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
> >         Memory at <ignored> (64-bit, non-prefetchable) [disabled]
> >         Capabilities: [40] Power Management version 2
> 
> These devices seem to be disabled, but if loading ohci-hcd does not
> help, you can try to load the sym53c8xx driver and look whether it
> ends up on the same IRQ as qstor.


I will go in tonight and disable all USB and symbios SCSI controllers
on the MB via the BIOS. I don't use SCSI disks on that server anymore,
and I can get by without the USB ports.

The really bad thing is that I can't reproduce it on purpose. Some times
I've gone for 6 weeks without any problems. This morning got really bad,
but it hasn't happened again since.

Thanks for all your help,

Alberto


-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

