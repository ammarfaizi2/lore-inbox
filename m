Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270672AbRHNVaD>; Tue, 14 Aug 2001 17:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270794AbRHNV3y>; Tue, 14 Aug 2001 17:29:54 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:27444 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S270672AbRHNV3g>; Tue, 14 Aug 2001 17:29:36 -0400
Date: Tue, 14 Aug 2001 23:29:47 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, mantel@suse.de, rubini@vision.unipv.it
Subject: Re: [PATCH] make psaux reconnect adjustable
Message-ID: <20010814232947.A16332@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	mantel@suse.de, rubini@vision.unipv.it
In-Reply-To: <20010814170306.Q1085@gum01m.etpnet.phys.tue.nl> <Pine.LNX.4.33.0108140954390.1679-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108140954390.1679-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: multipart/mixed; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2001 at 09:58:55AM -0700, Linus Torvalds wrote:
>  - do we actually need the config switch AT ALL, whether at bootup or not?
>    What exactly breaks if we just always pass the AA 00 values through?
>    Apparently nothing ever breaks, which makes me suspect that people are
>    just being unnecessarily defensive.
>=20
> In short, I'd prefer a patch that just unconditionally removes the code,
> unless somebody KNOWS that it could break something. That failing, a
> simple kernel command line option sounds better than more files in /proc.

OK, here come two patches. The first one removes the special PSAUX reconnect
handling completely. So userspace should handle it. (Which is possible; just
not implemented in gpm/X11 at this time AFAIK.)

Second patch reintroduces the special handling again, but does
* react on AA 00 instead of just AA, thus much less likely breaking other
  drivers (such as synps2). All PS/2 mouses I could access (about 5
  different models) produced AA 00, so this seems OK.
* is disabled by default, and needs to be enabled by the psaux-reconnect
  boot parameter, like in 2.2.19.

Second patch depends on first. Please apply just the first or both.

(Current failure of gpm/X11 would make me choose for both, but then I'm=20
 more the one thinking of customers of a distro than the one trying to keep
 the kernel clean. On the long term, I'd drop the second in any case.)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="247-noreconnect.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.7.kurt-1/drivers/char/pc_keyb.c linux-2.4.7.kurt-1-nore=
connect/drivers/char/pc_keyb.c
--- linux-2.4.7.kurt-1/drivers/char/pc_keyb.c	Tue Jul 24 18:42:36 2001
+++ linux-2.4.7.kurt-1-noreconnect/drivers/char/pc_keyb.c	Tue Aug 14 22:47:=
38 2001
@@ -81,8 +81,6 @@
=20
 static int __init psaux_init(void);
=20
-#define AUX_RECONNECT 170 /* scancode when ps2 device is plugged (back) in=
 */
-=20
 static struct aux_queue *queue;	/* Mouse data buffer. */
 static int aux_count;
 /* used when we send commands to the mouse that expect an ACK. */
@@ -406,11 +404,6 @@
 			return;
 		}
 		mouse_reply_expected =3D 0;
-	}
-	else if(scancode =3D=3D AUX_RECONNECT){
-		queue->head =3D queue->tail =3D 0;  /* Flush input queue */
-		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
-		return;
 	}
=20
 	add_mouse_randomness(scancode);

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="247-reconnect_bootpar.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.7.kurt-1-noreconnect/drivers/char/pc_keyb.c linux-2.4.7=
.kurt-1-recon_bootpar/drivers/char/pc_keyb.c
--- linux-2.4.7.kurt-1-noreconnect/drivers/char/pc_keyb.c	Tue Aug 14 22:47:=
38 2001
+++ linux-2.4.7.kurt-1-recon_bootpar/drivers/char/pc_keyb.c	Tue Aug 14 23:1=
3:49 2001
@@ -63,6 +63,7 @@
 #ifdef CONFIG_PSMOUSE
 static void aux_write_ack(int val);
 static void __aux_write_ack(int val);
+static int aux_reconnect =3D 0;
 #endif
=20
 static spinlock_t kbd_controller_lock =3D SPIN_LOCK_UNLOCKED;
@@ -81,6 +82,9 @@
=20
 static int __init psaux_init(void);
=20
+#define AUX_RECONNECT1 0xaa	/* scancode1 when ps2 device is plugged (back)=
 in */
+#define AUX_RECONNECT2 0x00	/* scancode2 when ps2 device is plugged (back)=
 in */
+=20
 static struct aux_queue *queue;	/* Mouse data buffer. */
 static int aux_count;
 /* used when we send commands to the mouse that expect an ACK. */
@@ -398,6 +402,7 @@
 static inline void handle_mouse_event(unsigned char scancode)
 {
 #ifdef CONFIG_PSMOUSE
+	static unsigned char prev_code;
 	if (mouse_reply_expected) {
 		if (scancode =3D=3D AUX_ACK) {
 			mouse_reply_expected--;
@@ -405,7 +410,15 @@
 		}
 		mouse_reply_expected =3D 0;
 	}
+	else if(scancode =3D=3D AUX_RECONNECT2 && prev_code =3D=3D AUX_RECONNECT1
+		&& aux_reconnect) {
+		printk (KERN_INFO "PS/2 mouse reconnect detected\n");
+		queue->head =3D queue->tail =3D 0;	/* Flush input queue */
+		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
+		return;
+	}
=20
+	prev_code =3D scancode;
 	add_mouse_randomness(scancode);
 	if (aux_count) {
 		int head =3D queue->head;
@@ -751,6 +764,14 @@
 }
=20
 #if defined CONFIG_PSMOUSE
+
+static int __init aux_reconnect_setup (char *str)
+{
+	aux_reconnect =3D 1;
+	return 1;
+}
+
+__setup("psaux-reconnect", aux_reconnect_setup);
=20
 /*
  * Check if this is a dual port controller.

--RASg3xLB4tUQ4RcS--

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7eZhLxmLh6hyYd04RAnJTAJ9CyWixEyMZ8qkmapcBwl/73IM7DwCfRR5s
TJ1yuGaW+r28gNeBOI1sVP8=
=HZo+
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
