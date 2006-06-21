Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWFUV7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWFUV7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWFUV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:58:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53258 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030332AbWFUV6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:58:42 -0400
Date: Wed, 21 Jun 2006 23:58:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Thomas Gleixner <tglx@linutronix.de>, dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/mtd/devices/: remove dead _ecc code
Message-ID: <20060621215840.GP9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some code that is dead code after the
"Remove read/write _ecc variants" patch that went into Linus' tree.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/devices/Kconfig       |    4 
 drivers/mtd/devices/Makefile      |    1 
 drivers/mtd/devices/doc2000.c     |  100 -----
 drivers/mtd/devices/doc2001.c     |   94 -----
 drivers/mtd/devices/doc2001plus.c |  109 ------
 drivers/mtd/devices/docecc.c      |  527 ------------------------------
 include/linux/mtd/doc2000.h       |    2 
 7 files changed, 18 insertions(+), 819 deletions(-)

--- linux-2.6.17-mm1-full/drivers/mtd/devices/Kconfig.old	2006-06-21 23:28:42.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/mtd/devices/Kconfig	2006-06-21 23:29:05.000000000 +0200
@@ -213,10 +213,6 @@
 
 config MTD_DOCPROBE
 	tristate
-	select MTD_DOCECC
-
-config MTD_DOCECC
-	tristate
 
 config MTD_DOCPROBE_ADVANCED
 	bool "Advanced detection options for DiskOnChip"
--- linux-2.6.17-mm1-full/drivers/mtd/devices/Makefile.old	2006-06-21 23:26:46.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/mtd/devices/Makefile	2006-06-21 23:26:59.000000000 +0200
@@ -7,7 +7,6 @@
 obj-$(CONFIG_MTD_DOC2001)	+= doc2001.o
 obj-$(CONFIG_MTD_DOC2001PLUS)	+= doc2001plus.o
 obj-$(CONFIG_MTD_DOCPROBE)	+= docprobe.o
-obj-$(CONFIG_MTD_DOCECC)	+= docecc.o
 obj-$(CONFIG_MTD_SLRAM)		+= slram.o
 obj-$(CONFIG_MTD_PHRAM)		+= phram.o
 obj-$(CONFIG_MTD_PMC551)	+= pmc551.o
--- linux-2.6.17-mm1-full/drivers/mtd/devices/doc2000.c.old	2006-06-21 23:13:28.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/mtd/devices/doc2000.c	2006-06-21 23:40:05.000000000 +0200
@@ -42,8 +42,6 @@
 #define DoC_is_Millennium(doc) (0)
 #endif
 
