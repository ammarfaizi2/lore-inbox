Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135719AbRAVXqh>; Mon, 22 Jan 2001 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135637AbRAVXq2>; Mon, 22 Jan 2001 18:46:28 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:24657
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135747AbRAVXp1>; Mon, 22 Jan 2001 18:45:27 -0500
Date: Tue, 23 Jan 2001 00:45:20 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] make drivers/scsi/megaraid.c check ioremaps return code (241p9)
Message-ID: <20010123004520.Q602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/megaraid.c check the return
code of ioremap and converts the affected code paths to forward
gotos error handling. It applies cleanly against ac10 and with a
little fuzz against 241p9.

Please comment.


--- linux-ac10-clean/drivers/scsi/megaraid.c	Sat Jan 20 15:17:13 2001
+++ linux-ac10/drivers/scsi/megaraid.c	Mon Jan 22 21:19:54 2001
@@ -1491,15 +1491,19 @@
     megaBase = pci_resource_start (pdev, 0);
     megaIrq  = pdev->irq;
 
-    if (flag & BOARD_QUARTZ)
+    if (flag & BOARD_QUARTZ) {
       megaBase = (long) ioremap (megaBase, 128);
+      if (!megaBase)
+	      continue;
+    }
     else
       megaBase += 0x10;
 
     /* Initialize SCSI Host structure */
     host = scsi_register (pHostTmpl, sizeof (mega_host_config));
     if(host == NULL)
-    	continue;
+        goto err_unmap;
+
     megaCfg = (mega_host_config *) host->hostdata;
     memset (megaCfg, 0, sizeof (mega_host_config));
 
@@ -1528,8 +1532,7 @@
       /* Request our IO Range */
       if (!request_region (megaBase, 16, "megaraid")) {
 	printk (KERN_WARNING "megaraid: Couldn't register I/O range!" CRLFSTR);
-	scsi_unregister (host);
-	continue;
+	goto err_unregister;
       }
     }
 
@@ -1538,8 +1541,7 @@
 		     "megaraid", megaCfg)) {
       printk (KERN_WARNING "megaraid: Couldn't register IRQ %d!" CRLFSTR,
 	      megaIrq);
-      scsi_unregister (host);
-      continue;
+      goto err_release;
     }
 
     mega_register_mailbox (megaCfg, virt_to_bus ((void *) &megaCfg->mailbox64));
@@ -1585,6 +1587,16 @@
     }
 
     numFound++;
+    continue;
+
+  err_release:
+    if (!flag = BOARD_QUARTZ)
+	    release_region(megaBase, 16);
+  err_unregister:
+    scsi_unregister (host);
+  err_unmap:
+    if (flag & BOARD_QUARTZ)
+	    iounmap(megaBase, 128);
   }
   return numFound;
 }

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

It's a recession when your neighbour loses his job; it's a depression 
when you lose yours. -- Harry S. Truman 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
