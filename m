Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbUKXH2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUKXH2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUKXHZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:25:25 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:2918 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262334AbUKXHO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:14:57 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/11] serio - use id matching
Date: Wed, 24 Nov 2004 02:09:00 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240207.33932.dtor_core@ameritech.net> <200411240208.14115.dtor_core@ameritech.net>
In-Reply-To: <200411240208.14115.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240209.02935.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1939.3.38, 2004-11-16 01:08:10-05:00, dtor_core@ameritech.net
  Input: replace serio's type field with serio_id structure and
         add ids table to serio drivers. This will allow split
         initial matching and probing routines for better sysfs
         integration.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/joystick/iforce/iforce-serio.c |   16 ++++++++--
 drivers/input/joystick/magellan.c            |   20 +++++++++---
 drivers/input/joystick/spaceball.c           |   22 +++++++++-----
 drivers/input/joystick/spaceorb.c            |   18 ++++++++---
 drivers/input/joystick/stinger.c             |   20 +++++++++---
 drivers/input/joystick/twidjoy.c             |   17 ++++++++--
 drivers/input/joystick/warrior.c             |   16 +++++++---
 drivers/input/keyboard/atkbd.c               |   31 +++++++++++++++----
 drivers/input/keyboard/lkkbd.c               |   16 +++++++---
 drivers/input/keyboard/newtonkbd.c           |   14 +++++++--
 drivers/input/keyboard/sunkbd.c              |   23 ++++++++++----
 drivers/input/keyboard/xtkbd.c               |   14 +++++++--
 drivers/input/mouse/psmouse-base.c           |   28 ++++++++++++------
 drivers/input/mouse/sermouse.c               |   20 +++++++++---
 drivers/input/mouse/synaptics.c              |    2 -
 drivers/input/mouse/vsxxxaa.c                |   16 +++++++---
 drivers/input/serio/ambakmi.c                |    2 -
 drivers/input/serio/ct82c710.c               |    2 -
 drivers/input/serio/gscps2.c                 |    6 ---
 drivers/input/serio/i8042.c                  |    6 +--
 drivers/input/serio/maceps2.c                |    2 -
 drivers/input/serio/parkbd.c                 |    2 -
 drivers/input/serio/pcips2.c                 |    2 -
 drivers/input/serio/q40kbd.c                 |    2 -
 drivers/input/serio/rpckbd.c                 |    2 -
 drivers/input/serio/sa1111ps2.c              |    2 -
 drivers/input/serio/serio.c                  |   30 ++++++++++++++-----
 drivers/input/serio/serio_raw.c              |   14 +++++++--
 drivers/input/serio/serport.c                |   18 ++++++++---
 drivers/input/touchscreen/gunze.c            |   20 +++++++++---
 drivers/input/touchscreen/h3600_ts_input.c   |   21 +++++++++----
 drivers/serial/sunsu.c                       |    7 ++--
 drivers/serial/sunzilog.c                    |    7 ++--
 include/linux/serio.h                        |   42 +++++++++++++++------------
 34 files changed, 334 insertions(+), 146 deletions(-)


===================================================================



diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/joystick/iforce/iforce-serio.c	2004-11-24 01:48:30 -05:00
@@ -129,10 +129,9 @@
 static void iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct iforce *iforce;
-	if (serio->type != (SERIO_RS232 | SERIO_IFORCE))
-		return;
 
-	if (!(iforce = kmalloc(sizeof(struct iforce), GFP_KERNEL))) return;
+	if (!(iforce = kmalloc(sizeof(struct iforce), GFP_KERNEL)))
+		return;
 	memset(iforce, 0, sizeof(struct iforce));
 
 	iforce->bus = IFORCE_232;
@@ -164,11 +163,22 @@
 	kfree(iforce);
 }
 
