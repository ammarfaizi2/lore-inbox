Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUFIAZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUFIAZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUFIAZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:25:08 -0400
Received: from mail.dif.dk ([193.138.115.101]:54179 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265463AbUFIAY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:24:57 -0400
Date: Wed, 9 Jun 2004 02:24:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix warnings in drivers/mtd/devices/doc200?.c
Message-ID: <Pine.LNX.4.56.0406090205170.25359@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's an attempt to fix the following warnings :

drivers/mtd/devices/doc2000.c: In function `DoC2k_init':
drivers/mtd/devices/doc2000.c:567: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2000.c:568: warning: assignment from incompatible pointer type

drivers/mtd/devices/doc2001.c: In function `DoCMil_init':
drivers/mtd/devices/doc2001.c:376: warning: assignment from incompatible pointer type
drivers/mtd/devices/doc2001.c:377: warning: assignment from incompatible pointer type

What goes on in both files is identical, and my attempted fix is also
identical for both files.
Here's what goes on:
An function pointer is assigned to the read_ecc and write_ecc members of a
struct mtd_info. These members are if the following form :

int (*read_ecc) (struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen, u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);
int (*write_ecc) (struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen, const u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);

but the protype of the function a pointer to which is assigned to them
looks like this:

static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,size_t *retlen, u_char *buf, u_char *eccbuf, int oobsel);
static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen, const u_char *buf, u_char *eccbuf, int oobsel);

The difference is the last parameter "int oobsel" vs the expected "struct nand_oobinfo *oobsel"

I must admit that I do not know what the purpose of "oobsel" is, nor do I
know very much about these functions or mtd devices in general, but since
the doc_*_ecc functions do not use the oobsel parameter at all I still
think I can propose a safe fix by simply changing the functions to take a
struct nand_oobinfo *  argument instead of their current  int  argument.
Comments??

In any case, here are two patches that change the functions to take the
expected argument types and thus kill the warnings. If this looks sane to
you, then please consider applying. If I've missed something then feel
free to point out my error.  I've only compile tested these patches.

Patches are against 2.6.7-rc3 :


--- linux-2.6.7-rc3/drivers/mtd/devices/doc2000.c-orig	2004-06-09 02:01:43.000000000 +0200
+++ linux-2.6.7-rc3/drivers/mtd/devices/doc2000.c	2004-06-09 02:03:22.000000000 +0200
@@ -53,9 +53,11 @@ static int doc_read(struct mtd_info *mtd
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t *retlen, const u_char *buf);
 static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t *retlen, u_char *buf, u_char *eccbuf, int oobsel);
+			size_t *retlen, u_char *buf, u_char *eccbuf,
+			struct nand_oobinfo *oobsel);
 static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t *retlen, const u_char *buf, u_char *eccbuf, int oobsel);
+			 size_t *retlen, const u_char *buf, u_char *eccbuf,
+			 struct nand_oobinfo *oobsel);
 static int doc_read_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
 			size_t *retlen, u_char *buf);
 static int doc_write_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
@@ -601,7 +603,8 @@ static int doc_read(struct mtd_info *mtd
 }

 static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t * retlen, u_char * buf, u_char * eccbuf, int oobsel)
+			size_t * retlen, u_char * buf, u_char * eccbuf,
+			struct nand_oobinfo *oobsel)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *) mtd->priv;
 	unsigned long docptr;
@@ -750,7 +753,7 @@ static int doc_write(struct mtd_info *mt

 static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
 			 size_t * retlen, const u_char * buf,
-			 u_char * eccbuf, int oobsel)
+			 u_char * eccbuf, struct nand_oobinfo *oobsel)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *) mtd->priv;
 	int di; /* Yes, DI is a hangover from when I was disassembling the binary driver */


--- linux-2.6.7-rc3/drivers/mtd/devices/doc2001.c-orig	2004-06-09 02:04:32.000000000 +0200
+++ linux-2.6.7-rc3/drivers/mtd/devices/doc2001.c	2004-06-09 02:06:32.000000000 +0200
@@ -37,9 +37,11 @@ static int doc_read(struct mtd_info *mtd
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t *retlen, const u_char *buf);
 static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t *retlen, u_char *buf, u_char *eccbuf, int oobsel);
+			size_t *retlen, u_char *buf, u_char *eccbuf,
+			struct nand_oobinfo *oobsel);
 static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t *retlen, const u_char *buf, u_char *eccbuf, int oobsel);
+			 size_t *retlen, const u_char *buf, u_char *eccbuf,
+			 struct nand_oobinfo *oobsel);
 static int doc_read_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
 			size_t *retlen, u_char *buf);
 static int doc_write_oob(struct mtd_info *mtd, loff_t ofs, size_t len,
@@ -399,15 +401,16 @@ static void DoCMil_init(struct mtd_info
 	}
 }

-static int doc_read (struct mtd_info *mtd, loff_t from, size_t len,
+static int doc_read(struct mtd_info *mtd, loff_t from, size_t len,
 		     size_t *retlen, u_char *buf)
 {
 	/* Just a special case of doc_read_ecc */
 	return doc_read_ecc(mtd, from, len, retlen, buf, NULL, 0);
 }

-static int doc_read_ecc (struct mtd_info *mtd, loff_t from, size_t len,
-			 size_t *retlen, u_char *buf, u_char *eccbuf, int oobsel)
+static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
+			 size_t *retlen, u_char *buf, u_char *eccbuf,
+			 struct nand_oobinfo *oobsel)
 {
 	int i, ret;
 	volatile char dummy;
@@ -525,15 +528,16 @@ static int doc_read_ecc (struct mtd_info
 	return ret;
 }

-static int doc_write (struct mtd_info *mtd, loff_t to, size_t len,
+static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		      size_t *retlen, const u_char *buf)
 {
 	char eccbuf[6];
 	return doc_write_ecc(mtd, to, len, retlen, buf, eccbuf, 0);
 }

-static int doc_write_ecc (struct mtd_info *mtd, loff_t to, size_t len,
-			  size_t *retlen, const u_char *buf, u_char *eccbuf, int oobsel)
+static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
+			  size_t *retlen, const u_char *buf, u_char *eccbuf,
+			  struct nand_oobinfo *oobsel)
 {
 	int i,ret = 0;
 	volatile char dummy;


--
Jesper Juhl <juhl-lkml@dif.dk>

