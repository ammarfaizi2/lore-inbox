Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbSL3Utz>; Mon, 30 Dec 2002 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbSL3Uty>; Mon, 30 Dec 2002 15:49:54 -0500
Received: from ra.abo.fi ([130.232.213.1]:22695 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S266020AbSL3Utx>;
	Mon, 30 Dec 2002 15:49:53 -0500
Date: Mon, 30 Dec 2002 22:58:16 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: trivial@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.5] opti92x-ad1848 second check_region fixup
In-Reply-To: <Pine.LNX.4.44.0212302222530.30703-100000@tuxedo.abo.fi>
Message-ID: <Pine.LNX.4.44.0212302254060.30703-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes check_region in snd_card_opti9xx_detect() to request_region,
with appropriate release_region. opti9xx_free() releases this region 
using chip->res_mc_base.

Since the _detect case now uses request_region, we can't do the same 
request_region afterwards, that would fail. So we move it inside the 
__ISAPNP__ case.

#
# create_patch: opti_2-2002-12-30-A.patch
# Date: Mon Dec 30 22:53:33 EET 2002
#
diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude opti_1-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c opti_2-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c
--- opti_1-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c	Mon Dec 30 20:19:47 2002
+++ opti_2-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c	Mon Dec 30 20:48:08 2002
@@ -1674,13 +1674,14 @@
 		if ((err = snd_opti9xx_init(chip, i)) < 0)
 			return err;
 
-		if (check_region(chip->mc_base, chip->mc_base_size))
+		if ((chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size, "opti9xx_detect")) == NULL)
 			continue;
 
 		value = snd_opti9xx_read(chip, OPTi9XX_MC_REG(1));
 		if ((value != 0xff) && (value != inb(chip->mc_base + 1)))
 			if (value == snd_opti9xx_read(chip, OPTi9XX_MC_REG(1)))
 				return 1;
+		release_region(chip->mc_base, chip->mc_base_size);
 	}
 #else	/* OPTi93X */
 	for (i = OPTi9XX_HW_82C931; i >= OPTi9XX_HW_82C930; i--) {
@@ -1690,7 +1691,7 @@
 		if ((err = snd_opti9xx_init(chip, i)) < 0)
 			return err;
 
-		if (check_region(chip->mc_base, chip->mc_base_size))
+		if ((chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size, "opti93x_detect")) == NULL)
 			continue;
 
 		spin_lock_irqsave(&chip->lock, flags);
@@ -1703,6 +1704,7 @@
 		snd_opti9xx_write(chip, OPTi9XX_MC_REG(7), 0xff - value);
 		if (snd_opti9xx_read(chip, OPTi9XX_MC_REG(7)) == 0xff - value)
 			return 1;
+		release_region(chip->mc_base, chip->mc_base_size);
 	}
 #endif	/* OPTi93X */
 
@@ -1993,6 +1995,12 @@
 		}
 		if (hw <= OPTi9XX_HW_82C930)
 			chip->mc_base -= 0x80;
+
+		if ((chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size, "OPTi9xx MC")) == NULL) {
+			snd_card_free(card);
+			return -ENOMEM;
+		}
+
 	} else {
 #endif	/* __ISAPNP__ */
 		if ((error = snd_card_opti9xx_detect(card, chip)) < 0) {
@@ -2002,11 +2010,6 @@
 #ifdef __ISAPNP__
 	}
 #endif	/* __ISAPNP__ */
-
-	if ((chip->res_mc_base = request_region(chip->mc_base, chip->mc_base_size, "OPTi9xx MC")) == NULL) {
-		snd_card_free(card);
-		return -ENOMEM;
-	}
 
 #ifdef __ISAPNP__
 	if (!isapnp) {

