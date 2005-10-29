Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVJ2SxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVJ2SxY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVJ2SxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:53:24 -0400
Received: from lug-owl.de ([195.71.106.12]:218 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751256AbVJ2SxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:53:23 -0400
Date: Sat, 29 Oct 2005 20:53:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] drivers/input/keyboard: convert to dynamic input_dev allocation
Message-ID: <20051029185321.GY27184@lug-owl.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
References: <1130481024363@kroah.com> <200510290059.37135.dtor_core@ameritech.net> <20051029150451.GV27184@lug-owl.de> <200510291128.48203.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sKosZo66cxuwvnFI"
Content-Disposition: inline
In-Reply-To: <200510291128.48203.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sKosZo66cxuwvnFI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-10-29 11:28:47 -0500, Dmitry Torokhov <dtor_core@ameritech.net=
> wrote:
> On Saturday 29 October 2005 10:04, Jan-Benedict Glaw wrote:
> > On Sat, 2005-10-29 00:59:36 -0500, Dmitry Torokhov <dtor_core@ameritech=
=2Enet> wrote:
> >=20
> > [...a patch I don't like]
> [ .. a patch that now I don't like ..]
>=20
> The messages are only generated when someone explicitely enables LKKBD_DE=
BUG,
> and if someone does enable it he surely can map the numeric values himsel=
f.
> There is no need to clutter the code with insignificant details.

Actually, I think there is. It should just be easy to use; albeit
that, if you look precisely at it, there are some defines etc that
aren't even used. Why? Because it documents the hardware.

I didn't like the larce switch either, but I kept it there for a
reason. So I'd really like to keep the ability to print out these
values by name. I don't think it hurts, so please keep it there.

Here's a revised version of the patch, making the function and it's
data static, as well as stuffing them into #ifdef DEBUG.

diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
index 7f06780..7173441 100644
--- a/drivers/input/keyboard/lkkbd.c
+++ b/drivers/input/keyboard/lkkbd.c
@@ -273,11 +273,11 @@ static lk_keycode_t lkkbd_keycode[LK_NUM
 	[0xfb] =3D KEY_APOSTROPHE,
 };
=20
-#define CHECK_LED(LED, BITS) do {		\
-	if (test_bit (LED, lk->dev->led))	\
-		leds_on |=3D BITS;		\
-	else					\
-		leds_off |=3D BITS;		\
+#define CHECK_LED(LK, VAR_ON, VAR_OFF, LED, BITS) do {		\
+	if (test_bit (LED, (LK)->dev->led))			\
+		VAR_ON |=3D BITS;					\
+	else							\
+		VAR_OFF |=3D BITS;				\
 	} while (0)
=20
 /*
@@ -298,6 +298,42 @@ struct lkkbd {
 	int ctrlclick_volume;
 };
=20
+#ifdef LKKBD_DEBUG
+/*
+ * Responses from the keyboard and mapping back to their names.
+ */
+static struct {
+	unsigned char value;
+	unsigned char *name;
+} lk_response[] =3D {
+#define RESPONSE(x) { .value =3D (x), .name =3D #x, }
+	RESPONSE (LK_STUCK_KEY),
+	RESPONSE (LK_SELFTEST_FAILED),
+	RESPONSE (LK_ALL_KEYS_UP),
+	RESPONSE (LK_METRONOME),
+	RESPONSE (LK_OUTPUT_ERROR),
+	RESPONSE (LK_INPUT_ERROR),
+	RESPONSE (LK_KBD_LOCKED),
+	RESPONSE (LK_KBD_TEST_MODE_ACK),
+	RESPONSE (LK_PREFIX_KEY_DOWN),
+	RESPONSE (LK_MODE_CHANGE_ACK),
+	RESPONSE (LK_RESPONSE_RESERVED),
+#undef RESPONSE
+};
+
+static unsigned char *
+response_name (unsigned char value)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE (lk_response); i++)
+		if (lk_response[i].value =3D=3D value)
+			return lk_response[i].name;
+
+	return "unknown";
+}
+#endif /* LKKBD_DEBUG */
+
 /*
  * Calculate volume parameter byte for a given volume.
  */
