Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWANQCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWANQCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWANQCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:02:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14520 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964791AbWANQCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:02:43 -0500
Date: Sat, 14 Jan 2006 17:02:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.15-mm4] sem2mutex: drivers/input/, #2
Message-ID: <20060114160253.GA1073@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/input/joystick/db9.c                |   13 +++++-----
 drivers/input/joystick/gamecon.c            |   13 +++++-----
 drivers/input/joystick/iforce/iforce-ff.c   |   24 +++++++++----------
 drivers/input/joystick/iforce/iforce-main.c |    2 -
 drivers/input/joystick/iforce/iforce.h      |    5 ++--
 drivers/input/joystick/turbografx.c         |   13 +++++-----
 drivers/input/keyboard/atkbd.c              |    9 ++++---
 drivers/input/mouse/psmouse-base.c          |   34 ++++++++++++++--------------
 8 files changed, 60 insertions(+), 53 deletions(-)

Index: linux/drivers/input/joystick/db9.c
===================================================================
--- linux.orig/drivers/input/joystick/db9.c
+++ linux/drivers/input/joystick/db9.c
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/parport.h>
 #include <linux/input.h>
+#include <linux/mutex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Atari, Amstrad, Commodore, Amiga, Sega, etc. joystick driver");
@@ -111,7 +112,7 @@ struct db9 {
 	struct pardevice *pd;
 	int mode;
 	int used;
-	struct semaphore sem;
+	struct mutex mutex;
 	char phys[DB9_MAX_DEVICES][32];
 };
 
@@ -523,7 +524,7 @@ static int db9_open(struct input_dev *de
 	struct parport *port = db9->pd->port;
 	int err;
 
-	err = down_interruptible(&db9->sem);
+	err = mutex_lock_interruptible(&db9->mutex);
 	if (err)
 		return err;
 
@@ -537,7 +538,7 @@ static int db9_open(struct input_dev *de
 		mod_timer(&db9->timer, jiffies + DB9_REFRESH_TIME);
 	}
 
-	up(&db9->sem);
+	mutex_unlock(&db9->mutex);
 	return 0;
 }
 
@@ -546,14 +547,14 @@ static void db9_close(struct input_dev *
 	struct db9 *db9 = dev->private;
 	struct parport *port = db9->pd->port;
 
-	down(&db9->sem);
+	mutex_lock(&db9->mutex);
 	if (!--db9->used) {
 		del_timer_sync(&db9->timer);
 		parport_write_control(port, 0x00);
 		parport_data_forward(port);
 		parport_release(db9->pd);
 	}
-	up(&db9->sem);
+	mutex_unlock(&db9->mutex);
 }
 
 static struct db9 __init *db9_probe(int parport, int mode)
@@ -601,7 +602,7 @@ static struct db9 __init *db9_probe(int 
 		goto err_unreg_pardev;
 	}
 
-	init_MUTEX(&db9->sem);
+	mutex_init(&db9->mutex);
 	db9->pd = pd;
 	db9->mode = mode;
 	init_timer(&db9->timer);
Index: linux/drivers/input/joystick/gamecon.c
===================================================================
--- linux.orig/drivers/input/joystick/gamecon.c
+++ linux/drivers/input/joystick/gamecon.c
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/parport.h>
 #include <linux/input.h>
+#include <linux/mutex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("NES, SNES, N64, MultiSystem, PSX gamepad driver");
@@ -83,7 +84,7 @@ struct gc {
 	struct timer_list timer;
 	unsigned char pads[GC_MAX + 1];
 	int used;
-	struct semaphore sem;
+	struct mutex mutex;
 	char phys[GC_MAX_DEVICES][32];
 };
 
@@ -507,7 +508,7 @@ static int gc_open(struct input_dev *dev
 	struct gc *gc = dev->private;
 	int err;
 
-	err = down_interruptible(&gc->sem);
+	err = mutex_lock_interruptible(&gc->mutex);
 	if (err)
 		return err;
 
@@ -517,7 +518,7 @@ static int gc_open(struct input_dev *dev
 		mod_timer(&gc->timer, jiffies + GC_REFRESH_TIME);
 	}
 
-	up(&gc->sem);
+	mutex_unlock(&gc->mutex);
 	return 0;
 }
 
