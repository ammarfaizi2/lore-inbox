Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVLDBOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVLDBOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 20:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVLDBOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 20:14:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750818AbVLDBOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 20:14:16 -0500
Date: Sat, 3 Dec 2005 17:14:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: Linux 2.6.15-rc3 problem found - scsi order changed
In-Reply-To: <20051204004302.GA2188@aitel.hist.no>
Message-ID: <Pine.LNX.4.64.0512031702110.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
 <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org>
 <438D69FF.2090002@aitel.hist.no> <438EB150.2090502@pobox.com>
 <20051204004302.GA2188@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Dec 2005, Helge Hafting wrote:
> 
> With 2.6.15-rc1 and later, I get:
> sda,sdb,sdc,sdd: the slots in my USB card reader
> sde, sdf, sdg: harddisks connected to the sym2 pci host adapter
> sdh, sdi     : harddisks connected to mainboard SATA
> 
> This kernel have all drivers compiled in - no modules.
> 
> So I have to ask - is this change (USB devices before 
> any other scsi disks) _intentional_ ?

No. Not only isn't it intentional, it's definitely a bug.

We've had it before. The USB devices should come last.

Now, in general, we can't _guarantee_ ordering, since with modules and 
lots of asynchronous events (USB is basically hotplug, we might "detect" a 
disk at any time), so at best it's always just going to be very much a 
"preferred ordering", but so far we've actually in _practice_ been able to 
be very good at keeping the preferred ordering pretty stable.

> I guess mounting by UUID is another way of fixing this?  Please tell if
> this change is intentional - it will making mounting scsi disks by device sort
> of useless for anyone with USB though :-/

Can you figure out exactly (or at least slightly more closely) where it 
happened? It might be something silly like link ordering changes (like the 
fact that drivers/block core files got moved to block/ - although I did 
actually try to check that the link order stayed the same there, since 
it was such an obvious thing), or it might be more subtle. But even just 
pinpointing it to one particular nightly snapshot would be good (and using 
"git bisect" to pinpoint it even more closely is obviously even better).

There's a fair number of changes wrt things like platform_device in 
the -rc1 series. But I actually wonder if it's that simple Makefile 
change.

Does this trivial patch fix it for you? It just makes sure that the usb/ 
subdirectory gets added to the list of driver subdirectories at the right 
point ...

(Link order matters for the "initcall()" ordering, even if it doesn't 
matter for anything else)

		Linus

----
diff --git a/drivers/Makefile b/drivers/Makefile
index fac1e16..ea410b6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -5,7 +5,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-obj-$(CONFIG_PCI)		+= pci/ usb/
+obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-$(CONFIG_RAPIDIO)		+= rapidio/
 obj-y				+= video/
@@ -49,6 +49,7 @@ obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
 obj-$(CONFIG_PARIDE) 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
+obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
