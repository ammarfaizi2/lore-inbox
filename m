Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266775AbSKHITo>; Fri, 8 Nov 2002 03:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266779AbSKHITo>; Fri, 8 Nov 2002 03:19:44 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:21990 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266775AbSKHITm>; Fri, 8 Nov 2002 03:19:42 -0500
Date: Fri, 8 Nov 2002 09:22:41 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.5. PATCH] cpufreq: correct initialization on Intel Coppermines
Message-ID: <20021108092241.A1636@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[2.5. PATCH] cpufreq: Intel Coppermines -- the saga continues.

The detection process for speedstep-enabled Pentium III Coppermines is
considered proprietary by Intel. The attempt to detect this
capability using MSRs failed. So, users need to pass the option
"speedstep_coppermine=3D1" to the kernel (boot option or parameter) if
they own a SpeedStep capable PIII Coppermine processor. Tualatins work
as before.

       Dominik


--- linux-2546original/arch/i386/kernel/cpu/cpufreq/speedstep.c	Tue Nov  5 =
12:27:14 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	Tue Nov  5 13:01:39 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: speedstep.c,v 1.53 2002/09/29 23:43:11 db Exp $
+ *  $Id: speedstep.c,v 1.57 2002/11/05 12:01:12 db Exp $
  *
  * (C) 2001  Dave Jones, Arjan van de ven.
  * (C) 2002  Dominik Brodowski <linux@brodo.de>
@@ -46,7 +46,8 @@
=20
 /* speedstep_processor
  */
-static unsigned int                     speedstep_processor;
+static unsigned int                     speedstep_processor =3D 0;
+static int                              speedstep_coppermine =3D 0;
=20
 #define SPEEDSTEP_PROCESSOR_PIII_C      0x00000001  /* Coppermine core */
 #define SPEEDSTEP_PROCESSOR_PIII_T      0x00000002  /* Tualatin core */
@@ -72,7 +73,7 @@
 #ifdef SPEEDSTEP_DEBUG
 #define dprintk(msg...) printk(msg)
 #else
-#define dprintk(msg...) do { } while(0);
+#define dprintk(msg...) do { } while(0)
 #endif
=20
=20
@@ -429,7 +430,7 @@
 /**=20
  * speedstep_detect_processor - detect Intel SpeedStep-capable processors.
  *
- *   Returns the SPEEDSTEP_PROCESSOR_-number for the detected chipset,=20
+ *   Returns the SPEEDSTEP_PROCESSOR_-number for the detected processor,=
=20
  * or zero on failure.
  */
 static unsigned int speedstep_detect_processor (void)
@@ -474,8 +475,6 @@
 		return SPEEDSTEP_PROCESSOR_PIII_T;
=20
 	case 0x08: /* Intel PIII [Coppermine] */
-		/* based on reverse-engineering information and
-		 * some guessing. HANDLE WITH CARE! */
  	        {
 			u32     msr_lo, msr_hi;
=20
@@ -487,21 +486,13 @@
 			if (msr_lo !=3D 0x0080000)
 				return 0;
=20
-			/* platform ID seems to be 0x00140000 */
-			rdmsr(MSR_IA32_PLATFORM_ID, msr_lo, msr_hi);
-			dprintk(KERN_DEBUG "cpufreq: Coppermine: MSR_IA32_PLATFORM ID is 0x%x, =
0x%x\n", msr_lo, msr_hi);
-			msr_hi =3D msr_lo & 0x001c0000;
-			if (msr_hi !=3D 0x00140000)
-				return 0;
-
-			/* and these bits seem to be either 00_b, 01_b or
-			 * 10_b but never 11_b */
-			msr_lo &=3D 0x00030000;
-			if (msr_lo =3D=3D 0x0030000)
-				return 0;
+			if (speedstep_coppermine)
+				return SPEEDSTEP_PROCESSOR_PIII_C;
=20
-			/* let's hope this is correct... */
-			return SPEEDSTEP_PROCESSOR_PIII_C;
+			printk(KERN_INFO "cpufreq: in case this is a SpeedStep-capable Intel Pe=
ntium III Coppermine\n");
+			printk(KERN_INFO "cpufreq: processor, please pass the boot option or mo=
dule parameter\n");
+			printk(KERN_INFO "cpufreq: `speedstep_coppermine=3D1` to the kernel. Th=
anks!\n");
+			return 0;
 		}
=20
 	default:
@@ -622,6 +613,25 @@
 }
=20
=20
+#ifndef MODULE
+/**
+ * speedstep_setup  speedstep command line parameter parsing
+ *
+ * speedstep command line parameter.  Use:
+ *  speedstep_coppermine=3D1
+ * if the CPU in your notebook is a SpeedStep-capable Intel
+ * Pentium III Coppermine. These processors cannot be detected
+ * automatically, as Intel continues to consider the detection=20
+ * alogrithm as proprietary material.
+ */
+static int __init speedstep_setup(char *str)
+{
+	speedstep_coppermine =3D simple_strtoul(str, &str, 0);
+	return 1;
+}
+__setup("speedstep_coppermine=3D", speedstep_setup);
+#endif
+
 /**
  * speedstep_init - initializes the SpeedStep CPUFreq driver
  *
@@ -637,18 +647,19 @@
=20
=20
 	/* detect chipset */
-	speedstep_chipset =3D speedstep_detect_chipset();
+	speedstep_chipset =3D speedstep_detect_chipset();=20
=20
 	/* detect chipset */
 	if (speedstep_chipset)
 		speedstep_processor =3D speedstep_detect_processor();
=20
 	if ((!speedstep_chipset) || (!speedstep_processor)) {
-		dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet)=
 available.\n", speedstep_processor ? "chipset" : "processor");
+		printk(KERN_INFO "a 0x%x b 0x%x\n", speedstep_processor, speedstep_chips=
et);
+		printk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) for this %s not (yet) =
available.\n", speedstep_chipset ? "processor" : "chipset");
 		return -ENODEV;
 	}
=20
-	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.5=
3 $\n");
+	dprintk(KERN_INFO "cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.5=
7 $\n");
 	dprintk(KERN_DEBUG "cpufreq: chipset 0x%x - processor 0x%x\n",=20
 	       speedstep_chipset, speedstep_processor);
=20
@@ -726,3 +737,5 @@
 MODULE_LICENSE ("GPL");
 module_init(speedstep_init);
 module_exit(speedstep_exit);
+
+MODULE_PARM (speedstep_coppermine, "i");

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9y3RQZ8MDCHJbN8YRAnpEAJ0ShFx3tR0IVYNPpFa4G1MG6FTCrwCfZXnU
oNTFzKs0n7QmU2I7NPQadQ8=
=lRPS
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
