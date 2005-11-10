Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVKJWnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVKJWnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVKJWnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:43:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14512 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932214AbVKJWm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:42:59 -0500
Date: Thu, 10 Nov 2005 23:41:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051110224158.GC9905@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz> <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz> <1131616948.27347.174.camel@baythorne.infradead.org> <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131621090.27347.184.camel@baythorne.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, how do I found out? I tried switching to CFI, and it will not
> > boot (unable to mount root...). No mtd-related messages as far as I
> > can see. There's quite a lot of mtd-related config options, I set them
> > like this:
> 
> If the old sharp driver had even a _chance_ of working, then you
> presumably have four 8-bit flash chips laid out on a 32-bit bus, and
> those chips are compatible with the Intel command set.
> 
> You can CONFIG_MTD_JEDECPROBE, and you want CONFIG_MTD_MAP_BANK_WIDTH=4,
> CONFIG_MTD_CFI_I4, CONFIG_MTD_CFI_INTELEXT.
> 
> Check that your chips are listed in the table in jedec_probe.c and turn
> on all the debugging in jedec_probe.c 

With these hacks, I'm able to mount flash at least read-only. On
attempt to remount read-write, I get 

"Write error in obliterating obsoleted node at 0x00bc0000: -30
...
Erase at 0x00c00000 failed immediately: -EROFS. Is the sector locked?"

Is it good news?
								Pavel

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -208,7 +208,7 @@ static void collie_set_vpp(int vpp)
 }
 
 static struct flash_platform_data collie_flash_data = {
-	.map_name	= "sharp",
+	.map_name	= "jedec_probe",
 	.set_vpp	= collie_set_vpp,
 	.parts		= collie_partitions,
 	.nr_parts	= ARRAY_SIZE(collie_partitions),
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
@@ -271,6 +273,19 @@ struct amd_flash_info {
  */
 static const struct amd_flash_info jedec_table[] = {
 	{
+		.mfr_id		= 0x00b0,
+		.dev_id		= 0x00b0,
+		.name		= "Collie hack",
+		.uaddr		= {
+                        [0] = MTD_UADDR_UNNECESSARY,    /* x8 */
+		},
+		.DevSize	= SIZE_4MiB,
+                .CmdSet         = P_ID_INTEL_EXT,
+                .NumEraseRegions= 1,
+                .regions        = {
+                        ERASEINFO(0x10000,64),
+                }
+	}, {
 		.mfr_id		= MANUFACTURER_AMD,
 		.dev_id		= AM29F032B,
 		.name		= "AMD AM29F032B",


-- 
Thanks, Sharp!
