Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136691AbREAStY>; Tue, 1 May 2001 14:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136693AbREAStP>; Tue, 1 May 2001 14:49:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11534 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136691AbREAStH>; Tue, 1 May 2001 14:49:07 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AEF04FE.E6ACD979@transmeta.com>
Date: Tue, 01 May 2001 11:48:30 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        Andries.Brouwer@cwi.nl
Subject: Re: FIXED iso9660 endianness cleanup patch
In-Reply-To: <200105011440.QAA12760@green.mif.pg.gda.pl> <3AEEFD7F.3E7C6B3@transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------19E0D55C457E19415DC2769C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------19E0D55C457E19415DC2769C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Okay, this one should actually work as advertised.  Pardon the mental
meltdown earlier.

This also changes "extern inline" to "static inline" (per Linus' request)
and always ignores the bigendian part of a bi-endian datum (per Tim
Riker's observation that lots of [Windoze?] programs get that wrong.)

It's still a bit of a loss to have to do unaligned load and endianness
conversion as two operations; on some machines it's doubtlessly faster to
do both at the same time.  However, *those* macros I didn't find...

	-hpa
--------------19E0D55C457E19415DC2769C
Content-Type: text/plain; charset=us-ascii;
 name="isofs-2.4.4-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isofs-2.4.4-2.diff"

diff -ur stock3/linux-2.4.4/fs/isofs/util.c linux-2.4.4/fs/isofs/util.c
--- stock3/linux-2.4.4/fs/isofs/util.c	Wed Nov 29 10:11:38 2000
+++ linux-2.4.4/fs/isofs/util.c	Mon Apr 30 20:49:33 2001
@@ -1,90 +1,9 @@
 /*
  *  linux/fs/isofs/util.c
- *
- *  The special functions in the file are numbered according to the section
- *  of the iso 9660 standard in which they are described.  isonum_733 will
- *  convert numbers according to section 7.3.3, etc.
- *
- *  isofs special functions.  This file was lifted in its entirety from
- *  the 386BSD iso9660 filesystem, by Pace Willisson <pace@blitz.com>.
  */
 
 #include <linux/time.h>
-
-int
-isonum_711 (char * p)
-{
-	return (*p & 0xff);
-}
-
-int
-isonum_712 (char * p)
-{
-	int val;
-	
-	val = *p;
-	if (val & 0x80)
-		val |= 0xffffff00;
-	return (val);
-}
-
-int
-isonum_721 (char * p)
-{
-	return ((p[0] & 0xff) | ((p[1] & 0xff) << 8));
-}
-
-int
-isonum_722 (char * p)
-{
-	return (((p[0] & 0xff) << 8) | (p[1] & 0xff));
-}
-
-int
-isonum_723 (char * p)
-{
-#if 0
-	if (p[0] != p[3] || p[1] != p[2]) {
-		fprintf (stderr, "invalid format 7.2.3 number\n");
-		exit (1);
-	}
-#endif
-	return (isonum_721 (p));
-}
-
-int
-isonum_731 (char * p)
-{
-	return ((p[0] & 0xff)
-		| ((p[1] & 0xff) << 8)
-		| ((p[2] & 0xff) << 16)
-		| ((p[3] & 0xff) << 24));
-}
-
-int
-isonum_732 (char * p)
-{
-	return (((p[0] & 0xff) << 24)
-		| ((p[1] & 0xff) << 16)
-		| ((p[2] & 0xff) << 8)
-		| (p[3] & 0xff));
-}
-
-int
-isonum_733 (char * p)
-{
-#if 0
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		if (p[i] != p[7-i]) {
-			fprintf (stderr, "bad format 7.3.3 number\n");
-			exit (1);
-		}
-	}
-#endif
-	return (isonum_731 (p));
-}
+#include <linux/iso_fs.h>
 
 /* 
  * We have to convert from a MM/DD/YY format to the Unix ctime format.
diff -ur stock3/linux-2.4.4/include/linux/iso_fs.h linux-2.4.4/include/linux/iso_fs.h
--- stock3/linux-2.4.4/include/linux/iso_fs.h	Fri Apr 27 15:48:20 2001
+++ linux-2.4.4/include/linux/iso_fs.h	Tue May  1 11:45:21 2001
@@ -165,14 +165,46 @@
 #define ISOFS_SUPER_MAGIC 0x9660
 
 #ifdef __KERNEL__
-extern int isonum_711(char *);
-extern int isonum_712(char *);
-extern int isonum_721(char *);
-extern int isonum_722(char *);
-extern int isonum_723(char *);
-extern int isonum_731(char *);
-extern int isonum_732(char *);
-extern int isonum_733(char *);
+/* Number conversion inlines, named after the section in ISO 9660
+   they correspond to. */
+
+#include <asm/byteorder.h>
+#include <asm/unaligned.h>
+
+static inline int isonum_711(char *p)
+{
+	return *(u8 *)p;
+}
+static inline int isonum_712(char *p)
+{
+	return *(s8 *)p;
+}
+static inline int isonum_721(char *p)
+{
+	return le16_to_cpu(get_unaligned((u16 *)p));
+}
+static inline int isonum_722(char *p)
+{
+	return be16_to_cpu(get_unaligned((u16 *)p));
+}
+static inline int isonum_723(char *p)
+{
+	/* Ignore bigendian datum due to broken mastering programs */
+	return le16_to_cpu(get_unaligned((u16 *)p));
+}
+static inline int isonum_731(char *p)
+{
+	return le32_to_cpu(get_unaligned((u32 *)p));
+}
+static inline int isonum_732(char *p)
+{
+	return be32_to_cpu(get_unaligned((u32 *)p));
+}
+static inline int isonum_733(char *p)
+{
+	/* Ignore bigendian datum due to broken mastering programs */
+	return le32_to_cpu(get_unaligned((u32 *)p));
+}
 extern int iso_date(char *, int);
 
 extern int parse_rock_ridge_inode(struct iso_directory_record *, struct inode *);

--------------19E0D55C457E19415DC2769C--

