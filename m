Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVKLXsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVKLXsX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVKLXsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:48:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39331 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964883AbVKLXsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:48:22 -0500
Date: Sat, 12 Nov 2005 22:33:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Todd Poynor <tpoynor@mvista.com>, linux-mtd@lists.infradead.org,
       David Woodhouse <dwmw2@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: latest mtd changes broke collie
Message-ID: <20051112213355.GA4676@elf.ucw.cz>
References: <20051110095050.GC2021@elf.ucw.cz> <1131616948.27347.174.camel@baythorne.infradead.org> <20051110103823.GB2401@elf.ucw.cz> <1131619903.27347.177.camel@baythorne.infradead.org> <20051110105954.GE2401@elf.ucw.cz> <1131621090.27347.184.camel@baythorne.infradead.org> <20051110224158.GC9905@elf.ucw.cz> <4373DEB4.5070406@mvista.com> <20051111001617.GD9905@elf.ucw.cz> <1131692514.3525.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131692514.3525.41.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I see the old sharp driver has a normally-not-defined AUTOUNLOCK symbol 
> > > that would enable some code to unlock blocks before writing/erasing 
> > > (which isn't recommended since the code doesn't know the policy on 
> > > whether the block is supposed to be locked).  The tree previously in use 
> > > may have had something similar setup.  It seems these flashes have all 
> > > blocks locked by default at power up.
> > 
> > Is there some quick hack I can do in kernel to unlock it?
> 
> I use the following on my device:
> 
>         mtd = do_map_probe(...);
>         
>         if (!mtd) { ...err... }
>         
>         mtd->owner = THIS_MODULE;
>         
>         mtd->unlock(mtd,0,mtd->size);
>         
> > Is it possible to accidentally unlock "BIOS" area and brick the device?
> 
> Yep, but you could modify the parameters to unlock to no do so.
> Depending on you partitioning scheme you might be able to use that to
> figure out what to unlock...

I tried this one. Size 0xc0000 is reported as a "bootloader" during
boot. 

[Plus I get a warning from jffs2 that flashsize is not aligned to
erasesize. Then I get lot of messages that empty flash at XXX ends at
XXX.]

Any more ideas?
								Pavel

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -208,8 +208,8 @@ static void collie_set_vpp(int vpp)
 }
 
 static struct flash_platform_data collie_flash_data = {
-//	.map_name	= "jedec_probe",
-	.map_name	= "sharp",
+	.map_name	= "jedec_probe",
+//	.map_name	= "sharp",
 	.set_vpp	= collie_set_vpp,
 	.parts		= collie_partitions,
 	.nr_parts	= ARRAY_SIZE(collie_partitions),
diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -211,6 +211,7 @@ static int sa1100_probe_subdev(struct sa
 		goto err;
 	}
 	subdev->mtd->owner = THIS_MODULE;
+	subdev->mtd->unlock(subdev->mtd, 0xc0000, subdev->mtd->size);
 
 	printk(KERN_INFO "SA1100 flash: CFI device at 0x%08lx, %dMiB, "
 		"%d-bit\n", phys, subdev->mtd->size >> 20,




-- 
Thanks, Sharp!
