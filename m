Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131392AbQLFUkz>; Wed, 6 Dec 2000 15:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130786AbQLFUkp>; Wed, 6 Dec 2000 15:40:45 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:27656 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130607AbQLFUki>; Wed, 6 Dec 2000 15:40:38 -0500
Date: Wed, 6 Dec 2000 21:09:28 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jerdfelt@valinux.com, usb@in.tum.de
Subject: Re: test12-pre6
Message-ID: <20001206210928.G847@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Dec 06, 2000 at 11:38:30AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 11:38:30AM -0800, Linus Torvalds wrote:
> But I see something obviously wrong there: you have busmaster disabled.
> 
> Looking into the UHCI controller code, I notice that neither UHCI driver
> actually does the (required)
> 
> 	pci_set_master(dev);
> 
> Please add that to just after a successful "pci_enable_device(dev)", and I
> just bet your USB will start working.

Yes, that did the trick! Problem solved, thanks a lot!

> Johannes, Georg, the above is a fairly embarrassing bug, and is likely to
> explain a _lot_ of USB failures (the OHCI driver does do this, btw).

Here is the patch, I don't know if it is enabled in the right place,
but it definatively fixes the problem.

--- drivers/usb/uhci.c.old	Wed Dec  6 20:55:05 2000
+++ drivers/usb/uhci.c	Wed Dec  6 20:55:37 2000
@@ -2383,6 +2383,8 @@
 	if (pci_enable_device(dev) < 0)
 		return -ENODEV;
 
+	pci_set_master(dev);
+
 	if (!dev->irq) {
 		err("found UHCI device with no IRQ assigned. check BIOS
settings!");
 		return -ENODEV;
--- drivers/usb/usb-uhci.c.old	Wed Dec  6 20:53:58 2000
+++ drivers/usb/usb-uhci.c	Wed Dec  6 20:54:48 2000
@@ -2941,6 +2941,8 @@
 
 	if (pci_enable_device(dev) < 0)
 		return -ENODEV;
+
+	pci_set_master(dev);
 	
 	/* Search for the IO base address.. */
 	for (i = 0; i < 6; i++) {

Thanks again,


Erik
[listening to an MP3 with the USB audio device]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
