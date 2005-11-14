Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVKNXIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVKNXIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVKNXIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:08:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35734 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932167AbVKNXIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:08:35 -0500
Date: Tue, 15 Nov 2005 00:07:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, dwmw2@infradead.org
Subject: [patch] Partial support for mtd on collie
Message-ID: <20051114230739.GA17587@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for sharp collie. I probably got regions wrong,
because chip can not be written to, but readonly support is still
better than no support at all.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_probe.c
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -25,6 +25,8 @@
 #include <linux/mtd/cfi.h>
 #include <linux/mtd/gen_probe.h>
 
+#define DEBUG(a, b...) printk(b)
+
 /* Manufacturers */
 #define MANUFACTURER_AMD	0x0001
 #define MANUFACTURER_ATMEL	0x001f
@@ -34,6 +36,7 @@
 #define MANUFACTURER_MACRONIX	0x00C2
 #define MANUFACTURER_NEC	0x0010
 #define MANUFACTURER_PMC	0x009D
+#define MANUFACTURER_SHARP	0x00b0
 #define MANUFACTURER_SST	0x00BF
 #define MANUFACTURER_ST		0x0020
 #define MANUFACTURER_TOSHIBA	0x0098
@@ -124,6 +127,9 @@
 #define PM49FL004	0x006E
 #define PM49FL008	0x006A
 
+/* Sharp */
+#define LH28F640BF	0x00b0
+
 /* ST - www.st.com */
 #define M29W800DT	0x00D7
 #define M29W800DB	0x005B
@@ -271,6 +277,19 @@ struct amd_flash_info {
  */
 static const struct amd_flash_info jedec_table[] = {
 	{
+		.mfr_id		= MANUFACTURER_SHARP,
+		.dev_id		= LH28F640BF,
+		.name		= "LH28F640BF",
+		.uaddr		= {
+                        [0] = MTD_UADDR_UNNECESSARY,    /* x8 */
+		},
+		.DevSize	= SIZE_4MiB,
+                .CmdSet         = P_ID_INTEL_STD,
+                .NumEraseRegions= 1,
+                .regions        = {
+                        ERASEINFO(0x40000,16),
+                }
+	}, {
 		.mfr_id		= MANUFACTURER_AMD,
 		.dev_id		= AM29F032B,
 		.name		= "AMD AM29F032B",
diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -211,6 +211,9 @@ static int sa1100_probe_subdev(struct sa
 		goto err;
 	}
 	subdev->mtd->owner = THIS_MODULE;
+#ifdef CONFIG_SA1100_COLLIE
+	subdev->mtd->unlock(subdev->mtd, 0xc0000, subdev->mtd->size - 0xc0000);
+#endif
 
 	printk(KERN_INFO "SA1100 flash: CFI device at 0x%08lx, %dMiB, "
 		"%d-bit\n", phys, subdev->mtd->size >> 20,

-- 
Thanks, Sharp!
