Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVBOFoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVBOFoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 00:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVBOFoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 00:44:55 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:9855 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261632AbVBOFmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 00:42:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [RCF/RFT] Fix race timer race in gameport-based joystick drivers
Date: Tue, 15 Feb 2005 00:42:31 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502150042.32564.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There seems to be a race WRT to timer handling in all gameport-based
joystick drivers. open() and close() methods are used to start and
stop polling timers on demand but counter and the timer itself is not
protected in any way so if several clients will try to open/close
corresponding input device node they could up with timer not running
at all or running while nobody has the node open. Plus it is possible
that disconnect will run and free driver structure while timer is running
on other CPU.

I have moved timer and counter down into gameport structure (I think it
is ok because on the one hand joysticks are the only users of gameport
and on the other hand polling timer can be useful to other clients if
ever writen), and added helper functions to manipulate it:

	- gameport_start_polling(gameport)
	- gameport_stop_polling(gameport)
	- gameport_set_poll_handler(gameoirt, handler)
	- gameport_set_poll_interval(gameport, msecs)

gameport_{start|stop}_poll handler are using spinlock to guarantee that
timer updated properly. Also, gameport_close deletes (synchronously) timer
to make sure there is no surprises since gameport_stop_poling does del_timer
and thus may leave timer scheduled. Timer routine also checks the counter
and does not restart it if there are no users.

Please let me know what you think.
 
-- 
Dmitry

===================================================================

Input: fix race timer handling races in gameport-based joystick drivers
       by moving pollig timer down into gameport and using spinlock to
       protect it.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/gameport/gameport.c  |   42 ++++++++++++++++++++++++++++++++++++-
 drivers/input/joystick/a3d.c       |   38 ++++++++++++++-------------------
 drivers/input/joystick/adi.c       |   25 +++++++++-------------
 drivers/input/joystick/analog.c    |   25 ++++++++--------------
 drivers/input/joystick/cobra.c     |   28 ++++++++++--------------
 drivers/input/joystick/gf2k.c      |   30 +++++++++++---------------
 drivers/input/joystick/grip.c      |   24 +++++++--------------
 drivers/input/joystick/grip_mp.c   |   30 ++++++--------------------
 drivers/input/joystick/guillemot.c |   23 +++++++-------------
 drivers/input/joystick/interact.c  |   24 +++++++--------------
 drivers/input/joystick/tmdc.c      |   25 ++++++++--------------
 include/linux/gameport.h           |   19 ++++++++++++++++
 12 files changed, 165 insertions(+), 168 deletions(-)


Index: dtor/drivers/input/joystick/guillemot.c
===================================================================
--- dtor.orig/drivers/input/joystick/guillemot.c
+++ dtor/drivers/input/joystick/guillemot.c
@@ -45,7 +45,6 @@ MODULE_LICENSE("GPL");
 #define GUILLEMOT_MAX_START	600	/* 600 us */
 #define GUILLEMOT_MAX_STROBE	60	/* 60 us */
 #define GUILLEMOT_MAX_LENGTH	17	/* 17 bytes */
-#define GUILLEMOT_REFRESH_TIME	HZ/50	/* 20 ms */
 
 static short guillemot_abs_pad[] =
 	{ ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, -1 };
