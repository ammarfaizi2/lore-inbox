Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267933AbRHBCXx>; Wed, 1 Aug 2001 22:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268045AbRHBCXe>; Wed, 1 Aug 2001 22:23:34 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:64094 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S267933AbRHBCXS>; Wed, 1 Aug 2001 22:23:18 -0400
Date: Thu, 2 Aug 2001 04:21:00 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alessandro Rubini <rubini@vision.unipv.it>, Hubert Mantel <mantel@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] make psaux reconnect adjustable
Message-ID: <20010802042100.B14010@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alessandro Rubini <rubini@ipvvis.unipv.it>,
	Hubert Mantel <mantel@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus Alan,

working on notebooks I got used to the touchpads.
Now, a lot of notebooks have a Synaptics touchpad.
It offers a few additional features, such as tossing or the third mouse
button (by a short click in the corner) ...

gpm -t synps2 does support those additional features and via the -R epeater
mode you also get it under X11.

Unfortunately, the synps2 generates nonstandard codes when in extended mode,
amongst which the reconnect (170) token.
The kernel (since 2.2.15) does interpret it as such and empties the queue.

This seems to appropriate for a real plug event. For a synps2, it's not, but
makes your mouse dead for a second. Instead the data should just be passed
to userspace (gpm).

So I made the behaviour switchable via a sysctl.=20
/proc/sys/dev/ps2/psmouse_reconnect (defaults to 1 =3D the interpret behavi=
our)
Being at it, I also made the kbd error and unknown scancode reporting
switchable. (It used to be ifdefs.)

Please apply attached patch (against 2.4.7).

Allesandro, should I submit a patch for gpm to automatically handle this for
synps2 in case the kernel patch gets accepted?

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="247-psaux-reconnect-sysctl.diff"
Content-Transfer-Encoding: quoted-printable

--- linux/include/linux/sysctl.h.orig	Tue Jul 31 23:49:42 2001
+++ linux/include/linux/sysctl.h	Thu Aug  2 03:41:34 2001
@@ -594,7 +594,8 @@
 	DEV_HWMON=3D2,
 	DEV_PARPORT=3D3,
 	DEV_RAID=3D4,
-	DEV_MAC_HID=3D5
+	DEV_MAC_HID=3D5,
+	DEV_PSAUX=3D6,
 };
=20
 /* /proc/sys/dev/cdrom */
@@ -653,6 +654,13 @@
 	DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE=3D4,
 	DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE=3D5,
 	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=3D6
+};
+
+/* /proc/sys/dev/psaux */
+enum {
+	DEV_PSMOUSE_RECONNECT=3D1,
+	DEV_KBD_REPORT_UNKN=3D2,
+	DEV_KBD_REPORT_TO=3D3,
 };
=20
 #ifdef __KERNEL__
--- linux/drivers/char/pc_keyb.c.orig	Fri Apr  6 19:42:55 2001
+++ linux/drivers/char/pc_keyb.c	Thu Aug  2 04:01:15 2001
@@ -92,8 +92,83 @@
 #define AUX_INTS_ON  (KBD_MODE_KCC | KBD_MODE_SYS | KBD_MODE_MOUSE_INT | K=
BD_MODE_KBD_INT)
=20
 #define MAX_RETRIES	60		/* some aux operations take long time*/
+
 #endif /* CONFIG_PSMOUSE */
