Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUJ3PuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUJ3PuH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUJ3PsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:48:06 -0400
Received: from mail.gmx.de ([213.165.64.20]:231 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261154AbUJ3Pnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:43:50 -0400
X-Authenticated: #815327
Message-ID: <4183B6B0.7010906@gmx.de>
Date: Sat, 30 Oct 2004 17:43:44 +0200
From: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] WOL for sis900
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5EAB29990F9C10883DEDBDE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5EAB29990F9C10883DEDBDE
Content-Type: multipart/mixed;
 boundary="------------070003080301080804090207"

This is a multi-part message in MIME format.
--------------070003080301080804090207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,
I have applied the patch from http://lkml.org/lkml/2003/7/16/88 manually 
to 2.6.7 (also works on 2.6.{8,9}) and have been using it since then.
Attached is a diff against 2.6.9.

Greets
-- 
---------------------------------------
Malte Schröder
MalteSch@gmx.de
ICQ# 68121508
---------------------------------------


--------------070003080301080804090207
Content-Type: text/x-patch;
 name="sis900_wol.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis900_wol.diff"

--- drivers/net/sis900.c.orig	2004-10-18 23:53:51.000000000 +0200
+++ drivers/net/sis900.c	2004-10-30 17:35:49.000000000 +0200
@@ -74,12 +74,14 @@
 
 #define SIS900_MODULE_NAME "sis900"
 #define SIS900_DRV_VERSION "v1.08.07 11/02/2003"
+#define SIS900_WOL_DEFAULT 0
 
 static char version[] __devinitdata =
 KERN_INFO "sis900.c: " SIS900_DRV_VERSION "\n";
 
 static int max_interrupt_work = 40;
 static int multicast_filter_limit = 128;
+static int enable_wol = SIS900_WOL_DEFAULT;
 
 #define sis900_debug debug
 static int sis900_debug;
@@ -182,9 +184,11 @@
 MODULE_PARM(multicast_filter_limit, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(debug, "i");
+MODULE_PARM(enable_wol, "i");
 MODULE_PARM_DESC(multicast_filter_limit, "SiS 900/7016 maximum number of filtered multicast addresses");
 MODULE_PARM_DESC(max_interrupt_work, "SiS 900/7016 maximum events handled per interrupt");
 MODULE_PARM_DESC(debug, "SiS 900/7016 debug level (2-4)");
+MODULE_PARM_DESC(enable_wol, "Enable Wake-on-LAN support (0/1)");
 
 static int sis900_open(struct net_device *net_dev);
 static int sis900_mii_probe (struct net_device * net_dev);
@@ -930,6 +934,7 @@
 {
 	struct sis900_private *sis_priv = net_dev->priv;
 	long ioaddr = net_dev->base_addr;
+	u32 cfgpmcsr;
 	u8 revision;
 	int ret;
 
@@ -956,6 +961,15 @@
 	/* Workaround for EDB */
 	sis900_set_mode(ioaddr, HW_SPEED_10_MBPS, FDX_CAPABLE_HALF_SELECTED);
 
+	/* Enable Wake-on-LAN if requested. */
+	if (enable_wol) {
+		pci_read_config_dword(sis_priv->pci_dev, CFGPMCSR, &cfgpmcsr);
+		cfgpmcsr |= PME_EN;
+		pci_write_config_dword(sis_priv->pci_dev, CFGPMCSR, cfgpmcsr);
+		outl(inl(ioaddr + pmctrl) | MAGICPKT | ALGORITHM, ioaddr + pmctrl);
+	} else
+		outl(inl(ioaddr + pmctrl) & ~MAGICPKT, ioaddr + pmctrl);
+
 	/* Enable all known interrupts by setting the interrupt mask. */
 	outl((RxSOVR|RxORN|RxERR|RxOK|TxURN|TxERR|TxIDLE), ioaddr + imr);
 	outl(RxENA | inl(ioaddr + cr), ioaddr + cr);
--- drivers/net/sis900.h.orig	2004-10-30 17:35:42.000000000 +0200
+++ drivers/net/sis900.h	2004-10-30 17:35:49.000000000 +0200
@@ -140,6 +140,25 @@
 	EEREQ = 0x00000400, EEDONE = 0x00000200, EEGNT = 0x00000100
 };
 
+/* Wake-on-LAN support. */
+enum sis900_power_management_control_register_bits {
+	LINKLOSS  = 0x00000001,
+	LINKON    = 0x00000002,
+	MAGICPKT  = 0x00000400,
+	ALGORITHM = 0x00000800,
+	FRM1EN    = 0x00100000,
+	FRM2EN    = 0x00200000,
+	FRM3EN    = 0x00400000,
+	FRM1ACS   = 0x01000000,
+	FRM2ACS   = 0x02000000,
+	FRM3ACS   = 0x04000000,
+	WAKEALL   = 0x40000000,
+	GATECLK   = 0x80000000
+};
+
+#define CFGPMCSR 0x44
+#define PME_EN 0x100
+
 /* Management Data I/O (mdio) frame */
 #define MIIread         0x6000
 #define MIIwrite        0x5002

--------------070003080301080804090207--

--------------enigF5EAB29990F9C10883DEDBDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg7a04q3E2oMjYtURAsLjAJwL/rqFNBxLXe3lkV5uDVU6Tl85mwCfbiqe
mg1+a2JgHha6I+drxg++eYw=
=fhcb
-----END PGP SIGNATURE-----

--------------enigF5EAB29990F9C10883DEDBDE--
