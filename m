Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTDRXXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTDRXXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:23:55 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:49057 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263300AbTDRXXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:23:53 -0400
Date: Fri, 18 Apr 2003 19:33:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] Solved: 2.4.20, 2.5.66 have different IDE channel
  order
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200304181935_MC3-1-3503-83F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  2.4 builds its global PCI device list in breadth-first order.

  2.5 is doing the scan that way but defers the construction of the
global list until later and then does it depth-first.  This causes
devices to found in different order by drivers. The below fixed that
problem for me:


--- linux-2.5.66-ref/drivers/pci/bus.c	Sat Mar 29 09:16:22 2003
+++ linux-2.5.66-uni/drivers/pci/bus.c	Fri Apr 18 19:08:04 2003
@ -75,7 +75,8 @
  * Add newly discovered PCI devices (which are on the bus->devices
  * list) to the global PCI device list, add the sysfs and procfs
  * entries.  Where a bridge is found, add the discovered bus to
- * the parents list of child buses, and recurse.
+ * the parents list of child buses, and recurse (breadth-first
+ * to be compatible with 2.4)
  *
  * Call hotplug for each new devices.
  */
@ -98,6 +99,12 @
 #endif
 		pci_create_sysfs_dev_files(dev);
 
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+
+		BUG_ON(list_empty(&dev->global_list));
+
 		/*
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.


------
 Chuck