-/* #define ECC_DEBUG */
-
 /* I have no idea why some DoC chips can not use memcpy_from|to_io().
  * This may be due to the different revisions of the ASIC controller built-in or
  * simplily a QA/Bug issue. Who knows ?? If you have trouble, please uncomment
@@ -55,10 +53,6 @@
 		    size_t *retlen, u_char *buf);
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t *retlen, const u_char *buf);
-static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t *retlen, u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);
-static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t *retlen, const u_char *buf, u_char *eccbuf, struct nand_oobinfo *oobsel);
 static int doc_read_oob(struct mtd_info *mtd, loff_t ofs,
 			struct mtd_oob_ops *ops);
 static int doc_write_oob(struct mtd_info *mtd, loff_t ofs,
@@ -615,19 +609,10 @@
 static int doc_read(struct mtd_info *mtd, loff_t from, size_t len,
 		    size_t * retlen, u_char * buf)
 {
-	/* Just a special case of doc_read_ecc */
-	return doc_read_ecc(mtd, from, len, retlen, buf, NULL, NULL);
-}
-
-static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t * retlen, u_char * buf, u_char * eccbuf, struct nand_oobinfo *oobsel)
-{
 	struct DiskOnChip *this = mtd->priv;
 	void __iomem *docptr = this->virtadr;
 	struct Nand *mychip;
-	unsigned char syndrome[6];
-	volatile char dummy;
-	int i, len256 = 0, ret=0;
+	int len256 = 0;
 	size_t left = len;
 
 	/* Don't allow read past end of device */
@@ -644,15 +629,6 @@
 		if (from + len > ((from | 0x1ff) + 1))
 			len = ((from | 0x1ff) + 1) - from;
 
-		/* The ECC will not be calculated correctly if less than 512 is read */
-		if (len != 0x200 && eccbuf)
-			printk(KERN_WARNING
-			       "ECC needs a full sector read (adr: %lx size %lx)\n",
-			       (long) from, (long) len);
-
-		/* printk("DoC_Read (adr: %lx size %lx)\n", (long) from, (long) len); */
-
-
 		/* Find the chip which is to be used and select it */
 		mychip = &this->chips[from >> (this->chipshift)];
 
@@ -673,15 +649,9 @@
 		DoC_Address(this, ADDR_COLUMN_PAGE, from, CDSN_CTRL_WP,
 			    CDSN_CTRL_ECC_IO);
 
-		if (eccbuf) {
-			/* Prime the ECC engine */
-			WriteDOC(DOC_ECC_RESET, docptr, ECCConf);
-			WriteDOC(DOC_ECC_EN, docptr, ECCConf);
-		} else {
-			/* disable the ECC engine */
-			WriteDOC(DOC_ECC_RESET, docptr, ECCConf);
-			WriteDOC(DOC_ECC_DIS, docptr, ECCConf);
-		}
+		/* disable the ECC engine */
+		WriteDOC(DOC_ECC_RESET, docptr, ECCConf);
+		WriteDOC(DOC_ECC_DIS, docptr, ECCConf);
 
 		/* treat crossing 256-byte sector for 2M x 8bits devices */
 		if (this->page256 && from + len > (from | 0xff) + 1) {
@@ -698,59 +668,6 @@
 		/* Let the caller know we completed it */
 		*retlen += len;
 
-		if (eccbuf) {
-			/* Read the ECC data through the DiskOnChip ECC logic */
-			/* Note: this will work even with 2M x 8bit devices as   */
-			/*       they have 8 bytes of OOB per 256 page. mf.      */
-			DoC_ReadBuf(this, eccbuf, 6);
-
-			/* Flush the pipeline */
-			if (DoC_is_Millennium(this)) {
-				dummy = ReadDOC(docptr, ECCConf);
-				dummy = ReadDOC(docptr, ECCConf);
-				i = ReadDOC(docptr, ECCConf);
-			} else {
-				dummy = ReadDOC(docptr, 2k_ECCStatus);
-				dummy = ReadDOC(docptr, 2k_ECCStatus);
-				i = ReadDOC(docptr, 2k_ECCStatus);
-			}
-
-			/* Check the ECC Status */
-			if (i & 0x80) {
-				int nb_errors;
-				/* There was an ECC error */
-#ifdef ECC_DEBUG
-				printk(KERN_ERR "DiskOnChip ECC Error: Read at %lx\n", (long)from);
-#endif
-				/* Read the ECC syndrom through the DiskOnChip ECC logic.
-				   These syndrome will be all ZERO when there is no error */
-				for (i = 0; i < 6; i++) {
-					syndrome[i] =
-					    ReadDOC(docptr, ECCSyndrome0 + i);
-				}
-	                        nb_errors = doc_decode_ecc(buf, syndrome);
-
-#ifdef ECC_DEBUG
-				printk(KERN_ERR "Errors corrected: %x\n", nb_errors);
-#endif
-	                        if (nb_errors < 0) {
-					/* We return error, but have actually done the read. Not that
-					   this can be told to user-space, via sys_read(), but at least
-					   MTD-aware stuff can know about it by checking *retlen */
-					ret = -EIO;
-	                        }
-			}
-
-#ifdef PSYCHO_DEBUG
-			printk(KERN_DEBUG "ECC DATA at %lxB: %2.2X %2.2X %2.2X %2.2X %2.2X %2.2X\n",
-				     (long)from, eccbuf[0], eccbuf[1], eccbuf[2],
-				     eccbuf[3], eccbuf[4], eccbuf[5]);
-#endif
-
-			/* disable the ECC engine */
-			WriteDOC(DOC_ECC_DIS, docptr , ECCConf);
-		}
-
 		/* according to 11.4.1, we need to wait for the busy line
 	         * drop if we read to the end of the page.  */
 		if(0 == ((from + len) & 0x1ff))
@@ -765,20 +682,13 @@
 
 	mutex_unlock(&this->lock);
 
-	return ret;
+	return 0;
 }
 
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t * retlen, const u_char * buf)
 {
 	char eccbuf[6];
-	return doc_write_ecc(mtd, to, len, retlen, buf, eccbuf, NULL);
-}
-
-static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t * retlen, const u_char * buf,
-			 u_char * eccbuf, struct nand_oobinfo *oobsel)
-{
 	struct DiskOnChip *this = mtd->priv;
 	int di; /* Yes, DI is a hangover from when I was disassembling the binary driver */
 	void __iomem *docptr = this->virtadr;
--- linux-2.6.17-mm1-full/drivers/mtd/devices/doc2001.c.old	2006-06-21 23:18:50.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/mtd/devices/doc2001.c	2006-06-21 23:40:00.000000000 +0200
@@ -25,8 +25,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/doc2000.h>
 
-/* #define ECC_DEBUG */
-
 /* I have no idea why some DoC chips can not use memcop_form|to_io().
  * This may be due to the different revisions of the ASIC controller built-in or
  * simplily a QA/Bug issue. Who knows ?? If you have trouble, please uncomment
@@ -37,12 +35,6 @@
 		    size_t *retlen, u_char *buf);
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t *retlen, const u_char *buf);
-static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t *retlen, u_char *buf, u_char *eccbuf,
-			struct nand_oobinfo *oobsel);
-static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t *retlen, const u_char *buf, u_char *eccbuf,
-			 struct nand_oobinfo *oobsel);
 static int doc_read_oob(struct mtd_info *mtd, loff_t ofs,
 			struct mtd_oob_ops *ops);
 static int doc_write_oob(struct mtd_info *mtd, loff_t ofs,
@@ -397,17 +389,8 @@
 static int doc_read (struct mtd_info *mtd, loff_t from, size_t len,
 		     size_t *retlen, u_char *buf)
 {
-	/* Just a special case of doc_read_ecc */
-	return doc_read_ecc(mtd, from, len, retlen, buf, NULL, NULL);
-}
-
-static int doc_read_ecc (struct mtd_info *mtd, loff_t from, size_t len,
-			 size_t *retlen, u_char *buf, u_char *eccbuf,
-			 struct nand_oobinfo *oobsel)
-{
-	int i, ret;
+	int i;
 	volatile char dummy;
-	unsigned char syndrome[6];
 	struct DiskOnChip *this = mtd->priv;
 	void __iomem *docptr = this->virtadr;
 	struct Nand *mychip = &this->chips[from >> (this->chipshift)];
@@ -437,15 +420,9 @@
 	DoC_Address(docptr, 3, from, CDSN_CTRL_WP, 0x00);
 	DoC_WaitReady(docptr);
 
-	if (eccbuf) {
-		/* init the ECC engine, see Reed-Solomon EDC/ECC 11.1 .*/
-		WriteDOC (DOC_ECC_RESET, docptr, ECCConf);
-		WriteDOC (DOC_ECC_EN, docptr, ECCConf);
-	} else {
-		/* disable the ECC engine */
-		WriteDOC (DOC_ECC_RESET, docptr, ECCConf);
-		WriteDOC (DOC_ECC_DIS, docptr, ECCConf);
-	}
+	/* disable the ECC engine */
+	WriteDOC (DOC_ECC_RESET, docptr, ECCConf);
+	WriteDOC (DOC_ECC_DIS, docptr, ECCConf);
 
 	/* Read the data via the internal pipeline through CDSN IO register,
 	   see Pipelined Read Operations 11.3 */
@@ -463,75 +440,14 @@
 
 	/* Let the caller know we completed it */
 	*retlen = len;
-        ret = 0;
 
-	if (eccbuf) {
-		/* Read the ECC data from Spare Data Area,
-		   see Reed-Solomon EDC/ECC 11.1 */
-		dummy = ReadDOC(docptr, ReadPipeInit);
-#ifndef USE_MEMCPY
-		for (i = 0; i < 5; i++) {
-			/* N.B. you have to increase the source address in this way or the
-			   ECC logic will not work properly */
-			eccbuf[i] = ReadDOC(docptr, Mil_CDSN_IO + i);
-		}
-#else
-		memcpy_fromio(eccbuf, docptr + DoC_Mil_CDSN_IO, 5);
-#endif
-		eccbuf[5] = ReadDOC(docptr, LastDataRead);
-
-		/* Flush the pipeline */
-		dummy = ReadDOC(docptr, ECCConf);
-		dummy = ReadDOC(docptr, ECCConf);
-
-		/* Check the ECC Status */
-		if (ReadDOC(docptr, ECCConf) & 0x80) {
-                        int nb_errors;
-			/* There was an ECC error */
-#ifdef ECC_DEBUG
-			printk("DiskOnChip ECC Error: Read at %lx\n", (long)from);
-#endif
-			/* Read the ECC syndrom through the DiskOnChip ECC logic.
-			   These syndrome will be all ZERO when there is no error */
-			for (i = 0; i < 6; i++) {
-				syndrome[i] = ReadDOC(docptr, ECCSyndrome0 + i);
-			}
-                        nb_errors = doc_decode_ecc(buf, syndrome);
-#ifdef ECC_DEBUG
-			printk("ECC Errors corrected: %x\n", nb_errors);
-#endif
-                        if (nb_errors < 0) {
-				/* We return error, but have actually done the read. Not that
-				   this can be told to user-space, via sys_read(), but at least
-				   MTD-aware stuff can know about it by checking *retlen */
-				ret = -EIO;
-                        }
-		}
-
-#ifdef PSYCHO_DEBUG
-		printk("ECC DATA at %lx: %2.2X %2.2X %2.2X %2.2X %2.2X %2.2X\n",
-		       (long)from, eccbuf[0], eccbuf[1], eccbuf[2], eccbuf[3],
-		       eccbuf[4], eccbuf[5]);
-#endif
-
-		/* disable the ECC engine */
-		WriteDOC(DOC_ECC_DIS, docptr , ECCConf);
-	}
-
-	return ret;
+	return 0;
 }
 
 static int doc_write (struct mtd_info *mtd, loff_t to, size_t len,
 		      size_t *retlen, const u_char *buf)
 {
 	char eccbuf[6];
-	return doc_write_ecc(mtd, to, len, retlen, buf, eccbuf, NULL);
-}
-
-static int doc_write_ecc (struct mtd_info *mtd, loff_t to, size_t len,
-			  size_t *retlen, const u_char *buf, u_char *eccbuf,
-			 struct nand_oobinfo *oobsel)
-{
 	int i,ret = 0;
 	volatile char dummy;
 	struct DiskOnChip *this = mtd->priv;
--- linux-2.6.17-mm1-full/drivers/mtd/devices/doc2001plus.c.old	2006-06-21 23:23:02.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/mtd/devices/doc2001plus.c	2006-06-21 23:39:54.000000000 +0200
@@ -29,8 +29,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/doc2000.h>
 
-/* #define ECC_DEBUG */
-
 /* I have no idea why some DoC chips can not use memcop_form|to_io().
  * This may be due to the different revisions of the ASIC controller built-in or
  * simplily a QA/Bug issue. Who knows ?? If you have trouble, please uncomment
@@ -41,12 +39,6 @@
 		size_t *retlen, u_char *buf);
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		size_t *retlen, const u_char *buf);
-static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-		size_t *retlen, u_char *buf, u_char *eccbuf,
-		struct nand_oobinfo *oobsel);
-static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-		size_t *retlen, const u_char *buf, u_char *eccbuf,
-		struct nand_oobinfo *oobsel);
 static int doc_read_oob(struct mtd_info *mtd, loff_t ofs,
 			struct mtd_oob_ops *ops);
 static int doc_write_oob(struct mtd_info *mtd, loff_t ofs,
@@ -595,18 +587,7 @@
 static int doc_read(struct mtd_info *mtd, loff_t from, size_t len,
 		    size_t *retlen, u_char *buf)
 {
-	/* Just a special case of doc_read_ecc */
-	return doc_read_ecc(mtd, from, len, retlen, buf, NULL, NULL);
-}
-
-static int doc_read_ecc(struct mtd_info *mtd, loff_t from, size_t len,
-			size_t *retlen, u_char *buf, u_char *eccbuf,
-			struct nand_oobinfo *oobsel)
-{
-	int ret, i;
-	volatile char dummy;
 	loff_t fofs;
-	unsigned char syndrome[6];
 	struct DiskOnChip *this = mtd->priv;
 	void __iomem * docptr = this->virtadr;
 	struct Nand *mychip = &this->chips[from >> (this->chipshift)];
@@ -644,105 +625,31 @@
 	WriteDOC(0, docptr, Mplus_FlashControl);
 	DoC_WaitReady(docptr);
 
-	if (eccbuf) {
-		/* init the ECC engine, see Reed-Solomon EDC/ECC 11.1 .*/
-		WriteDOC(DOC_ECC_RESET, docptr, Mplus_ECCConf);
-		WriteDOC(DOC_ECC_EN, docptr, Mplus_ECCConf);
-	} else {
-		/* disable the ECC engine */
-		WriteDOC(DOC_ECC_RESET, docptr, Mplus_ECCConf);
-	}
+	/* disable the ECC engine */
+	WriteDOC(DOC_ECC_RESET, docptr, Mplus_ECCConf);
 
 	/* Let the caller know we completed it */
 	*retlen = len;
-        ret = 0;
 
 	ReadDOC(docptr, Mplus_ReadPipeInit);
 	ReadDOC(docptr, Mplus_ReadPipeInit);
 
-	if (eccbuf) {
-		/* Read the data via the internal pipeline through CDSN IO
-		   register, see Pipelined Read Operations 11.3 */
-		MemReadDOC(docptr, buf, len);
-
-		/* Read the ECC data following raw data */
-		MemReadDOC(docptr, eccbuf, 4);
-		eccbuf[4] = ReadDOC(docptr, Mplus_LastDataRead);
-		eccbuf[5] = ReadDOC(docptr, Mplus_LastDataRead);
-
-		/* Flush the pipeline */
-		dummy = ReadDOC(docptr, Mplus_ECCConf);
-		dummy = ReadDOC(docptr, Mplus_ECCConf);
-
-		/* Check the ECC Status */
-		if (ReadDOC(docptr, Mplus_ECCConf) & 0x80) {
-                        int nb_errors;
-			/* There was an ECC error */
-#ifdef ECC_DEBUG
-			printk("DiskOnChip ECC Error: Read at %lx\n", (long)from);
-#endif
-			/* Read the ECC syndrom through the DiskOnChip ECC logic.
-			   These syndrome will be all ZERO when there is no error */
-			for (i = 0; i < 6; i++)
-				syndrome[i] = ReadDOC(docptr, Mplus_ECCSyndrome0 + i);
-
-                        nb_errors = doc_decode_ecc(buf, syndrome);
-#ifdef ECC_DEBUG
-			printk("ECC Errors corrected: %x\n", nb_errors);
-#endif
-                        if (nb_errors < 0) {
-				/* We return error, but have actually done the read. Not that
-				   this can be told to user-space, via sys_read(), but at least
-				   MTD-aware stuff can know about it by checking *retlen */
-#ifdef ECC_DEBUG
-			printk("%s(%d): Millennium Plus ECC error (from=0x%x:\n",
-				__FILE__, __LINE__, (int)from);
-			printk("        syndrome= %02x:%02x:%02x:%02x:%02x:"
-				"%02x\n",
-				syndrome[0], syndrome[1], syndrome[2],
-				syndrome[3], syndrome[4], syndrome[5]);
-			printk("          eccbuf= %02x:%02x:%02x:%02x:%02x:"
-				"%02x\n",
-				eccbuf[0], eccbuf[1], eccbuf[2],
-				eccbuf[3], eccbuf[4], eccbuf[5]);
-#endif
-				ret = -EIO;
-                        }
-		}
-
-#ifdef PSYCHO_DEBUG
-		printk("ECC DATA at %lx: %2.2X %2.2X %2.2X %2.2X %2.2X %2.2X\n",
-		       (long)from, eccbuf[0], eccbuf[1], eccbuf[2], eccbuf[3],
-		       eccbuf[4], eccbuf[5]);
-#endif
-
-		/* disable the ECC engine */
-		WriteDOC(DOC_ECC_DIS, docptr , Mplus_ECCConf);
-	} else {
-		/* Read the data via the internal pipeline through CDSN IO
-		   register, see Pipelined Read Operations 11.3 */
-		MemReadDOC(docptr, buf, len-2);
-		buf[len-2] = ReadDOC(docptr, Mplus_LastDataRead);
-		buf[len-1] = ReadDOC(docptr, Mplus_LastDataRead);
-	}
+	/* Read the data via the internal pipeline through CDSN IO
+	   register, see Pipelined Read Operations 11.3 */
+	MemReadDOC(docptr, buf, len-2);
+	buf[len-2] = ReadDOC(docptr, Mplus_LastDataRead);
+	buf[len-1] = ReadDOC(docptr, Mplus_LastDataRead);
 
 	/* Disable flash internally */
 	WriteDOC(0, docptr, Mplus_FlashSelect);
 
-	return ret;
+	return 0;
 }
 
 static int doc_write(struct mtd_info *mtd, loff_t to, size_t len,
 		     size_t *retlen, const u_char *buf)
 {
 	char eccbuf[6];
-	return doc_write_ecc(mtd, to, len, retlen, buf, eccbuf, NULL);
-}
-
-static int doc_write_ecc(struct mtd_info *mtd, loff_t to, size_t len,
-			 size_t *retlen, const u_char *buf, u_char *eccbuf,
-			 struct nand_oobinfo *oobsel)
-{
 	int i, before, ret = 0;
 	loff_t fto;
 	volatile char dummy;
--- linux-2.6.17-mm1-full/include/linux/mtd/doc2000.h.old	2006-06-21 23:25:37.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/mtd/doc2000.h	2006-06-21 23:25:44.000000000 +0200
@@ -190,6 +190,4 @@
 	struct mutex lock;
 };
 
