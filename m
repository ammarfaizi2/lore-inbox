Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTLGHcG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 02:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTLGHbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 02:31:41 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:57710 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263518AbTLGHag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 02:30:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 2/3] Take 2: resume support for i8042 (atkbd & psmouse)
Date: Sun, 7 Dec 2003 02:29:19 -0500
User-Agent: KMail/1.5.4
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@ucw.cz>,
       Brian Perkins <bperkins@netspace.org>,
       Karol Kozimor <sziwan@hell.org.pl>
References: <200312070227.21460.dtor_core@ameritech.net> <200312070228.31969.dtor_core@ameritech.net>
In-Reply-To: <200312070228.31969.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312070229.21303.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1516, 2003-12-07 02:05:30-05:00, dtor_core@ameritech.net
  Input: - Remove psmouse_pm_callback since i8042 now has its own resume
           handler which will issue reconnect request
         - Do not close/open serio port in psmouse_reconnect since i8042
           should restore ports to the proper state before calling reconnect


 psmouse-base.c |   35 -----------------------------------
 1 files changed, 35 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Sun Dec  7 02:18:36 2003
+++ b/drivers/input/mouse/psmouse-base.c	Sun Dec  7 02:18:36 2003
@@ -18,7 +18,6 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/init.h>
-#include <linux/pm.h>
 #include "psmouse.h"
 #include "synaptics.h"
 #include "logips2pp.h"
@@ -537,28 +536,12 @@
 }
 
 /*
- * Reinitialize mouse hardware after software suspend.
- */
-
-static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t request, void *data)
-{
-	struct psmouse *psmouse = dev->data;
-
-	if (request == PM_RESUME) {
-		psmouse->state = PSMOUSE_IGNORE;
-		serio_reconnect(psmouse->serio);
-	}
-	return 0;
-}
-
-/*
  * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
  */
 static void psmouse_connect(struct serio *serio, struct serio_dev *dev)
 {
 	struct psmouse *psmouse;
-	struct pm_dev *pmdev;
 	
 	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
 	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
@@ -590,14 +573,6 @@
 		return;
 	}
 	
-	if (serio->type != SERIO_PS_PSTHRU) {
-		pmdev = pm_register(PM_SYS_DEV, PM_SYS_UNKNOWN, psmouse_pm_callback);
-		if (pmdev) {
-			psmouse->dev.pm_dev = pmdev;
-			pmdev->data = psmouse;
-		}
-	}
-
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
 	sprintf(psmouse->phys, "%s/input0",
@@ -635,16 +610,6 @@
 	
 	if (!dev) {
 		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
-		return -1;
-	}
-	
-	/* We need to reopen the serio port to reinitialize the i8042 controller */
-	serio_close(serio);
-	if (serio_open(serio, dev)) {
-		/* do a disconnect here as serio_open leaves dev as NULL so disconnect 
-		 * will not be called automatically later
-		 */
-		psmouse_disconnect(serio);
 		return -1;
 	}
 	
