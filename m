Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161282AbWJKXxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161282AbWJKXxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJKXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:53:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:14888 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161282AbWJKXxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:53:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=JgaHZdrGpLim9XTfNZWW4HRVQoPPqAQ4uK4ld85SYLdVtCk30PiQjMB4FPTXo0lWIMG5l5SY9+6QI2gdDCJdDX6/0tNuFrRO5EVv0hdR8E3qcvnQGv6MyD6oKtTGulo0VGC/Y5RwU7BleDx26XBlW9AMu8djDIl3dnD56e54lGw=
Date: Thu, 12 Oct 2006 01:53:28 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc1] radeonfb: check return value of sysfs_create_bin_file
Message-ID: <20061011235328.GA13264@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_create_bin_file() is marked as warn_unused_result but we don't
actually check the return value.
Error is not fatal, the driver can operate fine without the files so
just print a notice on failure.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

---

 drivers/video/aty/radeon_base.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 0ed577e..bc2aac6 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2313,10 +2313,17 @@ #endif
 	radeon_check_modes(rinfo, mode_option);
 
 	/* Register some sysfs stuff (should be done better) */
-	if (rinfo->mon1_EDID)
-		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
-		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+	if (rinfo->mon1_EDID) {
+		if (sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr))
+			printk(KERN_INFO "radeonfb (%s): failed to create edid1 file. "
+				"Continuing anyway.\n", pci_name(rinfo->pdev));
+	}
+
+	if (rinfo->mon2_EDID) {
+		if (sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr))
+			printk(KERN_INFO "radeonfb (%s): failed to create edid2 file. "
+				"Continuing anyway.\n", pci_name(rinfo->pdev));
+	}
 
 	/* save current mode regs before we switch into the new one
 	 * so we can restore this upon __exit


Luca
-- 
Dicono che il cane sia il miglior amico dell'uomo. Secondo me non e`
vero. Quanti dei vostri amici avete fatto castrare, recentemente?
