Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUKGSjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUKGSjc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUKGSjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 13:39:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:34218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261673AbUKGSjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 13:39:07 -0500
Date: Sun, 7 Nov 2004 10:38:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, vojtech@ucw.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [no problem] PC110 broke 2.6.9
In-Reply-To: <1099845291.5564.120.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411071037140.2223@ppc970.osdl.org>
References: <20041106232228.GA9446@apps.cwi.nl>  <Pine.LNX.4.58.0411061529200.2223@ppc970.osdl.org>
  <1099791769.5564.118.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411061851300.2223@ppc970.osdl.org>
 <1099845291.5564.120.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Nov 2004, Alan Cox wrote:
> 
> Works for me

Do you still have the hw somewhere? Does this patch look sane? It compiles 
for me, and if CONFIG_PCI isn't enabled the thing should still DTRT (ie 
the code all just goes away), but still..

Andries, does this fix your machine with this drievr enabled?

		Linus

-----
===== drivers/input/mouse/pc110pad.c 1.10 vs edited =====
--- 1.10/drivers/input/mouse/pc110pad.c	2004-10-09 14:13:56 -07:00
+++ edited/drivers/input/mouse/pc110pad.c	2004-11-07 10:35:45 -08:00
@@ -38,6 +38,7 @@
 #include <linux/input.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -107,8 +108,22 @@
 	return 0;
 }
 
+/*
+ * We try to avoid enabling the hardware if it's not
+ * there, but we don't know how to test. But we do know
+ * that the PC110 is not a PCI system. So if we find any
+ * PCI devices in the machine, we don't have a PC110.
+ */
 static int __init pc110pad_init(void)
 {
+	struct pci_dev *dev;
+
+	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, NULL);
+	if (dev) {
+		pci_dev_put(dev);
+		return -ENOENT;
+	}
+
 	if (!request_region(pc110pad_io, 4, "pc110pad")) {
 		printk(KERN_ERR "pc110pad: I/O area %#x-%#x in use.\n",
 				pc110pad_io, pc110pad_io + 4);
