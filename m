Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131529AbRAWWac>; Tue, 23 Jan 2001 17:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbRAWWaN>; Tue, 23 Jan 2001 17:30:13 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:54613
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130098AbRAWW3z>; Tue, 23 Jan 2001 17:29:55 -0500
Date: Tue, 23 Jan 2001 23:29:47 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: ehm@cris.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] make drivers/scsi/qlogicfc.c check_region -> request_region + cleanup (241p9)
Message-ID: <20010123232947.L607@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I am guessing you as the maintainer of this code. If you are not,
I apologize for your inconvenience.)

The following patch makes drivers/scsi/qlogicfc.c check the 
return code of scsi_register, adds a missing pci64_free_consistent on
an error path and makes it use request_region exclusively.

It applies cleanly against ac10 and 241p9.

Comments?



--- linux-ac10-clean/drivers/scsi/qlogicfc.c	Mon Sep 18 22:36:25 2000
+++ linux-ac10/drivers/scsi/qlogicfc.c	Sat Jan 20 23:07:09 2001
@@ -756,6 +756,10 @@
 				continue;
 
 		        host = scsi_register(tmpt, sizeof(struct isp2x00_hostdata));
+			if (!host) {
+			        printk("qlogicfc%d : could not register host.\n", hostdata->host_id);
+				continue;
+			}
 			host->max_id = QLOGICFC_MAX_ID + 1;
 			host->max_lun = QLOGICFC_MAX_LUN;
 			host->hostt->use_new_eh_code = 1;
@@ -767,6 +771,7 @@
 
 			if (!hostdata->res){
 			        printk("qlogicfc%d : could not allocate memory for request and response queue.\n", hostdata->host_id);
+				pci64_free_consistent(pdev, RES_SIZE + REQ_SIZE, hostdata->res, busaddr);
 			        scsi_unregister(host);
 				continue;
 			}
@@ -812,7 +817,7 @@
 				scsi_unregister(host);
 				continue;
 			}
-			if (check_region(host->io_port, 0xff)) {
+			if (!request_region(host->io_port, 0xff, "qlogicfc")) {
 			        printk("qlogicfc%d : i/o region 0x%lx-0x%lx already "
 				       "in use\n",
 				       hostdata->host_id, host->io_port, host->io_port + 0xff);
@@ -821,7 +826,6 @@
 				scsi_unregister(host);
 				continue;
 			}
-			request_region(host->io_port, 0xff, "qlogicfc");
 
 			outw(0x0, host->io_port + PCI_SEMAPHORE);
 			outw(HCCR_CLEAR_RISC_INTR, host->io_port + HOST_HCCR);


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Open Source. Closed Minds. We are Slashdot. 
  --Anonymous Coward
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