-int doc_decode_ecc(unsigned char sector[512], unsigned char ecc1[6]);
-
 #endif /* __MTD_DOC2000_H__ */
--- linux-2.6.17-mm1-full/drivers/mtd/devices/docecc.c	2006-06-18 03:49:35.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,527 +0,0 @@
-/*
- * ECC algorithm for M-systems disk on chip. We use the excellent Reed
- * Solmon code of Phil Karn (karn@ka9q.ampr.org) available under the
- * GNU GPL License. The rest is simply to convert the disk on chip
- * syndrom into a standard syndom.
- *
- * Author: Fabrice Bellard (fabrice.bellard@netgem.com)
- * Copyright (C) 2000 Netgem S.A.
- *
- * $Id: docecc.c,v 1.7 2005/11/07 11:14:25 gleixner Exp $
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <asm/errno.h>
-#include <asm/io.h>
-#include <asm/uaccess.h>
-#include <linux/miscdevice.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include <linux/mtd/compatmac.h> /* for min() in older kernels */
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/doc2000.h>
-
-#define DEBUG_ECC 0
-/* need to undef it (from asm/termbits.h) */
-#undef B0
-
-#define MM 10 /* Symbol size in bits */
-#define KK (1023-4) /* Number of data symbols per block */
-#define B0 510 /* First root of generator polynomial, alpha form */
-#define PRIM 1 /* power of alpha used to generate roots of generator poly */
-#define	NN ((1 << MM) - 1)
-
-typedef unsigned short dtype;
-
-/* 1+x^3+x^10 */
-static const int Pp[MM+1] = { 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 };
-
-/* This defines the type used to store an element of the Galois Field
- * used by the code. Make sure this is something larger than a char if
- * if anything larger than GF(256) is used.
- *
- * Note: unsigned char will work up to GF(256) but int seems to run
- * faster on the Pentium.
- */
-typedef int gf;
-
-/* No legal value in index form represents zero, so
- * we need a special value for this purpose
- */
-#define A0	(NN)
-
-/* Compute x % NN, where NN is 2**MM - 1,
- * without a slow divide
- */
-static inline gf
-modnn(int x)
-{
-  while (x >= NN) {
-    x -= NN;
-    x = (x >> MM) + (x & NN);
-  }
-  return x;
-}
-
-#define	CLEAR(a,n) {\
-int ci;\
-for(ci=(n)-1;ci >=0;ci--)\
-(a)[ci] = 0;\
-}
-
-#define	COPY(a,b,n) {\
-int ci;\
-for(ci=(n)-1;ci >=0;ci--)\
-(a)[ci] = (b)[ci];\
-}
-
-#define	COPYDOWN(a,b,n) {\
-int ci;\
-for(ci=(n)-1;ci >=0;ci--)\
-(a)[ci] = (b)[ci];\
-}
-
-#define Ldec 1
-
-/* generate GF(2**m) from the irreducible polynomial p(X) in Pp[0]..Pp[m]
-   lookup tables:  index->polynomial form   alpha_to[] contains j=alpha**i;
-                   polynomial form -> index form  index_of[j=alpha**i] = i
-   alpha=2 is the primitive element of GF(2**m)
-   HARI's COMMENT: (4/13/94) alpha_to[] can be used as follows:
-        Let @ represent the primitive element commonly called "alpha" that
-   is the root of the primitive polynomial p(x). Then in GF(2^m), for any
-   0 <= i <= 2^m-2,
-        @^i = a(0) + a(1) @ + a(2) @^2 + ... + a(m-1) @^(m-1)
-   where the binary vector (a(0),a(1),a(2),...,a(m-1)) is the representation
-   of the integer "alpha_to[i]" with a(0) being the LSB and a(m-1) the MSB. Thus for
-   example the polynomial representation of @^5 would be given by the binary
-   representation of the integer "alpha_to[5]".
-                   Similarily, index_of[] can be used as follows:
-        As above, let @ represent the primitive element of GF(2^m) that is
-   the root of the primitive polynomial p(x). In order to find the power
-   of @ (alpha) that has the polynomial representation
-        a(0) + a(1) @ + a(2) @^2 + ... + a(m-1) @^(m-1)
-   we consider the integer "i" whose binary representation with a(0) being LSB
-   and a(m-1) MSB is (a(0),a(1),...,a(m-1)) and locate the entry
-   "index_of[i]". Now, @^index_of[i] is that element whose polynomial
-    representation is (a(0),a(1),a(2),...,a(m-1)).
-   NOTE:
-        The element alpha_to[2^m-1] = 0 always signifying that the
-   representation of "@^infinity" = 0 is (0,0,0,...,0).
-        Similarily, the element index_of[0] = A0 always signifying
-   that the power of alpha which has the polynomial representation
-   (0,0,...,0) is "infinity".
-
-*/
-
-static void
-generate_gf(dtype Alpha_to[NN + 1], dtype Index_of[NN + 1])
-{
-  register int i, mask;
-
-  mask = 1;
-  Alpha_to[MM] = 0;
-  for (i = 0; i < MM; i++) {
-    Alpha_to[i] = mask;
-    Index_of[Alpha_to[i]] = i;
-    /* If Pp[i] == 1 then, term @^i occurs in poly-repr of @^MM */
-    if (Pp[i] != 0)
-      Alpha_to[MM] ^= mask;	/* Bit-wise EXOR operation */
-    mask <<= 1;	/* single left-shift */
-  }
-  Index_of[Alpha_to[MM]] = MM;
-  /*
-   * Have obtained poly-repr of @^MM. Poly-repr of @^(i+1) is given by
-   * poly-repr of @^i shifted left one-bit and accounting for any @^MM
-   * term that may occur when poly-repr of @^i is shifted.
-   */
-  mask >>= 1;
-  for (i = MM + 1; i < NN; i++) {
-    if (Alpha_to[i - 1] >= mask)
-      Alpha_to[i] = Alpha_to[MM] ^ ((Alpha_to[i - 1] ^ mask) << 1);
-    else
-      Alpha_to[i] = Alpha_to[i - 1] << 1;
-    Index_of[Alpha_to[i]] = i;
-  }
-  Index_of[0] = A0;
-  Alpha_to[NN] = 0;
-}
-
-/*
- * Performs ERRORS+ERASURES decoding of RS codes. bb[] is the content
- * of the feedback shift register after having processed the data and
- * the ECC.
- *
- * Return number of symbols corrected, or -1 if codeword is illegal
- * or uncorrectable. If eras_pos is non-null, the detected error locations
- * are written back. NOTE! This array must be at least NN-KK elements long.
- * The corrected data are written in eras_val[]. They must be xor with the data
- * to retrieve the correct data : data[erase_pos[i]] ^= erase_val[i] .
- *
- * First "no_eras" erasures are declared by the calling program. Then, the
- * maximum # of errors correctable is t_after_eras = floor((NN-KK-no_eras)/2).
- * If the number of channel errors is not greater than "t_after_eras" the
- * transmitted codeword will be recovered. Details of algorithm can be found
- * in R. Blahut's "Theory ... of Error-Correcting Codes".
-
- * Warning: the eras_pos[] array must not contain duplicate entries; decoder failure
- * will result. The decoder *could* check for this condition, but it would involve
- * extra time on every decoding operation.
- * */
-static int
-eras_dec_rs(dtype Alpha_to[NN + 1], dtype Index_of[NN + 1],
-            gf bb[NN - KK + 1], gf eras_val[NN-KK], int eras_pos[NN-KK],
-            int no_eras)
-{
-  int deg_lambda, el, deg_omega;
-  int i, j, r,k;
-  gf u,q,tmp,num1,num2,den,discr_r;
-  gf lambda[NN-KK + 1], s[NN-KK + 1];	/* Err+Eras Locator poly
-					 * and syndrome poly */
-  gf b[NN-KK + 1], t[NN-KK + 1], omega[NN-KK + 1];
-  gf root[NN-KK], reg[NN-KK + 1], loc[NN-KK];
-  int syn_error, count;
-
-  syn_error = 0;
-  for(i=0;i<NN-KK;i++)
-      syn_error |= bb[i];
-
-  if (!syn_error) {
-    /* if remainder is zero, data[] is a codeword and there are no
-     * errors to correct. So return data[] unmodified
-     */
-    count = 0;
-    goto finish;
-  }
-
-  for(i=1;i<=NN-KK;i++){
-    s[i] = bb[0];
-  }
-  for(j=1;j<NN-KK;j++){
-    if(bb[j] == 0)
-      continue;
-    tmp = Index_of[bb[j]];
-
-    for(i=1;i<=NN-KK;i++)
-      s[i] ^= Alpha_to[modnn(tmp + (B0+i-1)*PRIM*j)];
-  }
-
-  /* undo the feedback register implicit multiplication and convert
-     syndromes to index form */
-
-  for(i=1;i<=NN-KK;i++) {
-      tmp = Index_of[s[i]];
-      if (tmp != A0)
-          tmp = modnn(tmp + 2 * KK * (B0+i-1)*PRIM);
-      s[i] = tmp;
-  }
-
-  CLEAR(&lambda[1],NN-KK);
-  lambda[0] = 1;
-
-  if (no_eras > 0) {
-    /* Init lambda to be the erasure locator polynomial */
-    lambda[1] = Alpha_to[modnn(PRIM * eras_pos[0])];
-    for (i = 1; i < no_eras; i++) {
-      u = modnn(PRIM*eras_pos[i]);
-      for (j = i+1; j > 0; j--) {
-	tmp = Index_of[lambda[j - 1]];
-	if(tmp != A0)
-	  lambda[j] ^= Alpha_to[modnn(u + tmp)];
-      }
-    }
-#if DEBUG_ECC >= 1
-    /* Test code that verifies the erasure locator polynomial just constructed
-       Needed only for decoder debugging. */
-
-    /* find roots of the erasure location polynomial */
-    for(i=1;i<=no_eras;i++)
-      reg[i] = Index_of[lambda[i]];
-    count = 0;
-    for (i = 1,k=NN-Ldec; i <= NN; i++,k = modnn(NN+k-Ldec)) {
-      q = 1;
-      for (j = 1; j <= no_eras; j++)
-	if (reg[j] != A0) {
-	  reg[j] = modnn(reg[j] + j);
-	  q ^= Alpha_to[reg[j]];
-	}
-      if (q != 0)
-	continue;
-      /* store root and error location number indices */
-      root[count] = i;
-      loc[count] = k;
-      count++;
-    }
-    if (count != no_eras) {
-      printf("\n lambda(x) is WRONG\n");
-      count = -1;
-      goto finish;
-    }
-#if DEBUG_ECC >= 2
-    printf("\n Erasure positions as determined by roots of Eras Loc Poly:\n");
-    for (i = 0; i < count; i++)
-      printf("%d ", loc[i]);
-    printf("\n");
-#endif
-#endif
-  }
-  for(i=0;i<NN-KK+1;i++)
-    b[i] = Index_of[lambda[i]];
-
-  /*
-   * Begin Berlekamp-Massey algorithm to determine error+erasure
-   * locator polynomial
-   */
-  r = no_eras;
-  el = no_eras;
-  while (++r <= NN-KK) {	/* r is the step number */
-    /* Compute discrepancy at the r-th step in poly-form */
-    discr_r = 0;
-    for (i = 0; i < r; i++){
-      if ((lambda[i] != 0) && (s[r - i] != A0)) {
-	discr_r ^= Alpha_to[modnn(Index_of[lambda[i]] + s[r - i])];
-      }
-    }
-    discr_r = Index_of[discr_r];	/* Index form */
-    if (discr_r == A0) {
-      /* 2 lines below: B(x) <-- x*B(x) */
-      COPYDOWN(&b[1],b,NN-KK);
-      b[0] = A0;
-    } else {
-      /* 7 lines below: T(x) <-- lambda(x) - discr_r*x*b(x) */
-      t[0] = lambda[0];
-      for (i = 0 ; i < NN-KK; i++) {
-	if(b[i] != A0)
-	  t[i+1] = lambda[i+1] ^ Alpha_to[modnn(discr_r + b[i])];
-	else
-	  t[i+1] = lambda[i+1];
-      }
-      if (2 * el <= r + no_eras - 1) {
-	el = r + no_eras - el;
-	/*
-	 * 2 lines below: B(x) <-- inv(discr_r) *
-	 * lambda(x)
-	 */
-	for (i = 0; i <= NN-KK; i++)
-	  b[i] = (lambda[i] == 0) ? A0 : modnn(Index_of[lambda[i]] - discr_r + NN);
-      } else {
-	/* 2 lines below: B(x) <-- x*B(x) */
-	COPYDOWN(&b[1],b,NN-KK);
-	b[0] = A0;
-      }
-      COPY(lambda,t,NN-KK+1);
-    }
-  }
-
-  /* Convert lambda to index form and compute deg(lambda(x)) */
-  deg_lambda = 0;
-  for(i=0;i<NN-KK+1;i++){
-    lambda[i] = Index_of[lambda[i]];
-    if(lambda[i] != A0)
-      deg_lambda = i;
-  }
-  /*
-   * Find roots of the error+erasure locator polynomial by Chien
-   * Search
-   */
-  COPY(&reg[1],&lambda[1],NN-KK);
-  count = 0;		/* Number of roots of lambda(x) */
-  for (i = 1,k=NN-Ldec; i <= NN; i++,k = modnn(NN+k-Ldec)) {
-    q = 1;
-    for (j = deg_lambda; j > 0; j--){
-      if (reg[j] != A0) {
-	reg[j] = modnn(reg[j] + j);
-	q ^= Alpha_to[reg[j]];
-      }
-    }
-    if (q != 0)
-      continue;
-    /* store root (index-form) and error location number */
-    root[count] = i;
-    loc[count] = k;
-    /* If we've already found max possible roots,
-     * abort the search to save time
-     */
-    if(++count == deg_lambda)
-      break;
-  }
-  if (deg_lambda != count) {
-    /*
-     * deg(lambda) unequal to number of roots => uncorrectable
-     * error detected
-     */
-    count = -1;
-    goto finish;
-  }
-  /*
-   * Compute err+eras evaluator poly omega(x) = s(x)*lambda(x) (modulo
-   * x**(NN-KK)). in index form. Also find deg(omega).
-   */
-  deg_omega = 0;
-  for (i = 0; i < NN-KK;i++){
-    tmp = 0;
-    j = (deg_lambda < i) ? deg_lambda : i;
-    for(;j >= 0; j--){
-      if ((s[i + 1 - j] != A0) && (lambda[j] != A0))
-	tmp ^= Alpha_to[modnn(s[i + 1 - j] + lambda[j])];
-    }
-    if(tmp != 0)
-      deg_omega = i;
-    omega[i] = Index_of[tmp];
-  }
-  omega[NN-KK] = A0;
-
-  /*
-   * Compute error values in poly-form. num1 = omega(inv(X(l))), num2 =
-   * inv(X(l))**(B0-1) and den = lambda_pr(inv(X(l))) all in poly-form
-   */
-  for (j = count-1; j >=0; j--) {
-    num1 = 0;
-    for (i = deg_omega; i >= 0; i--) {
-      if (omega[i] != A0)
-	num1  ^= Alpha_to[modnn(omega[i] + i * root[j])];
-    }
-    num2 = Alpha_to[modnn(root[j] * (B0 - 1) + NN)];
-    den = 0;
-
-    /* lambda[i+1] for i even is the formal derivative lambda_pr of lambda[i] */
-    for (i = min(deg_lambda,NN-KK-1) & ~1; i >= 0; i -=2) {
-      if(lambda[i+1] != A0)
-	den ^= Alpha_to[modnn(lambda[i+1] + i * root[j])];
-    }
-    if (den == 0) {
-#if DEBUG_ECC >= 1
-      printf("\n ERROR: denominator = 0\n");
-#endif
-      /* Convert to dual- basis */
-      count = -1;
-      goto finish;
-    }
-    /* Apply error to data */
-    if (num1 != 0) {
-        eras_val[j] = Alpha_to[modnn(Index_of[num1] + Index_of[num2] + NN - Index_of[den])];
-    } else {
-        eras_val[j] = 0;
-    }
-  }
- finish:
-  for(i=0;i<count;i++)
-      eras_pos[i] = loc[i];
-  return count;
-}
-
-/***************************************************************************/
-/* The DOC specific code begins here */
-
-#define SECTOR_SIZE 512
-/* The sector bytes are packed into NB_DATA MM bits words */
-#define NB_DATA (((SECTOR_SIZE + 1) * 8 + 6) / MM)
-
-/*
- * Correct the errors in 'sector[]' by using 'ecc1[]' which is the
- * content of the feedback shift register applyied to the sector and
- * the ECC. Return the number of errors corrected (and correct them in
- * sector), or -1 if error
- */
-int doc_decode_ecc(unsigned char sector[SECTOR_SIZE], unsigned char ecc1[6])
-{
-    int parity, i, nb_errors;
-    gf bb[NN - KK + 1];
-    gf error_val[NN-KK];
-    int error_pos[NN-KK], pos, bitpos, index, val;
-    dtype *Alpha_to, *Index_of;
-
-    /* init log and exp tables here to save memory. However, it is slower */
-    Alpha_to = kmalloc((NN + 1) * sizeof(dtype), GFP_KERNEL);
-    if (!Alpha_to)
-        return -1;
-
-    Index_of = kmalloc((NN + 1) * sizeof(dtype), GFP_KERNEL);
-    if (!Index_of) {
-        kfree(Alpha_to);
-        return -1;
-    }
-
-    generate_gf(Alpha_to, Index_of);
-
-    parity = ecc1[1];
-
-    bb[0] =  (ecc1[4] & 0xff) | ((ecc1[5] & 0x03) << 8);
-    bb[1] = ((ecc1[5] & 0xfc) >> 2) | ((ecc1[2] & 0x0f) << 6);
-    bb[2] = ((ecc1[2] & 0xf0) >> 4) | ((ecc1[3] & 0x3f) << 4);
-    bb[3] = ((ecc1[3] & 0xc0) >> 6) | ((ecc1[0] & 0xff) << 2);
-
-    nb_errors = eras_dec_rs(Alpha_to, Index_of, bb,
-                            error_val, error_pos, 0);
-    if (nb_errors <= 0)
-        goto the_end;
-
-    /* correct the errors */
-    for(i=0;i<nb_errors;i++) {
-        pos = error_pos[i];
-        if (pos >= NB_DATA && pos < KK) {
-            nb_errors = -1;
-            goto the_end;
-        }
-        if (pos < NB_DATA) {
-            /* extract bit position (MSB first) */
-            pos = 10 * (NB_DATA - 1 - pos) - 6;
-            /* now correct the following 10 bits. At most two bytes
-               can be modified since pos is even */
-            index = (pos >> 3) ^ 1;
-            bitpos = pos & 7;
-            if ((index >= 0 && index < SECTOR_SIZE) ||
-                index == (SECTOR_SIZE + 1)) {
-                val = error_val[i] >> (2 + bitpos);
-                parity ^= val;
-                if (index < SECTOR_SIZE)
-                    sector[index] ^= val;
-            }
-            index = ((pos >> 3) + 1) ^ 1;
-            bitpos = (bitpos + 10) & 7;
-            if (bitpos == 0)
-                bitpos = 8;
-            if ((index >= 0 && index < SECTOR_SIZE) ||
-                index == (SECTOR_SIZE + 1)) {
-                val = error_val[i] << (8 - bitpos);
-                parity ^= val;
-                if (index < SECTOR_SIZE)
-                    sector[index] ^= val;
-            }
-        }
-    }
-
-    /* use parity to test extra errors */
-    if ((parity & 0xff) != 0)
-        nb_errors = -1;
-
- the_end:
-    kfree(Alpha_to);
-    kfree(Index_of);
-    return nb_errors;
-}
-
-EXPORT_SYMBOL_GPL(doc_decode_ecc);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Fabrice Bellard <fabrice.bellard@netgem.com>");
-MODULE_DESCRIPTION("ECC code for correcting errors detected by DiskOnChip 2000 and Millennium ECC hardware");

