Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVBOX51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVBOX51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVBOX51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:57:27 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:8406 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261950AbVBOX5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:57:20 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] quiet non-x86 option ROM warnings
Date: Tue, 15 Feb 2005 15:57:05 -0800
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SxoEC6eNcmcDtuC"
Message-Id: <200502151557.06049.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_SxoEC6eNcmcDtuC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Both the r128 and radeon drivers complain if they don't find an x86 option ROM 
on the device they're talking to.  This would be fine, except that the 
message is incorrect--not all option ROMs are required to be x86 based.  This 
small patch just removes the messages altogether, causing the drivers to 
*silently* fall back to the non-x86 option ROM behavior (it works fine and 
there's no cause for alarm).

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>


--Boundary-00=_SxoEC6eNcmcDtuC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="non-x86-rom-ok.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="non-x86-rom-ok.patch"

===== drivers/video/aty/radeon_base.c 1.39 vs edited =====
--- 1.39/drivers/video/aty/radeon_base.c	2005-02-10 22:57:44 -08:00
+++ edited/drivers/video/aty/radeon_base.c	2005-02-15 15:51:19 -08:00
@@ -329,11 +329,9 @@
 	rinfo->bios_seg = rom;
 
 	/* Very simple test to make sure it appeared */
-	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "radeonfb (%s): Invalid ROM signature %x should be"
-		       "0xaa55\n", pci_name(rinfo->pdev), BIOS_IN16(0));
-		goto failed;
-	}
+	if (BIOS_IN16(0) != 0xaa55)
+		goto failed; /* not an x86 option ROM, bail out */
+
 	/* Look for the PCI data to check the ROM type */
 	dptr = BIOS_IN16(0x18);
 
===== drivers/video/aty/aty128fb.c 1.56 vs edited =====
--- 1.56/drivers/video/aty/aty128fb.c	2005-02-10 22:57:44 -08:00
+++ edited/drivers/video/aty/aty128fb.c	2005-02-15 15:51:40 -08:00
@@ -812,11 +812,8 @@
 	}
 
 	/* Very simple test to make sure it appeared */
-	if (BIOS_IN16(0) != 0xaa55) {
-		printk(KERN_ERR "aty128fb: Invalid ROM signature %x should be 0xaa55\n",
-		       BIOS_IN16(0));
-		goto failed;
-	}
+	if (BIOS_IN16(0) != 0xaa55)
+		goto failed; /* not an x86 option ROM, bail out */
 
 	/* Look for the PCI data to check the ROM type */
 	dptr = BIOS_IN16(0x18);

--Boundary-00=_SxoEC6eNcmcDtuC--
