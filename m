Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131844AbRAWWwy>; Tue, 23 Jan 2001 17:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbRAWWwp>; Tue, 23 Jan 2001 17:52:45 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:61013
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130387AbRAWWw1>; Tue, 23 Jan 2001 17:52:27 -0500
Date: Tue, 23 Jan 2001 23:52:15 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: zaga@fly.srk.fer.hr
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/wd7000.c: check_region -> request_region (241p9)
Message-ID: <20010123235215.E9514@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/wd7000.c use request_region
instead of check_region+request_region. It also drops a panic() and
changes error paths to be forward gotos (in part necessary by the
request_region change).

It applies cleanly against ac10 and 241p9.

Comments?



--- linux-ac10-clean/drivers/scsi/wd7000.c	Sun Nov 12 04:01:11 2000
+++ linux-ac10/drivers/scsi/wd7000.c	Mon Jan 22 21:05:10 2001
@@ -863,7 +863,7 @@
 	 */
 	if (freescbs < needed) {
 	    busy = 0;
-	    panic ("wd7000: can't get enough free SCBs.\n");
+	    printk (KERN_ERR "wd7000: can't get enough free SCBs.\n");
 	    restore_flags (flags);
 	    return (NULL);
 	}
@@ -1593,7 +1593,7 @@
 	printk ("wd7000_detect: check IO 0x%x region...\n", iobase);
 #endif
 
-	if (!check_region (iobase, 4)) {
+	if (request_region (iobase, 4, "wd7000")) {
 
 #ifdef WD7000_DEBUG
 	    printk ("wd7000_detect: ASC reset (IO 0x%x) ...", iobase);
@@ -1609,12 +1609,12 @@
 #ifdef WD7000_DEBUG
 	    {
 		printk ("failed!\n");
-		continue;
+		goto err_release;
 	    }
-	    else
+	    else 
 		printk ("ok!\n");
 #else
-		continue;
+	    goto err_release;
 #endif
 
 	    if (inb (iobase + ASC_INTR_STAT) == 1) {
@@ -1627,7 +1627,8 @@
 		 */
 		sh = scsi_register (tpnt, sizeof (Adapter));
 		if(sh==NULL)
-			continue;
+		    goto err_release;
+
 		host = (Adapter *) sh->hostdata;
 
 #ifdef WD7000_DEBUG
@@ -1650,11 +1651,8 @@
 			host->iobase, host->irq, host->dma);
 #endif
 
-		if (!wd7000_init (host)) {	/* Initialization failed */
-		    scsi_unregister (sh);
-
-		    continue;
-		}
+		if (!wd7000_init (host)) 	/* Initialization failed */
+		    goto err_unregister;
 
 		/*
 		 *  OK from here - we'll use this adapter/configuration.
@@ -1662,11 +1660,6 @@
 		wd7000_revision (host);		/* important for scatter/gather */
 
 		/*
-		 * Register our ports.
-		 */
-		request_region (host->iobase, 4, "wd7000");
-
-		/*
 		 *  For boards before rev 6.0, scatter/gather isn't supported.
 		 */
 		if (host->rev1 < 6)
@@ -1690,6 +1683,13 @@
 	else
 	    printk ("wd7000_detect: IO 0x%x region already allocated!\n", iobase);
 #endif
+
+	continue;
+
+    err_unregister:
+	scsi_unregister (sh);
+    err_release:
+	release_region(iobase, 4);
 
     }
 


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

First snow, then silence.
This thousand dollar screen dies
so beautifully.           --- Error messages in haiku
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
