Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbTISK05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbTISK04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:26:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18830 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261480AbTISK0v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:51 -0400
Subject: [PATCH 5/11] input: Fix resume of PS/2 mouse
In-Reply-To: <1063967201965@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:41 +0200
Message-Id: <10639672012942@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1343, 2003-09-19 01:18:46-07:00, petero2@telia.com
  psmouse-base.c:
    Fix resume of PS/2 mouse. Uses old PM interface at the moment.


 psmouse-base.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:24 2003
+++ b/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:24 2003
@@ -17,6 +17,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/init.h>
+#include <linux/pm.h>
 #include "psmouse.h"
 #include "synaptics.h"
 #include "logips2pp.h"
@@ -512,6 +513,30 @@
 }
 
 /*
+ * Reinitialize mouse hardware after software suspend.
+ */
+
+static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t request, void *data)
+{
+	struct psmouse *psmouse = dev->data;
+	struct serio_dev *ser_dev = psmouse->serio->dev;
+
+	synaptics_disconnect(psmouse);
+
+	/* We need to reopen the serio port to reinitialize the i8042 controller */
+	serio_close(psmouse->serio);
+	serio_open(psmouse->serio, ser_dev);
+
+	/* Probe and re-initialize the mouse */
+	psmouse_probe(psmouse);
+	psmouse_initialize(psmouse);
+	synaptics_pt_init(psmouse);
+	psmouse_activate(psmouse);
+
+	return 0;
+}
+
+/*
  * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
  */
@@ -519,6 +544,7 @@
 static void psmouse_connect(struct serio *serio, struct serio_dev *dev)
 {
 	struct psmouse *psmouse;
+	struct pm_dev *pmdev;
 	
 	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
 	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
@@ -551,6 +577,12 @@
 		return;
 	}
 	
+	pmdev = pm_register(PM_SYS_DEV, PM_SYS_UNKNOWN, psmouse_pm_callback);
+	if (pmdev) {
+		psmouse->dev.pm_dev = pmdev;
+		pmdev->data = psmouse;
+	}
+
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
 	sprintf(psmouse->phys, "%s/input0",

