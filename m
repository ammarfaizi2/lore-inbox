Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUB0Bgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUB0Bgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:36:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:43460 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261691AbUB0Bfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:35:51 -0500
Date: Thu, 26 Feb 2004 17:37:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: bcollins@debian.org, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] SCSI host num allocation improvement
Message-Id: <20040226173743.2bf473b4.akpm@osdl.org>
In-Reply-To: <20040226171928.750f5f6f.akpm@osdl.org>
References: <20040226235412.GA819@phunnypharm.org>
	<20040226171928.750f5f6f.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> The lib/idr.c code is a bit clumsy but it does do the job relatively
> efficiently.

hmm, not too bad actually.  It compiles, but I didn't test it.



--- 25/drivers/scsi/hosts.c~scsi-host-allocation-fix	Thu Feb 26 17:30:40 2004
+++ 25-akpm/drivers/scsi/hosts.c	Thu Feb 26 17:36:47 2004
@@ -30,6 +30,7 @@
 #include <linux/list.h>
 #include <linux/completion.h>
 #include <linux/unistd.h>
+#include <linux/idr.h>
 
 #include <scsi/scsi_host.h>
 #include "scsi.h"
@@ -38,9 +39,6 @@
 #include "scsi_logging.h"
 
 
-static int scsi_host_next_hn;		/* host_no for next new host */
-
-
 static void scsi_host_cls_release(struct class_device *class_dev)
 {
 	put_device(&class_to_shost(class_dev)->shost_gendev);
@@ -166,6 +164,30 @@ static void scsi_host_dev_release(struct
 	kfree(shost);
 }
 
+static DECLARE_MUTEX(host_num_lock);
+static struct idr allocated_hosts;
+
+/**
+ * scsi_host_num_alloc - allocate a unique host number for a scsi host.
+ *
+ * Note:
+ *      Must hold host_num_lock when calling this, and continue holding it
+ *      till after the host is added to the shost_class.
+ *
+ * Return value:
+ *      A unique host number.
+ **/
+static int scsi_host_num_alloc(void)
+{
+	int ret;
+
+	down(&host_num_lock);
+	idr_pre_get(&allocated_hosts, GFP_KERNEL);
+	ret = idr_get_new(&allocated_hosts, NULL);
+	up(&host_num_lock);
+	return ret;
+}
+
 /**
  * scsi_host_alloc - register a scsi host adapter instance.
  * @sht:	pointer to scsi host template
@@ -214,7 +236,6 @@ struct Scsi_Host *scsi_host_alloc(struct
 
 	init_MUTEX(&shost->scan_mutex);
 
-	shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */
 	shost->dma_channel = 0xff;
 
 	/* These three are default values which can be overridden */
@@ -263,6 +284,8 @@ struct Scsi_Host *scsi_host_alloc(struct
 	if (rval)
 		goto fail_kfree;
 
+	shost->host_no = scsi_host_num_alloc();
+
 	device_initialize(&shost->shost_gendev);
 	snprintf(shost->shost_gendev.bus_id, BUS_ID_SIZE, "host%d",
 		shost->host_no);
@@ -308,6 +331,9 @@ struct Scsi_Host *scsi_register(struct s
 void scsi_unregister(struct Scsi_Host *shost)
 {
 	list_del(&shost->sht_legacy_list);
+	down(&host_num_lock);
+	idr_remove(&allocated_hosts, shost->host_no);
+	up(&host_num_lock);
 	scsi_host_put(shost);
 }
 
@@ -361,6 +387,7 @@ void scsi_host_put(struct Scsi_Host *sho
 
 int scsi_init_hosts(void)
 {
+	idr_init(&allocated_hosts);
 	return class_register(&shost_class);
 }
 

_

