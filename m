Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132984AbREAFb0>; Tue, 1 May 2001 01:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136486AbREAFbR>; Tue, 1 May 2001 01:31:17 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:41230 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132984AbREAFbE>; Tue, 1 May 2001 01:31:04 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AEE4A06.3666F4BE@transmeta.com>
Date: Mon, 30 Apr 2001 22:30:47 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andries Brouwer <Andries.Brouwer@cwi.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: iso9660 endianness cleanup patch
Content-Type: multipart/mixed;
 boundary="------------8A04DF78B3326BEC2D6AE1A6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8A04DF78B3326BEC2D6AE1A6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi guys,

I was looking over the iso9660 code, and noticed that it was doing
endianness conversion via ad hoc *functions*, not even inlines; nor did
it take any advantage of the fact that iso9660 is bi-endian (has "all"
data in both bigendian and littleendian format.)

The attached patch fixes both.  It is against 2.4.4, but from the looks
of it it should patch against -ac as well.

	-hpa
--------------8A04DF78B3326BEC2D6AE1A6
Content-Type: text/plain; charset=us-ascii;
 name="isofs-2.4.4-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isofs-2.4.4-1.diff"

--- linux-2.4.4/include/linux/iso_fs.h	Fri Apr 27 15:48:20 2001
+++ linux-2.4.4-ciso/include/linux/iso_fs.h	Mon Apr 30 20:09:31 2001
@@ -165,14 +165,51 @@
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
+
+extern inline int isonum_711(char *p)
+{
+	return *(u8 *)p;
+}
+extern inline int isonum_712(char *p)
+{
+	return *(s8 *)p;
+}
+extern inline int isonum_721(char *p)
+{
+	return le16_to_cpu(*(u16 *)p);
+}
+extern inline int isonum_722(char *p)
+{
+	return be16_to_cpu(*(u16 *)p);
+}
+extern inline int isonum_723(char *p)
+{
+#ifdef __BIG_ENDIAN
+	return be16_to_cpu(*(u16 *)(p+2));
+#else
+	return le16_to_cpu(*(u16 *)p);
+#endif
+}
+extern inline int isonum_731(char *p)
+{
+	return le32_to_cpu(*(u32 *)p);
+}
+extern inline int isonum_732(char *p)
+{
+	return be32_to_cpu(*(u32 *)p);
+}
+extern inline int isonum_733(char *p)
+{
+#ifdef __BIG_ENDIAN
+	return be32_to_cpu(*(u32 *)(p+4));
+#else
+	return le32_to_cpu(*(u32 *)p);
+#endif
+}
 extern int iso_date(char *, int);
 
 extern int parse_rock_ridge_inode(struct iso_directory_record *, struct inode *);
--- linux-2.4.4/fs/isofs/util.c	Wed Nov 29 10:11:38 2000
+++ linux-2.4.4-ciso/fs/isofs/util.c	Mon Apr 30 20:04:24 2001
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

--------------8A04DF78B3326BEC2D6AE1A6--

