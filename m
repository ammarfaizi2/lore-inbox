Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUB0DF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 22:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUB0DF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 22:05:27 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:45525 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261585AbUB0DFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 22:05:12 -0500
Date: Thu, 26 Feb 2004 22:04:28 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [BK PATCH] SCSI host num allocation improvement
Message-ID: <20040227030428.GA707@phunnypharm.org>
References: <20040226235412.GA819@phunnypharm.org> <20040226171928.750f5f6f.akpm@osdl.org> <20040226173743.2bf473b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226173743.2bf473b4.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's one that actually compiles.

===== drivers/scsi/hosts.c 1.96 vs edited =====
--- 1.96/drivers/scsi/hosts.c	Mon Dec 29 16:38:10 2003
+++ edited/drivers/scsi/hosts.c	Thu Feb 26 22:00:33 2004
@@ -30,6 +30,7 @@
 #include <linux/list.h>
 #include <linux/completion.h>
 #include <linux/unistd.h>
+#include <linux/idr.h>
 
 #include <scsi/scsi_host.h>
 #include "scsi.h"
@@ -37,12 +38,15 @@
 #include "scsi_priv.h"
 #include "scsi_logging.h"
 
-
-static int scsi_host_next_hn;		/* host_no for next new host */
+static DECLARE_MUTEX(host_num_lock);
+static struct idr allocated_hosts;
 
 
 static void scsi_host_cls_release(struct class_device *class_dev)
 {
+	down(&host_num_lock);
+	idr_remove(&allocated_hosts, class_to_shost(class_dev)->host_no);
+	up(&host_num_lock);
 	put_device(&class_to_shost(class_dev)->shost_gendev);
 }
 
@@ -166,6 +170,7 @@
 	kfree(shost);
 }
 
+
 /**
  * scsi_host_alloc - register a scsi host adapter instance.
  * @sht:	pointer to scsi host template
@@ -214,7 +219,6 @@
 
 	init_MUTEX(&shost->scan_mutex);
 
-	shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */
 	shost->dma_channel = 0xff;
 
 	/* These three are default values which can be overridden */
@@ -263,6 +267,11 @@
 	if (rval)
 		goto fail_kfree;
 
+	down(&host_num_lock);
+	idr_pre_get(&allocated_hosts, GFP_KERNEL);
+	shost->host_no = idr_get_new(&allocated_hosts, NULL);
+	up(&host_num_lock);
+
 	device_initialize(&shost->shost_gendev);
 	snprintf(shost->shost_gendev.bus_id, BUS_ID_SIZE, "host%d",
 		shost->host_no);
@@ -307,6 +316,9 @@
 
 void scsi_unregister(struct Scsi_Host *shost)
 {
+	down(&host_num_lock);
+	idr_remove(&allocated_hosts, shost->host_no);
+	up(&host_num_lock);
 	list_del(&shost->sht_legacy_list);
 	scsi_host_put(shost);
 }
@@ -361,6 +373,7 @@
 
 int scsi_init_hosts(void)
 {
+	idr_init(&allocated_hosts);
 	return class_register(&shost_class);
 }
 
-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
