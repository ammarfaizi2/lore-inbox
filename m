Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSIJQ6R>; Tue, 10 Sep 2002 12:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSIJQ6R>; Tue, 10 Sep 2002 12:58:17 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:11669 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316683AbSIJQ6P>; Tue, 10 Sep 2002 12:58:15 -0400
Date: Tue, 10 Sep 2002 19:26:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Greg Kroah-Hartmann <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.4-ac] trivial ohci fixes
Message-ID: <Pine.LNX.4.44.0209101922480.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Alan,
	This is just a trivial patch for the following, and also a 
buglet (clear_bit usb_register/derister race there?) fix

usb-uhci.c: $Revision: 1.1.1.1 $ time 21:43:25 Sep  8 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb-ohci.c: USB OHCI at membase 0xd0012000, IRQ 11
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb-ohci.c: USB HC TakeOver failed!
usb.c: USB bus -1 deregistered <--

Index: linux-2.4.20-pre5-ac4/drivers/usb//usb-ohci.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-pre5-ac4/drivers/usb/usb-ohci.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 usb-ohci.c
--- linux-2.4.20-pre5-ac4/drivers/usb//usb-ohci.c	8 Sep 2002 18:05:41 -0000	1.1.1.1
+++ linux-2.4.20-pre5-ac4/drivers/usb//usb-ohci.c	8 Sep 2002 21:28:56 -0000
@@ -2440,8 +2440,9 @@
 	}
 	pci_set_drvdata(ohci->ohci_dev, NULL);
 	if (ohci->bus) {
-		if (ohci->bus->busnum)
+		if (ohci->bus->busnum != -1)
 			usb_deregister_bus (ohci->bus);
+
 		usb_free_bus (ohci->bus);
 	}
 
Index: linux-2.4.20-pre5-ac4/drivers/usb//usb.c
===================================================================
RCS file: /build/cvsroot/linux-2.4.20-pre5-ac4/drivers/usb/usb.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 usb.c
--- linux-2.4.20-pre5-ac4/drivers/usb//usb.c	8 Sep 2002 18:05:41 -0000	1.1.1.1
+++ linux-2.4.20-pre5-ac4/drivers/usb//usb.c	8 Sep 2002 19:24:48 -0000
@@ -457,11 +457,10 @@
 	 */
 	down (&usb_bus_list_lock);
 	list_del(&bus->bus_list);
+	clear_bit(bus->busnum, busmap.busmap);
 	up (&usb_bus_list_lock);
 
 	usbdevfs_remove_bus(bus);
-
-	clear_bit(bus->busnum, busmap.busmap);
 
 	usb_bus_put(bus);
 }

-- 
function.linuxpower.ca

