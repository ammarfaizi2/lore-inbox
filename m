Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbTL3Noh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 08:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbTL3Nog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 08:44:36 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:21465
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265791AbTL3Nof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 08:44:35 -0500
Date: Tue, 30 Dec 2003 08:44:33 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: trivial@rustcorp.com.au
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi/advansys.c check_region() fix
Message-ID: <20031230134433.GA22187@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Tue, 30 Dec 2003 08:42:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another trivial check_region() fix verified by Gene


--- linux-clean/drivers/scsi/advansys.c.org	2003-12-29 19:35:26.000000000 -0500
+++ linux-clean/drivers/scsi/advansys.c	2003-12-30 01:37:01.000000000 -0500
@@ -4619,7 +4619,7 @@
                         ASC_DBG1(1,
                                 "advansys_detect: probing I/O port 0x%x...\n",
                             iop);
-                        if (check_region(iop, ASC_IOADR_GAP) != 0) {
+                        if (!request_region(iop, ASC_IOADR_GAP, "advansys")) {
                             printk(
 "AdvanSys SCSI: specified I/O Port 0x%X is busy\n", iop);
                             /* Don't try this I/O port twice. */
@@ -4630,6 +4630,7 @@
 "AdvanSys SCSI: specified I/O Port 0x%X has no adapter\n", iop);
                             /* Don't try this I/O port twice. */
                             asc_ioport[ioport] = 0;
+			    release_region(iop, ASC_IOADR_GAP);
                             goto ioport_try_again;
                         } else {
                             /*
@@ -4647,6 +4648,7 @@
                                   * 'ioport' past this board.
                                   */
                                  ioport++;
+				 release_region(iop, ASC_IOADR_GAP);
                                  goto ioport_try_again;
                             }
                         }
@@ -10003,10 +10005,11 @@
     }
     for (; i < ASC_IOADR_TABLE_MAX_IX; i++) {
         iop_base = _asc_def_iop_base[i];
-        if (check_region(iop_base, ASC_IOADR_GAP) != 0) {
+        if (!request_region(iop_base, ASC_IOADR_GAP, "advansys")) {
             ASC_DBG1(1,
-               "AscSearchIOPortAddr11: check_region() failed I/O port 0x%x\n",
+               "AscSearchIOPortAddr11: request_region() failed I/O port 0x%x\n",
                      iop_base);
+	    release_region(iop_base, ASC_IOADR_GAP);
             continue;
         }
         ASC_DBG1(1, "AscSearchIOPortAddr11: probing I/O port 0x%x\n", iop_base);


O