@@ -525,13 +526,13 @@ static void gc_close(struct input_dev *d
 {
 	struct gc *gc = dev->private;
 
-	down(&gc->sem);
+	mutex_lock(&gc->mutex);
 	if (!--gc->used) {
 		del_timer_sync(&gc->timer);
 		parport_write_control(gc->pd->port, 0x00);
 		parport_release(gc->pd);
 	}
-	up(&gc->sem);
+	mutex_unlock(&gc->mutex);
 }
 
 static int __init gc_setup_pad(struct gc *gc, int idx, int pad_type)
@@ -648,7 +649,7 @@ static struct gc __init *gc_probe(int pa
 		goto err_unreg_pardev;
 	}
 
-	init_MUTEX(&gc->sem);
+	mutex_init(&gc->mutex);
 	gc->pd = pd;
 	init_timer(&gc->timer);
 	gc->timer.data = (long) gc;
Index: linux/drivers/input/joystick/iforce/iforce-ff.c
===================================================================
--- linux.orig/drivers/input/joystick/iforce/iforce-ff.c
+++ linux/drivers/input/joystick/iforce/iforce-ff.c
@@ -42,14 +42,14 @@ static int make_magnitude_modifier(struc
 	unsigned char data[3];
 
 	if (!no_alloc) {
-		down(&iforce->mem_mutex);
+		mutex_lock(&iforce->mem_mutex);
 		if (allocate_resource(&(iforce->device_memory), mod_chunk, 2,
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
-			up(&iforce->mem_mutex);
+			mutex_unlock(&iforce->mem_mutex);
 			return -ENOMEM;
 		}
-		up(&iforce->mem_mutex);
+		mutex_unlock(&iforce->mem_mutex);
 	}
 
 	data[0] = LO(mod_chunk->start);
@@ -75,14 +75,14 @@ static int make_period_modifier(struct i
 	period = TIME_SCALE(period);
 
 	if (!no_alloc) {
-		down(&iforce->mem_mutex);
+		mutex_lock(&iforce->mem_mutex);
 		if (allocate_resource(&(iforce->device_memory), mod_chunk, 0x0c,
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
-			up(&iforce->mem_mutex);
+			mutex_unlock(&iforce->mem_mutex);
 			return -ENOMEM;
 		}
-		up(&iforce->mem_mutex);
+		mutex_unlock(&iforce->mem_mutex);
 	}
 
 	data[0] = LO(mod_chunk->start);
@@ -115,14 +115,14 @@ static int make_envelope_modifier(struct
 	fade_duration = TIME_SCALE(fade_duration);
 
 	if (!no_alloc) {
-		down(&iforce->mem_mutex);
+		mutex_lock(&iforce->mem_mutex);
 		if (allocate_resource(&(iforce->device_memory), mod_chunk, 0x0e,
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
-			up(&iforce->mem_mutex);
+			mutex_unlock(&iforce->mem_mutex);
 			return -ENOMEM;
 		}
-		up(&iforce->mem_mutex);
+		mutex_unlock(&iforce->mem_mutex);
 	}
 
 	data[0] = LO(mod_chunk->start);
@@ -152,14 +152,14 @@ static int make_condition_modifier(struc
 	unsigned char data[10];
 
 	if (!no_alloc) {
-		down(&iforce->mem_mutex);
+		mutex_lock(&iforce->mem_mutex);
 		if (allocate_resource(&(iforce->device_memory), mod_chunk, 8,
 			iforce->device_memory.start, iforce->device_memory.end, 2L,
 			NULL, NULL)) {
-			up(&iforce->mem_mutex);
+			mutex_unlock(&iforce->mem_mutex);
 			return -ENOMEM;
 		}
-		up(&iforce->mem_mutex);
+		mutex_unlock(&iforce->mem_mutex);
 	}
 
 	data[0] = LO(mod_chunk->start);
Index: linux/drivers/input/joystick/iforce/iforce-main.c
===================================================================
--- linux.orig/drivers/input/joystick/iforce/iforce-main.c
+++ linux/drivers/input/joystick/iforce/iforce-main.c
@@ -350,7 +350,7 @@ int iforce_init_device(struct iforce *if
 
 	init_waitqueue_head(&iforce->wait);
 	spin_lock_init(&iforce->xmit_lock);
-	init_MUTEX(&iforce->mem_mutex);
+	mutex_init(&iforce->mem_mutex);
 	iforce->xmit.buf = iforce->xmit_data;
 	iforce->dev = input_dev;
 
Index: linux/drivers/input/joystick/iforce/iforce.h
===================================================================
--- linux.orig/drivers/input/joystick/iforce/iforce.h
+++ linux/drivers/input/joystick/iforce/iforce.h
@@ -37,7 +37,7 @@
 #include <linux/serio.h>
 #include <linux/config.h>
 #include <linux/circ_buf.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 /* This module provides arbitrary resource management routines.
  * I use it to manage the device's memory.
@@ -45,6 +45,7 @@
  */
 #include <linux/ioport.h>
 
+
 #define IFORCE_MAX_LENGTH	16
 
 /* iforce::bus */
@@ -146,7 +147,7 @@ struct iforce {
 	wait_queue_head_t wait;
 	struct resource device_memory;
 	struct iforce_core_effect core_effects[FF_EFFECTS_MAX];
-	struct semaphore mem_mutex;
+	struct mutex mem_mutex;
 };
 
 /* Get hi and low bytes of a 16-bits int */
Index: linux/drivers/input/joystick/turbografx.c
===================================================================
--- linux.orig/drivers/input/joystick/turbografx.c
+++ linux/drivers/input/joystick/turbografx.c
@@ -37,6 +37,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("TurboGraFX parallel port interface driver");
@@ -86,7 +87,7 @@ static struct tgfx {
 	char phys[TGFX_MAX_DEVICES][32];
 	int sticks;
 	int used;
-	struct semaphore sem;
+	struct mutex sem;
 } *tgfx_base[TGFX_MAX_PORTS];
 
 /*
@@ -128,7 +129,7 @@ static int tgfx_open(struct input_dev *d
 	struct tgfx *tgfx = dev->private;
 	int err;
 
-	err = down_interruptible(&tgfx->sem);
+	err = mutex_lock_interruptible(&tgfx->sem);
 	if (err)
 		return err;
 
@@ -138,7 +139,7 @@ static int tgfx_open(struct input_dev *d
 		mod_timer(&tgfx->timer, jiffies + TGFX_REFRESH_TIME);
 	}
 
-	up(&tgfx->sem);
+	mutex_unlock(&tgfx->sem);
 	return 0;
 }
 
@@ -146,13 +147,13 @@ static void tgfx_close(struct input_dev 
 {
 	struct tgfx *tgfx = dev->private;
 
-	down(&tgfx->sem);
+	mutex_lock(&tgfx->sem);
 	if (!--tgfx->used) {
 		del_timer_sync(&tgfx->timer);
 		parport_write_control(tgfx->pd->port, 0x00);
 		parport_release(tgfx->pd);
 	}
-	up(&tgfx->sem);
+	mutex_unlock(&tgfx->sem);
 }
 
 
@@ -191,7 +192,7 @@ static struct tgfx __init *tgfx_probe(in
 		goto err_unreg_pardev;
 	}
 
-	init_MUTEX(&tgfx->sem);
+	mutex_init(&tgfx->sem);
 	tgfx->pd = pd;
 	init_timer(&tgfx->timer);
 	tgfx->timer.data = (long) tgfx;
Index: linux/drivers/input/keyboard/atkbd.c
===================================================================
--- linux.orig/drivers/input/keyboard/atkbd.c
+++ linux/drivers/input/keyboard/atkbd.c
@@ -27,6 +27,7 @@
 #include <linux/serio.h>
 #include <linux/workqueue.h>
 #include <linux/libps2.h>
+#include <linux/mutex.h>
 
 #define DRIVER_DESC	"AT and PS/2 keyboard driver"
 
@@ -216,7 +217,7 @@ struct atkbd {
 	unsigned long time;
 
 	struct work_struct event_work;
-	struct semaphore event_sem;
+	struct mutex event_mutex;
 	unsigned long event_mask;
 };
 
@@ -452,7 +453,7 @@ static void atkbd_event_work(void *data)
 	unsigned char param[2];
 	int i, j;
 
-	down(&atkbd->event_sem);
+	mutex_lock(&atkbd->event_mutex);
 
 	if (test_and_clear_bit(ATKBD_LED_EVENT_BIT, &atkbd->event_mask)) {
 		param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
@@ -483,7 +484,7 @@ static void atkbd_event_work(void *data)
 		ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETREP);
 	}
 
-	up(&atkbd->event_sem);
+	mutex_unlock(&atkbd->event_mutex);
 }
 
 /*
@@ -849,7 +850,7 @@ static int atkbd_connect(struct serio *s
 	atkbd->dev = dev;
 	ps2_init(&atkbd->ps2dev, serio);
 	INIT_WORK(&atkbd->event_work, atkbd_event_work, atkbd);
-	init_MUTEX(&atkbd->event_sem);
+	mutex_init(&atkbd->event_mutex);
 
 	switch (serio->id.type) {
 
Index: linux/drivers/input/mouse/psmouse-base.c
===================================================================
--- linux.orig/drivers/input/mouse/psmouse-base.c
+++ linux/drivers/input/mouse/psmouse-base.c
@@ -20,6 +20,8 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 #include <linux/libps2.h>
+#include <linux/mutex.h>
+
 #include "psmouse.h"
 #include "synaptics.h"
 #include "logips2pp.h"
@@ -99,13 +101,13 @@ __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
 /*
- * psmouse_sem protects all operations changing state of mouse
+ * psmouse_mutex protects all operations changing state of mouse
  * (connecting, disconnecting, changing rate or resolution via
  * sysfs). We could use a per-device semaphore but since there
  * rarely more than one PS/2 mouse connected and since semaphore
  * is taken in "slow" paths it is not worth it.
  */
-static DECLARE_MUTEX(psmouse_sem);
+static DEFINE_MUTEX(psmouse_mutex);
 
 static struct workqueue_struct *kpsmoused_wq;
 
@@ -882,7 +884,7 @@ static void psmouse_resync(void *p)
 	int failed = 0, enabled = 0;
 	int i;
 
-	down(&psmouse_sem);
+	mutex_lock(&psmouse_mutex);
 
 	if (psmouse->state != PSMOUSE_RESYNCING)
 		goto out;
@@ -962,7 +964,7 @@ static void psmouse_resync(void *p)
 	if (parent)
 		psmouse_activate(parent);
  out:
-	up(&psmouse_sem);
+	mutex_unlock(&psmouse_mutex);
 }
 
 /*
@@ -988,14 +990,14 @@ static void psmouse_disconnect(struct se
 
 	sysfs_remove_group(&serio->dev.kobj, &psmouse_attribute_group);
 
-	down(&psmouse_sem);
+	mutex_lock(&psmouse_mutex);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	/* make sure we don't have a resync in progress */
-	up(&psmouse_sem);
+	mutex_unlock(&psmouse_mutex);
 	flush_workqueue(kpsmoused_wq);
-	down(&psmouse_sem);
+	mutex_lock(&psmouse_mutex);
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
@@ -1018,7 +1020,7 @@ static void psmouse_disconnect(struct se
 	if (parent)
 		psmouse_activate(parent);
 
-	up(&psmouse_sem);
+	mutex_unlock(&psmouse_mutex);
 }
 
 static int psmouse_switch_protocol(struct psmouse *psmouse, struct psmouse_protocol *proto)
@@ -1090,7 +1092,7 @@ static int psmouse_connect(struct serio 
 	struct input_dev *input_dev;
 	int retval = -ENOMEM;
 
-	down(&psmouse_sem);
+	mutex_lock(&psmouse_mutex);
 
 	/*
 	 * If this is a pass-through port deactivate parent so the device
@@ -1158,7 +1160,7 @@ out:
 	if (parent)
 		psmouse_activate(parent);
 
-	up(&psmouse_sem);
+	mutex_unlock(&psmouse_mutex);
 	return retval;
 }
 
@@ -1175,7 +1177,7 @@ static int psmouse_reconnect(struct seri
 		return -1;
 	}
 
-	down(&psmouse_sem);
+	mutex_lock(&psmouse_mutex);
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
 		parent = serio_get_drvdata(serio->parent);
@@ -1209,7 +1211,7 @@ out:
 	if (parent)
 		psmouse_activate(parent);
 
-	up(&psmouse_sem);
+	mutex_unlock(&psmouse_mutex);
 	return rc;
 }
 
@@ -1287,7 +1289,7 @@ ssize_t psmouse_attr_set_helper(struct d
 		goto out_unpin;
 	}
 
-	retval = down_interruptible(&psmouse_sem);
+	retval = mutex_lock_interruptible(&psmouse_mutex);
 	if (retval)
 		goto out_unpin;
 
@@ -1314,7 +1316,7 @@ ssize_t psmouse_attr_set_helper(struct d
 		psmouse_activate(parent);
 
  out_up:
-	up(&psmouse_sem);
+	mutex_unlock(&psmouse_mutex);
  out_unpin:
 	serio_unpin_driver(serio);
 	return retval;
@@ -1371,11 +1373,11 @@ static ssize_t psmouse_attr_set_protocol
 			return -EIO;
 		}
 
-		up(&psmouse_sem);
+		mutex_unlock(&psmouse_mutex);
 		serio_unpin_driver(serio);
 		serio_unregister_child_port(serio);
 		serio_pin_driver_uninterruptible(serio);
-		down(&psmouse_sem);
+		mutex_lock(&psmouse_mutex);
 
 		if (serio->drv != &psmouse_drv) {
 			input_free_device(new_dev);
