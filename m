Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWAZLD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWAZLD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAZLD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:03:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:17089 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932137AbWAZLD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:03:27 -0500
Message-ID: <43D8AC70.70306@sirrix.de>
Date: Thu, 26 Jan 2006 12:03:12 +0100
From: Oskar Senft <osk-lkml@sirrix.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB host pci-quirks
Content-Type: multipart/mixed;
 boundary="------------050101070505020602060901"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:701b7ca108cfd083b467aa547eda228f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050101070505020602060901
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi all!

I'm currently working with Linux in a hardware virtualization
environment (L4 microkernel). During tests, we discovered, that there is
some incosistency in the kernel configuration dependencies:

the file "drivers/usb/host/pci-quirks.c" is added to the kernel as soon
as PCI support is activated, even if USB support is completely disabled.

We discovered this issue while trying to run multiple Linux instances
simultaneously.

Is there a special need, that the "drivers/usb/host/pci-quirks.c" is
compiled into the kernel even if USB support is disabled?

I suggest the attached patch to resolve that problem. The file then is
only included if PCI and USB support is enabled.

Best regards,
Oskar.

--------------050101070505020602060901
Content-Type: text/plain;
 name="pci_but_no_usb-2006-01-24.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_but_no_usb-2006-01-24.patch"

--- drivers/usb/host/Makefile.orig	2006-01-24 12:28:11.000000000 +0100
+++ drivers/usb/host/Makefile	2006-01-24 12:27:38.000000000 +0100
@@ -2,7 +2,15 @@
 # Makefile for USB Host Controller Drivers
 #
 
-obj-$(CONFIG_PCI)		+= pci-quirks.o
+# only compile pci-quirks if PCI is enabled
+# and USB is either compiled as a module
+ifeq ($(CONFIG_USB),m)
+	obj-$(CONFIG_PCI)		+= pci-quirks.o
+endif
+# or directly into the kernel
+ifeq ($(CONFIG_USB),y)
+        obj-$(CONFIG_PCI)               += pci-quirks.o
+endif
 
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o

--------------050101070505020602060901--
