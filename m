Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131779AbRAVX2H>; Mon, 22 Jan 2001 18:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130615AbRAVX16>; Mon, 22 Jan 2001 18:27:58 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:16721
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129692AbRAVX1s>; Mon, 22 Jan 2001 18:27:48 -0500
Date: Tue, 23 Jan 2001 00:27:36 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-apus-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/53c7xx.c error handling and cleanup (241p9)
Message-ID: <20010123002736.D602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I hope I haven't missed any relevant lists :) )

The following patch makes drivers/scsi/53c7xx.c check the return code
of request_region and release the irq properly in the error path.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/53c7xx.c	Sun Nov 12 04:01:11 2000
+++ linux-ac10/drivers/scsi/53c7xx.c	Sun Jan 21 21:56:29 2001
@@ -1077,19 +1077,18 @@
     {
 	printk("scsi%d : IRQ%d not free, detaching\n",
 		host->host_no, host->irq);
-	scsi_unregister (host);
-	return -1;
+	goto err_unregister;
     } 
 
     if ((hostdata->run_tests && hostdata->run_tests(host) == -1) ||
         (hostdata->options & OPTION_DEBUG_TESTS_ONLY)) {
     	/* XXX Should disable interrupts, etc. here */
-	scsi_unregister (host);
-    	return -1;
+	goto err_free_irq;
     } else {
 	if (host->io_port)  {
 	    host->n_io_port = 128;
-	    request_region (host->io_port, host->n_io_port, "ncr53c7xx");
+	    if (!request_region (host->io_port, host->n_io_port, "ncr53c7xx"))
+		goto err_free_irq;
 	}
     }
     
@@ -1098,6 +1097,12 @@
 	hard_reset (host);
     }
     return 0;
+
+ err_free_irq:
+    free_irq(host->irq,  NCR53c7x0_intr);
+ err_unregister:
+    scsi_unregister(host);
+    return -1;
 }
 
 /* 
@@ -1206,8 +1211,10 @@
     size += 256;
 #endif
     /* Size should be < 8K, so we can fit it in two pages. */
-    if (size > 8192)
-      panic("53c7xx: hostdata > 8K");
+    if (size > 8192) {
+      printk(KERN_ERR "53c7xx: hostdata > 8K\n");
+      return -1;
+
     instance = scsi_register (tpnt, 4);
     if (!instance)
     {
@@ -3091,8 +3098,10 @@
 #endif
 /* FIXME: for ISA bus '7xx chips, we need to or GFP_DMA in here */
 
-        if (size > 4096)
-            panic ("53c7xx: allocate_cmd size > 4K");
+        if (size > 4096) {
+            printk (KERN_ERR "53c7xx: allocate_cmd size > 4K\n");
+	    return NULL;
+	}
         real = get_free_page(GFP_ATOMIC);
         if (real == 0)
         	return NULL;

-- 
        Rasmus(rasmus@jaquet.dk)

If a man says something in a forest and there are no women around to 
hear him, is he still wrong? -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
