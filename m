Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbRAWWUW>; Tue, 23 Jan 2001 17:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131703AbRAWWUM>; Tue, 23 Jan 2001 17:20:12 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:53333
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130689AbRAWWT5>; Tue, 23 Jan 2001 17:19:57 -0500
Date: Tue, 23 Jan 2001 23:19:49 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: ipslinux@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/ips.c check_region -> request_region (241p9)
Message-ID: <20010123231949.I607@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/ips.c use the return code
of request_region instead of calling check_region. It also moves
some resource freeing to ips_free since that made my error path
cleaner.

It applies cleanly against ac10 and 241p9.

Please comment.


--- linux-ac10-clean/drivers/scsi/ips.c	Sat Jan 20 15:17:13 2001
+++ linux-ac10/drivers/scsi/ips.c	Sun Jan 21 19:17:07 2001
@@ -668,7 +668,7 @@
                       ips_name, ips_next_controller, mem_addr, mem_len);
 
 #if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,17)
-            if (check_mem_region(mem_addr, mem_len)) {
+            if (!request_mem_region(mem_addr, mem_len, "ips")) {
                /* Couldn't allocate io space */
                printk(KERN_WARNING "(%s%d) couldn't allocate IO space %x len %d.\n",
                       ips_name, ips_next_controller, io_addr, io_len);
@@ -677,8 +677,6 @@
 
                continue;
             }
-
-            request_mem_region(mem_addr, mem_len, "ips");
 #endif
 
             base = mem_addr & PAGE_MASK;
@@ -696,7 +694,7 @@
             DEBUG_VAR(1, "(%s%d) detect, IO region %x, size: %d",
                       ips_name, ips_next_controller, io_addr, io_len);
 
-            if (check_region(io_addr, io_len)) {
+            if (!request_region(io_addr, io_len, "ips")) {
                /* Couldn't allocate io space */
                printk(KERN_WARNING "(%s%d) couldn't allocate IO space %x len %d.\n",
                       ips_name, ips_next_controller, io_addr, io_len);
@@ -706,7 +704,6 @@
                continue;
             }
 
-            request_region(io_addr, io_len, "ips");
          }
 
          /* get planer status */
@@ -1031,6 +1028,7 @@
 
       if (!ha->active) {
          scsi_unregister(sh);
+         ips_free(ha); /* To free request_*'ed resources. */
          ips_ha[i] = NULL;
          ips_sh[i] = NULL;
 
@@ -1152,15 +1150,6 @@
    /* free extra memory */
    ips_free(ha);
 
-   /* Free I/O Region */
-   if (ha->io_addr)
-      release_region(ha->io_addr, ha->io_len);
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,17)
-   if (ha->mem_addr)
-      release_mem_region(ha->mem_addr, ha->mem_len);
-#endif
-
    /* free IRQ */
    free_irq(ha->irq, ha);
 
@@ -4531,6 +4520,15 @@
          ha->mem_ptr = NULL;
          ha->mem_addr = 0;
       }
+      
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,3,17)
+      if (ha->mem_addr)
+         release_mem_region(ha->mem_addr, ha->mem_len);
+#endif
+
+      if (ha->io_addr)
+         release_region(ha->io_addr, ha->io_len);
+
    }
 }
 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"You who hate the Jews so, why did you adopt their religion?" 
   -- Friedrich Nietzsche, addressing anti-semitic Christians 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
