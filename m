Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTFJGDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 02:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTFJGDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 02:03:22 -0400
Received: from [61.95.53.28] ([61.95.53.28]:10502 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S262385AbTFJGDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 02:03:19 -0400
Date: Tue, 10 Jun 2003 16:16:54 +1000
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030610061654.GB25390@himi.org>
Mail-Followup-To: jsimmons@infradead.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've started seeing a hard lockup on boot with my Fujitsu Lifebook
p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
kernel as of 2003-06-09 (possibly earlier - the last kernel I've
tested is bk as of 2003-06-04). lspci lists this hardware:

---------------------------------------------------
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 03)
00:00.1 RAM memory: Transmeta Corporation SDRAM controller
00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Cont=
roller Audio Device (rev 01)
00:06.0 Bridge: ALi Corporation M7101 PMU
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:09.0 USB Controller: NEC Corporation USB (rev 41)
00:09.1 USB Controller: NEC Corporation USB (rev 41)
00:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
00:0c.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controlle=
r (rev 01)
00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C=
/8139C+ (rev 10)
00:12.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan chipset =
(rev 01)
00:13.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 C=
ontroller (PHY/Link)
00:14.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 =
LY
---------------------------------------------------

Building the kernel without framebuffer support results in a
bootable kernel. Disabling only framebuffer console support (ie,
CONFIG_FB=3Dy, CONFIG_FB_RADEON=3Dy, CONFIG_FRAMEBUFFER_CONSOLE=3Dn)
oopses the same way as with the framebuffer console enabled.

Unfortunately, the system locks up to the point where I can't scroll
back to get the full oops, and it never hits any logfiles, so all I
have (copied by hand, with a few formatting changes to make copying
easier) is the last 25 lines of the oops:

---------------------------------------------------
c01c042b pci_enable_device_bars+0x21/0x40
c01c0457 pci_enable_device+0x17/0x20
c0245c37 radeonfb_pci_register+0x37/0x66 (?)
c0109a1c common_interrupt+0x18/0x20
c01c23f2 pci_device_probe_static+0x52/0x70
c01c251c __pci_device_probe+0x3c/0x50
c01c255f pci_device_probe+0x2f/0x50
c02162a5 bus_match+0x45/0x80
c02163ce driver_attach+0x5e/0x60
c0216673 bus_add_driver+0x93/0xb0
c0216abf driver_register+0x2f/0x40
c015883d register_chrdev+0xcd/0x120
c01c2802 pci_register_driver+0x72/0xa0
c0378733 radeonfb_init+0x13/0x40
c0378207 fbmem_init+0x87/0xc0
c0374169 chr_dev_init+0x79/0xa0
c03627bb do_initcalls+0x2b/0xa0=20
c012bc3f init_workqueues+0xf/0x30
c010506b init+0x2b/0x180
c0105040 init+0x0/0x180
c010725d kernel_thread_helper+0x5/0x18

Code: bad EIP value.
 <0>Kernel panic: Attempted to kill init!
--------------------------------------------------

This is the diff between the working config (sans framebuffer=20
support) and the oopsing config: =20

--------------------------------------------------
--- /boot/config-2.5.70-20030610        2003-06-10 14:51:29.000000000 +1000
+++ /boot/config-2.5.70-20030610-nofb   2003-06-10 14:40:14.000000000 +1000
@@ -1036,27 +1036,8 @@
 #
 # Graphics support
 #
-CONFIG_FB=3Dy
-# CONFIG_FB_CIRRUS is not set
-# CONFIG_FB_PM2 is not set
-# CONFIG_FB_CYBER2000 is not set
-# CONFIG_FB_IMSTT is not set
-# CONFIG_FB_VGA16 is not set
-CONFIG_FB_VESA=3Dy
+# CONFIG_FB is not set
 CONFIG_VIDEO_SELECT=3Dy
-# CONFIG_FB_HGA is not set
-# CONFIG_FB_RIVA is not set
-# CONFIG_FB_MATROX is not set
-CONFIG_FB_RADEON=3Dy
-# CONFIG_FB_ATY128 is not set
-# CONFIG_FB_ATY is not set
-# CONFIG_FB_SIS is not set
-# CONFIG_FB_NEOMAGIC is not set
-# CONFIG_FB_3DFX is not set
-# CONFIG_FB_VOODOO1 is not set
-# CONFIG_FB_TRIDENT is not set
-# CONFIG_FB_PM3 is not set
-# CONFIG_FB_VIRTUAL is not set
=20
 #
 # Console display driver support
@@ -1064,19 +1045,6 @@
 CONFIG_VGA_CONSOLE=3Dy
 # CONFIG_MDA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=3Dy
-CONFIG_FRAMEBUFFER_CONSOLE=3Dy
-CONFIG_PCI_CONSOLE=3Dy
-# CONFIG_FONTS is not set
-CONFIG_FONT_8x8=3Dy
-CONFIG_FONT_8x16=3Dy
-
-#
-# Logo configuration
-#
-CONFIG_LOGO=3Dy
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
-CONFIG_LOGO_LINUX_CLUT224=3Dy
=20
 #
 # Sound
--------------------------------------------------

If you need any other information, ask away - I'll do my best.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5XfVQPlfmRRKmRwRAvIPAJ9GekCZK0CKU9cpqbaGzlufX8QYBQCffVVY
BqcE9q/jsYs4YrohX8vjEzQ=
=9Ha8
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
