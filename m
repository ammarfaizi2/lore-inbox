Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRAWV6l>; Tue, 23 Jan 2001 16:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAWV6b>; Tue, 23 Jan 2001 16:58:31 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:50005
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129811AbRAWV62>; Tue, 23 Jan 2001 16:58:28 -0500
Date: Tue, 23 Jan 2001 22:58:12 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-apus-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/53c7xx.c error handling and cleanup (241p9)
Message-ID: <20010123225812.B607@jaquet.dk>
In-Reply-To: <20010123002736.D602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010123002736.D602@jaquet.dk>; from rasmus@jaquet.dk on Tue, Jan 23, 2001 at 12:27:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 12:27:36AM +0100, Rasmus Andersen wrote:

Hi again.

I completely messed up a large part of the patches posted yesterday due
to lack of sleep and being clinically braindead (the compile test was
run in the wrong tree...).

So I'll be posting some new patches that actually compiles (knock on
wood). I apologise for the unnecessary mails :(

(Thanks goes to Bill Wendling for bringing my attention to this one.)

--- linux-ac10-clean/drivers/scsi/53c7xx.c	Sun Nov 12 04:01:11 2000
+++ linux-ac10/drivers/scsi/53c7xx.c	Tue Jan 23 21:25:18 2001
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
@@ -1206,8 +1211,11 @@
     size += 256;
 #endif
     /* Size should be < 8K, so we can fit it in two pages. */
-    if (size > 8192)
-      panic("53c7xx: hostdata > 8K");
+    if (size > 8192) {
+      printk(KERN_ERR "53c7xx: hostdata > 8K\n");
+      return -1;
+    }
+
     instance = scsi_register (tpnt, 4);
     if (!instance)
     {
@@ -3091,8 +3099,10 @@
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

Are they taking DDT?
                -- Vice President Dan Quayle asking doctors at a Manhattan
                   AIDS clinic about their treatments of choice, 4/30/92
                   (reported in Esquire, 8/92, and NY Post early May 92)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
