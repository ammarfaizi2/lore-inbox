Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280622AbRKJL4k>; Sat, 10 Nov 2001 06:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280623AbRKJL4d>; Sat, 10 Nov 2001 06:56:33 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:61009 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S280622AbRKJL4R>; Sat, 10 Nov 2001 06:56:17 -0500
Date: Sat, 10 Nov 2001 12:56:15 +0100
From: Kurt Garloff <garloff@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] clgenfb
Message-ID: <20011110125615.F16015@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DNUSDXU7R7AVVM8C"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.13 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DNUSDXU7R7AVVM8C
Content-Type: multipart/mixed; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

thanks for clgenfb, the fb driver for cirrus logic chips!
It made the PowerStorm in my Digital PWS more useable.
I can run XF86 fbdev on top of it; I will replace the VGA ASAP though.

Some hints for people:
I had to use -accel false -vyres -1 to get it sort of stable.

Still, in text-mode apps that scroll windows like jed, it occasionally
crashes the machine :-(=20
XFree86 fbdev (4.1.0) runs perfeclty though, XFree86 cirrus (4.1.0) produces
distorted output.

I have a patch for you:
* Memory detection was wrong here. I just have 512k, which clgenfb does not
  seem to be prepared for. I had another look at XFree86 sources to fix it.=
=20
  Now it works correctly.
* I added a 800x600 mode and tweaked the timings to more reasonable values:
  You always want to have short right/bottom shoulder, medium length sync a=
nd
  relatively long left/top shoulder to help monitors with syncing.

Please apply,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cirrus-fixes-2414p7aa2SuSE.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.14-pre7-aa2-SuSE/drivers/video/clgenfb.c	Fri Nov  9 11:47:04 =
2001
+++ linux-2.4.14p7aa2SuSE.compile.AXP/drivers/video/clgenfb.c	Sat Nov 10 01=
:25:48 2001
@@ -31,7 +31,7 @@
  *
  */
=20
-#define CLGEN_VERSION "1.9.9"
+#define CLGEN_VERSION "1.9.9.1"
=20
 #include <linux/config.h>
 #include <linux/module.h>
@@ -86,7 +86,6 @@
 /* disable runtime assertions? */
 /* #define CLGEN_NDEBUG */
=20
-
 /* debug output */
 #ifdef CLGEN_DEBUG
 #define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__ ,=
 ## args)
@@ -115,6 +114,7 @@
 #define FALSE 0
=20
 #define MB_ (1024*1024)
+#define KB_ (1024)
=20
 #define MAX_NUM_BOARDS 7
=20
@@ -439,11 +439,23 @@
 		 {0, 8, 0},
 		 {0, 8, 0},
 		 {0, 0, 0},
-	       0, 0, -1, -1, FB_ACCEL_NONE, 40000, 32, 32, 33, 10, 96, 2,
+	       0, 0, -1, -1, FB_ACCEL_NONE, 40000, 48, 16, 32, 8, 96, 4,
      FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
 	 }
 	},
=20
+	{"800x600",		/* 800x600, 48 kHz, 76 Hz, 50 MHz PixClock */
+	 {
+		 800, 600, 800, 600, 0, 0, 8, 0,
+		 {0, 8, 0},
+		 {0, 8, 0},
+		 {0, 8, 0},
+		 {0, 0, 0},
+	       0, 0, -1, -1, FB_ACCEL_NONE, 20000, 128, 16, 24, 2, 96, 6,
+     0, FB_VMODE_NONINTERLACED
+	 }
+	},
+
 	/*
 	   Modeline from XF86Config:
 	   Mode "1024x768" 80  1024 1136 1340 1432  768 770 774 805
@@ -455,8 +467,8 @@
 			{0, 8, 0},
 			{0, 8, 0},
 			{0, 0, 0},
-	      0, 0, -1, -1, FB_ACCEL_NONE, 12500, 92, 112, 31, 2, 204, 4,
-     FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
+	      0, 0, -1, -1, FB_ACCEL_NONE, 12500, 144, 32, 30, 2, 192, 6,
+     0, FB_VMODE_NONINTERLACED
 		}
 	}
 };
@@ -2404,22 +2416,27 @@
  * seem to have. */
 static unsigned int __init clgen_get_memsize (caddr_t regbase)
 {
-	unsigned long mem =3D 1 * MB_;
+	unsigned long mem;
 	unsigned char SRF;
=20
 	DPRINTK ("ENTER\n");
=20
 	SRF =3D vga_rseq (regbase, CL_SEQRF);
-	if ((SRF & 0x18) =3D=3D 0x18) {
+	switch ((SRF & 0x18)) {
+	    case 0x08: mem =3D 512 * 1024; break;
+	    case 0x10: mem =3D 1024 * 1024; break;
 		/* 64-bit DRAM data bus width; assume 2MB. Also indicates 2MB memory
 		   * on the 5430. */
-		mem *=3D 2;
+	    case 0x18: mem =3D 2048 * 1024; break;
+	    default: printk ("CLgenfb: Unknown memory size!\n");
+		mem =3D 1024 * 1024;
 	}
 	if (SRF & 0x80) {
 		/* If DRAM bank switching is enabled, there must be twice as much
 		   * memory installed. (4MB on the 5434) */
 		mem *=3D 2;
 	}
+	/* TODO: Handling of GD5446/5480 (see XF86 sources ...) */
 	return mem;
=20
 	DPRINTK ("EXIT\n");
@@ -2562,9 +2579,9 @@
 	info->fbmem_phys =3D board_addr;
 	info->size =3D board_size;
=20
-	printk (" RAM (%lu MB) at 0x%lx, ", info->size / MB_, board_addr);
+	printk (" RAM (%lu kB) at 0x%lx, ", info->size / KB_, board_addr);
=20
-	printk (KERN_INFO "Cirrus Logic chipset on PCI bus\n");
+	printk ("Cirrus Logic chipset on PCI bus\n");
=20
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
--- linux-2.4.14-pre7-aa2-SuSE/Documentation/fb/clgenfb.txt	Thu Jan  6 19:2=
3:46 2000
+++ linux-2.4.14p7aa2SuSE.compile.AXP/Documentation/fb/clgenfb.txt	Sat Nov =
10 01:25:32 2001
@@ -35,11 +35,18 @@
 At the moment, there are two kernel command line arguments supported:
=20
 mode:640x480
+mode:800x600
 	or
 mode:1024x768
=20
 Full support for startup video modes (modedb) will be integrated soon.
=20
+Version 1.9.9.1
+---------------
+* Fix memory detection for 512kB case
+* 800x600 mode
+* Fixed timings
+* Hint for AXP: Use -accel false -vyres -1 when changing resolution
=20
=20
 Version 1.9.4.4

--DEueqSqTbz/jWVG1--

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE77RXexmLh6hyYd04RAn+pAJ9k2Y3XQ+FlugyuoyUQzJNi2+W8vwCeOWTk
MqTZDhIFfaZjV+xoOV/BR/s=
=J3P/
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--
