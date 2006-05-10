Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWEJIMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWEJIMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWEJIMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:12:25 -0400
Received: from mail77.messagelabs.com ([62.231.131.243]:45787 "HELO
	mail77.messagelabs.com") by vger.kernel.org with SMTP
	id S932301AbWEJIMY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:12:24 -0400
X-VirusChecked: Checked
X-Env-Sender: Daniel.Sherwood@sepura.com
X-Msg-Ref: server-11.tower-77.messagelabs.com!1147248741!51889943!1
X-StarScan-Version: 5.5.9.1; banners=sepura.com,-,-
X-Originating-IP: [62.254.217.187]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] ATI Remote Control improvements
Date: Wed, 10 May 2006 09:12:23 +0100
Message-ID: <7B12C7CF8EB6734F9C50A406CD99BED23AD51D@mail01b.SEPURA.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ATI Remote Control improvements
Thread-Index: AcZ0CXe6e9V+2OGjSb+cl5P0N1rqIw==
From: "Daniel Sherwood" <Daniel.Sherwood@sepura.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

Please find below a patch to improve the functionality of the ATI Remote
Control as follows.

* Fixed handling of double-click BTN_XXX events that require the
input_event timestamp to change between press and release events.
* Added module parameter 'xkeycodesonly' to prevent driver generating
keycodes that are not recognised by X windows. (disabled by default)
* Added module parameter 'selectiverepeat' to make driver only generate
key repeats for certain keys such and cursor and volume.  (disabled by
default)
* Modified filter and key repate support to use millisecond values set
by 'filtertime', 'repeatdelay' & 'repeatrate' module parameters.
* Added module parameters 'mouseascursor' & 'mouseascursordefault' to
allow the mouse area to behave as the normal cursor-keys.  This
functionality can optionally be switched with the 'HAND' key.  (disabled
by default)
* Added module parameter 'mousedoubleclick' to make the double-click
events actually send two clicks of BTN_LEFT or BTN_RIGHT rather than
BTN_SIDE or BTN_EXTRA.  (disabled by default)

Without specifying module options, the behaviour will be the same as the
previous version except for the BTN_XXX click fix and the filter and key
repeat handling.

Cheers

Daniel



diff -ru -x '*.config' -x autoconf.h
kernel-2.6.16.base/linux-2.6.16.i686/drivers/usb/input/ati_remote.c
kernel-2.6.16/linux-2.6.16.i686/drivers/usb/input/ati_remote.c
--- kernel-2.6.16.base/linux-2.6.16.i686/drivers/usb/input/ati_remote.c
2006-03-20 05:53:29.000000000 +0000
+++ kernel-2.6.16/linux-2.6.16.i686/drivers/usb/input/ati_remote.c
2006-05-09 20:00:09.000000000 +0100
@@ -22,6 +22,27 @@
  *                Vincent Vanackere <vanackere@lif.univ-mrs.fr>
  *            Added support for the "Lola" remote contributed by:
  *                Seth Cohn <sethcohn@yahoo.com>
+ *  Apr 2006: Daniel Sherwood
+ *            Version 2.2.2
+ *            Fixed handling of double-click BTN_XXX events that
require
+ *              the input_event timestamp to change between press and
+ *              release events.
+ *            Added module parameter 'xkeycodesonly' to prevent driver
+ *              generating keycodes that are not recognised by X
windows.
+ *              (disabled by default)
+ *            Added module parameter 'selectiverepeat' to make driver 
+ *              only generate key repeats for certain keys such and
cursor
+ *              and volume.  (disabled by default)
+ *            Modified filter and key repate support to use millisecond

+ *              values set by 'filtertime', 'repeatdelay' &
'repeatrate'
+ *              module parameters.
+ *            Added module parameters 'mouseascursor' &
'mouseascursordefault'
+ *              to allow the mouse area to behave as the normal
cursor-keys.
+ *              this functionality can optionally be switched with the 
+ *              'HAND' key.  (disabled by default)
+ *            Added module parameter 'mousedoubleclick' to make the
double-
+ *              click events actually send two clicks of BTN_LEFT or
BTN_RIGHT
+ *              rather than BTN_SIDE or BTN_EXTRA.  (disabled by
default)
  *
  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* * *
  *
