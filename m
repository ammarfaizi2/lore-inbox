Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSHGRCG>; Wed, 7 Aug 2002 13:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSHGRCG>; Wed, 7 Aug 2002 13:02:06 -0400
Received: from ppp-217-133-222-186.dialup.tiscali.it ([217.133.222.186]:22731
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318760AbSHGRCF>; Wed, 7 Aug 2002 13:02:05 -0400
Subject: [PATCH] [2.5 i386] Swap TLS and TSS entries to improve spatial
	locality
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-aA19DxSoSQx8T68mr8PH"
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Aug 2002 19:05:38 +0200
Message-Id: <1028739938.11775.30.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aA19DxSoSQx8T68mr8PH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

GDT entries are usually accessed with this pattern:
        * Interrupt: read TSS (for ss0:esp0) and kernel CS/DS
        * Schedule: write TLS, LDT, load FS and GS (either TLS, user DS
          or LDT entry)
        * Return: read user CS/DS

Swapping the TLS and TSS entries causes the GDT entries that are read
during interrupt and schedule to be in the same cacheline.


diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	2002-07-29 04:18:06.000000000 +0200
+++ b/arch/i386/kernel/head.S	2002-08-07 19:03:24.000000000 +0200
@@ -416,12 +416,12 @@
  */
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
-	.quad 0x0000000000000000	/* TLS descriptor */
+	.quad 0x0000000000000000	/* TSS descriptor */
 	.quad 0x00cf9a000000ffff	/* 0x10 kernel 4GB code at 0x00000000 */
 	.quad 0x00cf92000000ffff	/* 0x18 kernel 4GB data at 0x00000000 */
 	.quad 0x00cffa000000ffff	/* 0x23 user   4GB code at 0x00000000 */
 	.quad 0x00cff2000000ffff	/* 0x2b user   4GB data at 0x00000000 */
-	.quad 0x0000000000000000	/* TSS descriptor */
+	.quad 0x0000000000000000	/* TLS descriptor */
 	.quad 0x0000000000000000	/* LDT descriptor */
 	/*
 	 * The APM segments have byte granularity and their bases
diff --exclude-from=/home/ldb/src/linux-exclude -urNd a/include/asm-i386/desc.h b/include/asm-i386/desc.h
--- a/include/asm-i386/desc.h	2002-08-02 01:19:14.000000000 +0200
+++ b/include/asm-i386/desc.h	2002-08-07 18:56:12.000000000 +0200
@@ -7,12 +7,12 @@
  * The layout of the per-CPU GDT under Linux:
  *
  *   0 - null
- *   1 - Thread-Local Storage (TLS) segment
+ *   1 - TSS
  *   2 - kernel code segment
  *   3 - kernel data segment
  *   4 - user code segment		<==== new cacheline
  *   5 - user data segment
- *   6 - TSS
+ *   6 - Thread-Local Storage (TLS) segment
  *   7 - LDT
  *   8 - APM BIOS support		<==== new cacheline
  *   9 - APM BIOS support
@@ -27,8 +27,8 @@
  *  18 - not used
  *  19 - not used
  */
-#define TLS_ENTRY 1
-#define TSS_ENTRY 6
+#define TSS_ENTRY 1
+#define TLS_ENTRY 6
 #define LDT_ENTRY 7
 /*
  * The interrupt descriptor table has room for 256 idt's,


--=-aA19DxSoSQx8T68mr8PH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UVNidjkty3ft5+cRAmkXAJ9EueTrmthRTbBTJlR0txECoThoHwCdGPE9
mMGpvWSNpKUBrFB56xuUsiA=
=7yZK
-----END PGP SIGNATURE-----

--=-aA19DxSoSQx8T68mr8PH--
