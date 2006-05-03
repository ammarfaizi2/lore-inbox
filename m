Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWECTug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWECTug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 15:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWECTug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 15:50:36 -0400
Received: from fmr19.intel.com ([134.134.136.18]:60136 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750768AbWECTuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 15:50:35 -0400
Date: Wed, 3 May 2006 12:58:48 -0700
From: mark gross <mgross@linux.intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       mark.gross@intel.com
Subject: [PATCH] EDAC Coexistance with BIOS
Message-ID: <20060503195848.GA13018@linux.intel.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch addresses the issue of EDAC/BIOS coexistence for the
e752x chip-sets.  It is a patch agaist 2.6.17-rc3-mm1.

We have found a problem where the BIOS will start the system with the error
registers (dev0:fun1) hidden and assuming it has exclusive access to them.
The edac driver violates this assumption.

The work around this patch offers is to honor the hidden-ness as an
indication that it is not safe to use those registers.


Please apply

Signed-off-by: Mark Gross <mark.gross@intel.com>

Thanks,


diff -urN -X linux-2.6.17-rc3-mm1/Documentation/dontdiff linux-2.6.17-rc3-mm1/drivers/edac/e752x_edac.c linux-2.6.17-rc3-mm1_edac/drivers/edac/e752x_edac.c
--- linux-2.6.17-rc3-mm1/drivers/edac/e752x_edac.c	2006-05-03 11:31:04.000000000 -0700
+++ linux-2.6.17-rc3-mm1_edac/drivers/edac/e752x_edac.c	2006-05-03 11:20:54.000000000 -0700
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
+static int force_function_unhide;
+
 #define e752x_printk(level, fmt, arg...) \
 	edac_printk(level, "e752x", fmt, ##arg)
 
@@ -782,8 +784,16 @@
 	debugf0("%s(): mci\n", __func__);
 	debugf0("Starting Probe1\n");
 
-	/* enable device 0 function 1 */
+	/* check to see if device 0 function 1 is enabled; if it isn't, we
+	 * assume the BIOS has reserved it for a reason and is expecting
+	 * exclusive access, we take care not to violate that assumption and
+	 * fail the probe. */
 	pci_read_config_byte(pdev, E752X_DEVPRES1, &stat8);
+	if (!force_function_unhide && !(stat8 & (1 << 5))) {
+		printk(KERN_INFO "Contact your BIOS vendor to see if the "
+			"E752x error registers can be safely un-hidden\n");
+		goto fail;
+	}
 	stat8 |= (1 << 5);
 	pci_write_config_byte(pdev, E752X_DEVPRES1, stat8);
 
@@ -1063,3 +1073,8 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Linux Networx (http://lnxi.com) Tom Zimmerman\n");
 MODULE_DESCRIPTION("MC support for Intel e752x memory controllers");
+
+module_param(force_function_unhide, int, 0444);
+MODULE_PARM_DESC(force_function_unhide, "if BIOS sets Dev0:Fun1 up as hidden:"
+" 1=force unhide and hope BIOS doesn't fight driver for Dev0:Fun1 access");
+