@@ -122,6 +143,38 @@
 module_param(debug, int, 0444);
 MODULE_PARM_DESC(debug, "Enable extra debug messages and information");
 
+static int xkeycodesonly;
+module_param(xkeycodesonly, int, 0444);
+MODULE_PARM_DESC(xkeycodesonly, "Do not use keycodes >256");
+
+static int selectiverepeat;
+module_param(selectiverepeat, int, 0444);
+MODULE_PARM_DESC(selectiverepeat, "Only apply repeat to cursors and
volume");
+
+static int filtertime = 50;
+module_param(filtertime, int, 0444);
+MODULE_PARM_DESC(filtertime, "Define the gap between events that
determines what constitutes the user pressing the same key again (ms)");
+
+static int repeatdelay = 400;
+module_param(repeatdelay, int, 0444);
+MODULE_PARM_DESC(repeatdelay, "Define the initial repeat delay (ms)");
+
+static int repeatrate = 100;
+module_param(repeatrate, int, 0444);
+MODULE_PARM_DESC(repeatrate, "Define the repeat rate (ms)");
+
+static int mouseascursor;
+module_param(mouseascursor, int, 0444);
+MODULE_PARM_DESC(mouseascursor, "Define mouse control behaviour.
0=mouse, 1=cursor, 2=auto");
+
+static int mouseascursordefault;
+module_param(mouseascursordefault, int, 0444);
+MODULE_PARM_DESC(mouseascursordefault, "Define initial mouse control
behaviour for mouseascursor=auto. 0=mouse, 1=cursor");
+
+static int mousedoubleclick;
+module_param(mousedoubleclick, int, 0444);
+MODULE_PARM_DESC(mousedoubleclick, "Double-click mouse events map to
double-clicks rather than side buttons");
+
 #define dbginfo(dev, format, arg...) do { if (debug) dev_info(dev ,
format , ## arg); } while (0)
 #undef err
 #define err(format, arg...) printk(KERN_ERR format , ## arg)
@@ -149,16 +202,6 @@
 /* Acceleration curve for directional control pad */
 static const char accel[] = { 1, 2, 4, 6, 9, 13, 20 };
 
-/* Duplicate event filtering time.
- * Sequential, identical KIND_FILTERED inputs with less than
- * FILTER_TIME jiffies between them are considered as repeat
- * events. The hardware generates 5 events for the first keypress
- * and we have to take this into account for an accurate repeat
- * behaviour.
- * (HZ / 20) == 50 ms and works well for me.
- */
-#define FILTER_TIME (HZ / 20)
-
 static DECLARE_MUTEX(disconnect_sem);
 
 struct ati_remote {
@@ -179,6 +222,7 @@
 	unsigned long old_jiffies;
 	unsigned long acc_jiffies;  /* handle acceleration */
 	unsigned int repeat_count;
+        int mouseascursorstate;
 
 	char name[NAME_BUFSIZE];
 	char phys[NAME_BUFSIZE];
@@ -190,12 +234,18 @@
 /* "Kinds" of messages sent from the hardware to the driver. */
 #define KIND_END        0
 #define KIND_LITERAL    1   /* Simply pass to input system */
-#define KIND_FILTERED   2   /* Add artificial key-up events, drop
keyrepeats */
+#define KIND_FILTERED   2   /* Add artificial key-up events, drop
keyrepeats, don't simulate repeat */
 #define KIND_LU         3   /* Directional keypad diagonals - left up,
*/
 #define KIND_RU         4   /*   right up,  */
 #define KIND_LD         5   /*   left down, */
 #define KIND_RD         6   /*   right down */
 #define KIND_ACCEL      7   /* Directional keypad - left, right, up,
down.*/
+#define KIND_REPEAT     8   /* Add artificial key-up events, drop
keyrepeats, simulate repeat */
+#define KIND_BUTTON     9   /* Add artificial key-up events after small
gap, drop keyrepeats, don't simulate repeat */
+
+#define MODE_XKEYCODESONLY    0x0100
+#define MODE_MOUSEASCURSOR    0x0200
+#define MODE_MOUSEDOUBLECLICK 0x0400
 
 /* Translation table from hardware messages to input events. */
 static const struct {
@@ -206,17 +256,29 @@
 	int value;
 }  ati_remote_tbl[] = {
 	/* Directional control pad axes */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x35, 0x70, EV_KEY, KEY_LEFT,
1},  /* left */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x36, 0x71, EV_KEY, KEY_RIGHT,
1}, /* right */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x37, 0x72, EV_KEY, KEY_UP,
1},    /* up */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x38, 0x73, EV_KEY, KEY_DOWN,
1},  /* down */
 	{KIND_ACCEL,   0x35, 0x70, EV_REL, REL_X, -1},	 /* left */
 	{KIND_ACCEL,   0x36, 0x71, EV_REL, REL_X, 1},    /* right */
 	{KIND_ACCEL,   0x37, 0x72, EV_REL, REL_Y, -1},	 /* up */
 	{KIND_ACCEL,   0x38, 0x73, EV_REL, REL_Y, 1},    /* down */
 	/* Directional control pad diagonals */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x39, 0x74, EV_KEY, KEY_UP,
1},    /* left up */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x3a, 0x75, EV_KEY, KEY_UP,
1},    /* right up */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x3c, 0x77, EV_KEY, KEY_DOWN,
1},  /* left down */
+	{KIND_REPEAT|MODE_MOUSEASCURSOR,  0x3b, 0x76, EV_KEY, KEY_DOWN,
1},  /* right down */
 	{KIND_LU,      0x39, 0x74, EV_REL, 0, 0},        /* left up */
 	{KIND_RU,      0x3a, 0x75, EV_REL, 0, 0},        /* right up */
 	{KIND_LD,      0x3c, 0x77, EV_REL, 0, 0},        /* left down */
 	{KIND_RD,      0x3b, 0x76, EV_REL, 0, 0},        /* right down
*/
 
 	/* "Mouse button" buttons */
