Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUGHHCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUGHHCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGHHCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:02:16 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:53634 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265840AbUGHG7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 8/8] New set of input patches
Date: Thu, 8 Jul 2004 01:59:04 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080158.05735.dtor_core@ameritech.net> <200407080158.32258.dtor_core@ameritech.net>
In-Reply-To: <200407080158.32258.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080159.06311.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1827, 2004-07-08 01:29:31-05:00, dtor_core@ameritech.net
  Input: rearrange activation/children probe sequence in psmouse so
         reconnect on children ports works even after parent port is
         fully activated:
         - when connecting/reconnecting a port always activate it
         - when connecting/reconnecting a pass-throgh port deactivate
           parent first and activate it after connect is done
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   55 +++++++++++++++++++++++++++++++++++++------------------
 psmouse.h      |    1 +
 2 files changed, 38 insertions(+), 18 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-07-08 01:35:50 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-07-08 01:35:50 -05:00
@@ -655,6 +655,21 @@
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 }
 
+
+/*
+ * psmouse_deactivate() puts the mouse into poll mode so that we don't get motion
+ * reports from it unless we explicitely request it.
+ */
+
+static void psmouse_deactivate(struct psmouse *psmouse)
+{
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE))
+		printk(KERN_WARNING "psmouse.c: Failed to deactivate mouse on %s\n", psmouse->serio->phys);
+
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+}
+
+
 /*
  * psmouse_cleanup() resets the mouse into power-on state.
  */
@@ -705,8 +720,14 @@
 	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
 		return;
 
-	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU)
+	/*
+	 * If this is a pass-through port deactivate parent so the device
+	 * connected to this port can be successfully identified
+	 */
+	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
 		parent = serio->parent->private;
+		psmouse_deactivate(parent);
+	}
 
 	if (!(psmouse = kmalloc(sizeof(struct psmouse), GFP_KERNEL)))
 		goto out;
@@ -766,21 +787,15 @@
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
-	/*
-	 * OK, the device is ready, we just need to activate it (turn the
-	 * stream mode on). But if mouse has a pass-through port we don't
-	 * want to do it yet to not disturb child detection.
-	 * The child will activate this port when it's ready.
-	 */
-
 	if (serio->child) {
 		/*
 		 * Nothing to be done here, serio core will detect that
 		 * the driver set serio->child and will register it for us.
 		 */
 		printk(KERN_INFO "serio: %s port at %s\n", serio->child->name, psmouse->phys);
-	} else
-		psmouse_activate(psmouse);
+	}
+
+	psmouse_activate(psmouse);
 
 out:
 	/* If this is a pass-through port the parent awaits to be activated */
@@ -794,20 +809,26 @@
 	struct psmouse *psmouse = serio->private;
 	struct psmouse *parent = NULL;
 	struct serio_driver *drv = serio->drv;
+	int rc = -1;
 
 	if (!drv || !psmouse) {
 		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
 
+	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+		parent = serio->parent->private;
+		psmouse_deactivate(parent);
+	}
+
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
 
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
-			return -1;
+			goto out;
 	} else if (psmouse_probe(psmouse) < 0 ||
 		   psmouse->type != psmouse_extensions(psmouse, psmouse_max_proto, 0))
-		return -1;
+		goto out;
 
 	/* ok, the device type (and capabilities) match the old one,
 	 * we can continue using it, complete intialization
@@ -816,20 +837,18 @@
 
 	psmouse_initialize(psmouse);
 
-	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU)
-		parent = serio->parent->private;
-
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
-	if (!serio->child)
-		psmouse_activate(psmouse);
+	psmouse_activate(psmouse);
+	rc = 0;
 
+out:
 	/* If this is a pass-through port the parent waits to be activated */
 	if (parent)
 		psmouse_activate(parent);
 
-	return 0;
+	return rc;
 }
 
 
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-07-08 01:35:50 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-07-08 01:35:50 -05:00
@@ -9,6 +9,7 @@
 #define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
+#define PSMOUSE_CMD_DISABLE	0x00f5
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
 #define PSMOUSE_CMD_RESET_BAT	0x02ff
 
