Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135766AbRAVXmH>; Mon, 22 Jan 2001 18:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135843AbRAVXlu>; Mon, 22 Jan 2001 18:41:50 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:23633
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135765AbRAVXlb>; Mon, 22 Jan 2001 18:41:31 -0500
Date: Tue, 23 Jan 2001 00:41:25 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] make drivers/scsi/hosts.c check kmalloc return codes (241p9)
Message-ID: <20010123004125.N602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/hosts.c check kmalloc's
return code, drops some gratitious zero initializations and
makes it a little less panicky.

It applies cleanly against ac10 and 241p9.

Please comment.


--- linux-ac10-clean/drivers/scsi/hosts.c	Mon Oct 30 23:44:29 2000
+++ linux-ac10/drivers/scsi/hosts.c	Sat Jan 20 23:07:08 2001
@@ -69,7 +69,7 @@
  *  idiocy.
  */
 
-Scsi_Host_Template * scsi_hosts = NULL;
+Scsi_Host_Template * scsi_hosts;
 
 
 /*
@@ -77,12 +77,12 @@
  *      MAX_SCSI_HOSTS here.
  */
 
-Scsi_Host_Name * scsi_host_no_list = NULL;
-struct Scsi_Host * scsi_hostlist = NULL;
-struct Scsi_Device_Template * scsi_devicelist = NULL;
+Scsi_Host_Name * scsi_host_no_list;
+struct Scsi_Host * scsi_hostlist;
+struct Scsi_Device_Template * scsi_devicelist;
 
-int max_scsi_hosts = 0;
-int next_scsi_host = 0;
+int max_scsi_hosts;
+int next_scsi_host;
 
 void
 scsi_unregister(struct Scsi_Host * sh){
@@ -140,10 +140,7 @@
 					 (tpnt->unchecked_isa_dma && j ? 
 					  GFP_DMA : 0) | GFP_ATOMIC);
     if(retval == NULL)
-    {
-        printk("scsi: out of memory in scsi_register.\n");
-    	return NULL;
-    }
+        goto err_out;
     	
     memset(retval, 0, sizeof(struct Scsi_Host) + j);
 
@@ -163,12 +160,19 @@
     atomic_set(&retval->host_active,0);
     retval->host_busy = 0;
     retval->host_failed = 0;
-    if(j > 0xffff) panic("Too many extra bytes requested\n");
+    if(j > 0xffff) {
+            printk("scsi: Too many extra bytes requested\n");
+            goto err_dealloc_retval;
+    }
     retval->extra_bytes = j;
     retval->loaded_as_module = 1;
     if (flag_new) {
 	shn = (Scsi_Host_Name *) kmalloc(sizeof(Scsi_Host_Name), GFP_ATOMIC);
+        if (!shn)
+                goto err_dealloc_retval;
 	shn->name = kmalloc(hname_len + 1, GFP_ATOMIC);
+        if (!shn->name) 
+                goto err_dealloc_shn;
 	if (hname_len > 0)
 	    strncpy(shn->name, hname, hname_len);
 	shn->name[hname_len] = 0;
@@ -258,6 +262,14 @@
     }
     
     return retval;
+
+ err_dealloc_shn:
+    kfree(shn);
+ err_dealloc_retval:
+    kfree(retval);
+ err_out:
+    printk("scsi: out of memory in scsi_register.\n");
+    return NULL;
 }
 
 int

-- 
        Rasmus(rasmus@jaquet.dk)

While the Melissa license is a bit unclear, Melissa aggressively
encourages free distribution of its source code.
  -- Kevin Dalley on Melissa being Open Source
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
