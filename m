Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWALUga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWALUga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWALUga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:36:30 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:62353 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161244AbWALUg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:36:29 -0500
Date: Thu, 12 Jan 2006 14:36:25 -0600
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       johnrose@austin.ibm.com
Subject: [PATCH] PCI panic on dlpar add (add pci slot to running partition)
Message-ID: <20060112203625.GU26221@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linas@austin.ibm.com (linas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg, Please apply and forward upstream.

Removing and then adding a PCI slot to a running partition results in
a kernel panic. The current code attempts to add iospace for an entire 
root bus, which is inappropriate, and silently fails.  When a pci device 
tries to use the iospace, a page fault is taken, as the iospace had not
been mapped, and of course the page fault cannot be resolved. 

This only occurs for PCI adapters using pio, which may be why it hadn't 
been seen earlier (this seems to have been broken for a while).
This patch has survived testing of dozens of slot add and removes.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.15-git6/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.15-git6.orig/drivers/pci/hotplug/rpadlpar_core.c	2006-01-12 13:54:52.374015674 -0600
+++ linux-2.6.15-git6/drivers/pci/hotplug/rpadlpar_core.c	2006-01-12 13:56:08.191380743 -0600
@@ -152,7 +152,7 @@
 	pcibios_claim_one_bus(dev->bus);
 
 	/* ioremap() for child bus, which may or may not succeed */
-	(void) remap_bus_range(dev->bus);
+	remap_bus_range(dev->subordinate);
 
 	/* Add new devices to global lists.  Register in proc, sysfs. */
 	pci_bus_add_devices(phb->bus);
