Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVKWU1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVKWU1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVKWUYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:24:14 -0500
Received: from digitalimplant.org ([64.62.235.95]:3722 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932320AbVKWUXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:23:48 -0500
Date: Wed, 23 Nov 2005 12:23:41 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org, "" <linux-pm@lists.osdl.org>,
       "" <linux-sound@vger.kernel.org>
cc: akpm@osdl.org
Subject: [Patch 6/6] [OSS] Remove deprecated PM interface from opl3sa2 driver.
Message-ID: <Pine.LNX.4.50.0511231222190.16769-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff-tree aa59c7491b6cfe7add4218667e6b35e94a4181fa (from a653f4aea340869b6482dce578901c2d40c95912)
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Wed Nov 23 11:59:53 2005 -0800

    [OSS] Remove deprecated PM interface from opl3sa2driver.

    This change removes the old, deprecated interface from the
    opl3sa2 driver, including the pm_{,un}register() calls, the
    local storage of the pmdev object and the reference to the
    old header files. This change is done to assist in eradicating
    the users of the legacy interface so as to help facilitate
    the removal of the interface itself.

    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

:040000 040000 22cf5552bbabece21464a9c3e27a05412fce6418 1d796a5f70b9d7e54b517866a4940847e60531a4 M	sound

diffstat:

 sound/oss/opl3sa2.c |  110 ----------------------------------------------------
 1 files changed, 110 deletions(-)

---

aa59c7491b6cfe7add4218667e6b35e94a4181fa
diff --git a/sound/oss/opl3sa2.c b/sound/oss/opl3sa2.c
index cd41d0e..5cecdbc 100644
--- a/sound/oss/opl3sa2.c
+++ b/sound/oss/opl3sa2.c
@@ -69,8 +69,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/pm.h>
-#include <linux/pm_legacy.h>
 #include "sound_config.h"

 #include "ad1848.h"
@@ -139,10 +137,6 @@ typedef struct {
 	struct pnp_dev* pdev;
 	int activated;			/* Whether said devices have been activated */
 #endif
-#ifdef CONFIG_PM_LEGACY
-	unsigned int	in_suspend;
-	struct pm_dev	*pmdev;
-#endif
 	unsigned int	card;
 	int		chipset;	/* What's my version(s)? */
 	char		*chipset_name;
@@ -341,22 +335,6 @@ static void opl3sa2_mixer_reset(opl3sa2_
 	}
 }

-/* Currently only used for power management */
-#ifdef CONFIG_PM_LEGACY
-static void opl3sa2_mixer_restore(opl3sa2_state_t* devc)
-{
-	if (devc) {
-		opl3sa2_set_volume(devc, devc->volume_l, devc->volume_r);
-		opl3sa2_set_mic(devc, devc->mic);
-
-		if (devc->chipset == CHIPSET_OPL3SA3) {
-			opl3sa3_set_bass(devc, devc->bass_l, devc->bass_r);
-			opl3sa3_set_treble(devc, devc->treble_l, devc->treble_r);
-		}
-	}
-}
-#endif /* CONFIG_PM_LEGACY */
-
 static inline void arg_to_vol_mono(unsigned int vol, int* value)
 {
 	int left;
@@ -832,84 +810,6 @@ static struct pnp_driver opl3sa2_driver

 /* End of component functions */

-#ifdef CONFIG_PM_LEGACY
-
-static DEFINE_SPINLOCK(opl3sa2_lock);
-
-/* Power Management support functions */
-static int opl3sa2_suspend(struct pm_dev *pdev, unsigned int pm_mode)
-{
-	unsigned long flags;
-	opl3sa2_state_t *p;
-
-	if (!pdev)
-		return -EINVAL;
-
-	spin_lock_irqsave(&opl3sa2_lock,flags);
-
-	p = (opl3sa2_state_t *) pdev->data;
-	switch (pm_mode) {
-	case 1:
-		pm_mode = OPL3SA2_PM_MODE1;
-		break;
-	case 2:
-		pm_mode = OPL3SA2_PM_MODE2;
-		break;
-	case 3:
-		pm_mode = OPL3SA2_PM_MODE3;
-		break;
-	default:
-		/* we don't know howto handle this... */
-		spin_unlock_irqrestore(&opl3sa2_lock, flags);
-		return -EBUSY;
-	}
-
-	p->in_suspend = 1;
-
-	/* its supposed to automute before suspending, so we won't bother */
-	opl3sa2_write(p->cfg_port, OPL3SA2_PM, pm_mode);
-	/* wait a while for the clock oscillator to stabilise */
-	mdelay(10);
-
-	spin_unlock_irqrestore(&opl3sa2_lock,flags);
-	return 0;
-}
-
-static int opl3sa2_resume(struct pm_dev *pdev)
-{
-	unsigned long flags;
-	opl3sa2_state_t *p;
-
- 	if (!pdev)
- 		return -EINVAL;
-
-	p = (opl3sa2_state_t *) pdev->data;
-	spin_lock_irqsave(&opl3sa2_lock,flags);
-
- 	/* I don't think this is necessary */
-	opl3sa2_write(p->cfg_port, OPL3SA2_PM, OPL3SA2_PM_MODE0);
-	opl3sa2_mixer_restore(p);
- 	p->in_suspend = 0;
-
-	spin_unlock_irqrestore(&opl3sa2_lock,flags);
-	return 0;
-}
-
-static int opl3sa2_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
-{
-	unsigned long mode = (unsigned  long)data;
-
-	switch (rqst) {
-		case PM_SUSPEND:
-			return opl3sa2_suspend(pdev, mode);
-
-		case PM_RESUME:
-			return opl3sa2_resume(pdev);
-	}
-	return 0;
-}
-#endif /* CONFIG_PM_LEGACY */
-
 /*
  * Install OPL3-SA2 based card(s).
  *
@@ -1021,12 +921,6 @@ static int __init init_opl3sa2(void)

 		/* ewww =) */
 		opl3sa2_state[card].card = card;
-#ifdef CONFIG_PM_LEGACY
-		/* register our power management capabilities */
-		opl3sa2_state[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
-		if (opl3sa2_state[card].pmdev)
-			opl3sa2_state[card].pmdev->data = &opl3sa2_state[card];
-#endif /* CONFIG_PM_LEGACY */

 		/*
 		 * Set the Yamaha 3D enhancement mode (aka Ymersion) if asked to and
@@ -1083,10 +977,6 @@ static void __exit cleanup_opl3sa2(void)
 	int card;

 	for(card = 0; card < opl3sa2_cards_num; card++) {
-#ifdef CONFIG_PM_LEGACY
-		if (opl3sa2_state[card].pmdev)
-			pm_unregister(opl3sa2_state[card].pmdev);
-#endif
 	        if (opl3sa2_state[card].cfg_mpu.slots[1] != -1) {
 			unload_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu);
  		}
