Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbSJIWmu>; Wed, 9 Oct 2002 18:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJIWld>; Wed, 9 Oct 2002 18:41:33 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:65035 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262432AbSJIWi2>;
	Wed, 9 Oct 2002 18:38:28 -0400
Date: Wed, 9 Oct 2002 15:40:15 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.41
Message-ID: <20021009224015.GD18646@kroah.com>
References: <20021009223848.GB18646@kroah.com> <20021009223945.GC18646@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009223945.GC18646@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.741   -> 1.742  
#	drivers/hotplug/cpqphp_core.c	1.10    -> 1.11   
#	drivers/hotplug/cpqphp_pci.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/09	Dan.Zink@hp.com	1.742
# [PATCH] Compaq PCI Hotplug bug fix
# 
# Found the bug.  The following patch fixes the hot plug
# driver so that it has a fallback when there are no unused
# IRQs on a system.  At some point intialization got re-
# ordered and this was broken.
# 
# I found another bug that was preventing the existing scheme from
# working.  It looks like the function "pcibios_set_irq_routing" is
# returning 1 for success, but the hot plug driver was interpreting it as
# failure.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Wed Oct  9 15:37:40 2002
+++ b/drivers/hotplug/cpqphp_core.c	Wed Oct  9 15:37:40 2002
@@ -1110,6 +1110,9 @@
 	/*
 	 * Get IO, memory, and IRQ resources for new devices
 	 */
+	// The next line is required for cpqhp_find_available_resources
+	ctrl->interrupt = pdev->irq;
+
 	rc = cpqhp_find_available_resources(ctrl, cpqhp_rom_start);
 	ctrl->add_support = !rc;
 	if (rc) {
@@ -1138,7 +1141,6 @@
 	writel(0xFFFFFFFFL, ctrl->hpc_reg + INT_MASK);
 
 	/* set up the interrupt */
-	ctrl->interrupt = pdev->irq;
 	dbg("HPC interrupt = %d \n", ctrl->interrupt);
 	if (request_irq(ctrl->interrupt,
 			(void (*)(int, void *, struct pt_regs *)) &cpqhp_ctrl_intr,
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Wed Oct  9 15:37:40 2002
+++ b/drivers/hotplug/cpqphp_pci.c	Wed Oct  9 15:37:40 2002
@@ -360,8 +360,8 @@
 	    __FUNCTION__, dev_num, bus_num, int_pin, irq_num);
 	rc = pcibios_set_irq_routing(&fakedev, int_pin - 0x0a, irq_num);
 	dbg("%s: rc %d\n", __FUNCTION__, rc);
-	if (rc)
-		return rc;
+	if (!rc)
+		return !rc;
 
 	// set the Edge Level Control Register (ELCR)
 	temp_word = inb(0x4d0);
