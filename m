Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWDTWUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWDTWUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWDTWUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:20:00 -0400
Received: from cpe-66-66-109-154.rochester.res.rr.com ([66.66.109.154]:46051
	"EHLO death.krwtech.com") by vger.kernel.org with ESMTP
	id S932081AbWDTWT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:19:59 -0400
Date: Thu, 20 Apr 2006 18:19:53 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: James.Bottomley@SteelEye.com
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.16] scsi: clean up warnings in Advansys driver
In-Reply-To: <20060420004915.45cd34be.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604201735100.2044@death>
References: <Pine.LNX.4.64.0604191444200.1841@death> <20060419163247.6986a87c.akpm@osdl.org>
 <20060419224202.3e2f99f5.akpm@osdl.org> <Pine.LNX.4.64.0604200242410.3134@death>
 <20060420004915.45cd34be.akpm@osdl.org>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typecast warnings and switch from check_region to request_region

Signed-off-by: Ken Witherow <ken@krwtech.com>

---
  drivers/scsi/advansys.c |   17 ++++++++++-------
  1 file changed, 10 insertions(+), 7 deletions(-)



--- linux-2.6.16/drivers/scsi/advansys.c	2006-03-20 00:53:29.000000000 -0500
+++ linux/drivers/scsi/advansys.c	2006-04-20 17:27:43.000000000 -0400
@@ -2056,11 +2056,11 @@ STATIC ASC_DCNT  AscGetMaxDmaCount(ushor
  /*
   * Define Adv Library required memory access macros.
   */
-#define ADV_MEM_READB(addr) readb(addr)
-#define ADV_MEM_READW(addr) readw(addr)
-#define ADV_MEM_WRITEB(addr, byte) writeb(byte, addr)
-#define ADV_MEM_WRITEW(addr, word) writew(word, addr)
-#define ADV_MEM_WRITEDW(addr, dword) writel(dword, addr)
+#define ADV_MEM_READB(addr) readb((void *) addr)
+#define ADV_MEM_READW(addr) readw((void *) addr)
+#define ADV_MEM_WRITEB(addr, byte) writeb(byte, (void *) addr)
+#define ADV_MEM_WRITEW(addr, word) writew(word, (void *) addr)
+#define ADV_MEM_WRITEDW(addr, dword) writel(dword,(void *) addr)

  #define ADV_CARRIER_COUNT (ASC_DEF_MAX_HOST_QNG + 15)

@@ -4415,7 +4415,7 @@ advansys_detect(struct scsi_host_templat
                          ASC_DBG1(1,
                                  "advansys_detect: probing I/O port 0x%x...\n",
                              iop);
-                        if (check_region(iop, ASC_IOADR_GAP) != 0) {
+			if (!request_region(iop, ASC_IOADR_GAP, "advansys")){
                              printk(
  "AdvanSys SCSI: specified I/O Port 0x%X is busy\n", iop);
                              /* Don't try this I/O port twice. */
@@ -4425,6 +4425,7 @@ advansys_detect(struct scsi_host_templat
                              printk(
  "AdvanSys SCSI: specified I/O Port 0x%X has no adapter\n", iop);
                              /* Don't try this I/O port twice. */
+			    release_region(iop, ASC_IOADR_GAP);
                              asc_ioport[ioport] = 0;
                              goto ioport_try_again;
                          } else {
@@ -4445,6 +4446,7 @@ advansys_detect(struct scsi_host_templat
                                   ioport++;
                                   goto ioport_try_again;
                              }
+			    release_region(iop, ASC_IOADR_GAP);
                          }
                          /*
                           * This board appears good, don't try the I/O port
@@ -9752,13 +9754,14 @@ AscSearchIOPortAddr11(
      }
      for (; i < ASC_IOADR_TABLE_MAX_IX; i++) {
          iop_base = _asc_def_iop_base[i];
-        if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
+	if (!request_region(iop_base, ASC_IOADR_GAP, "advansys")){
              ASC_DBG1(1,
                 "AscSearchIOPortAddr11: check_region() failed I/O port 0x%x\n",
                       iop_base);
              continue;
          }
          ASC_DBG1(1, "AscSearchIOPortAddr11: probing I/O port 0x%x\n", iop_base);
+	release_region(iop_base, ASC_IOADR_GAP);
          if (AscFindSignature(iop_base)) {
              return (iop_base);
          }