@@ -69,8 +68,6 @@ struct guillemot_type {
 struct guillemot {
 	struct gameport *gameport;
 	struct input_dev dev;
-	struct timer_list timer;
-	int used;
 	int bads;
 	int reads;
 	struct guillemot_type *type;
@@ -120,12 +117,12 @@ static int guillemot_read_packet(struct 
 }
 
 /*
- * guillemot_timer() reads and analyzes Guillemot joystick data.
+ * guillemot_poll() reads and analyzes Guillemot joystick data.
  */
 
-static void guillemot_timer(unsigned long private)
+static void guillemot_poll(struct gameport *gameport)
 {
-	struct guillemot *guillemot = (struct guillemot *) private;
+	struct guillemot *guillemot = gameport_get_drvdata(gameport);
 	struct input_dev *dev = &guillemot->dev;
 	u8 data[GUILLEMOT_MAX_LENGTH];
 	int i;
@@ -150,8 +147,6 @@ static void guillemot_timer(unsigned lon
 	}
 
 	input_sync(dev);
-
-	mod_timer(&guillemot->timer, jiffies + GUILLEMOT_REFRESH_TIME);
 }
 
 /*
@@ -162,8 +157,7 @@ static int guillemot_open(struct input_d
 {
 	struct guillemot *guillemot = dev->private;
 
-	if (!guillemot->used++)
-		mod_timer(&guillemot->timer, jiffies + GUILLEMOT_REFRESH_TIME);
+	gameport_start_polling(guillemot->gameport);
 	return 0;
 }
 
@@ -175,8 +169,7 @@ static void guillemot_close(struct input
 {
 	struct guillemot *guillemot = dev->private;
 
-	if (!--guillemot->used)
-		del_timer(&guillemot->timer);
+	gameport_stop_polling(guillemot->gameport);
 }
 
 /*
@@ -194,9 +187,6 @@ static int guillemot_connect(struct game
 		return -ENOMEM;
 
 	guillemot->gameport = gameport;
-	init_timer(&guillemot->timer);
-	guillemot->timer.data = (long) guillemot;
-	guillemot->timer.function = guillemot_timer;
 
 	gameport_set_drvdata(gameport, guillemot);
 
@@ -222,6 +212,9 @@ static int guillemot_connect(struct game
 		goto fail2;
 	}
 
+	gameport_set_poll_handler(gameport, guillemot_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	sprintf(guillemot->phys, "%s/input0", gameport->phys);
 
 	guillemot->type = guillemot_type + i;
Index: dtor/drivers/input/joystick/a3d.c
===================================================================
--- dtor.orig/drivers/input/joystick/a3d.c
+++ dtor/drivers/input/joystick/a3d.c
@@ -45,7 +45,6 @@ MODULE_LICENSE("GPL");
 #define A3D_MAX_STROBE		60	/* 40 us */
 #define A3D_DELAY_READ		3	/* 3 ms */
 #define A3D_MAX_LENGTH		40	/* 40*3 bits */
-#define A3D_REFRESH_TIME	HZ/50	/* 20 ms */
 
 #define A3D_MODE_A3D		1	/* Assassin 3D */
 #define A3D_MODE_PAN		2	/* Panther */
@@ -59,12 +58,10 @@ struct a3d {
 	struct gameport *gameport;
 	struct gameport *adc;
 	struct input_dev dev;
-	struct timer_list timer;
 	int axes[4];
 	int buttons;
 	int mode;
 	int length;
-	int used;
 	int reads;
 	int bads;
 	char phys[32];
@@ -178,19 +175,20 @@ static void a3d_read(struct a3d *a3d, un
 
 
 /*
- * a3d_timer() reads and analyzes A3D joystick data.
+ * a3d_poll() reads and analyzes A3D joystick data.
  */
 
-static void a3d_timer(unsigned long private)
+static void a3d_poll(struct gameport *gameport)
 {
-	struct a3d *a3d = (void *) private;
+	struct a3d *a3d = gameport_get_drvdata(gameport);
 	unsigned char data[A3D_MAX_LENGTH];
 
 	a3d->reads++;
-	if (a3d_read_packet(a3d->gameport, a3d->length, data) != a3d->length
-		|| data[0] != a3d->mode || a3d_csum(data, a3d->length))
-	 	a3d->bads++; else a3d_read(a3d, data);
-	mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);
+	if (a3d_read_packet(a3d->gameport, a3d->length, data) != a3d->length ||
+	    data[0] != a3d->mode || a3d_csum(data, a3d->length))
+	 	a3d->bads++;
+	else
+		a3d_read(a3d, data);
 }
 
 /*
@@ -218,10 +216,11 @@ static int a3d_adc_cooked_read(struct ga
 static int a3d_adc_open(struct gameport *gameport, int mode)
 {
 	struct a3d *a3d = gameport->port_data;
+
 	if (mode != GAMEPORT_MODE_COOKED)
 		return -1;
-	if (!a3d->used++)
-		mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);
+
+	gameport_start_polling(a3d->gameport);
 	return 0;
 }
 
@@ -233,8 +232,7 @@ static void a3d_adc_close(struct gamepor
 {
 	struct a3d *a3d = gameport->port_data;
 
-	if (!--a3d->used)
-		del_timer(&a3d->timer);
+	gameport_stop_polling(a3d->gameport);
 }
 
 /*
@@ -245,8 +243,7 @@ static int a3d_open(struct input_dev *de
 {
 	struct a3d *a3d = dev->private;
 
-	if (!a3d->used++)
-		mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);
+	gameport_start_polling(a3d->gameport);
 	return 0;
 }
 
@@ -258,8 +255,7 @@ static void a3d_close(struct input_dev *
 {
 	struct a3d *a3d = dev->private;
 
-	if (!--a3d->used)
-		del_timer(&a3d->timer);
+	gameport_stop_polling(a3d->gameport);
 }
 
 /*
@@ -278,9 +274,6 @@ static int a3d_connect(struct gameport *
 		return -ENOMEM;
 
 	a3d->gameport = gameport;
-	init_timer(&a3d->timer);
-	a3d->timer.data = (long) a3d;
-	a3d->timer.function = a3d_timer;
 
 	gameport_set_drvdata(gameport, a3d);
 
@@ -304,6 +297,9 @@ static int a3d_connect(struct gameport *
 		goto fail2;
 	}
 
+	gameport_set_poll_handler(gameport, a3d_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	sprintf(a3d->phys, "%s/input0", gameport->phys);
 
 	if (a3d->mode == A3D_MODE_PXL) {
Index: dtor/drivers/input/joystick/grip_mp.c
===================================================================
--- dtor.orig/drivers/input/joystick/grip_mp.c
+++ dtor/drivers/input/joystick/grip_mp.c
@@ -38,11 +38,9 @@ MODULE_LICENSE("GPL");
 
 struct grip_mp {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct input_dev dev[4];
 	int mode[4];
 	int registered[4];
-	int used;
 	int reads;
 	int bads;
 
@@ -81,7 +79,6 @@ struct grip_mp {
  */
 
 #define GRIP_INIT_DELAY         2000          /*  2 ms */
-#define GRIP_REFRESH_TIME       HZ/50	      /* 20 ms */
 
 #define GRIP_MODE_NONE		0
 #define GRIP_MODE_RESET         1
@@ -526,8 +523,9 @@ static void report_slot(struct grip_mp *
  * Get the multiport state.
  */
 
-static void get_and_report_mp_state(struct grip_mp *grip)
+static void grip_poll(struct gameport *gameport)
 {
+	struct grip_mp *grip = gameport_get_drvdata(gameport);
 	int i, npkts, flags;
 
 	for (npkts = 0; npkts < 4; npkts++) {
@@ -554,8 +552,7 @@ static int grip_open(struct input_dev *d
 {
 	struct grip_mp *grip = dev->private;
 
-	if (!grip->used++)
-		mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
+	gameport_start_polling(grip->gameport);
 	return 0;
 }
 
@@ -567,8 +564,7 @@ static void grip_close(struct input_dev 
 {
 	struct grip_mp *grip = dev->private;
 
-	if (!--grip->used)
-		del_timer(&grip->timer);
+	gameport_start_polling(grip->gameport);
 }
 
 /*
@@ -606,18 +602,6 @@ static void register_slot(int slot, stru
 	       grip_name[grip->mode[slot]], slot);
 }
 
-/*
- * Repeatedly polls the multiport and generates events.
- */
-
-static void grip_timer(unsigned long private)
-{
-	struct grip_mp *grip = (void*) private;
-
-	get_and_report_mp_state(grip);
-	mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
-}
-
 static int grip_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct grip_mp *grip;
@@ -627,9 +611,6 @@ static int grip_connect(struct gameport 
 		return -ENOMEM;
 
 	grip->gameport = gameport;
-	init_timer(&grip->timer);
-	grip->timer.data = (long) grip;
-	grip->timer.function = grip_timer;
 
 	gameport_set_drvdata(gameport, grip);
 
@@ -637,6 +618,9 @@ static int grip_connect(struct gameport 
 	if (err)
 		goto fail1;
 
+	gameport_set_poll_handler(gameport, grip_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	if (!multiport_init(grip)) {
 		err = -ENODEV;
 		goto fail2;
Index: dtor/drivers/input/joystick/interact.c
===================================================================
--- dtor.orig/drivers/input/joystick/interact.c
+++ dtor/drivers/input/joystick/interact.c
@@ -48,7 +48,6 @@ MODULE_LICENSE("GPL");
 #define INTERACT_MAX_START	400	/* 400 us */
 #define INTERACT_MAX_STROBE	40	/* 40 us */
 #define INTERACT_MAX_LENGTH	32	/* 32 bits */
-#define INTERACT_REFRESH_TIME	HZ/50	/* 20 ms */
 
 #define INTERACT_TYPE_HHFX	0	/* HammerHead/FX */
 #define INTERACT_TYPE_PP8D	1	/* ProPad 8 */
@@ -56,8 +55,6 @@ MODULE_LICENSE("GPL");
 struct interact {
 	struct gameport *gameport;
 	struct input_dev dev;
-	struct timer_list timer;
-	int used;
 	int bads;
 	int reads;
 	unsigned char type;
@@ -127,12 +124,12 @@ static int interact_read_packet(struct g
 }
 
 /*
- * interact_timer() reads and analyzes InterAct joystick data.
+ * interact_poll() reads and analyzes InterAct joystick data.
  */
 
-static void interact_timer(unsigned long private)
+static void interact_poll(struct gameport *gameport)
 {
-	struct interact *interact = (struct interact *) private;
+	struct interact *interact = gameport_get_drvdata(gameport);
 	struct input_dev *dev = &interact->dev;
 	u32 data[3];
 	int i;
@@ -179,9 +176,6 @@ static void interact_timer(unsigned long
 	}
 
 	input_sync(dev);
-
-	mod_timer(&interact->timer, jiffies + INTERACT_REFRESH_TIME);
-
 }
 
 /*
@@ -192,8 +186,7 @@ static int interact_open(struct input_de
 {
 	struct interact *interact = dev->private;
 
-	if (!interact->used++)
-		mod_timer(&interact->timer, jiffies + INTERACT_REFRESH_TIME);
+	gameport_start_polling(interact->gameport);
 	return 0;
 }
 
@@ -205,8 +198,7 @@ static void interact_close(struct input_
 {
 	struct interact *interact = dev->private;
 
-	if (!--interact->used)
-		del_timer(&interact->timer);
+	gameport_stop_polling(interact->gameport);
 }
 
 /*
@@ -224,9 +216,6 @@ static int interact_connect(struct gamep
 		return -ENOMEM;
 
 	interact->gameport = gameport;
-	init_timer(&interact->timer);
-	interact->timer.data = (long) interact;
-	interact->timer.function = interact_timer;
 
 	gameport_set_drvdata(gameport, interact);
 
@@ -252,6 +241,9 @@ static int interact_connect(struct gamep
 		goto fail2;
 	}
 
+	gameport_set_poll_handler(gameport, interact_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	sprintf(interact->phys, "%s/input0", gameport->phys);
 
 	interact->type = i;
Index: dtor/drivers/input/joystick/tmdc.c
===================================================================
--- dtor.orig/drivers/input/joystick/tmdc.c
+++ dtor/drivers/input/joystick/tmdc.c
@@ -48,7 +48,6 @@ MODULE_LICENSE("GPL");
 #define TMDC_MAX_START		400	/* 400 us */
 #define TMDC_MAX_STROBE		45	/* 45 us */
 #define TMDC_MAX_LENGTH		13
-#define TMDC_REFRESH_TIME	HZ/50	/* 20 ms */
 
 #define TMDC_MODE_M3DI		1
 #define TMDC_MODE_3DRP		3
@@ -94,7 +93,6 @@ static struct {
 
 struct tmdc {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct input_dev dev[2];
 	char name[2][64];
 	char phys[2][32];
@@ -104,7 +102,6 @@ struct tmdc {
 	unsigned char absc[2];
 	unsigned char btnc[2][4];
 	unsigned char btno[2][4];
-	int used;
 	int reads;
 	int bads;
 	unsigned char exists;
@@ -160,13 +157,13 @@ static int tmdc_read_packet(struct gamep
 }
 
 /*
- * tmdc_read() reads and analyzes ThrustMaster joystick data.
+ * tmdc_poll() reads and analyzes ThrustMaster joystick data.
  */
 
-static void tmdc_timer(unsigned long private)
+static void tmdc_poll(struct gameport *gameport)
 {
 	unsigned char data[2][TMDC_MAX_LENGTH];
-	struct tmdc *tmdc = (void *) private;
+	struct tmdc *tmdc = gameport_get_drvdata(gameport);
 	struct input_dev *dev;
 	unsigned char r, bad = 0;
 	int i, j, k, l;
@@ -221,23 +218,21 @@ static void tmdc_timer(unsigned long pri
 	}
 
 	tmdc->bads += bad;
-
-	mod_timer(&tmdc->timer, jiffies + TMDC_REFRESH_TIME);
 }
 
 static int tmdc_open(struct input_dev *dev)
 {
 	struct tmdc *tmdc = dev->private;
-	if (!tmdc->used++)
-		mod_timer(&tmdc->timer, jiffies + TMDC_REFRESH_TIME);
+
+	gameport_start_polling(tmdc->gameport);
 	return 0;
 }
 
 static void tmdc_close(struct input_dev *dev)
 {
 	struct tmdc *tmdc = dev->private;
-	if (!--tmdc->used)
-		del_timer(&tmdc->timer);
+
+	gameport_stop_polling(tmdc->gameport);
 }
 
 /*
@@ -271,9 +266,6 @@ static int tmdc_connect(struct gameport 
 		return -ENOMEM;
 
 	tmdc->gameport = gameport;
-	init_timer(&tmdc->timer);
-	tmdc->timer.data = (long) tmdc;
-	tmdc->timer.function = tmdc_timer;
 
 	gameport_set_drvdata(gameport, tmdc);
 
@@ -286,6 +278,9 @@ static int tmdc_connect(struct gameport 
 		goto fail2;
 	}
 
+	gameport_set_poll_handler(gameport, tmdc_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	for (j = 0; j < 2; j++)
 		if (tmdc->exists & (1 << j)) {
 
Index: dtor/drivers/input/joystick/adi.c
===================================================================
--- dtor.orig/drivers/input/joystick/adi.c
+++ dtor/drivers/input/joystick/adi.c
@@ -49,7 +49,6 @@ MODULE_LICENSE("GPL");
 
 #define ADI_MAX_START		200	/* Trigger to packet timeout [200us] */
 #define ADI_MAX_STROBE		40	/* Single bit timeout [40us] */
-#define ADI_REFRESH_TIME	HZ/50	/* How often to poll the joystick [20 ms] */
 #define ADI_INIT_DELAY		10	/* Delay after init packet [10ms] */
 #define ADI_DATA_DELAY		4	/* Delay after data packet [4ms] */
 
@@ -129,11 +128,9 @@ struct adi {
 
 struct adi_port {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct adi adi[2];
 	int bad;
 	int reads;
-	int used;
 };
 
 /*
@@ -277,15 +274,15 @@ static int adi_read(struct adi_port *por
 }
 
 /*
- * adi_timer() repeatedly polls the Logitech joysticks.
+ * adi_poll() repeatedly polls the Logitech joysticks.
  */
 
-static void adi_timer(unsigned long data)
+static void adi_poll(struct gameport *gameport)
 {
-	struct adi_port *port = (void *) data;
+	struct adi_port *port = gameport_get_drvdata(gameport);
+
 	port->bad -= adi_read(port);
 	port->reads++;
-	mod_timer(&port->timer, jiffies + ADI_REFRESH_TIME);
 }
 
 /*
@@ -295,8 +292,8 @@ static void adi_timer(unsigned long data
 static int adi_open(struct input_dev *dev)
 {
 	struct adi_port *port = dev->private;
-	if (!port->used++)
-		mod_timer(&port->timer, jiffies + ADI_REFRESH_TIME);
+
+	gameport_start_polling(port->gameport);
 	return 0;
 }
 
@@ -307,8 +304,8 @@ static int adi_open(struct input_dev *de
 static void adi_close(struct input_dev *dev)
 {
 	struct adi_port *port = dev->private;
-	if (!--port->used)
-		del_timer(&port->timer);
+
+	gameport_stop_polling(port->gameport);
 }
 
 /*
@@ -475,9 +472,6 @@ static int adi_connect(struct gameport *
 		return -ENOMEM;
 
 	port->gameport = gameport;
-	init_timer(&port->timer);
-	port->timer.data = (long) port;
-	port->timer.function = adi_timer;
 
 	gameport_set_drvdata(gameport, port);
 
@@ -504,6 +498,9 @@ static int adi_connect(struct gameport *
 		return -ENODEV;
 	}
 
+	gameport_set_poll_handler(gameport, adi_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	msleep(ADI_INIT_DELAY);
 	if (adi_read(port)) {
 		msleep(ADI_DATA_DELAY);
Index: dtor/drivers/input/gameport/gameport.c
===================================================================
--- dtor.orig/drivers/input/gameport/gameport.c
+++ dtor/drivers/input/gameport/gameport.c
@@ -39,6 +39,8 @@ EXPORT_SYMBOL(gameport_rescan);
 EXPORT_SYMBOL(gameport_cooked_read);
 EXPORT_SYMBOL(gameport_set_name);
 EXPORT_SYMBOL(gameport_set_phys);
+EXPORT_SYMBOL(gameport_start_polling);
+EXPORT_SYMBOL(gameport_stop_polling);
 
 /*
  * gameport_sem protects entire gameport subsystem and is taken
@@ -122,6 +124,37 @@ static int gameport_measure_speed(struct
 #endif
 }
 
+void gameport_start_polling(struct gameport *gameport)
+{
+	spin_lock(&gameport->timer_lock);
+
+	if (!gameport->poll_cnt++) {
+		BUG_ON(!gameport->poll_handler);
+		BUG_ON(!gameport->poll_interval);
+		mod_timer(&gameport->poll_timer, jiffies + msecs_to_jiffies(gameport->poll_interval));
+	}
+
+	spin_unlock(&gameport->timer_lock);
+}
+
+void gameport_stop_polling(struct gameport *gameport)
+{
+	spin_lock(&gameport->timer_lock);
+
+	if (!--gameport->poll_cnt)
+		del_timer(&gameport->poll_timer);
+
+	spin_unlock(&gameport->timer_lock);
+}
+
+static void gameport_run_poll_handler(unsigned long d)
+{
+	struct gameport *gameport = (struct gameport *)d;
+
+	gameport->poll_handler(gameport);
+	if (gameport->poll_cnt)
+		mod_timer(&gameport->poll_timer, jiffies + msecs_to_jiffies(gameport->poll_interval));
+}
 
 /*
  * Basic gameport -> driver core mappings
@@ -465,10 +498,14 @@ static void gameport_init_port(struct ga
 	device_initialize(&gameport->dev);
 	snprintf(gameport->dev.bus_id, sizeof(gameport->dev.bus_id),
 		 "gameport%lu", (unsigned long)atomic_inc_return(&gameport_no) - 1);
-	gameport->dev.bus = &gameport_bus;
 	gameport->dev.release = gameport_release_port;
 	if (gameport->parent)
 		gameport->dev.parent = &gameport->parent->dev;
+
+	spin_lock_init(&gameport->timer_lock);
+	init_timer(&gameport->poll_timer);
+	gameport->poll_timer.function = gameport_run_poll_handler;
+	gameport->poll_timer.data = (unsigned long)gameport;
 }
 
 /*
@@ -697,6 +734,9 @@ int gameport_open(struct gameport *gamep
 
 void gameport_close(struct gameport *gameport)
 {
+	del_timer_sync(&gameport->poll_timer);
+	gameport->poll_handler = NULL;
+	gameport->poll_interval = 0;
 	gameport_set_drv(gameport, NULL);
 	if (gameport->close)
 		gameport->close(gameport);
Index: dtor/include/linux/gameport.h
===================================================================
--- dtor.orig/include/linux/gameport.h
+++ dtor/include/linux/gameport.h
@@ -30,6 +30,12 @@ struct gameport {
 	int (*open)(struct gameport *, int);
 	void (*close)(struct gameport *);
 
+	struct timer_list poll_timer;
+	unsigned int poll_interval;	/* in msecs */
+	spinlock_t timer_lock;
+	unsigned int poll_cnt;
+	void (*poll_handler)(struct gameport *);
+
 	struct gameport *parent, *child;
 
 	struct gameport_driver *drv;
@@ -176,4 +182,17 @@ static inline int gameport_time(struct g
 	return (time * gameport->speed) / 1000;
 }
 
+static inline void gameport_set_poll_handler(struct gameport *gameport, void (*handler)(struct gameport *))
+{
+	gameport->poll_handler = handler;
+}
+
+static inline void gameport_set_poll_interval(struct gameport *gameport, unsigned int msecs)
+{
+	gameport->poll_interval = msecs;
+}
+
+void gameport_start_polling(struct gameport *gameport);
+void gameport_stop_polling(struct gameport *gameport);
+
 #endif
Index: dtor/drivers/input/joystick/grip.c
===================================================================
--- dtor.orig/drivers/input/joystick/grip.c
+++ dtor/drivers/input/joystick/grip.c
@@ -53,14 +53,10 @@ MODULE_LICENSE("GPL");
 #define GRIP_MAX_CHUNKS_XT	10
 #define GRIP_MAX_BITS_XT	30
 
-#define GRIP_REFRESH_TIME	HZ/50	/* 20 ms */
-
 struct grip {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct input_dev dev[2];
 	unsigned char mode[2];
-	int used;
 	int reads;
 	int bads;
 	char phys[2][32];
@@ -185,9 +181,9 @@ static int grip_xt_read_packet(struct ga
  * grip_timer() repeatedly polls the joysticks and generates events.
  */
 
-static void grip_timer(unsigned long private)
+static void grip_poll(struct gameport *gameport)
 {
-	struct grip *grip = (void*) private;
+	struct grip *grip = gameport_get_drvdata(gameport);
 	unsigned int data[GRIP_LENGTH_XT];
 	struct input_dev *dev;
 	int i, j;
@@ -281,23 +277,21 @@ static void grip_timer(unsigned long pri
 
 		input_sync(dev);
 	}
-
-	mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
 }
 
 static int grip_open(struct input_dev *dev)
 {
 	struct grip *grip = dev->private;
-	if (!grip->used++)
-		mod_timer(&grip->timer, jiffies + GRIP_REFRESH_TIME);
+
+	gameport_start_polling(grip->gameport);
 	return 0;
 }
 
 static void grip_close(struct input_dev *dev)
 {
 	struct grip *grip = dev->private;
-	if (!--grip->used)
-		del_timer(&grip->timer);
+
+	gameport_stop_polling(grip->gameport);
 }
 
 static int grip_connect(struct gameport *gameport, struct gameport_driver *drv)
@@ -311,9 +305,6 @@ static int grip_connect(struct gameport 
 		return -ENOMEM;
 
 	grip->gameport = gameport;
-	init_timer(&grip->timer);
-	grip->timer.data = (long) grip;
-	grip->timer.function = grip_timer;
 
 	gameport_set_drvdata(gameport, grip);
 
@@ -345,6 +336,9 @@ static int grip_connect(struct gameport 
 		goto fail2;
 	}
 
+	gameport_set_poll_handler(gameport, grip_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	for (i = 0; i < 2; i++)
 		if (grip->mode[i]) {
 
Index: dtor/drivers/input/joystick/gf2k.c
===================================================================
--- dtor.orig/drivers/input/joystick/gf2k.c
+++ dtor/drivers/input/joystick/gf2k.c
@@ -46,7 +46,6 @@ MODULE_LICENSE("GPL");
 #define GF2K_STROBE		40	/* The time we wait for the first bit [40 us] */
 #define GF2K_TIMEOUT		4	/* Wait for everything to settle [4 ms] */
 #define GF2K_LENGTH		80	/* Max number of triplets in a packet */
-#define GF2K_REFRESH		HZ/50	/* Time between joystick polls [20 ms] */
 
 /*
  * Genius joystick ids ...
@@ -82,11 +81,9 @@ static short gf2k_seq_digital[] = { 590,
 
 struct gf2k {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct input_dev dev;
 	int reads;
 	int bads;
-	int used;
 	unsigned char id;
 	unsigned char length;
 	char phys[32];
@@ -204,36 +201,35 @@ static void gf2k_read(struct gf2k *gf2k,
 }
 
 /*
- * gf2k_timer() reads and analyzes Genius joystick data.
+ * gf2k_poll() reads and analyzes Genius joystick data.
  */
 
-static void gf2k_timer(unsigned long private)
+static void gf2k_poll(struct gameport *gameport)
 {
-	struct gf2k *gf2k = (void *) private;
+	struct gf2k *gf2k = gameport_get_drvdata(gameport);
 	unsigned char data[GF2K_LENGTH];
 
 	gf2k->reads++;
 
-	if (gf2k_read_packet(gf2k->gameport, gf2k_length[gf2k->id], data) < gf2k_length[gf2k->id]) {
+	if (gf2k_read_packet(gf2k->gameport, gf2k_length[gf2k->id], data) < gf2k_length[gf2k->id])
 		gf2k->bads++;
-	} else gf2k_read(gf2k, data);
-
-	mod_timer(&gf2k->timer, jiffies + GF2K_REFRESH);
+	else
+		gf2k_read(gf2k, data);
 }
 
 static int gf2k_open(struct input_dev *dev)
 {
 	struct gf2k *gf2k = dev->private;
-	if (!gf2k->used++)
-		mod_timer(&gf2k->timer, jiffies + GF2K_REFRESH);
+
+	gameport_start_polling(gf2k->gameport);
 	return 0;
 }
 
 static void gf2k_close(struct input_dev *dev)
 {
 	struct gf2k *gf2k = dev->private;
-	if (!--gf2k->used)
-		del_timer(&gf2k->timer);
+
+	gameport_stop_polling(gf2k->gameport);
 }
 
 /*
@@ -250,9 +246,6 @@ static int gf2k_connect(struct gameport 
 		return -ENOMEM;
 
 	gf2k->gameport = gameport;
-	init_timer(&gf2k->timer);
-	gf2k->timer.data = (long) gf2k;
-	gf2k->timer.function = gf2k_timer;
 
 	gameport_set_drvdata(gameport, gf2k);
 
@@ -295,6 +288,9 @@ static int gf2k_connect(struct gameport 
 		goto fail2;
 	}
 
+	gameport_set_poll_handler(gameport, gf2k_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	sprintf(gf2k->phys, "%s/input0", gameport->phys);
 
 	gf2k->length = gf2k_lens[gf2k->id];
Index: dtor/drivers/input/joystick/analog.c
===================================================================
--- dtor.orig/drivers/input/joystick/analog.c
+++ dtor/drivers/input/joystick/analog.c
@@ -90,7 +90,6 @@ __obsolete_setup("js=");
 
 #define ANALOG_MAX_TIME		3	/* 3 ms */
 #define ANALOG_LOOP_TIME	2000	/* 2 * loop */
-#define ANALOG_REFRESH_TIME	HZ/100	/* 10 ms */
 #define ANALOG_SAITEK_DELAY	200	/* 200 us */
 #define ANALOG_SAITEK_TIME	2000	/* 2000 us */
 #define ANALOG_AXIS_TIME	2	/* 2 * refresh */
@@ -121,7 +120,6 @@ struct analog {
 
 struct analog_port {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct analog analog[2];
 	unsigned char mask;
 	char saitek;
@@ -134,7 +132,6 @@ struct analog_port {
 	int axes[4];
 	int buttons;
 	int initial[4];
-	int used;
 	int axtime;
 };
 
@@ -307,12 +304,12 @@ static int analog_button_read(struct ana
 }
 
 /*
- * analog_timer() repeatedly polls the Analog joysticks.
+ * analog_poll() repeatedly polls the Analog joysticks.
  */
 
-static void analog_timer(unsigned long data)
+static void analog_poll(struct gameport *gameport)
 {
-	struct analog_port *port = (void *) data;
+	struct analog_port *port = gameport_get_drvdata(gameport);
 	int i;
 
 	char saitek = !!(port->analog[0].mask & ANALOG_SAITEK);
@@ -338,8 +335,6 @@ static void analog_timer(unsigned long d
 	for (i = 0; i < 2; i++)
 		if (port->analog[i].mask)
 			analog_decode(port->analog + i, port->axes, port->initial, port->buttons);
-
-	mod_timer(&port->timer, jiffies + ANALOG_REFRESH_TIME);
 }
 
 /*
@@ -349,8 +344,8 @@ static void analog_timer(unsigned long d
 static int analog_open(struct input_dev *dev)
 {
 	struct analog_port *port = dev->private;
-	if (!port->used++)
-		mod_timer(&port->timer, jiffies + ANALOG_REFRESH_TIME);
+
+	gameport_start_polling(port->gameport);
 	return 0;
 }
 
@@ -361,8 +356,8 @@ static int analog_open(struct input_dev 
 static void analog_close(struct input_dev *dev)
 {
 	struct analog_port *port = dev->private;
-	if (!--port->used)
-		del_timer(&port->timer);
+
+	gameport_stop_polling(port->gameport);
 }
 
 /*
@@ -594,9 +589,6 @@ static int analog_init_port(struct gamep
 	int i, t, u, v;
 
 	port->gameport = gameport;
-	init_timer(&port->timer);
-	port->timer.data = (long) port;
-	port->timer.function = analog_timer;
 
 	gameport_set_drvdata(gameport, port);
 
@@ -678,6 +670,9 @@ static int analog_connect(struct gamepor
 		return err;
 	}
 
+	gameport_set_poll_handler(gameport, analog_poll);
+	gameport_set_poll_interval(gameport, 10);
+
 	for (i = 0; i < 2; i++)
 		if (port->analog[i].mask)
 			analog_init_device(port, port->analog + i, i);
Index: dtor/drivers/input/joystick/cobra.c
===================================================================
--- dtor.orig/drivers/input/joystick/cobra.c
+++ dtor/drivers/input/joystick/cobra.c
@@ -42,7 +42,6 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 #define COBRA_MAX_STROBE	45	/* 45 us max wait for first strobe */
-#define COBRA_REFRESH_TIME	HZ/50	/* 20 ms between reads */
 #define COBRA_LENGTH		36
 
 static char* cobra_name = "Creative Labs Blaster GamePad Cobra";
@@ -51,9 +50,7 @@ static int cobra_btn[] = { BTN_START, BT
 
 struct cobra {
 	struct gameport *gameport;
-	struct timer_list timer;
 	struct input_dev dev[2];
-	int used;
 	int reads;
 	int bads;
 	unsigned char exists;
@@ -114,18 +111,19 @@ static unsigned char cobra_read_packet(s
 	return ret;
 }
 
-static void cobra_timer(unsigned long private)
+static void cobra_poll(struct gameport *gameport)
 {
-	struct cobra *cobra = (void *) private;
+	struct cobra *cobra = gameport_get_drvdata(gameport);
 	struct input_dev *dev;
 	unsigned int data[2];
 	int i, j, r;
 
 	cobra->reads++;
 
-	if ((r = cobra_read_packet(cobra->gameport, data)) != cobra->exists)
+	if ((r = cobra_read_packet(gameport, data)) != cobra->exists) {
 		cobra->bads++;
-	else
+		return;
+	}
 
 	for (i = 0; i < 2; i++)
 		if (cobra->exists & r & (1 << i)) {
@@ -141,23 +139,21 @@ static void cobra_timer(unsigned long pr
 			input_sync(dev);
 
 		}
-
-	mod_timer(&cobra->timer, jiffies + COBRA_REFRESH_TIME);
 }
 
 static int cobra_open(struct input_dev *dev)
 {
 	struct cobra *cobra = dev->private;
-	if (!cobra->used++)
-		mod_timer(&cobra->timer, jiffies + COBRA_REFRESH_TIME);
+
+	gameport_start_polling(cobra->gameport);
 	return 0;
 }
 
 static void cobra_close(struct input_dev *dev)
 {
 	struct cobra *cobra = dev->private;
-	if (!--cobra->used)
-		del_timer(&cobra->timer);
+
+	gameport_stop_polling(cobra->gameport);
 }
 
 static int cobra_connect(struct gameport *gameport, struct gameport_driver *drv)
@@ -171,9 +167,6 @@ static int cobra_connect(struct gameport
 		return -ENOMEM;
 
 	cobra->gameport = gameport;
-	init_timer(&cobra->timer);
-	cobra->timer.data = (long) cobra;
-	cobra->timer.function = cobra_timer;
 
 	gameport_set_drvdata(gameport, cobra);
 
@@ -195,6 +188,9 @@ static int cobra_connect(struct gameport
 		goto fail2;
 	}
 
+	gameport_set_poll_handler(gameport, cobra_poll);
+	gameport_set_poll_interval(gameport, 20);
+
 	for (i = 0; i < 2; i++)
 		if ((cobra->exists >> i) & 1) {
 

