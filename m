Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVKWUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVKWUYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVKWUYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:24:20 -0500
Received: from digitalimplant.org ([64.62.235.95]:62345 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932289AbVKWUXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:23:40 -0500
Date: Wed, 23 Nov 2005 12:23:30 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org, "" <linux-pm@lists.osdl.org>,
       "" <linux-sound@vger.kernel.org>
cc: akpm@osdl.org
Subject: [Patch 2/6] [OSS] Remove deprecated PM interface from cs4281 driver.
Message-ID: <Pine.LNX.4.50.0511231218220.16769-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff-tree aa92446260fcefe1a74c849e55f19d219f78f563 (from ce8c2299f594d1d1c115b629e541208919be9b3f)
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Wed Nov 23 11:49:00 2005 -0800

    [OSS] Remove deprecated PM interface from cs4281 driver.

    This change removes the old, deprecated interface from the
    cs4281 driver, including the pm_{,un}register() calls, the
    local storage of the pmdev object and the reference to the
    old header files. This change is done to assist in eradicating
    the users of the legacy interface so as to help facilitate
    the removal of the interface itself.

    Note that this driver has been obsoleted by an ALSA equivalent.

    Note that this driver has hooks for PCI power management,
    but does not implement the ->suspend()/->resume() methods.

    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

:040000 040000 90c9c18df1a44670e4d5c9777ba3abde96ffb73d a8246728e19c02094c7d8150836f7c0f7b9a1d02 M	sound

diffstat:

 sound/oss/cs4281/cs4281m.c     |   21 +--------------------
 sound/oss/cs4281/cs4281pm-24.c |   39 ---------------------------------------
 2 files changed, 1 insertion(+), 59 deletions(-)

---

aa92446260fcefe1a74c849e55f19d219f78f563
diff --git a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
index adc6896..46dd41d 100644
--- a/sound/oss/cs4281/cs4281m.c
+++ b/sound/oss/cs4281/cs4281m.c
@@ -298,7 +298,6 @@ struct cs4281_state {
 	struct cs4281_pipeline pl[CS4281_NUMBER_OF_PIPELINES];
 };

-#include <linux/pm_legacy.h>
 #include "cs4281pm-24.c"

 #if CSDEBUG
@@ -4256,9 +4255,6 @@ static void __devinit cs4281_InitPM(stru
 static int __devinit cs4281_probe(struct pci_dev *pcidev,
 				  const struct pci_device_id *pciid)
 {
-#ifndef NOT_CS4281_PM
-	struct pm_dev *pmdev;
-#endif
 	struct cs4281_state *s;
 	dma_addr_t dma_mask;
 	mm_segment_t fs;
@@ -4374,19 +4370,7 @@ static int __devinit cs4281_probe(struct
 	}
 #ifndef NOT_CS4281_PM
 	cs4281_InitPM(s);
-	pmdev = cs_pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev), cs4281_pm_callback);
-	if (pmdev)
-	{
-		CS_DBGOUT(CS_INIT | CS_PM, 4, printk(KERN_INFO
-			 "cs4281: probe() pm_register() succeeded (%p).\n", pmdev));
-		pmdev->data = s;
-	}
-	else
-	{
-		CS_DBGOUT(CS_INIT | CS_PM | CS_ERROR, 0, printk(KERN_INFO
-			 "cs4281: probe() pm_register() failed (%p).\n", pmdev));
-		s->pm.flags |= CS4281_PM_NOT_REGISTERED;
-	}
+	s->pm.flags |= CS4281_PM_NOT_REGISTERED;
 #endif

 	pci_set_master(pcidev);	// enable bus mastering
@@ -4487,9 +4471,6 @@ static int __init cs4281_init_module(voi
 static void __exit cs4281_cleanup_module(void)
 {
 	pci_unregister_driver(&cs4281_pci_driver);
-#ifndef NOT_CS4281_PM
-	cs_pm_unregister_all(cs4281_pm_callback);
-#endif
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2,
 		  printk(KERN_INFO "cs4281: cleanup_cs4281() finished\n"));
 }
diff --git a/sound/oss/cs4281/cs4281pm-24.c b/sound/oss/cs4281/cs4281pm-24.c
index d2a453a..90cbd76 100644
--- a/sound/oss/cs4281/cs4281pm-24.c
+++ b/sound/oss/cs4281/cs4281pm-24.c
@@ -27,9 +27,6 @@
 #ifndef NOT_CS4281_PM
 #include <linux/pm.h>

-#define cs_pm_register(a, b, c) pm_register((a), (b), (c));
-#define cs_pm_unregister_all(a) pm_unregister_all((a));
-
 static int cs4281_suspend(struct cs4281_state *s);
 static int cs4281_resume(struct cs4281_state *s);
 /*
@@ -41,42 +38,6 @@ static int cs4281_resume(struct cs4281_s
 #define CS4281_SUSPEND_TBL cs4281_suspend_null
 #define CS4281_RESUME_TBL cs4281_resume_null

-static int cs4281_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	struct cs4281_state *state;
-
-	CS_DBGOUT(CS_PM, 2, printk(KERN_INFO
-		"cs4281: cs4281_pm_callback dev=%p rqst=0x%x state=%p\n",
-			dev,(unsigned)rqst,data));
-	state = (struct cs4281_state *) dev->data;
-	if (state) {
-		switch(rqst) {
-			case PM_SUSPEND:
-				CS_DBGOUT(CS_PM, 2, printk(KERN_INFO
-					"cs4281: PM suspend request\n"));
-				if(cs4281_suspend(state))
-				{
-				    CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO
-					"cs4281: PM suspend request refused\n"));
-					return 1;
-				}
-				break;
-			case PM_RESUME:
-				CS_DBGOUT(CS_PM, 2, printk(KERN_INFO
-					"cs4281: PM resume request\n"));
-				if(cs4281_resume(state))
-				{
-				    CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO
-					"cs4281: PM resume request refused\n"));
-					return 1;
-				}
-				break;
-		}
-	}
-
-	return 0;
-}
-
 #else /* CS4281_PM */
 #define CS4281_SUSPEND_TBL cs4281_suspend_null
 #define CS4281_RESUME_TBL cs4281_resume_null
