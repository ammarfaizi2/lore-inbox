Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313160AbSDOKAr>; Mon, 15 Apr 2002 06:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313161AbSDOKAr>; Mon, 15 Apr 2002 06:00:47 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:22821 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S313156AbSDOKAj>; Mon, 15 Apr 2002 06:00:39 -0400
Date: Mon, 15 Apr 2002 12:00:36 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux Alpha list <linux-alpha@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Digital PWS: Still IDE DMA corruption w/ 2.4.18
Message-ID: <20020415120036.E4551@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux Alpha list <linux-alpha@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HCdXmnRlPgeNBad2
Content-Type: multipart/mixed; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ivan, Jay, Richard,

I once complained about IDE DMA data corruption on my Digital Personal
Workstation (Miata). The corruption would occur every fourth or fifth 8k
block that was written to disk and only the first couple of bytes were
affected.=20
I came up with a workaround in ide-dma.

The problem was identified as being a documented (well, if you can get the
documents) chipset bug on the pyxis (21174) chipset used on Miata MoBo.

Ivan came up with a better fix: Instead of a hack breaking down the segments
into 8k blocks in ide-dma, he just disabled the hardware SG support on
affected Miatas, so the normal sg_map() call would do the breaking down.

I then tested Ivan's test and reported it to work.=20
Ivan's patch was merged in the 2.4.18pre3 kernel (misattributed to RTH).

