Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVKWUZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVKWUZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKWUYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:24:16 -0500
Received: from digitalimplant.org ([64.62.235.95]:3210 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932323AbVKWUXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:23:48 -0500
Date: Wed, 23 Nov 2005 12:23:39 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org, "" <linux-pm@lists.osdl.org>,
       "" <linux-sound@vger.kernel.org>
cc: akpm@osdl.org
Subject: [Patch 5/6] [OSS] Remove deprecated PM interface from nm256 driver.
Message-ID: <Pine.LNX.4.50.0511231221290.16769-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff-tree a653f4aea340869b6482dce578901c2d40c95912 (from d4637f6330e57390156e151d15c06247cca7c78f)
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Wed Nov 23 11:56:13 2005 -0800

    [OSS] Remove deprecated PM interface from nm256 driver.

    This change removes the old, deprecated interface from the
    nm256 driver, including the pm_{,un}register() calls, the
    local storage of the pmdev object and the reference to the
    old header files. This change is done to assist in eradicating
    the users of the legacy interface so as to help facilitate
    the removal of the interface itself.

    Note that this driver has been obsoleted by an ALSA equivalent.

    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

:040000 040000 87f4944625899f3a0bbd1656f1ca1546ef304b29 22cf5552bbabece21464a9c3e27a05412fce6418 M	sound

diffstat:

 sound/oss/nm256_audio.c |   47 -----------------------------------------------
 1 files changed, 47 deletions(-)

---

a653f4aea340869b6482dce578901c2d40c95912
diff --git a/sound/oss/nm256_audio.c b/sound/oss/nm256_audio.c
index 0ce2c40..42d8f05 100644
--- a/sound/oss/nm256_audio.c
+++ b/sound/oss/nm256_audio.c
@@ -24,8 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/pm.h>
-#include <linux/pm_legacy.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
@@ -49,7 +47,6 @@ static int nm256_grabInterrupt (struct n
 static int nm256_releaseInterrupt (struct nm256_info *card);
 static irqreturn_t nm256_interrupt (int irq, void *dev_id, struct pt_regs *dummy);
 static irqreturn_t nm256_interrupt_zx (int irq, void *dev_id, struct pt_regs *dummy);
-static int handle_pm_event (struct pm_dev *dev, pm_request_t rqst, void *data);

 /* These belong in linux/pci.h. */
 #define PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO 0x8005
@@ -992,15 +989,6 @@ nm256_install_mixer (struct nm256_info *
     return 0;
 }

-/* Perform a full reset on the hardware; this is invoked when an APM
-   resume event occurs.  */
-static void
-nm256_full_reset (struct nm256_info *card)
-{
-    nm256_initHw (card);
-    ac97_reset (&(card->mdev));
-}
-
 /*
  * See if the signature left by the NM256 BIOS is intact; if so, we use
  * the associated address as the end of our audio buffer in the video
@@ -1053,7 +1041,6 @@ static int __devinit
 nm256_install(struct pci_dev *pcidev, enum nm256rev rev, char *verstr)
 {
     struct nm256_info *card;
-    struct pm_dev *pmdev;
     int x;

     if (pci_enable_device(pcidev))
@@ -1234,43 +1221,10 @@ nm256_install(struct pci_dev *pcidev, en

     nm256_install_mixer (card);

-    pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev), handle_pm_event);
-    if (pmdev)
-        pmdev->data = card;
-
     return 1;
 }


-/*
- * PM event handler, so the card is properly reinitialized after a power
- * event.
- */
-static int
-handle_pm_event (struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-    struct nm256_info *crd = (struct nm256_info*) dev->data;
-    if (crd) {
-        switch (rqst) {
-	case PM_SUSPEND:
-	    break;
-	case PM_RESUME:
-            {
-                int playing = crd->playing;
-                nm256_full_reset (crd);
-                /*
-                 * A little ugly, but that's ok; pretend the
-                 * block we were playing is done.
-                 */
-                if (playing)
-                    DMAbuf_outputintr (crd->dev_for_play, 1);
-            }
-	    break;
-	}
-    }
-    return 0;
-}
-
 static int __devinit
 nm256_probe(struct pci_dev *pcidev,const struct pci_device_id *pciid)
 {
@@ -1696,7 +1650,6 @@ static int __init do_init_nm256(void)
 static void __exit cleanup_nm256 (void)
 {
     pci_unregister_driver(&nm256_pci_driver);
-    pm_unregister_all (&handle_pm_event);
 }

 module_init(do_init_nm256);
