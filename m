Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUFIArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUFIArS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUFIArS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:47:18 -0400
Received: from mail.dif.dk ([193.138.115.101]:39332 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265487AbUFIArJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:47:09 -0400
Date: Wed, 9 Jun 2004 02:46:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix warnings in drivers/mtd/devices/doc200?.c
In-Reply-To: <1086740981.5459.47.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0406090241230.25359@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0406090205170.25359@jjulnx.backbone.dif.dk>
 <1086740981.5459.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2004, David Woodhouse wrote:

> On Wed, 2004-06-09 at 02:24 +0200, Jesper Juhl wrote:
> > I must admit that I do not know what the purpose of "oobsel" is, nor do I
> > know very much about these functions or mtd devices in general, but since
> > the doc_*_ecc functions do not use the oobsel parameter at all I still
> > think I can propose a safe fix by simply changing the functions to take a
> > struct nand_oobinfo *  argument instead of their current  int  argument.
> > Comments??
>
> That works, but please don't do it without also adding something like:
>
> #warning This driver should be updated to the new ECC API.
>

Ok, that seems preferable to me since then at least it states that "we
know something needs updating here" as opposed to just a compiler warning
which (to a regular user) indicates something along the lines of "nobody
bothered to clean up this code". Personally I prefer the explicit "we know
about this" warning and then having the code compile cleanly.

> Or you could just leave the warning we already have :) >
> It works at the moment because the only thing that _uses_ the driver in
> question is something which also doesn't use the new argument. We're
> working on a new driver and at that point we'll also update the code
> which uses it.
>

Ok. For the time being, here's an updated version of my patchs fixing the
argument type and adding an explicit #warning - still against 2.5.7-rc3 :


--- linux-2.6.7-rc3/drivers/mtd/devices/doc2000.c-orig	2004-06-09 02:01:43.000000000 +0200
+++ linux-2.6.7-rc3/drivers/mtd/devices/doc2000.c	2004-06-09 02:41:34.000000000 +0200
@@ -24,6 +24,8 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/doc2000.h>

+#warning This driver should be updated to the new ECC API.
+
 #define DOC_SUPPORT_2000
 #define DOC_SUPPORT_MILLENNIUM

@@ -53,9 +55,11 @@ static int doc_read(struct mtd_info *mtd
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
@@ -601,7 +605,8 @@ static int doc_read(struct mtd_info *mtd
 }

 static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t * retlen, u_char * buf, u_char * eccbuf, int oobsel)
+			size_t * retlen, u_char * buf, u_char * eccbuf,
+			struct nand_oobinfo *oobsel)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *) mtd->priv;
 	unsigned long docptr;
@@ -750,7 +755,7 @@ static int doc_write(struct mtd_info *mt

 static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
 			 size_t * retlen, const u_char * buf,
-			 u_char * eccbuf, int oobsel)
+			 u_char * eccbuf, struct nand_oobinfo *oobsel)
 {
 	struct DiskOnChip *this = (struct DiskOnChip *) mtd->priv;
 	int di; /* Yes, DI is a hangover from when I was disassembling the binary driver */


--- linux-2.6.7-rc3/drivers/mtd/devices/doc2001.c-orig	2004-06-09 02:04:32.000000000 +0200
+++ linux-2.6.7-rc3/drivers/mtd/devices/doc2001.c	2004-06-09 02:41:44.000000000 +0200
@@ -24,6 +24,8 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/doc2000.h>

+#warning This driver should be updated to the new ECC API.
+
 /* #define ECC_DEBUG */

 /* I have no idea why some DoC chips can not use memcop_form|to_io().
@@ -37,9 +39,11 @@ static int doc_read(struct mtd_info *mtd
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
@@ -399,15 +403,16 @@ static void DoCMil_init(struct mtd_info
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
@@ -525,15 +530,16 @@ static int doc_read_ecc (struct mtd_info
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

