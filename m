Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUGXSop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUGXSop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUGXSop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 14:44:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:3268 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262085AbUGXSom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 14:44:42 -0400
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <41029215.1030406@optonline.net>
References: <40FD38A0.3000603@optonline.net>
	 <20040720155928.GC10921@atrey.karlin.mff.cuni.cz>
	 <40FD4CFA.6070603@optonline.net>
	 <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
	 <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston>
	 <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston>
	 <40FD82B1.8030704@optonline.net> <1090356079.1993.12.camel@gaston>
	 <40FD85A3.2060502@optonline.net> <1090357324.1993.15.camel@gaston>
	 <410280E9.5040001@optonline.net> <1090684826.1963.6.camel@gaston>
	 <41029215.1030406@optonline.net>
Content-Type: text/plain
Message-Id: <1090694118.1971.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 14:35:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 12:45, Nathan Bryant wrote:
> Benjamin Herrenschmidt wrote:
> > sysfs only takes care about the bus hierarchy as far as suspend/resume
> > is concerned (which is the only sane way to do it imho)
> 
> I saw comments in one of the PCI IDE driver pcidev->suspend routines 
> that say "we don't need to iterate over the list of drives, sysfs does 
> that for us."

That's different, because the disks are actually registered as
"struct device" childs of the bus, and thus get proper suspend/resume
callbacks.

> > No, the ordering cannot be dictated by the upper layer, but by the
> > physical bus hierarchy. The low level driver gets the suspend callback
> > and need to notify the parent. The md/multipath must keep track that one
> > of the device it relies on is going away and thus block the queues.
> > 
> > That is at least for machine suspend/resume.
> 
> We're talking past each other. I'm saying you take into consideration 
> the physical bus hierarchy: PCI bus x is a parent of SCSI bus y which is 
> a parent of SCSI disk drive z. Suspend disk z, with involvement from the 
> block layer and scsi midlayer, before even calling the actual 
> pcidev->suspend routine on the SCSI bus adapter. Shouldn't require more 
> than minimal LLD involvement.

Oh sure, the disks are in the loop, the problem happens with multipath
and such which "breaks" the bus hiearchy somewhat. The queue management
is part of the "functional" hierarchy (read: block layer) on top of
SCSI disks, thus the disks will be the one getting the suspend callback,
but they have to "notify" their functional parent (block layer, md, ...)
to properly get the queues stopped.

IDE sort-of does that internally, by generating a special request that
goes down the queue (in order to be properly ordered with whatever
is pending in the queue, including pending tagged commands if any),
and the "toplevel" IDE handling will stop processing the queue once
that request got past, but it's a hackery that at this point is quite
specific to drivers/ide/

> >>Looking in /sys/devices shows that sysfs already knows that 'host0' is a 
> >>child of a SCSI PCI device.
> > 
> > 
> > Yes, but the PM herarchy is the bus hierarchy, I don't see a simple way
> > of going through both in this case ...
> 
> In the case of IDE, IDE is registered as a bus_type and has generic 
> suspend code for the whole bus that is unrelated to the pcidev. The PIIX 
> IDE (Intel chipsets) PCI pcidev struct doesn't even have suspend and 
> resume callbacks filled in, but it works fine!

Well... not exactly. The pci_dev is the parent of the IDE bus in the
bus hierarchy. PIIX may lack the proper callbacks (it probably need
some stuff there too). For a good working example, ide/ppc/pmac.c,
it is a macio_dev (or a pci_dev, depending on the ASIC model).

The suspend request first reaches the disk(s), which does the queue
processing I mentioned earlier & stanby's the disks. Once that's done,
the parent (ide pmac) gets it's suspend call and does some suspend work
on the controller HW. Resume is the opposite, the controller gets
resumed first, then the child(s) (disk(s))

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