=20
+/* We want to be able to handle the psmouse reconnect token; unfortunately=
 the
+ * Synaptics touchpads (and probably others too) use it for their extented
+ * functionality and produce them in extended mode (as set by gpm -t synps=
2).
+ * So we make this adjustable via a sysctl.  garloff@suse.de, 2001-08-01 */
+
+#ifdef CONFIG_SYSCTL
+#include <linux/sysctl.h>
+#ifdef CONFIG_PSMOUSE
+int sysctl_psmouse_reconnect =3D 1;
+#endif
+int sysctl_kbd_report_unkn =3D 0;
+int sysctl_kbd_report_to =3D 0;
+
+static int psaux_sysctl_handler (ctl_table *ctl, int write, struct file *f=
ilp,
+				 void *buffer, size_t *lenp)
+{
+	int *valp =3D ctl->data;
+	int ret =3D proc_dointvec(ctl, write, filp, buffer, lenp);=20
+	if (write) {
+		if (*valp)
+			*valp =3D 1;
+	}
+	return ret;
+}
+		=09
+
+ctl_table psaux_table[] =3D {
+#ifdef CONFIG_PSMOUSE  =20
+        {DEV_PSMOUSE_RECONNECT, "psmouse_reconnect", &sysctl_psmouse_recon=
nect,
+                sizeof(int), 0644, NULL, &psaux_sysctl_handler},
+#endif  =20
+	{DEV_KBD_REPORT_UNKN, "kbd_report_unknown", &sysctl_kbd_report_unkn,
+                sizeof(int), 0644, NULL, &psaux_sysctl_handler},
+        {DEV_KBD_REPORT_TO, "kbd_report_timeout", &sysctl_kbd_report_to,
+                sizeof(int), 0644, NULL, &psaux_sysctl_handler},
+	{0}
+};
+
+ctl_table psaux_psaux_table[] =3D {
+        {DEV_CDROM, "ps2", NULL, 0, 0555, psaux_table},
+        {0}
+        };
+
+ctl_table psaux_root_table[] =3D {
+#ifdef CONFIG_PROC_FS
+        {CTL_DEV, "dev", NULL, 0, 0555, psaux_psaux_table},
+#endif /* CONFIG_PROC_FS */
+        {0}
+        };
+static struct ctl_table_header *psaux_sysctl_header;
+
+static void psaux_sysctl_register (void)
+{
+	static int initialized;
+	if (initialized) return;
+=09
+	psaux_sysctl_header =3D register_sysctl_table (psaux_root_table, 1);
+	/*psaux_root_table->child->de->owner =3D THIS_MODULE;*/
+	initialized++;
+}
+
+/*
+static void psaux_sysctl_unregister (void)
+{
+	if (psaux_sysctl_header)
+		unregister_sysctl_table (psaux_sysctl_header);
+}
+ */
+#else /* CONFIG_SYSCTL */
+#define sysctl_psmouse_reconnect 1
+#define sysctl_kbd_report_unkn 0
+#define sysctl_kbd_report_to 0
+#endif /* CONFIG_SYSCTL */
+
 /*
  * Wait for keyboard controller input buffer to drain.
  *
@@ -123,9 +198,8 @@
 		mdelay(1);
 		timeout--;
 	} while (timeout);
-#ifdef KBD_REPORT_TIMEOUTS
-	printk(KERN_WARNING "Keyboard timed out[1]\n");
-#endif
+	if (sysctl_kbd_report_to)
+		printk(KERN_WARNING "Keyboard timed out[1]\n");
 }
=20
 /*
@@ -320,10 +394,8 @@
 		  *keycode =3D E1_PAUSE;
 		  prev_scancode =3D 0;
 	      } else {
-#ifdef KBD_REPORT_UNKN
-		  if (!raw_mode)
+		  if (!raw_mode && sysctl_kbd_report_unkn)
 		    printk(KERN_INFO "keyboard: unknown e1 escape sequence\n");
-#endif
 		  prev_scancode =3D 0;
 		  return 0;
 	      }
@@ -348,11 +420,9 @@
 	      if (e0_keys[scancode])
 		*keycode =3D e0_keys[scancode];
 	      else {
-#ifdef KBD_REPORT_UNKN
-		  if (!raw_mode)
+		  if (!raw_mode && sysctl_kbd_report_unkn)
 		    printk(KERN_INFO "keyboard: unknown scancode e0 %02x\n",
 			   scancode);
-#endif
 		  return 0;
 	      }
 	  }
@@ -370,11 +440,9 @@
 	  *keycode =3D high_keys[scancode - SC_LIM];
=20
 	  if (!*keycode) {
-	      if (!raw_mode) {
-#ifdef KBD_REPORT_UNKN
+	      if (!raw_mode && sysctl_kbd_report_unkn) {
 		  printk(KERN_INFO "keyboard: unrecognized scancode (%02x)"
 			 " - ignored\n", scancode);
-#endif
 	      }
 	      return 0;
 	  }
@@ -404,12 +472,15 @@
 		mouse_reply_expected =3D 0;
 	}
 	else if(scancode =3D=3D AUX_RECONNECT){
-		queue->head =3D queue->tail =3D 0;  /* Flush input queue */
-		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
-		return;
+		if (sysctl_psmouse_reconnect) {
+			queue->head =3D queue->tail =3D 0;  /* Flush input queue */
+			__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
+			return;
+		}
 	}
+	else
+		add_mouse_randomness(scancode);
=20
-	add_mouse_randomness(scancode);
 	if (aux_count) {
 		int head =3D queue->head;
=20
@@ -511,17 +582,14 @@
 			if (resend)
 				break;
 			mdelay(1);
-			if (!--timeout) {
-#ifdef KBD_REPORT_TIMEOUTS
+			if (!--timeout && sysctl_kbd_report_to) {
 				printk(KERN_WARNING "keyboard: Timeout - AT keyboard not present?\n");
-#endif
 				return 0;
 			}
 		}
 	} while (retries-- > 0);
-#ifdef KBD_REPORT_TIMEOUTS
-	printk(KERN_WARNING "keyboard: Too many NACKs -- noisy kbd cable?\n");
-#endif
+	if (sysctl_kbd_report_to)
+		printk(KERN_WARNING "keyboard: Too many NACKs -- noisy kbd cable?\n");
 	return 0;
 }
=20
@@ -751,6 +819,7 @@
=20
 	/* Ok, finally allocate the IRQ, and off we go.. */
 	kbd_request_irq(keyboard_interrupt);
+	psaux_sysctl_register ();
 }
=20
 #if defined CONFIG_PSMOUSE

--i9LlY+UWpKt15+FH--

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7aLkLxmLh6hyYd04RAtTfAJ0Y5pDpKz/cMablMNOe7Et6KOIYXQCg0hQ2
VP6sTljkegsAQX4fy5vGwzI=
=8pPh
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
