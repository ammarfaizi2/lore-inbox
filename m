Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAYU1d>; Thu, 25 Jan 2001 15:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131811AbRAYU1Y>; Thu, 25 Jan 2001 15:27:24 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:50266
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130934AbRAYU1J>; Thu, 25 Jan 2001 15:27:09 -0500
Date: Thu, 25 Jan 2001 21:26:55 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.rutgers.edu
Subject: [PATCH] make drivers/scsi/sym53c8xx.c check request_region's return code (241p9)]
Message-ID: <20010125212655.D603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I apparently forgot to cc the lists on this one. Replies should be cc'ed
to groudier@club-internet.fr also.

Thanks.

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Date: Tue, 23 Jan 2001 23:37:14 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: groudier@club-internet.fr
Subject: [PATCH] make drivers/scsi/sym53c8xx.c check request_region's return code (241p9)
User-Agent: Mutt/1.2.4i

Hi.

The following patch makes drivers/scsi/sym53c8xx.c check the return
code of request_region. It applies cleanly against ac10 and 241p9.

Please comment.



--- linux-ac10-clean/drivers/scsi/sym53c8xx.c	Mon Jan  1 19:23:21 2001
+++ linux-ac10/drivers/scsi/sym53c8xx.c	Sun Jan 21 21:40:54 2001
@@ -5817,7 +5817,11 @@
 	*/
 
 	if (device->slot.io_port) {
-		request_region(device->slot.io_port, np->base_ws, NAME53C8XX);
+		if (!request_region(device->slot.io_port, np->base_ws, 
+				    NAME53C8XX)) {
+			printk(KERN_ERR "Cannot mmap IO range.\n");
+			goto attach_error;
+		}
 		np->base_io = device->slot.io_port;
 	}

--- linux-ac10-clean/drivers/scsi/sym53c8xx_comm.h	Mon Oct 16 21:56:50 2000
+++ linux-ac10/drivers/scsi/sym53c8xx_comm.h	Mon Jan 22 21:56:46 2001
@@ -1799,7 +1799,8 @@
 	**    Get access to chip IO registers
 	*/
 #ifdef NCR_IOMAPPED
-	request_region(devp->slot.io_port, 128, NAME53C8XX);
+	if (!request_region(devp->slot.io_port, 128, NAME53C8XX))
+		return;
 	devp->slot.base_io = devp->slot.io_port;
 #else
 	devp->slot.reg = (struct ncr_reg *) remap_pci_mem(devp->slot.base, 128);


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

It isn't pollution that's harming the environment. It's the impurities in
our air and water that are doing it.  -Former U.S. Vice-President Dan
Quayle

----- End forwarded message -----

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Freedom of the press is limited to those who own one.
                                 - A.J. Liebling 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