+static struct serio_id iforce_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_IFORCE,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 struct serio_driver iforce_serio_drv = {
 	.driver		= {
 		.name	= "iforce",
 	},
 	.description	= "RS232 I-Force joysticks and wheels driver",
+	.ids		= iforce_serio_ids,
 	.write_wakeup	= iforce_serio_write_wakeup,
 	.interrupt	= iforce_serio_irq,
 	.connect	= iforce_serio_connect,
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/joystick/magellan.c	2004-11-24 01:48:30 -05:00
@@ -146,8 +146,8 @@
 
 /*
  * magellan_connect() is the routine that is called when someone adds a
- * new serio device. It looks for the Magellan, and if found, registers
- * it as an input device.
+ * new serio device that supports Magellan protocol and registers it as
+ * an input device.
  */
 
 static void magellan_connect(struct serio *serio, struct serio_driver *drv)
@@ -155,9 +155,6 @@
 	struct magellan *magellan;
 	int i, t;
 
-	if (serio->type != (SERIO_RS232 | SERIO_MAGELLAN))
-		return;
-
 	if (!(magellan = kmalloc(sizeof(struct magellan), GFP_KERNEL)))
 		return;
 
@@ -202,14 +199,25 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id magellan_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_MAGELLAN,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver magellan_drv = {
 	.driver		= {
 		.name	= "magellan",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= magellan_serio_ids,
 	.interrupt	= magellan_interrupt,
 	.connect	= magellan_connect,
 	.disconnect	= magellan_disconnect,
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/joystick/spaceball.c	2004-11-24 01:48:30 -05:00
@@ -201,8 +201,8 @@
 
 /*
  * spaceball_connect() is the routine that is called when someone adds a
- * new serio device. It looks for the Magellan, and if found, registers
- * it as an input device.
+ * new serio device that supports Spaceball protocol and registers it as
+ * an input device.
  */
 
 static void spaceball_connect(struct serio *serio, struct serio_driver *drv)
@@ -210,10 +210,7 @@
 	struct spaceball *spaceball;
 	int i, t, id;
 
-	if ((serio->type & ~SERIO_ID) != (SERIO_RS232 | SERIO_SPACEBALL))
-		return;
-
-	if ((id = (serio->type & SERIO_ID) >> 8) > SPACEBALL_MAX_ID)
+	if ((id = serio->id.id) > SPACEBALL_MAX_ID)
 		return;
 
 	if (!(spaceball = kmalloc(sizeof(struct spaceball), GFP_KERNEL)))
@@ -272,14 +269,25 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id spaceball_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_SPACEBALL,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver spaceball_drv = {
 	.driver		= {
 		.name	= "spaceball",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= spaceball_serio_ids,
 	.interrupt	= spaceball_interrupt,
 	.connect	= spaceball_connect,
 	.disconnect	= spaceball_disconnect,
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/joystick/spaceorb.c	2004-11-24 01:48:30 -05:00
@@ -162,7 +162,7 @@
 
 /*
  * spaceorb_connect() is the routine that is called when someone adds a
- * new serio device. It looks for the SpaceOrb/Avenger, and if found, registers
+ * new serio device that supports SpaceOrb/Avenger protocol and registers
  * it as an input device.
  */
 
@@ -171,9 +171,6 @@
 	struct spaceorb *spaceorb;
 	int i, t;
 
-	if (serio->type != (SERIO_RS232 | SERIO_SPACEORB))
-		return;
-
 	if (!(spaceorb = kmalloc(sizeof(struct spaceorb), GFP_KERNEL)))
 		return;
 	memset(spaceorb, 0, sizeof(struct spaceorb));
@@ -216,14 +213,25 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id spaceorb_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_SPACEORB,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver spaceorb_drv = {
 	.driver		= {
 		.name	= "spaceorb",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= spaceorb_serio_ids,
 	.interrupt	= spaceorb_interrupt,
 	.connect	= spaceorb_connect,
 	.disconnect	= spaceorb_disconnect,
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/joystick/stinger.c	2004-11-24 01:48:30 -05:00
@@ -134,8 +134,8 @@
 
 /*
  * stinger_connect() is the routine that is called when someone adds a
- * new serio device. It looks for the Stinger, and if found, registers
- * it as an input device.
+ * new serio device that supports Stinger protocol and registers it as
+ * an input device.
  */
 
 static void stinger_connect(struct serio *serio, struct serio_driver *drv)
@@ -143,9 +143,6 @@
 	struct stinger *stinger;
 	int i;
 
-	if (serio->type != (SERIO_RS232 | SERIO_STINGER))
-		return;
-
 	if (!(stinger = kmalloc(sizeof(struct stinger), GFP_KERNEL)))
 		return;
 
@@ -191,14 +188,25 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id stinger_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_STINGER,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver stinger_drv = {
 	.driver		= {
 		.name	= "stinger",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= stinger_serio_ids,
 	.interrupt	= stinger_interrupt,
 	.connect	= stinger_connect,
 	.disconnect	= stinger_disconnect,
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/joystick/twidjoy.c	2004-11-24 01:48:30 -05:00
@@ -197,9 +197,6 @@
 	struct twidjoy *twidjoy;
 	int i;
 
-	if (serio->type != (SERIO_RS232 | SERIO_TWIDJOY))
-		return;
-
 	if (!(twidjoy = kmalloc(sizeof(struct twidjoy), GFP_KERNEL)))
 		return;
 
@@ -250,14 +247,26 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id twidjoy_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_TWIDJOY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+
 static struct serio_driver twidjoy_drv = {
 	.driver		= {
 		.name	= "twidjoy",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= twidjoy_serio_ids,
 	.interrupt	= twidjoy_interrupt,
 	.connect	= twidjoy_connect,
 	.disconnect	= twidjoy_disconnect,
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/joystick/warrior.c	2004-11-24 01:48:30 -05:00
@@ -148,9 +148,6 @@
 	struct warrior *warrior;
 	int i;
 
-	if (serio->type != (SERIO_RS232 | SERIO_WARRIOR))
-		return;
-
 	if (!(warrior = kmalloc(sizeof(struct warrior), GFP_KERNEL)))
 		return;
 
@@ -202,14 +199,25 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id warrior_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_WARRIOR,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver warrior_drv = {
 	.driver		= {
 		.name	= "warrior",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= warrior_serio_ids,
 	.interrupt	= warrior_interrupt,
 	.connect	= warrior_connect,
 	.disconnect	= warrior_disconnect,
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-11-24 01:48:30 -05:00
@@ -779,7 +779,7 @@
 
 	ps2_init(&atkbd->ps2dev, serio);
 
-	switch (serio->type & SERIO_TYPE) {
+	switch (serio->id.type) {
 
 		case SERIO_8042_XL:
 			atkbd->translated = 1;
@@ -787,12 +787,6 @@
 			if (serio->write)
 				atkbd->write = 1;
 			break;
-		case SERIO_RS232:
-			if ((serio->type & SERIO_PROTO) == SERIO_PS2SER)
-				break;
-		default:
-			kfree(atkbd);
-			return;
 	}
 
 	atkbd->softraw = atkbd_softraw;
@@ -897,11 +891,34 @@
 	return 0;
 }
 
+static struct serio_id atkbd_serio_ids[] = {
+	{
+		.type	= SERIO_8042,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{
+		.type	= SERIO_8042_XL,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_PS2SER,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver atkbd_drv = {
 	.driver		= {
 		.name	= "atkbd",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= atkbd_serio_ids,
 	.interrupt	= atkbd_interrupt,
 	.connect	= atkbd_connect,
 	.reconnect	= atkbd_reconnect,
diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/keyboard/lkkbd.c	2004-11-24 01:48:30 -05:00
@@ -629,11 +629,6 @@
 	struct lkkbd *lk;
 	int i;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_RS232)
-		return;
-	if ((serio->type & SERIO_PROTO) != SERIO_LKKBD)
-		return;
-
 	if (!(lk = kmalloc (sizeof (struct lkkbd), GFP_KERNEL)))
 		return;
 	memset (lk, 0, sizeof (struct lkkbd));
@@ -708,11 +703,22 @@
 	kfree (lk);
 }
 
+static struct serio_id lkkbd_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_LKKBD,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver lkkbd_drv = {
 	.driver		= {
 		.name	= "lkkbd",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= lkkbd_serio_ids,
 	.connect	= lkkbd_connect,
 	.disconnect	= lkkbd_disconnect,
 	.interrupt	= lkkbd_interrupt,
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/keyboard/newtonkbd.c	2004-11-24 01:48:30 -05:00
@@ -89,9 +89,6 @@
 	struct nkbd *nkbd;
 	int i;
 
-	if (serio->type != (SERIO_RS232 | SERIO_NEWTON))
-		return;
-
 	if (!(nkbd = kmalloc(sizeof(struct nkbd), GFP_KERNEL)))
 		return;
 
@@ -145,11 +142,22 @@
 	kfree(nkbd);
 }
 
+static struct serio_id nkbd_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_NEWTON,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 struct serio_driver nkbd_drv = {
 	.driver		= {
 		.name	= "newtonkbd",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= nkbd_serio_ids,
 	.interrupt	= nkbd_interrupt,
 	.connect	= nkbd_connect,
 	.disconnect	= nkbd_disconnect,
diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/keyboard/sunkbd.c	2004-11-24 01:48:30 -05:00
@@ -228,12 +228,6 @@
 	struct sunkbd *sunkbd;
 	int i;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_RS232)
-		return;
-
-	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_SUNKBD)
-		return;
-
 	if (!(sunkbd = kmalloc(sizeof(struct sunkbd), GFP_KERNEL)))
 		return;
 
@@ -307,11 +301,28 @@
 	kfree(sunkbd);
 }
 
+static struct serio_id sunkbd_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_SUNKBD,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_UNKNOWN, /* sunkbd does probe */
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver sunkbd_drv = {
 	.driver		= {
 		.name	= "sunkbd",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= sunkbd_serio_ids,
 	.interrupt	= sunkbd_interrupt,
 	.connect	= sunkbd_connect,
 	.disconnect	= sunkbd_disconnect,
diff -Nru a/drivers/input/keyboard/xtkbd.c b/drivers/input/keyboard/xtkbd.c
--- a/drivers/input/keyboard/xtkbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/keyboard/xtkbd.c	2004-11-24 01:48:30 -05:00
@@ -93,9 +93,6 @@
 	struct xtkbd *xtkbd;
 	int i;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_XT)
-		return;
-
 	if (!(xtkbd = kmalloc(sizeof(struct xtkbd), GFP_KERNEL)))
 		return;
 
@@ -149,11 +146,22 @@
 	kfree(xtkbd);
 }
 
+static struct serio_id xtkbd_serio_ids[] = {
+	{
+		.type	= SERIO_XT,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 struct serio_driver xtkbd_drv = {
 	.driver		= {
 		.name	= "xtkbd",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= xtkbd_serio_ids,
 	.interrupt	= xtkbd_interrupt,
 	.connect	= xtkbd_connect,
 	.disconnect	= xtkbd_disconnect,
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-11-24 01:48:30 -05:00
@@ -714,7 +714,7 @@
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 	del_timer_sync(&psmouse->ping_timer);
 
-	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+	if (serio->parent && serio->id.type  == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
 		if (parent->pt_deactivate)
 			parent->pt_deactivate(parent);
@@ -739,15 +739,11 @@
 {
 	struct psmouse *psmouse, *parent = NULL;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
-	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
-		return;
-
 	/*
 	 * If this is a pass-through port deactivate parent so the device
 	 * connected to this port can be successfully identified
 	 */
-	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
 	}
@@ -853,7 +849,7 @@
 		return -1;
 	}
 
-	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
 	}
@@ -888,12 +884,28 @@
 	return rc;
 }
 
+static struct serio_id psmouse_serio_ids[] = {
+	{
+		.type	= SERIO_8042,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{
+		.type	= SERIO_PS_PSTHRU,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
 
 static struct serio_driver psmouse_drv = {
 	.driver		= {
 		.name	= "psmouse",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= psmouse_serio_ids,
 	.interrupt	= psmouse_interrupt,
 	.connect	= psmouse_connect,
 	.reconnect	= psmouse_reconnect,
@@ -940,7 +952,7 @@
 		goto out;
 	}
 
-	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
 		psmouse_deactivate(parent);
 	}
diff -Nru a/drivers/input/mouse/sermouse.c b/drivers/input/mouse/sermouse.c
--- a/drivers/input/mouse/sermouse.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/mouse/sermouse.c	2004-11-24 01:48:30 -05:00
@@ -246,10 +246,7 @@
 	struct sermouse *sermouse;
 	unsigned char c;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_RS232)
-		return;
-
-	if (!(serio->type & SERIO_PROTO) || ((serio->type & SERIO_PROTO) > SERIO_MZPP))
+	if (!serio->id.proto || serio->id.proto > SERIO_MZPP)
 		return;
 
 	if (!(sermouse = kmalloc(sizeof(struct sermouse), GFP_KERNEL)))
@@ -263,8 +260,8 @@
 	sermouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
 	sermouse->dev.private = sermouse;
 
-	sermouse->type = serio->type & SERIO_PROTO;
-	c = (serio->type & SERIO_EXTRA) >> 16;
+	sermouse->type = serio->id.proto;
+	c = serio->id.extra;
 
 	if (c & 0x01) set_bit(BTN_MIDDLE, sermouse->dev.keybit);
 	if (c & 0x02) set_bit(BTN_SIDE, sermouse->dev.keybit);
@@ -295,11 +292,22 @@
 	printk(KERN_INFO "input: %s on %s\n", sermouse_protocols[sermouse->type], serio->phys);
 }
 
+static struct serio_id sermouse_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver sermouse_drv = {
 	.driver		= {
 		.name	= "sermouse",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= sermouse_serio_ids,
 	.interrupt	= sermouse_interrupt,
 	.connect	= sermouse_connect,
 	.disconnect	= sermouse_disconnect,
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-11-24 01:48:30 -05:00
@@ -288,7 +288,7 @@
 
 	memset(serio, 0, sizeof(struct serio));
 
-	serio->type = SERIO_PS_PSTHRU;
+	serio->id.type = SERIO_PS_PSTHRU;
 	strlcpy(serio->name, "Synaptics pass-through", sizeof(serio->name));
 	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->name));
 	serio->write = synaptics_pt_write;
diff -Nru a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
--- a/drivers/input/mouse/vsxxxaa.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/mouse/vsxxxaa.c	2004-11-24 01:48:30 -05:00
@@ -494,11 +494,6 @@
 {
 	struct vsxxxaa *mouse;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_RS232)
-		return;
-	if ((serio->type & SERIO_PROTO) != SERIO_VSXXXAA)
-		return;
-
 	if (!(mouse = kmalloc (sizeof (struct vsxxxaa), GFP_KERNEL)))
 		return;
 
@@ -551,11 +546,22 @@
 	printk (KERN_INFO "input: %s on %s\n", mouse->name, mouse->phys);
 }
 
+static struct serio_id vsxxaa_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_VSXXXAA,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver vsxxxaa_drv = {
 	.driver		= {
 		.name	= "vsxxxaa",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= vsxxaa_serio_ids,
 	.connect	= vsxxxaa_connect,
 	.interrupt	= vsxxxaa_interrupt,
 	.disconnect	= vsxxxaa_disconnect,
diff -Nru a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
--- a/drivers/input/serio/ambakmi.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/ambakmi.c	2004-11-24 01:48:30 -05:00
@@ -134,7 +134,7 @@
 	memset(kmi, 0, sizeof(struct amba_kmi_port));
 	memset(io, 0, sizeof(struct serio));
 
-	io->type	= SERIO_8042;
+	io->id.type	= SERIO_8042;
 	io->write	= amba_kmi_write;
 	io->open	= amba_kmi_open;
 	io->close	= amba_kmi_close;
diff -Nru a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/ct82c710.c	2004-11-24 01:48:30 -05:00
@@ -181,7 +181,7 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type = SERIO_8042;
+		serio->id.type = SERIO_8042;
 		serio->open = ct82c710_open;
 		serio->close = ct82c710_close;
 		serio->write = ct82c710_write;
diff -Nru a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- a/drivers/input/serio/gscps2.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/gscps2.c	2004-11-24 01:48:30 -05:00
@@ -363,11 +363,7 @@
 	snprintf(serio->name, sizeof(serio->name), "GSC PS/2 %s",
 		 (ps2port->id == GSC_ID_KEYBOARD) ? "keyboard" : "mouse");
 	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
-	serio->idbus		= BUS_GSC;
-	serio->idvendor		= PCI_VENDOR_ID_HP;
-	serio->idproduct	= 0x0001;
-	serio->idversion	= 0x0010;
-	serio->type		= SERIO_8042;
+	serio->id.type		= SERIO_8042;
 	serio->write		= gscps2_write;
 	serio->open		= gscps2_open;
 	serio->close		= gscps2_close;
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/i8042.c	2004-11-24 01:48:30 -05:00
@@ -960,7 +960,7 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type		= i8042_direct ? SERIO_8042 : SERIO_8042_XL,
+		serio->id.type		= i8042_direct ? SERIO_8042 : SERIO_8042_XL,
 		serio->write		= i8042_dumbkbd ? NULL : i8042_kbd_write,
 		serio->open		= i8042_open,
 		serio->close		= i8042_close,
@@ -984,7 +984,7 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type		= SERIO_8042;
+		serio->id.type		= SERIO_8042;
 		serio->write		= i8042_aux_write;
 		serio->open		= i8042_open;
 		serio->close		= i8042_close;
@@ -1008,7 +1008,7 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type		= SERIO_8042;
+		serio->id.type		= SERIO_8042;
 		serio->write		= i8042_aux_write;
 		serio->open		= i8042_open;
 		serio->close		= i8042_close;
diff -Nru a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
--- a/drivers/input/serio/maceps2.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/maceps2.c	2004-11-24 01:48:30 -05:00
@@ -125,7 +125,7 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type		= SERIO_8042;
+		serio->id.type		= SERIO_8042;
 		serio->write		= maceps2_write;
 		serio->open		= maceps2_open;
 		serio->close		= maceps2_close;
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/parkbd.c	2004-11-24 01:48:30 -05:00
@@ -158,7 +158,7 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type = parkbd_mode;
+		serio->id.type = parkbd_mode;
 		serio->write = parkbd_write,
 		strlcpy(serio->name, "PARKBD AT/XT keyboard adapter", sizeof(serio->name));
 		snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", parkbd_dev->port->name);
diff -Nru a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
--- a/drivers/input/serio/pcips2.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/pcips2.c	2004-11-24 01:48:30 -05:00
@@ -150,7 +150,7 @@
 	memset(ps2if, 0, sizeof(struct pcips2_data));
 	memset(serio, 0, sizeof(struct serio));
 
-	serio->type		= SERIO_8042;
+	serio->id.type		= SERIO_8042;
 	serio->write		= pcips2_write;
 	serio->open		= pcips2_open;
 	serio->close		= pcips2_close;
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/q40kbd.c	2004-11-24 01:48:30 -05:00
@@ -122,7 +122,7 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type		= SERIO_8042;
+		serio->id.type		= SERIO_8042;
 		serio->open		= q40kbd_open;
 		serio->close		= q40kbd_close;
 		serio->dev.parent	= &q40kbd_device->dev;
diff -Nru a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- a/drivers/input/serio/rpckbd.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/rpckbd.c	2004-11-24 01:48:30 -05:00
@@ -115,7 +115,7 @@
 		return -ENOMEM;
 
 	memset(serio, 0, sizeof(struct serio));
-	serio->type		= SERIO_8042;
+	serio->id.type		= SERIO_8042;
 	serio->write		= rpckbd_write;
 	serio->open		= rpckbd_open;
 	serio->close		= rpckbd_close;
diff -Nru a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
--- a/drivers/input/serio/sa1111ps2.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/sa1111ps2.c	2004-11-24 01:48:30 -05:00
@@ -245,7 +245,7 @@
 	memset(ps2if, 0, sizeof(struct ps2if));
 	memset(serio, 0, sizeof(struct serio));
 
-	serio->type		= SERIO_8042;
+	serio->id.type		= SERIO_8042;
 	serio->write		= ps2_write;
 	serio->open		= ps2_open;
 	serio->close		= ps2_close;
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/serio.c	2004-11-24 01:48:30 -05:00
@@ -69,17 +69,33 @@
 static void serio_reconnect_port(struct serio *serio);
 static void serio_disconnect_port(struct serio *serio);
 
+static int serio_match_port(const struct serio_id *ids, struct serio *serio)
+{
+	while (ids->type || ids->proto) {
+		if ((ids->type == SERIO_ANY || ids->type == serio->id.type) ||
+		    (ids->proto == SERIO_ANY || ids->proto == serio->id.proto) ||
+		    (ids->extra == SERIO_ANY || ids->extra == serio->id.extra) ||
+		    (ids->id == SERIO_ANY || ids->id == serio->id.id))
+			return 1;
+		ids++;
+	}
+	return 0;
+}
+
 static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
 {
 	get_driver(&drv->driver);
 
-	drv->connect(serio, drv);
-	if (serio->drv) {
-		down_write(&serio_bus.subsys.rwsem);
-		serio->dev.driver = &drv->driver;
-		device_bind_driver(&serio->dev);
-		up_write(&serio_bus.subsys.rwsem);
-		return 1;
+	if (serio_match_port(drv->ids, serio)) {
+		drv->connect(serio, drv);
+
+		if (serio->drv) {
+			down_write(&serio_bus.subsys.rwsem);
+			serio->dev.driver = &drv->driver;
+			device_bind_driver(&serio->dev);
+			up_write(&serio_bus.subsys.rwsem);
+			return 1;
+		}
 	}
 
 	put_driver(&drv->driver);
diff -Nru a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
--- a/drivers/input/serio/serio_raw.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/serio_raw.c	2004-11-24 01:48:30 -05:00
@@ -275,9 +275,6 @@
 	struct serio_raw *serio_raw;
 	int err;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_8042)
-		return;
-
 	if (!(serio_raw = kmalloc(sizeof(struct serio_raw), GFP_KERNEL))) {
 		printk(KERN_ERR "serio_raw.c: can't allocate memory for a device\n");
 		return;
@@ -363,11 +360,22 @@
 	up(&serio_raw_sem);
 }
 
+static struct serio_id serio_raw_serio_ids[] = {
+	{
+		.type	= SERIO_8042,
+		.proto	= SERIO_ANY,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver serio_raw_drv = {
 	.driver		= {
 		.name	= "serio_raw",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= serio_raw_serio_ids,
 	.interrupt	= serio_raw_interrupt,
 	.connect	= serio_raw_connect,
 	.reconnect	= serio_raw_reconnect,
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/serio/serport.c	2004-11-24 01:48:30 -05:00
@@ -49,7 +49,7 @@
 {
 	struct serport *serport = serio->port_data;
 
-	serport->serio->type = 0;
+	serport->serio->id.type = 0;
 	wake_up_interruptible(&serport->wait);
 }
 
@@ -81,7 +81,7 @@
 	memset(serio, 0, sizeof(struct serio));
 	strlcpy(serio->name, "Serial port", sizeof(serio->name));
 	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", tty_name(tty, name));
-	serio->type = SERIO_RS232;
+	serio->id.type = SERIO_RS232;
 	serio->write = serport_serio_write;
 	serio->close = serport_serio_close;
 	serio->port_data = serport;
@@ -145,7 +145,7 @@
 
 	serio_register_port(serport->serio);
 	printk(KERN_INFO "serio: Serial port %s\n", tty_name(tty, name));
-	wait_event_interruptible(serport->wait, !serport->serio->type);
+	wait_event_interruptible(serport->wait, !serport->serio->id.type);
 	serio_unregister_port(serport->serio);
 
 	clear_bit(SERPORT_BUSY, &serport->flags);
@@ -160,9 +160,17 @@
 static int serport_ldisc_ioctl(struct tty_struct * tty, struct file * file, unsigned int cmd, unsigned long arg)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
+	struct serio *serio = serport->serio;
+	unsigned long type;
 
-	if (cmd == SPIOCSTYPE)
-		return get_user(serport->serio->type, (unsigned long __user *) arg);
+	if (cmd == SPIOCSTYPE) {
+		if (get_user(type, (unsigned long __user *) arg))
+			return -EFAULT;
+
+		serio->id.proto	= type & 0x000000ff;
+		serio->id.id	= (type & 0x0000ff00) >> 8;
+		serio->id.extra	= (type & 0x00ff0000) >> 16;
+	}
 
 	return -EINVAL;
 }
diff -Nru a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
--- a/drivers/input/touchscreen/gunze.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/touchscreen/gunze.c	2004-11-24 01:48:30 -05:00
@@ -111,17 +111,14 @@
 
 /*
  * gunze_connect() is the routine that is called when someone adds a
- * new serio device. It looks whether it was registered as a Gunze touchscreen
- * and if yes, registers it as an input device.
+ * new serio device that supports Gunze protocol and registers it as
+ * an input device.
  */
 
 static void gunze_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct gunze *gunze;
 
-	if (serio->type != (SERIO_RS232 | SERIO_GUNZE))
-		return;
-
 	if (!(gunze = kmalloc(sizeof(struct gunze), GFP_KERNEL)))
 		return;
 
@@ -159,14 +156,25 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id gunze_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_GUNZE,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver gunze_drv = {
 	.driver		= {
 		.name	= "gunze",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= gunze_serio_ids,
 	.interrupt	= gunze_interrupt,
 	.connect	= gunze_connect,
 	.disconnect	= gunze_disconnect,
diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-11-24 01:48:30 -05:00
@@ -102,6 +102,7 @@
 	struct input_dev dev;
 	struct pm_dev *pm_dev;
 	struct serio *serio;
+	struct pm_dev *pm_dev;
 	unsigned char event;	/* event ID from packet */
 	unsigned char chksum;
 	unsigned char len;
@@ -373,16 +374,13 @@
 
 /*
  * h3600ts_connect() is the routine that is called when someone adds a
- * new serio device. It looks whether it was registered as a H3600 touchscreen
- * and if yes, registers it as an input device.
+ * new serio device that supports H3600 protocol and registers it as
+ * an input device.
  */
 static void h3600ts_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct h3600_dev *ts;
 
-	if (serio->type != (SERIO_RS232 | SERIO_H3600))
-		return;
-
 	if (!(ts = kmalloc(sizeof(struct h3600_dev), GFP_KERNEL)))
 		return;
 
@@ -481,14 +479,25 @@
 }
 
 /*
- * The serio device structure.
+ * The serio driver structure.
  */
 
+static struct serio_id h3600ts_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_H3600,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
 static struct serio_driver h3600ts_drv = {
 	.driver		= {
 		.name	= "h3600ts",
 	},
 	.description	= DRIVER_DESC,
+	.ids		= h3600ts_serio_ids,
 	.interrupt	= h3600ts_interrupt,
 	.connect	= h3600ts_connect,
 	.disconnect	= h3600ts_disconnect,
diff -Nru a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
--- a/drivers/serial/sunsu.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/serial/sunsu.c	2004-11-24 01:48:30 -05:00
@@ -1312,12 +1312,13 @@
 
 		serio->port_data = up;
 
-		serio->type = SERIO_RS232;
+		serio->id.type = SERIO_RS232;
 		if (up->su_type == SU_PORT_KBD) {
-			serio->type |= SERIO_SUNKBD;
+			serio->id.proto = SERIO_SUNKBD;
 			strlcpy(serio->name, "sukbd", sizeof(serio->name));
 		} else {
-			serio->type |= (SERIO_SUN | (1 << 16));
+			serio->id.proto = SERIO_SUN;
+			serio->id.extra = 1;
 			strlcpy(serio->name, "sums", sizeof(serio->name));
 		}
 		strlcpy(serio->phys, (channel == 0 ? "su/serio0" : "su/serio1"),
diff -Nru a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c	2004-11-24 01:48:30 -05:00
+++ b/drivers/serial/sunzilog.c	2004-11-24 01:48:30 -05:00
@@ -1560,12 +1560,13 @@
 
 		serio->port_data = up;
 
-		serio->type = SERIO_RS232;
+		serio->id.type = SERIO_RS232;
 		if (channel == KEYBOARD_LINE) {
-			serio->type |= SERIO_SUNKBD;
+			serio->id.proto = SERIO_SUNKBD;
 			strlcpy(serio->name, "zskbd", sizeof(serio->name));
 		} else {
-			serio->type |= (SERIO_SUN | (1 << 16));
+			serio->id.proto = SERIO_SUN;
+			serio->id.extra = 1;
 			strlcpy(serio->name, "zsms", sizeof(serio->name));
 		}
 		strlcpy(serio->phys,
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-11-24 01:48:30 -05:00
+++ b/include/linux/serio.h	2004-11-24 01:48:30 -05:00
@@ -20,6 +20,13 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 
+struct serio_id {
+	unsigned char type;
+	unsigned char extra;
+	unsigned char id;
+	unsigned char proto;
+};
+
 struct serio {
 	void *port_data;
 
@@ -28,13 +35,7 @@
 
 	unsigned int manual_bind;
 
-	unsigned short idbus;
-	unsigned short idvendor;
-	unsigned short idproduct;
-	unsigned short idversion;
-
-	unsigned long type;
-	unsigned long event;
+	struct serio_id id;
 
 	spinlock_t lock;		/* protects critical sections from port's interrupt handler */
 
@@ -59,6 +60,7 @@
 	void *private;
 	char *description;
 
+	struct serio_id *ids;
 	unsigned int manual_bind;
 
 	void (*write_wakeup)(struct serio *);
@@ -160,15 +162,22 @@
 #define SERIO_PARITY	2
 #define SERIO_FRAME	4
 
-#define SERIO_TYPE	0xff000000UL
-#define SERIO_XT	0x00000000UL
-#define SERIO_8042	0x01000000UL
-#define SERIO_RS232	0x02000000UL
-#define SERIO_HIL_MLC	0x03000000UL
-#define SERIO_PS_PSTHRU	0x05000000UL
-#define SERIO_8042_XL	0x06000000UL
+#define SERIO_ANY	0xff
 
-#define SERIO_PROTO	0xFFUL
+/*
+ * Serio types
+ */
+#define SERIO_XT	0x00
+#define SERIO_8042	0x01
+#define SERIO_RS232	0x02
+#define SERIO_HIL_MLC	0x03
+#define SERIO_PS_PSTHRU	0x05
+#define SERIO_8042_XL	0x06
+
+/*
+ * Serio types
+ */
+#define SERIO_UNKNOWN	0x00
 #define SERIO_MSC	0x01
 #define SERIO_SUN	0x02
 #define SERIO_MS	0x03
@@ -195,8 +204,5 @@
 #define SERIO_SNES232	0x26
 #define SERIO_SEMTECH	0x27
 #define SERIO_LKKBD	0x28
-
-#define SERIO_ID	0xff00UL
-#define SERIO_EXTRA	0xff0000UL
 
 #endif
