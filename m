Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTL3FKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTL3FKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:10:48 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:45470 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S264917AbTL3FK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:10:28 -0500
Message-ID: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>
Date: Tue, 30 Dec 2003 00:10:27 -0500 (EST)
Subject: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
From: "Brad House" <brad_mssw@gentoo.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to fix a Gentoo user's problem, and get rid
of compilation warnings for 64bit (on AMD64 mainly) megaraid
compilation, I have created this patch, and needs some
extensive testing.

The only thing I wasn't sure about was what unsigned integer
was guaranteed to be the exact size of a pointer, and it seemed
that looking in include/asm-x86_64/types.h that  dma_addr_t
was the only one that fit the bill.

Anyhow, the patch is inlined below, as well as available
for download here:
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/megaraid_64bit_patch.diff

Please CC: me on any replies as I am not subscribed to this
list!

-Brad House
brad_mssw@gentoo.org

diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c
linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c
--- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c	2003-12-29
23:51:43.000000000 -0500
+++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c	2003-12-29
23:54:01.005469936 -0500
@@ -1292,7 +1292,7 @@

 			/* Calculate Scatter-Gather info */
 			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
-					(u32 *)&mbox->m_out.xferaddr, (u32 *)&seg);
+					(dma_addr_t *)&mbox->m_out.xferaddr, (u32 *)&seg);

 			return scb;

@@ -2262,7 +2262,7 @@
  * Note: For 64 bit cards, we need a minimum of one SG element for
read/write
  */
 static int
-mega_build_sglist(adapter_t *adapter, scb_t *scb, u32 *buf, u32 *len)
+mega_build_sglist(adapter_t *adapter, scb_t *scb, dma_addr_t *buf, u32 *len)
 {
 	struct scatterlist	*sgl;
 	struct page	*page;
@@ -2962,8 +2962,8 @@
 			mbox->m_out.numsectors);
 	len += sprintf(page+len, "  LBA          = 0x%02x\n",
 			mbox->m_out.lba);
-	len += sprintf(page+len, "  DTA          = 0x%08x\n",
-			mbox->m_out.xferaddr);
+	len += sprintf(page+len, "  DTA          = 0x%08lx\n",
+			(unsigned long int)mbox->m_out.xferaddr);
 	len += sprintf(page+len, "  Logical Drive= 0x%02x\n",
 			mbox->m_out.logdrv);
 	len += sprintf(page+len, "  No of SG Elmt= 0x%02x\n",
@@ -4048,7 +4048,7 @@
 	megacmd_t	mc;
 	megastat_t	*ustats;
 	int		num_ldrv;
-	u32		uxferaddr = 0;
+	dma_addr_t	uxferaddr = 0;
 	struct pci_dev	*pdev;

 	ustats = NULL; /* avoid compilation warnings */
diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.h
linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.h
--- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.h	2003-12-29
23:51:43.000000000 -0500
+++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.h	2003-12-29
23:54:01.005469936 -0500
@@ -125,7 +125,7 @@
 	/* 0x1 */ u8 cmdid;
 	/* 0x2 */ u16 numsectors;
 	/* 0x4 */ u32 lba;
-	/* 0x8 */ u32 xferaddr;
+	/* 0x8 */ dma_addr_t xferaddr;
 	/* 0xC */ u8 logdrv;
 	/* 0xD */ u8 numsgelements;
 	/* 0xE */ u8 resvd;
@@ -173,7 +173,7 @@
 	u8 reqsensearea[MAX_REQ_SENSE_LEN];
 	u8 numsgelements;
 	u8 scsistatus;
-	u32 dataxferaddr;
+	dma_addr_t dataxferaddr;
 	u32 dataxferlen;
 } __attribute__ ((packed)) mega_passthru;

@@ -201,7 +201,7 @@
 	u8 reqsenselen;
 	u8 reqsensearea[MAX_REQ_SENSE_LEN];
 	u8 rsvd4;
-	u32 dataxferaddr;
+	dma_addr_t dataxferaddr;
 	u32 dataxferlen;
 } __attribute__ ((packed)) mega_ext_passthru;

@@ -211,7 +211,7 @@
 } __attribute__ ((packed)) mega_sgl64;

 typedef struct {
-	u32 address;
+	dma_addr_t address;
 	u32 length;
 } __attribute__ ((packed)) mega_sglist;

@@ -561,7 +561,7 @@
 	u8	opcode;
 	u8	subopcode;
 	u32	lba;
-	u32	xferaddr;
+	dma_addr_t	xferaddr;
 	u8	logdrv;
 	u8	rsvd[3];
 	u8	numstatus;
@@ -1016,7 +1016,7 @@
 static int mega_print_inquiry(char *, char *);

 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
-			      u32 *buffer, u32 *length);
+			      dma_addr_t *buffer, u32 *length);
 static inline int mega_busywait_mbox (adapter_t *);
 static int __mega_busywait_mbox (adapter_t *);
 static void mega_rundoneq (adapter_t *);



