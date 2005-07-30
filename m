Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVG3Pmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVG3Pmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 11:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVG3Pml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 11:42:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33990 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262515AbVG3Pml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 11:42:41 -0400
Date: Sat, 30 Jul 2005 17:42:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [FYI, ugly] first version of working frontlight
Message-ID: <20050730154229.GA6131@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got frontlight to work, wow. Patch is extremely ugly, and I have a
small problem? How do I do this properly? I need  locomo_writel() to
manipulate frontlight settings, but that only seems available in
locomo.c. Putting frontlight support there is certainly possible, but
looks ugly to me...
								Pavel

author <pavel@amd.(none)> Sat, 30 Jul 2005 17:37:58 +0200
committer <pavel@amd.(none)> Sat, 30 Jul 2005 17:37:58 +0200

 arch/arm/common/locomo.c |   53 ++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -638,6 +638,52 @@ static int locomo_resume(struct device *
 }
 #endif
 
+
+static spinlock_t fl_lock = SPIN_LOCK_UNLOCKED;
+
+#define LCM_ALC_EN	0x8000
+
+void frontlight_set(struct locomo *lchip, int duty, int vr, int bpwf)
+{
+	unsigned long flags;
+#if 0
+	if (vr) poodlefl_enable_accel();
+	else 	poodlefl_disable_accel();
+#endif
+
+	spin_lock_irqsave(&fl_lock, flags);
+	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	udelay(100);
+	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+	locomo_writel(bpwf | LCM_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	spin_unlock_irqrestore(&fl_lock, flags);
+}
+
+
 /**
  *	locomo_probe - probe for a single LoCoMo chip.
  *	@phys_addr: physical address of device.
@@ -697,6 +743,9 @@ __locomo_probe(struct device *me, struct
 	/* FrontLight */
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+
+	frontlight_set(lchip, 163, 0, 148); /* Same constants can be used for collie and poodle (depending on CONFIG options in original sharp code?! */
+
 	/* Longtime timer */
 	locomo_writel(0, lchip->base + LOCOMO_LTINT);
 	/* SPI */

-- 
if you have sharp zaurus hardware you don't need... you know my address