I was not entirely correct, though :-(
Here's what my 2.4.18 kernel says on bootup:
pci: pyxis 8K boundary dma bug - sg dma disabled
So Ivan's patch is active.

But occasionally, I see corruption. It happens about once per 100MB written
to disk. Again it happens at the start of an 8k block. Between 4 and 36
bytes are affected. (See the hexified output of a cmp -l attached in
cmp.SL80-ISO7-ISO7.bad).

I don't know exactly what happens there, but I imagine that despite having
disabled HW SG support, the occasionally allocates two contigous 8k blocks
and the sg_map() function will just make one 16k segment from it. So we
still do a busmaster DMA read across a page boundary: Boom!

So, I revamped my workaround in ide-dma to make sure no segments larger than
8k get through for write operations ...
The patch does prevent the corruption of data, so I assume my above
speculation is about right.
Patch against 2.4.18 is attached.

Note: Even with the patch applied, I found data corruption twice (bit 1
cleared on a byte with offset 0xXXXXX063), but I'd guess this is yet another
unrelated thing (firmware, cables, kernel bug). But I could only trigger th=
is
once so far (after transfering something like 5GB).

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmp.SL80-ISO7-ISO7.bad"

00c06000 58 dd
00c06001 75 ed
00c06002 d0 a0
00c06003 98 2b
02a1a000 28 62
02a1a001 a9 37
02a1a002 3b 16
02a1a003 70 57
06958000 d7 ff
06958001 6f d8
06958002 43 6f
06958003 ba c5
093fc000 5d a4
093fc001 6c 5f
093fc002 1d 42
093fc003 62 18
0affc000 48 9b
0affc001 4e 75
0affc002 cb bf
0affc003 26 99
0bee2000 02 60
0bee2001 87 6b
0bee2002 86 d0
0bee2003 01 95
0bee2004 11 37
0bee2005 5e d8
0bee2006 8c 0b
0bee2007 08 1d
0bee2008 36 8c
0bee2009 b1 00
0bee200a 49 88
0bee200b 91 44
0bee200c 0c 1f
0bee200d 3e 1c
0bee200e 2c c6
0bee200f 3c 84
0bee2010 ba 41
0bee2011 55 11
0bee2012 03 10
0bee2013 72 34
0bee2014 f7 42
0bee2015 0f fc
0bee2016 e6 21
0bee2017 26 30
0bee2018 e4 4c
0bee2019 67 48
0bee201a de e2
0bee201b 4d 4f
0bee201c 29 b2
0bee201d ee 96
0bee201e 52 17
0bee201f 51 06
0bee2020 dc 4d
0bee2021 23 8d
0bee2022 d7 b9
0bee2023 3d ea
0c820000 52 50
0c820001 23 98
0c820002 e6 e5
0c820003 93 b5
10e40000 12 2e
10e40001 ae 25
10e40002 ea e5
10e40003 4a 96
10e40004 02 de
10e40005 81 f7
10e40006 9a 7d
10e40007 b8 ff
10e40008 58 6e
10e40009 5e c0
10e4000a c3 80
10e4000b 35 ee
115b2000 85 05
115b2001 b8 24
115b2002 50 27
115b2003 44 01
149c8000 4a 65
149c8001 f1 4d
149c8002 e1 98
149c8003 bb 4f
149c8004 81 0f
149c8005 81 1d
149c8006 3d fb
149c8007 1b b6
149c8008 24 a3
149c8009 16 7a
149c800a 28 37
149c800b 75 c6
149c800c 04 3c
149c800d 39 37
149c800e 92 56
149c800f eb 2d
149c8010 ff 85
149c8011 0d a4
149c8012 eb c1
149c8013 1f e5
149c8014 ce 6e
149c8015 60 5e
149c8016 ea 78
149c8017 50 13
149c8018 f5 d5
149c8019 4e 51
149c801a f9 f5
149c801b 72 eb
16008000 4a 40
16008001 96 c6
16008002 0e 4a
16008003 c3 63
17834000 03 55
17834001 fe de
17834002 64 ac
17834003 6b 2c
1a8c8000 24 44
1a8c8001 fb f3
1a8c8002 dc b7
1a8c8003 64 c5
1b7cc000 dc 0e
1b7cc001 ce d6
1b7cc002 d4 e6
1b7cc003 59 42
1b7cc004 00 96
1b7cc005 f5 74
1b7cc006 d5 a1
1b7cc007 4c a7
1b7cc008 b7 19
1b7cc009 ad b4
1b7cc00a 70 a1
1b7cc00b e4 03
1b7cc00c 33 f6
1b7cc00d d8 ba
1b7cc00e 42 9b
1b7cc00f e2 55
1b7cc010 f8 48
1b7cc011 1f c9
1b7cc012 df ca
1b7cc013 fe ed
1b7cc014 1f 7e
1b7cc015 e8 73
1b7cc016 5f c7
1b7cc017 db e9
1e814000 d5 0c
1e814001 d8 53
1e814002 56 04
1e814003 1e 2f
1f536000 94 ce
1f536001 f0 b4
1f536002 de eb
1f536003 7e e4
23f34000 16 c5
23f34001 e2 79
23f34002 e3 2f
23f34003 22 d2
2449e000 cb 59
2449e001 d1 e3
2449e002 bc e3
2449e003 24 e5
271d0000 49 14
271d0001 06 f2
271d0002 43 2a
271d0003 78 56
271d4000 9f 32
271d4001 55 49
271d4002 3a f4
271d4003 1d d5
271d4004 9c 29
271d4005 43 ff
271d4006 6c 9f
271d4007 a2 08
271d4008 ce ab
271d4009 70 90
271d400a 9b 15
271d400b 93 44
271d400c 21 b7
271d400d 08 54
271d400e fe 8c
271d400f c4 43
271d4010 f1 b4
271d4011 e0 da
271d4012 61 4c
271d4013 0c 42
271d4014 fb 4c
271d4015 2a 48
271d4016 a6 ff
271d4017 1a 70
271d4018 ca 1b
271d4019 9b 3b
271d401a c1 ab
271d401b f8 14
271d401c 1c 7d
271d401d 63 96
271d401e 06 16
271d401f 56 98
271d4020 61 af
271d4021 c4 ef
271d4022 06 94
271d4023 d1 83

--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pyxis-ide-dma-pagecross-2418.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.18.SuSE/drivers/ide/ide-dma.c	Wed Mar 27 10:58:32 2002
+++ linux-2.4.18.SuSE.axp/drivers/ide/ide-dma.c	Fri Apr  5 12:41:34 2002
@@ -326,6 +326,9 @@
 	return pci_map_sg(hwif->pci_dev, sg, nents, hwif->sg_dma_direction);
 }
