Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVATDDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVATDDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 22:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVATDDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 22:03:44 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:7093 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261959AbVATDDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 22:03:14 -0500
Message-ID: <41EF1FAF.7020509@yahoo.co.uk>
Date: Thu, 20 Jan 2005 03:04:15 +0000
From: Paul Marrons <pmarrons@yahoo.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mj@ucw.cz, linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: #2 Backport of pci cardbus number enumeration from 2.6 to 2.4.29
Content-Type: multipart/mixed;
 boundary="------------080302070202030008010802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080302070202030008010802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin,

I forgot to attach the actually patch file in my last mail. It's 
attached this time with a copy of my previous email below:

Hi Martin,

To overcome a problem with my laptop cardbus not being assigned the 
correct bus number in 2.4.29 (I originally did this change for 2.4.27) I 
backported a portion of the code in the 2.6 kernel drivers/pci/pci.c 
file. I did this because I noticed that only 2.6 assigned the correct 
bus number and I specifically need to run 2.4.X because of a driver I 
need that is not 2.6 compatible. Basically without this change on my 
laptop (Thinkpad 240) both the main PCI bus and cardbus bridge both get 
assigned bus#0 and as a result any cardbus devices present are not 
correctly detected and allocated any resources, in addition the 
/proc/bus/pci contains two '0' entries and tools such as lspci fail to 
work.

I am aware of people overcoming this problem (with my model of laptop) 
by setting defining pcibios_assign_all_busses() as 1. But this backport 
is a superior solution to the problem.

The few small changes are isolated to pci_add_new_bus and 
pci_scan_bridge. I hope you will be able to incorporate them into the 
next 2.4 kernel release.

If there is anything else I need to do please let me know.

Regards,

Paul Marrons.

--------------080302070202030008010802
Content-Type: text/plain;
 name="pci-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-patch.diff"

--- pci.c.orig	2004-11-17 11:54:21.000000000 +0000
+++ pci.c	2005-01-20 02:01:26.000000000 +0000
@@ -1,3 +1,4 @@
+
 /*
  *	$Id: pci.c,v 1.91 1999/01/21 13:34:01 davem Exp $
  *
@@ -1238,8 +1239,6 @@
 	 * Allocate a new bus, and inherit stuff from the parent..
 	 */
 	child = pci_alloc_bus();
-	if (!child)
-		return NULL;
 
 	list_add_tail(&child->node, &parent->children);
 	child->self = dev;
@@ -1286,29 +1285,25 @@
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 	DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n", dev->slot_name, buses & 0xffffff, pass);
-	if ((buses & 0xffff00) && !pcibios_assign_all_busses()) {
+	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
 		/*
 		 * Bus already configured by firmware, process it in the first
 		 * pass and just note the configuration.
 		 */
+	        unsigned busnr,cmax;
+	        busnr = (buses >> 8)&0xFF;
 		if (pass)
 			return max;
-
-		child = pci_add_new_bus(bus, dev, 0);
-		if (!child)
-			return max;
-
+		child = pci_add_new_bus(bus, dev, busnr);
 		child->primary = buses & 0xFF;
-		child->secondary = (buses >> 8) & 0xFF;
 		child->subordinate = (buses >> 16) & 0xFF;
 		child->number = child->secondary;
-		if (!is_cardbus) {
-			unsigned int cmax = pci_do_scan_bus(child);
-			if (cmax > max) max = cmax;
-		} else {
-			unsigned int cmax = child->subordinate;
-			if (cmax > max) max = cmax;
-		}
+	        
+	        cmax = pci_do_scan_bus(child);
+	        if(cmax > max)
+	             max=cmax;
+	        if(child->subordinate > max)
+	             max = child->subordinate;
 	} else {
 		/*
 		 * We need to assign a number to this bus which we always
@@ -1322,13 +1317,19 @@
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
 		child = pci_add_new_bus(bus, dev, ++max);
-		if (!child)
-			return max;
-
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->secondary)   <<  8)
 		      | ((unsigned int)(child->subordinate) << 16);
+	        /*
+		 * yenta.c forces a secondary latency timer of 176.
+		 * Copy that behaviour here.
+		 */
+		if (is_cardbus) {
+			buses &= ~0xff000000;
+			buses |= 176 << 24;
+		}
+	   
 		/*
 		 * We need to blast all three values with a single write.
 		 */

--------------080302070202030008010802--