+	{KIND_LITERAL|MODE_MOUSEASCURSOR, 0x3d, 0x78, EV_KEY,
KEY_KPENTER, 1},   /* left btn down */
+	{KIND_LITERAL|MODE_MOUSEASCURSOR, 0x3e, 0x79, EV_KEY,
KEY_KPENTER, 0},   /* left btn up */
+	{KIND_LITERAL|MODE_MOUSEASCURSOR, 0x41, 0x7c, EV_KEY,
KEY_BACKSPACE, 1}, /* right btn down */
+	{KIND_LITERAL|MODE_MOUSEASCURSOR, 0x42, 0x7d, EV_KEY,
KEY_BACKSPACE, 0}, /* right btn up */
 	{KIND_LITERAL, 0x3d, 0x78, EV_KEY, BTN_LEFT, 1}, /* left btn
down */
 	{KIND_LITERAL, 0x3e, 0x79, EV_KEY, BTN_LEFT, 0}, /* left btn up
*/
 	{KIND_LITERAL, 0x41, 0x7c, EV_KEY, BTN_RIGHT, 1},/* right btn
down */
@@ -224,8 +286,12 @@
 
 	/* Artificial "doubleclick" events are generated by the
hardware.
 	 * They are mapped to the "side" and "extra" mouse buttons here.
*/
-	{KIND_FILTERED, 0x3f, 0x7a, EV_KEY, BTN_SIDE, 1}, /* left
dblclick */
-	{KIND_FILTERED, 0x43, 0x7e, EV_KEY, BTN_EXTRA, 1},/* right
dblclick */
+	{KIND_FILTERED|MODE_MOUSEASCURSOR, 0x3f, 0x7a, EV_KEY,
KEY_KPENTER, 1},   /* left dblclick */
+	{KIND_FILTERED|MODE_MOUSEASCURSOR, 0x43, 0x7e, EV_KEY,
KEY_BACKSPACE, 1}, /* right dblclick */
+	{KIND_BUTTON|MODE_MOUSEDOUBLECLICK, 0x3f, 0x7a, EV_KEY,
BTN_LEFT, 2},     /* left dblclick */
+	{KIND_BUTTON|MODE_MOUSEDOUBLECLICK, 0x43, 0x7e, EV_KEY,
BTN_RIGHT, 2},    /* right dblclick */
+	{KIND_BUTTON, 0x3f, 0x7a, EV_KEY, BTN_SIDE, 1}, /* left dblclick
*/
+	{KIND_BUTTON, 0x43, 0x7e, EV_KEY, BTN_EXTRA, 1},/* right
dblclick */
 
 	/* keyboard. */
 	{KIND_FILTERED, 0xd2, 0x0d, EV_KEY, KEY_1, 1},