=20
+#if defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_GENERIC)
+extern int have_pyxis_pagecross_bug;
+#endif=09
 /*
  * ide_build_dmatable() prepares a dma request.
  * Returns 0 if all went okay, returns 1 otherwise.
@@ -377,6 +380,25 @@
 			xcount =3D bcount & 0xffff;
 			if (is_trm290_chipset)
 				xcount =3D ((xcount >> 2) - 1) << 16;
+		=09
+			/* garloff@suse.de, 2001-12-11: Don't cross page boundaries=20
+			 * on boards with pyxis dma read page bound cross bug
+			 * when writing (DMA read) */
+#if defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_GENERIC)
+			if (have_pyxis_pagecross_bug && func =3D=3D ide_dma_write
+			    && HWIF(drive)->pci_dev->bus->number =3D=3D 0) {
+				if (xcount =3D=3D0)=20
+					xcount =3D 0x10000;
+				while ((cur_addr & (PAGE_SIZE-1)) + xcount > PAGE_SIZE) {
+					u32 newcnt =3D PAGE_SIZE - (cur_addr & (PAGE_SIZE-1));
+					if (count++ >=3D PRD_ENTRIES)
+						goto use_pio_instead;
+					*table++ =3D cpu_to_le32(newcnt);
+					*table++ =3D cpu_to_le32(cur_addr +=3D newcnt);
+					xcount -=3D newcnt;
+				}
+			}
+#endif
 			if (xcount =3D=3D 0x0000) {
 				/*=20
 				 * Most chipsets correctly interpret a length
@@ -389,12 +411,16 @@
 					goto use_pio_instead;
=20
 				*table++ =3D cpu_to_le32(0x8000);
-				*table++ =3D cpu_to_le32(cur_addr + 0x8000);
+				*table++ =3D cpu_to_le32(cur_addr +=3D 0x8000);
 				xcount =3D 0x8000;
 			}
-			*table++ =3D cpu_to_le32(xcount);
-			cur_addr +=3D bcount;
+			cur_addr +=3D xcount;
 			cur_len -=3D bcount;
+			// *table++ =3D cpu_to_le32(xcount | (cur_len? 0: 0x80000000));
+			/* garloff@suse.de, 2001-12-11: We don't mark the last PDR segment
+			 * with EOT bit (31) in length field, but let the drive
+			 * send us an interrupt. */
+			*table++ =3D cpu_to_le32(xcount);
 		}
=20
 		sg++;
--- linux-2.4.18.SuSE/arch/alpha/kernel/core_cia.c	Sun Oct 21 19:30:58 2001
+++ linux-2.4.18.SuSE.axp/arch/alpha/kernel/core_cia.c	Fri Apr  5 12:38:47 =
2002
@@ -388,6 +388,14 @@
 	*(vip)CIA_IOC_PCI_T1_BASE =3D virt_to_phys(ppte) >> 2;
 }
=20
+/* garloff@suse.de, 2001-12-11:
+ * Flag set, if we suffer PYXIS page crossing corruption on DMA reads.
+ * Note: All PCI devices sitting on primary PCI bus doing busmaster DMA
+ * should check this flag and adjust their SG tables accordingly for reads
+ * from memory (i.e. writes to device). See ide-dma.c code for an example.
+ */
+int have_pyxis_pagecross_bug;
+
 static void __init
 verify_tb_operation(void)
 {
@@ -565,6 +573,8 @@
 	/* Clean up after the tests.  */
 	arena->ptes[4] =3D 0;
 	arena->ptes[5] =3D 0;
+	*(vip)CIA_IOC_TBn_PAGEm(0,0) =3D 0;
+	*(vip)CIA_IOC_TB_TAGn(0) =3D 0;
=20
 	if (use_tbia_try2) {
 		alpha_mv.mv_pci_tbi =3D cia_pci_tbi_try2;
@@ -760,6 +770,9 @@
 	hwrpb_update_checksum(hwrpb);
=20
 	do_init_arch(1);
+	/* Normally, we should check for the presence of this bug,
+	 * but there's no easy way to detect it. KG, 2001-12-18. */
+	have_pyxis_pagecross_bug =3D 1;
 }
=20
 void __init
--- linux-2.4.18.SuSE/arch/alpha/kernel/alpha_ksyms.c	Wed Mar 27 10:58:30 2=
002
+++ linux-2.4.18.SuSE.axp/arch/alpha/kernel/alpha_ksyms.c	Fri Apr  5 13:10:=
59 2002
@@ -263,7 +263,12 @@
=20
 EXPORT_SYMBOL(get_wchan);
=20
-#ifdef CONFIG_ALPHA_IRONGATE
+#if defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_GENERIC)
+extern int have_pyxis_pagecross_bug;
+EXPORT_SYMBOL_NOVERS(have_pyxis_pagecross_bug);
+#endif
+
+# ifdef CONFIG_ALPHA_IRONGATE
 EXPORT_SYMBOL(irongate_ioremap);
 EXPORT_SYMBOL(irongate_iounmap);
 #endif

--jKBxcB1XkHIR0Eqt--

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8uqTDxmLh6hyYd04RAi9KAKDaC8e/DCfqloNugAcj84w6YuhU2gCg2aKj
CGqWS1TuYIOkUW2EBHVr7Qc=
=1nhD
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
