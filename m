Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135683AbRAVXj1>; Mon, 22 Jan 2001 18:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135682AbRAVXjS>; Mon, 22 Jan 2001 18:39:18 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:23121
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135673AbRAVXjI>; Mon, 22 Jan 2001 18:39:08 -0500
Date: Tue, 23 Jan 2001 00:38:56 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: faith@cs.unc.edu
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/fd_mcs.c cleanup (241p9)
Message-ID: <20010123003856.L602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I am guessing you as maintainer of this code. If you are not,
I apologise.)

The following patch makes drivers/scsi/fd_mcs.c use the return
code of request_region instead of check_region. It also makes
the driver release the irq on error. It applies cleanly against
ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/fd_mcs.c	Mon Sep 18 22:36:25 2000
+++ linux-ac10/drivers/scsi/fd_mcs.c	Mon Jan 22 22:55:53 2001
@@ -406,23 +406,24 @@
 	/* claim the slot */
 	mca_set_adapter_name( slot-1, fd_mcs_adapters[loop].name );
 
-	/* check irq/region */
-	if (check_region(port, 0x10) ||
-	    request_irq(irq, fd_mcs_intr,
-			SA_SHIRQ, "fd_mcs", hosts)) {
-	  printk( "fd_mcs: check_region() || request_irq() failed, Skip it\n");
-
+	/* check/get irq/region */
+	if (!request_region(port, 0x10, "fd_mcs") ) {
+	  printk(KERN_WARNING "fd_mcs: request_region() failed, Skip it\n");
 	  continue;
 	}
+		
+	if (request_irq(irq, fd_mcs_intr, SA_SHIRQ, "fd_mcs", hosts)) {
+	  printk(KERN_WARNING "fd_mcs: request_irq() failed, Skip it\n");
+	  goto err_release;
+	}
 
 	/* register */
 	if (!(shpnt = scsi_register(tpnt, sizeof(struct fd_hostdata)))) {
 	  printk( "fd_mcs: scsi_register() failed\n");
-	  continue;
+	  goto err_free_irq;
 	}
 
 	/* request I/O region */
-	request_region( port, 0x10, "fd_mcs" );
 
 	/* save name */
 	strcpy(adapter_name, fd_mcs_adapters[loop].name);
@@ -578,6 +579,12 @@
 	      FD_MAX_HOSTS);
       break;
     }
+    continue;
+
+  err_free_irq:
+    free_irq(irq, fd_mcs_intr);
+  err_release:
+    release_region(port, 0x10);
   }
 
   return found;

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Three things are certain:
Death, taxes, and lost data.
Guess which has occurred. --- Error messages in haiku
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
