Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUIPLT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUIPLT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUIPLTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:19:36 -0400
Received: from gprs214-194.eurotel.cz ([160.218.214.194]:21378 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267940AbUIPLTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:19:12 -0400
Date: Thu, 16 Sep 2004 13:18:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 0/2
Message-ID: <20040916111852.GC5467@elf.ucw.cz>
References: <1095332314.3855.157.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095332314.3855.157.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here are two patches for the driver model, which have been in use in
> suspend2 for around a month.
> 
> The first provides support for keeping part of the device tree alive
> while suspending the remainder. This is accomplished by abstracting the
> dpm_active, dpm_off and dpm_irq lists into a new struct partial device

I believe this is wrong approach.

For atomic snapshot to work, all devices need to be stopped. If your
video card does DMA, it needs to be stopped. So all drivers need to
know, you can not just exclude part of tree.

Now, you probably do not want disks to spin down and you want your
screen unblanked (as an optimalization/speedup). Patch for keeping
disk up is allready in -mm. Patch for keeping radeonfb up looks like
this, and is pending, too.

If more such patches are needed, post them, but not telling drivers
based on their class is not an option.

								Pavel

--- clean-mm/drivers/video/aty/radeon_pm.c	2004-08-24 09:03:18.000000000 +0200
+++ linux-mm/drivers/video/aty/radeon_pm.c	2004-09-15 13:00:51.000000000 +0200
@@ -871,7 +871,8 @@
 	agp_enable(0);
 #endif
 
-	fb_set_suspend(info, 1);
+	if (system_state != SYSTEM_SNAPSHOT)
+		fb_set_suspend(info, 1);
 
 	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
 		/* Make sure engine is reset */
@@ -880,12 +881,14 @@
 		radeon_engine_idle();
 	}
 
-	/* Blank display and LCD */
-	radeonfb_blank(VESA_POWERDOWN, info);
-
-	/* Sleep */
-	rinfo->asleep = 1;
-	rinfo->lock_blank = 1;
+	if (system_state != SYSTEM_SNAPSHOT) {
+		/* Blank display and LCD */
+		radeonfb_blank(VESA_POWERDOWN, info);
+
+		/* Sleep */
+		rinfo->asleep = 1;
+		rinfo->lock_blank = 1;
+	}
 
 	/* Suspend the chip to D2 state when supported
 	 */

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
