Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270195AbRHNJ50>; Tue, 14 Aug 2001 05:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270076AbRHNJ5S>; Tue, 14 Aug 2001 05:57:18 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:2095 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S270011AbRHNJ5C>; Tue, 14 Aug 2001 05:57:02 -0400
Date: Tue, 14 Aug 2001 11:57:01 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mantel@suse.de,
        rubini@vision.unipv.it, torvalds@transmeta.com
Subject: Re: [PATCH] make psaux reconnect adjustable
Message-ID: <20010814115701.A1952@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, Andries.Brouwer@cwi.nl,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	mantel@suse.de, rubini@vision.unipv.it, torvalds@transmeta.com
In-Reply-To: <200108021727.RAA113816@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <200108021727.RAA113816@vlet.cwi.nl>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andries,

On Thu, Aug 02, 2001 at 05:27:07PM +0000, Andries Brouwer wrote:
>     Your other mail implies that we can fix the problem without manual
>     intervention by parsing AA 00 instead of just AA. If it's true, I'd=
=3D20
>     consider that the best solution.=3D20
>=20
> Maybe precisely one person reported this, and his address
> now bounces. If there exist people who need this "psaux-reconnect"
> they can report on the codes they see. Note that just like AA is
> a perfectly normal code, also the sequence AA 00 is perfectly
> normal. Testing for that only diminishes the probability of
> getting it by accident.

I can confirm what you suggest: My mouse (Logitech wheel USB/PS2) sends
indeed AA 00.=20
So, I extended my patch (which you will dislike even more, I know, as you're
against sysctls unlike me):
psmouse_reconnect =3D 0: Do nothing (just pass all to userspace)
psmouse_reconnect =3D 1: Flush Q & ping mouse on AA 00 (default)
psmouse_reconnect =3D 2: Flush Q & ping mouse on AA (old behaviour)

> Instead of adding boot parameters or sysctls or heuristics,
> probably we should just transfer the codes seen to user space,
> e.g. to gpm.  Then it is up to gpm to recognize an AA 00 sequence
> and decide whether that is something special.

With reconnect 1 or 2: After reconnecting, mouse behaves strange (jumping
			around the screen)
With reconnect 0:      Mouse is dead

In both cases restarting gpm gets the mouse back to work again.
It seems the imps2 driver does some initialization to the mouse.

If I use the plain ps2 driver, then finally, I see the benefit of the
reconnect code in the kernel:
With reconnect =3D 1 or 2: It works after replugging
With reconnect =3D 0:      Mouse is dead after replugging

In the latter case restarting gpm helps.

Patch is attached.
It adds the sysctls as the last patch did, but now the psmouse_reconnect has
3 possible values. Also, I added a printk, so the kernel logs detected mouse
reconnect events.

Linus, Alan, I'd like to have your input:

Do you like the patch as is? Should I remove the sysctls and just look for
AA 00 (as Andries may prefer)? Shouldn't the AA 00 be passed to userspace
as well in any case (to allow e.g. the imps2 driver to do reinitialization)?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="247-psaux-reconnect-sysctl2.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.7.kurt-1/drivers/char/pc_keyb.c linux-2.4.7.kurt-1-psau=
x/drivers/char/pc_keyb.c
--- linux-2.4.7.kurt-1/drivers/char/pc_keyb.c	Tue Jul 24 18:42:36 2001
+++ linux-2.4.7.kurt-1-psaux/drivers/char/pc_keyb.c	Tue Aug 14 10:44:50 2001
@@ -81,8 +81,9 @@
=20
 static int __init psaux_init(void);
=20
-#define AUX_RECONNECT 170 /* scancode when ps2 device is plugged (back) in=
 */
-=20
+#define AUX_RECONNECT1 170 /* scancode when ps2 device is plugged (back) i=
n */
+#define AUX_RECONNECT2 0   /* scancode when ps2 device is plugged (back) i=
n */
+
 static struct aux_queue *queue;	/* Mouse data buffer. */
 static int aux_count;
 /* used when we send commands to the mouse that expect an ACK. */
@@ -92,8 +93,83 @@
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
+		if (*valp > 2)
+			*valp =3D 2;
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
@@ -123,9 +199,8 @@
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
@@ -324,10 +399,8 @@
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
@@ -352,11 +425,9 @@
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
@@ -374,11 +445,9 @@
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
@@ -397,6 +466,7 @@
 	    return 0200;
 }
=20
+static unsigned char psaux_prev;
 static inline void handle_mouse_event(unsigned char scancode)
 {
 #ifdef CONFIG_PSMOUSE
@@ -407,13 +477,24 @@
 		}
 		mouse_reply_expected =3D 0;
 	}
-	else if(scancode =3D=3D AUX_RECONNECT){
+	else if(scancode =3D=3D AUX_RECONNECT1=20
+		&& sysctl_psmouse_reconnect =3D=3D 2) {
+		printk (KERN_DEBUG "PS2 mouse reconnect detected.\n");
+		queue->head =3D queue->tail =3D 0;  /* Flush input queue */
+		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
+		return;
+	}
+	else if (scancode =3D=3D AUX_RECONNECT2 && psaux_prev =3D=3D AUX_RECONNEC=
T1
+		 && sysctl_psmouse_reconnect =3D=3D 1 ) {
+		printk (KERN_DEBUG "PS2 mouse reconnect detected.\n");
 		queue->head =3D queue->tail =3D 0;  /* Flush input queue */
 		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
 		return;
 	}
=20
 	add_mouse_randomness(scancode);
+	psaux_prev =3D scancode;
+
 	if (aux_count) {
 		int head =3D queue->head;
=20
@@ -515,17 +596,14 @@
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
@@ -755,6 +833,7 @@
=20
 	/* Ok, finally allocate the IRQ, and off we go.. */
 	kbd_request_irq(keyboard_interrupt);
+	psaux_sysctl_register ();
 }
=20
 #if defined CONFIG_PSMOUSE
diff -uNr linux-2.4.7.kurt-1/include/linux/sysctl.h linux-2.4.7.kurt-1-psau=
x/include/linux/sysctl.h
--- linux-2.4.7.kurt-1/include/linux/sysctl.h	Tue Jul 24 18:48:05 2001
+++ linux-2.4.7.kurt-1-psaux/include/linux/sysctl.h	Tue Aug 14 10:37:54 2001
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

--OgqxwSJOaUobr8KG--

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ePXtxmLh6hyYd04RAtjyAJ9yB7UclerJDTGLJ7/fRRuKKpt3UQCgv8lZ
DkKvb6jTel1rBPPB1U3zEwI=
=nhjD
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
