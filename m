Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbTCaWQ2>; Mon, 31 Mar 2003 17:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbTCaWQ2>; Mon, 31 Mar 2003 17:16:28 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:29193 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S261871AbTCaWQX>;
	Mon, 31 Mar 2003 17:16:23 -0500
Date: Mon, 31 Mar 2003 17:27:43 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: More on HID keyboard handling.
Message-ID: <20030331222743.GA2532@babylon.d2dc.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I still have not heard anything back from you either way on the attached
patch.

It goes on top of the grabbing patch you already accepted, but it allows
for /much/ more flexibility.

If this is not an approach you would like to take, do you have any
alternate ideas?

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

     "First they came for the Jews, and I didn't speak out - because I
was not a jew. Then they came for the Communists, and I did not speak
out - because I was not a Communist. Then they came for the trade
unionists, and I did not speak out - because I was not a trade unionist.
Then they came for me and there was no one left to speak for me!"
  - Pastor Niemoeller - victim of Hitler's Nazis

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hid_mask_2.5.63.diff"
Content-Transfer-Encoding: quoted-printable

diff -ur linux-2.5.63/drivers/char/keyboard.c linux-2.5.63.input/drivers/ch=
ar/keyboard.c
--- linux-2.5.63/drivers/char/keyboard.c	2003-03-13 18:09:29.000000000 -0500
+++ linux-2.5.63.input/drivers/char/keyboard.c	2003-03-15 07:23:12.00000000=
0 -0500
@@ -1174,6 +1174,7 @@
 	handle->dev =3D dev;
 	handle->handler =3D handler;
 	handle->name =3D kbd_name;
+	handle->mask =3D ~BIT(0);
=20
 	input_open_device(handle);
 	kbd_refresh_leds(handle);
diff -ur linux-2.5.63/drivers/input/evdev.c linux-2.5.63.input/drivers/inpu=
t/evdev.c
--- linux-2.5.63/drivers/input/evdev.c	2003-03-15 08:35:36.000000000 -0500
+++ linux-2.5.63.input/drivers/input/evdev.c	2003-03-15 07:20:29.000000000 =
-0500
@@ -36,6 +36,7 @@
 	struct input_event buffer[EVDEV_BUFFER_SIZE];
 	int head;
 	int tail;
+	unsigned long mask;
 	struct fasync_struct *fasync;
 	struct evdev *evdev;
 	struct list_head node;
@@ -47,11 +48,15 @@
 {
 	struct evdev *evdev =3D handle->private;
 	struct evdev_list *list;
+	struct timeval time;
+	unsigned long mask =3D input_get_device_mask(handle->dev);
+
+	do_gettimeofday(&time);
=20
 	if (evdev->grab) {
 		list =3D evdev->grab;
=20
-		do_gettimeofday(&list->buffer[list->head].time);
+		list->buffer[list->head].time =3D time;
 		list->buffer[list->head].type =3D type;
 		list->buffer[list->head].code =3D code;
 		list->buffer[list->head].value =3D value;
@@ -60,14 +65,15 @@
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	} else
 		list_for_each_entry(list, &evdev->list, node) {
+			if (~list->mask & mask) {
+				list->buffer[list->head].time =3D time;
+				list->buffer[list->head].type =3D type;
+				list->buffer[list->head].code =3D code;
+				list->buffer[list->head].value =3D value;
+				list->head =3D (list->head + 1) & (EVDEV_BUFFER_SIZE - 1);
=20
-			do_gettimeofday(&list->buffer[list->head].time);
-			list->buffer[list->head].type =3D type;
-			list->buffer[list->head].code =3D code;
-			list->buffer[list->head].value =3D value;
-			list->head =3D (list->head + 1) & (EVDEV_BUFFER_SIZE - 1);
-
-			kill_fasync(&list->fasync, SIGIO, POLL_IN);
+				kill_fasync(&list->fasync, SIGIO, POLL_IN);
+			}
 		}
=20
 	wake_up_interruptible(&evdev->wait);
@@ -286,6 +292,28 @@
 				return 0;
 			}
=20
+		case EVIOCGMASK:
+			if (put_user(~list->mask, ((unsigned long *) arg) + 0))
+				return -EFAULT;
+			return 0;
+
+		case EVIOCSMASK:
+			list->mask =3D ~arg;
+			return 0;
+
+		case EVIOCGDMASK:
+			{
+				unsigned long mask;
+				mask =3D input_get_device_mask (dev);
+				if (put_user(mask, ((unsigned long *) arg) + 0))
+					return -EFAULT;
+				return 0;
+			}
+
+		case EVIOCSDMASK:
+			input_set_device_mask(dev, arg);
+			return 0;
+
 		default:
=20
 			if (_IOC_TYPE(cmd) !=3D 'E' || _IOC_DIR(cmd) !=3D _IOC_READ)
diff -ur linux-2.5.63/drivers/input/input.c linux-2.5.63.input/drivers/inpu=
t/input.c
--- linux-2.5.63/drivers/input/input.c	2003-03-15 08:35:36.000000000 -0500
+++ linux-2.5.63.input/drivers/input/input.c	2003-03-15 07:17:52.000000000 =
-0500
@@ -33,6 +33,8 @@
 EXPORT_SYMBOL(input_unregister_handler);
 EXPORT_SYMBOL(input_register_minor);
 EXPORT_SYMBOL(input_unregister_minor);
