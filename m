Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262407AbSJJVnw>; Thu, 10 Oct 2002 17:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSJJVnw>; Thu, 10 Oct 2002 17:43:52 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:29710 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262407AbSJJVnt>;
	Thu, 10 Oct 2002 17:43:49 -0400
Date: Thu, 10 Oct 2002 14:45:28 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI Hotplug fixes for 2.4.20-pre10
Message-ID: <20021010214527.GB27523@kroah.com>
References: <20021010214455.GA27523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010214455.GA27523@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.737   -> 1.738  
#	drivers/hotplug/cpqphp_core.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	Dan.Zink@hp.com	1.738
# [PATCH] Compaq PCI Hotplug bug fix
# 
# Found the bug.  The following patch fixes the hot plug
# driver so that it has a fallback when there are no unused
# IRQs on a system.  At some point intialization got re-
# ordered and this was broken.
# 
# Greg, this should apply to 2.4 and 2.5 if you wouldn't
# mind submitting it.
# 
# Thanks,
# Dan
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Thu Oct 10 14:44:44 2002
+++ b/drivers/hotplug/cpqphp_core.c	Thu Oct 10 14:44:44 2002
@@ -1101,6 +1101,9 @@
 	/*
 	 * Get IO, memory, and IRQ resources for new devices
 	 */
+	// The next line is required for cpqhp_find_available_resources
+	ctrl->interrupt = pdev->irq;
+
 	rc = cpqhp_find_available_resources(ctrl, cpqhp_rom_start);
 	ctrl->add_support = !rc;
 	if (rc) {
@@ -1129,7 +1132,6 @@
 	writel(0xFFFFFFFFL, ctrl->hpc_reg + INT_MASK);
 
 	/* set up the interrupt */
-	ctrl->interrupt = pdev->irq;
 	dbg("HPC interrupt = %d \n", ctrl->interrupt);
 	if (request_irq(ctrl->interrupt,
 			(void (*)(int, void *, struct pt_regs *)) &cpqhp_ctrl_intr,