@@ -440,43 +476,24 @@ lkkbd_interrupt (struct serio *serio, un
 					input_report_key (lk->dev, lk->keycode[i], 0);
 			input_sync (lk->dev);
 			break;
-		case LK_METRONOME:
-			DBG (KERN_INFO "Got %#d and don't "
-					"know how to handle...\n");
+
+		case 0x01:
+			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
+			lk->ignore_bytes =3D LK_NUM_IGNORE_BYTES;
+			lk->id[LK_NUM_IGNORE_BYTES - lk->ignore_bytes--] =3D data;
+			schedule_work (&lk->tq);
 			break;
+
+		case LK_METRONOME:
 		case LK_OUTPUT_ERROR:
-			DBG (KERN_INFO "Got LK_OUTPUT_ERROR and don't "
-					"know how to handle...\n");
-			break;
 		case LK_INPUT_ERROR:
-			DBG (KERN_INFO "Got LK_INPUT_ERROR and don't "
-					"know how to handle...\n");
-			break;
 		case LK_KBD_LOCKED:
-			DBG (KERN_INFO "Got LK_KBD_LOCKED and don't "
-					"know how to handle...\n");
-			break;
 		case LK_KBD_TEST_MODE_ACK:
-			DBG (KERN_INFO "Got LK_KBD_TEST_MODE_ACK and don't "
-					"know how to handle...\n");
-			break;
 		case LK_PREFIX_KEY_DOWN:
-			DBG (KERN_INFO "Got LK_PREFIX_KEY_DOWN and don't "
-					"know how to handle...\n");
-			break;
 		case LK_MODE_CHANGE_ACK:
-			DBG (KERN_INFO "Got LK_MODE_CHANGE_ACK and ignored "
-					"it properly...\n");
-			break;
 		case LK_RESPONSE_RESERVED:
-			DBG (KERN_INFO "Got LK_RESPONSE_RESERVED and don't "
-					"know how to handle...\n");
-			break;
-		case 0x01:
-			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
-			lk->ignore_bytes =3D LK_NUM_IGNORE_BYTES;
-			lk->id[LK_NUM_IGNORE_BYTES - lk->ignore_bytes--] =3D data;
-			schedule_work (&lk->tq);
+			DBG (KERN_INFO "Got %s and don't know how to handle...\n",
+					response_name (data));
 			break;
=20
 		default:
@@ -509,10 +526,10 @@ lkkbd_event (struct input_dev *dev, unsi
=20
 	switch (type) {
 		case EV_LED:
-			CHECK_LED (LED_CAPSL, LK_LED_SHIFTLOCK);
-			CHECK_LED (LED_COMPOSE, LK_LED_COMPOSE);
-			CHECK_LED (LED_SCROLLL, LK_LED_SCROLLLOCK);
-			CHECK_LED (LED_SLEEP, LK_LED_WAIT);
+			CHECK_LED (lk, leds_on, leds_off, LED_CAPSL, LK_LED_SHIFTLOCK);
+			CHECK_LED (lk, leds_on, leds_off, LED_COMPOSE, LK_LED_COMPOSE);
+			CHECK_LED (lk, leds_on, leds_off, LED_SCROLLL, LK_LED_SCROLLLOCK);
+			CHECK_LED (lk, leds_on, leds_off, LED_SLEEP, LK_LED_WAIT);
 			if (leds_on !=3D 0) {
 				lk->serio->write (lk->serio, LK_CMD_LED_ON);
 				lk->serio->write (lk->serio, leds_on);
@@ -574,10 +591,10 @@ lkkbd_reinit (void *data)
 	lk->serio->write (lk->serio, LK_CMD_SET_DEFAULTS);
=20
 	/* Set LEDs */
-	CHECK_LED (LED_CAPSL, LK_LED_SHIFTLOCK);
-	CHECK_LED (LED_COMPOSE, LK_LED_COMPOSE);
-	CHECK_LED (LED_SCROLLL, LK_LED_SCROLLLOCK);
-	CHECK_LED (LED_SLEEP, LK_LED_WAIT);
+	CHECK_LED (lk, leds_on, leds_off, LED_CAPSL, LK_LED_SHIFTLOCK);
+	CHECK_LED (lk, leds_on, leds_off, LED_COMPOSE, LK_LED_COMPOSE);
+	CHECK_LED (lk, leds_on, leds_off, LED_SCROLLL, LK_LED_SCROLLLOCK);
+	CHECK_LED (lk, leds_on, leds_off, LED_SLEEP, LK_LED_WAIT);
 	if (leds_on !=3D 0) {
 		lk->serio->write (lk->serio, LK_CMD_LED_ON);
 		lk->serio->write (lk->serio, leds_on);


MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--sKosZo66cxuwvnFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDY8UhHb1edYOZ4bsRAnohAJ9L0BhTr1jI7/mDinA+pj2Ptuh1NACfbN1G
brcaYx+g/oF2YX34nkx945A=
=60Ur
-----END PGP SIGNATURE-----

--sKosZo66cxuwvnFI--