@@ -249,6 +315,8 @@
 	{KIND_FILTERED, 0xdd, 0x18, EV_KEY, KEY_KPENTER, 1},    /*
"check" */
 	{KIND_FILTERED, 0xdb, 0x16, EV_KEY, KEY_MENU, 1},       /*
"menu" */
 	{KIND_FILTERED, 0xc7, 0x02, EV_KEY, KEY_POWER, 1},      /* Power
*/
+	{KIND_FILTERED|MODE_XKEYCODESONLY, 0xc8, 0x03, EV_KEY,
KEY_PROG1, 1},         /* TV */
+	{KIND_FILTERED|MODE_XKEYCODESONLY, 0xc9, 0x04, EV_KEY,
KEY_PROG2, 1},        /* DVD */
 	{KIND_FILTERED, 0xc8, 0x03, EV_KEY, KEY_TV, 1},         /* TV */
 	{KIND_FILTERED, 0xc9, 0x04, EV_KEY, KEY_DVD, 1},        /* DVD
*/
 	{KIND_FILTERED, 0xca, 0x05, EV_KEY, KEY_WWW, 1},        /* WEB
*/
@@ -256,14 +324,17 @@
 	{KIND_FILTERED, 0xcc, 0x07, EV_KEY, KEY_EDIT, 1},       /*
"hand" */
 	{KIND_FILTERED, 0xe1, 0x1c, EV_KEY, KEY_COFFEE, 1},     /*
"timer" */
 	{KIND_FILTERED, 0xe5, 0x20, EV_KEY, KEY_FRONT, 1},      /* "max"
*/
-	{KIND_FILTERED, 0xe2, 0x1d, EV_KEY, KEY_LEFT, 1},       /* left
*/
-	{KIND_FILTERED, 0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* right
*/
-	{KIND_FILTERED, 0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* down
*/
-	{KIND_FILTERED, 0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* up */
+	{KIND_REPEAT,   0xe2, 0x1d, EV_KEY, KEY_LEFT, 1},       /* left
*/
+	{KIND_REPEAT,   0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* right
*/
+	{KIND_REPEAT,   0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* down
*/
+	{KIND_REPEAT,   0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* up */
+	{KIND_FILTERED|MODE_XKEYCODESONLY, 0xe3, 0x1e, EV_KEY,
KEY_KPENTER, 1},         /* "OK" */
 	{KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_OK, 1},         /* "OK"
*/
-	{KIND_FILTERED, 0xce, 0x09, EV_KEY, KEY_VOLUMEDOWN, 1}, /* VOL +
*/
-	{KIND_FILTERED, 0xcd, 0x08, EV_KEY, KEY_VOLUMEUP, 1},   /* VOL -
*/
+	{KIND_REPEAT,   0xce, 0x09, EV_KEY, KEY_VOLUMEDOWN, 1}, /* VOL +
*/
+	{KIND_REPEAT,   0xcd, 0x08, EV_KEY, KEY_VOLUMEUP, 1},   /* VOL -
*/
 	{KIND_FILTERED, 0xcf, 0x0a, EV_KEY, KEY_MUTE, 1},       /* MUTE
*/
+	{KIND_FILTERED|MODE_XKEYCODESONLY, 0xd0, 0x0b, EV_KEY,
KEY_PAGEUP, 1},  /* CH + */
+	{KIND_FILTERED|MODE_XKEYCODESONLY, 0xd1, 0x0c, EV_KEY,
KEY_PAGEDOWN, 1},/* CH - */
 	{KIND_FILTERED, 0xd0, 0x0b, EV_KEY, KEY_CHANNELUP, 1},  /* CH +
*/
 	{KIND_FILTERED, 0xd1, 0x0c, EV_KEY, KEY_CHANNELDOWN, 1},/* CH -
*/
 	{KIND_FILTERED, 0xec, 0x27, EV_KEY, KEY_RECORD, 1},     /* ( o)
red */
@@ -399,7 +470,7 @@
 /*
  *	ati_remote_event_lookup
  */
-static int ati_remote_event_lookup(int rem, unsigned char d1, unsigned
char d2)
+static int ati_remote_event_lookup(int rem, unsigned char d1, unsigned
char d2, int mouseascursorstate)
 {
 	int i;
 
@@ -410,8 +481,15 @@
 		if ((((ati_remote_tbl[i].data1 & 0x0f) == (d1 & 0x0f)))
&&
 		    ((((ati_remote_tbl[i].data1 >> 4) -
 		       (d1 >> 4) + rem) & 0x0f) == 0x0f) &&
-		    (ati_remote_tbl[i].data2 == d2))
-			return i;
+		    (ati_remote_tbl[i].data2 == d2)) {
+			if (   (ati_remote_tbl[i].kind &
MODE_XKEYCODESONLY && !xkeycodesonly)
+                            || (ati_remote_tbl[i].kind &
MODE_MOUSEDOUBLECLICK && !mousedoubleclick)
+                            || (ati_remote_tbl[i].kind &
MODE_MOUSEASCURSOR && mouseascursor == 0)
+                            || (ati_remote_tbl[i].kind &
MODE_MOUSEASCURSOR && mouseascursor == 2 && !mouseascursorstate) ) {
+			} else {
+				return i;
+			}
+		}
 
 	}
 	return -1;
@@ -427,6 +505,8 @@
 	struct input_dev *dev = ati_remote->idev;
 	int index, acc;
 	int remote_num;
+	int kind;
+        int multi;
 
 	/* Deal with strange looking inputs */
 	if ( (urb->actual_length != 4) || (data[0] != 0x14) ||
@@ -446,7 +526,7 @@
 	}
 
 	/* Look up event code index in translation table */
-	index = ati_remote_event_lookup(remote_num, data[1], data[2]);
+	index = ati_remote_event_lookup(remote_num, data[1], data[2],
ati_remote->mouseascursorstate);
 	if (index < 0) {
 		dev_warn(&ati_remote->interface->dev,
 			 "Unknown input from channel 0x%02x: data
%02x,%02x\n",
@@ -457,7 +537,8 @@
 		"channel 0x%02x; data %02x,%02x; index %d; keycode
%d\n",
 		remote_num, data[1], data[2], index,
ati_remote_tbl[index].code);
 
-	if (ati_remote_tbl[index].kind == KIND_LITERAL) {
+	kind = ati_remote_tbl[index].kind & 0x00ff;
+	if (kind == KIND_LITERAL) {
 		input_regs(dev, regs);
 		input_event(dev, ati_remote_tbl[index].type,
 			ati_remote_tbl[index].code,
@@ -468,31 +549,63 @@
 		return;
 	}
 
-	if (ati_remote_tbl[index].kind == KIND_FILTERED) {
-		/* Filter duplicate events which happen "too close"
together. */
+	if (kind == KIND_FILTERED || kind == KIND_REPEAT || kind ==
KIND_BUTTON) {
 		if ((ati_remote->old_data[0] == data[1]) &&
-			(ati_remote->old_data[1] == data[2]) &&
-			time_before(jiffies, ati_remote->old_jiffies +
FILTER_TIME)) {
-			ati_remote->repeat_count++;
+			(ati_remote->old_data[1] == data[2]) ) {
+			/* Same key as before.  Check for a gap that
would indicate a release/press by the user. */
+			if (time_after(jiffies, ati_remote->old_jiffies
+ msecs_to_jiffies(filtertime))) {
+				/* This is a new press of the same key.
Start again */
+				ati_remote->repeat_count = 0;
+			} else if (ati_remote->repeat_count == 0 &&
time_after(jiffies, ati_remote->acc_jiffies +
msecs_to_jiffies(repeatdelay))) {
+				/* Key held long enough for first repeat
*/
+				ati_remote->repeat_count++;
+			} else if (ati_remote->repeat_count > 0 &&
time_after(jiffies, ati_remote->acc_jiffies +
msecs_to_jiffies(repeatrate))) {
+				/* Key held long enough for further
repeats */
+				ati_remote->repeat_count++;
+			} else {
+				/* Key held, but not long enough for
repeat */
+				ati_remote->old_jiffies = jiffies;
+				return;
+			}
 		} else {
+			/* New key, start again */
 			ati_remote->repeat_count = 0;
 		}
 
 		ati_remote->old_data[0] = data[1];
 		ati_remote->old_data[1] = data[2];
 		ati_remote->old_jiffies = jiffies;
+		ati_remote->acc_jiffies = jiffies;
 
 		if ((ati_remote->repeat_count > 0)
-		    && (ati_remote->repeat_count < 5))
+		    && (kind == KIND_FILTERED || kind == KIND_BUTTON) &&
selectiverepeat != 0) {
 			return;
+		}
 
+		if (mouseascursor == 2 && ati_remote_tbl[index].code ==
KEY_EDIT) {
+			ati_remote->mouseascursorstate =
!ati_remote->mouseascursorstate;
+			return;
+		}
 
-		input_regs(dev, regs);
-		input_event(dev, ati_remote_tbl[index].type,
-			ati_remote_tbl[index].code, 1);
-		input_event(dev, ati_remote_tbl[index].type,
-			ati_remote_tbl[index].code, 0);
-		input_sync(dev);
+                multi = ati_remote_tbl[index].value;
+		while( multi-- ) {
+			input_regs(dev, regs);
+			input_event(dev, ati_remote_tbl[index].type,
+				ati_remote_tbl[index].code, 1);
+			if (kind == KIND_BUTTON) {
+				struct timeval then, now;
+				int loop = 1000000;
+				input_sync(dev);
+				do_gettimeofday(&then);
+				do {
+					do_gettimeofday(&now);
+				} while( timeval_compare(&now, &then) ==
0 && loop-- );
+				input_regs(dev, regs);
+			}
+			input_event(dev, ati_remote_tbl[index].type,
+				ati_remote_tbl[index].code, 0);
+			input_sync(dev);
+		}
 
 		return;
 	}
@@ -520,7 +633,7 @@
 	else acc = accel[6];
 
 	input_regs(dev, regs);
-	switch (ati_remote_tbl[index].kind) {
+	switch (kind) {
 	case KIND_ACCEL:
 		input_event(dev, ati_remote_tbl[index].type,
 			ati_remote_tbl[index].code,
@@ -544,7 +657,7 @@
 		break;
 	default:
 		dev_dbg(&ati_remote->interface->dev, "ati_remote
kind=%d\n",
-			ati_remote_tbl[index].kind);
+			kind);
 	}
 	input_sync(dev);
 
@@ -682,6 +795,8 @@
 	ati_remote->out_urb->transfer_dma = ati_remote->outbuf_dma;
 	ati_remote->out_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
+        ati_remote->mouseascursorstate = mouseascursordefault;
+
 	/* send initialization strings */
 	if ((ati_remote_sendpacket(ati_remote, 0x8004, init1)) ||
 	    (ati_remote_sendpacket(ati_remote, 0x8007, init2))) {

_______________________________________________________________________

The information in this email is confidential.  It is intended
solely for the addressee.  Access to this email by anyone else
is unauthorised.  If you are not the intended recipient, any
disclosure, copying, or distribution is prohibited and may be
unlawful.  If you have received this email in error please delete
it immediately and contact commercial@sepura.com.
_________________________________________________________________

This e-mail has been scanned for all viruses by Star Internet.
The service is powered by MessageLabs.