+EXPORT_SYMBOL(input_get_device_mask);
+EXPORT_SYMBOL(input_set_device_mask);
 EXPORT_SYMBOL(input_grab_device);
 EXPORT_SYMBOL(input_release_device);
 EXPORT_SYMBOL(input_open_device);
@@ -183,7 +185,7 @@
 		dev->grab->handler->event(dev->grab, type, code, value);
 	else
 		list_for_each_entry(handle, &dev->h_list, d_node)
-			if (handle->open)
+			if (handle->open && (~handle->mask & ~dev->mask))
 				handle->handler->event(handle, type, code, value);
 }
=20
@@ -208,6 +210,16 @@
 	return 0;
 }
=20
+unsigned long input_get_device_mask (struct input_dev *dev)
+{
+	return ~dev->mask;
+}
+
+void input_set_device_mask (struct input_dev *dev, unsigned long mask)
+{
+	dev->mask =3D ~mask;
+}
+
 int input_grab_device(struct input_handle *handle)
 {
 	if (handle->dev->grab)
diff -ur linux-2.5.63/drivers/input/joydev.c linux-2.5.63.input/drivers/inp=
ut/joydev.c
--- linux-2.5.63/drivers/input/joydev.c	2003-03-13 18:09:29.000000000 -0500
+++ linux-2.5.63.input/drivers/input/joydev.c	2003-03-15 07:23:50.000000000=
 -0500
@@ -400,6 +400,7 @@
 	joydev->handle.name =3D joydev->name;
 	joydev->handle.handler =3D handler;
 	joydev->handle.private =3D joydev;
+	joydev->handle.mask =3D ~BIT(0);
 	sprintf(joydev->name, "js%d", minor);
=20
 	for (i =3D 0; i < ABS_MAX; i++)
diff -ur linux-2.5.63/drivers/input/mousedev.c linux-2.5.63.input/drivers/i=
nput/mousedev.c
--- linux-2.5.63/drivers/input/mousedev.c	2003-03-13 18:09:29.000000000 -05=
00
+++ linux-2.5.63.input/drivers/input/mousedev.c	2003-03-15 07:23:58.0000000=
00 -0500
@@ -419,6 +419,7 @@
 	mousedev->handle.name =3D mousedev->name;
 	mousedev->handle.handler =3D handler;
 	mousedev->handle.private =3D mousedev;
+	mousedev->handle.mask =3D ~BIT(0);
 	sprintf(mousedev->name, "mouse%d", minor);
=20
 	if (mousedev_mix.open)
diff -ur linux-2.5.63/include/linux/input.h linux-2.5.63.input/include/linu=
x/input.h
--- linux-2.5.63/include/linux/input.h	2003-03-15 08:35:36.000000000 -0500
+++ linux-2.5.63.input/include/linux/input.h	2003-03-15 08:10:53.000000000 =
-0500
@@ -77,7 +77,11 @@
 #define EVIOCRMFF		_IOW('E', 0x81, int)			/* Erase a force effect */
 #define EVIOCGEFFECTS		_IOR('E', 0x84, int)			/* Report number of effects =
playable at the same time */
=20
-#define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
+#define EVIOCGRAB		_IOW('E', 0x90, int)	/* Grab/Release device */
+#define EVIOCGMASK		_IOR('E', 0x91, unsigned long *)	/* Get our input mask=
 */
+#define EVIOCSMASK		_IOW('E', 0x92, unsigned long)		/* Set our input mask =
*/
+#define EVIOCGDMASK		_IOR('E', 0x93, unsigned long *)	/* Get device input =
mask */
+#define EVIOCSDMASK		_IOW('E', 0x94, unsigned long)		/* Set device input m=
ask */
=20
 /*
  * Event types
@@ -801,6 +805,7 @@
 	int (*upload_effect)(struct input_dev *dev, struct ff_effect *effect);
 	int (*erase_effect)(struct input_dev *dev, int effect_id);
=20
+	unsigned long mask;
 	struct input_handle *grab;
=20
 	struct list_head	h_list;
@@ -874,6 +879,7 @@
=20
 	int open;
 	char *name;
+	unsigned long mask;
=20
 	struct input_dev *dev;
 	struct input_handler *handler;
@@ -893,6 +899,9 @@
 void input_register_handler(struct input_handler *);
 void input_unregister_handler(struct input_handler *);
=20
+unsigned long input_get_device_mask(struct input_dev *);
+void input_set_device_mask(struct input_dev *, unsigned long mask);
+
 int input_grab_device(struct input_handle *);
 void input_release_device(struct input_handle *);
=20

--2oS5YaxWCcQjTEyO--

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+iMDfRFMAi+ZaeAERAot2AKCz8iOH9/gJytnn43IE/ZMvCKaLVQCgmBBv
0bmmQykMkM68dtw5DT9Cp/w=
=cqAy
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
