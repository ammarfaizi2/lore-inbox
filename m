Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSKJQ0G>; Sun, 10 Nov 2002 11:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSKJQ0G>; Sun, 10 Nov 2002 11:26:06 -0500
Received: from host194.steeleye.com ([66.206.164.34]:59915 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264936AbSKJQ0F>; Sun, 10 Nov 2002 11:26:05 -0500
Message-Id: <200211101632.gAAGWln11508@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "J.E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BOGUS: megaraid changes 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "10 Nov 2002 16:47:48 GMT." <1036946868.1009.16.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Nov 2002 11:32:47 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> I dont think panic() is needed bug a loud printk and maybe an error
> return from scsi_register() would do the trick. We do however have a
> couple of drivers where "pray, the firmware does all the work" is the
> right answer, but they really should be setting their own handler that
> delays rather than aborting/resetting/kicking offline 

How about this?  It doesn't panic, just refuses to attach the driver (although 
this will still eventually cause a panic if your root fs is on it).

James

===== hosts.c 1.23 vs edited =====
--- 1.23/drivers/scsi/hosts.c	Tue Nov  5 11:18:22 2002
+++ edited/hosts.c	Sun Nov 10 10:17:32 2002
@@ -51,6 +51,22 @@
 
 static int scsi_host_next_hn;		/* host_no for next new host */
 static int scsi_hosts_registered;	/* cnt of registered scsi hosts */
+static int scsi_ignore_no_error_handling = 0;
+
+#ifdef MODULE
+MODULE_PARM(scsi_ignore_no_error_handling, "i");
+#else
+static int __init
+scsi_ignore_no_error_handling_setup(char *str)
+{
+        scsi_ignore_no_error_handling = 1;
+
+        return 1;
+}
+        
+__setup("scsi_ignore_no_error_handling=", scsi_ignore_no_error_handling_setup)
;
+#endif
+
 
 /**
  * scsi_tp_for_each_host - call function for each scsi host off a template
@@ -345,6 +361,25 @@
 	int gfp_mask;
 	DECLARE_MUTEX_LOCKED(sem);
 
+	/*
+	 * Determine host number. Check reserved first before allocating
+	 * new one
+	 */
+	hname = (shost_tp->proc_name) ?  shost_tp->proc_name : "";
+	hname_len = strlen(hname);
+
+        /* Check to see if this host has any error handling facilities */
+        if(shost_tp->eh_strategy_handler == NULL &&
+           shost_tp->eh_abort_handler == NULL &&
+           shost_tp->eh_device_reset_handler == NULL &&
+           shost_tp->eh_bus_reset_handler == NULL &&
+           shost_tp->eh_host_reset_handler == NULL) {
+                printk(KERN_ERR "ERROR: SCSI host `%s' has no error 
handling\nERROR: This is not a safe way to run your SCSI host\nERROR: The 
error handling must be added to this driver\n", hname);
+                if(!scsi_ignore_no_error_handling) {
+                        printk(KERN_ERR "ERROR: not attaching this 
host.\n\nERROR: to force attachment, boot with the 
scsi_ignore_no_error_handling flag");
+                        return NULL;
+                }
+        } 
 	gfp_mask = GFP_KERNEL;
 	if (shost_tp->unchecked_isa_dma && xtr_bytes)
 		gfp_mask |= __GFP_DMA;
@@ -356,13 +391,6 @@
 	}
 
 	memset(shost, 0, sizeof(struct Scsi_Host) + xtr_bytes);
-
-	/*
-	 * Determine host number. Check reserved first before allocating
-	 * new one
-	 */
-	hname = (shost_tp->proc_name) ?  shost_tp->proc_name : "";
-	hname_len = strlen(hname);
 
 	if (hname_len)
 		list_for_each(lh, &scsi_host_hn_list) {


