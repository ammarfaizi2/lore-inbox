Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVDNLXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVDNLXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 07:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVDNLXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 07:23:53 -0400
Received: from gate.in-addr.de ([212.8.193.158]:33005 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261475AbVDNLXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 07:23:48 -0400
Date: Thu, 14 Apr 2005 13:23:18 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [patch 1/1] nbd: Don't create all MAX_NBD devices by default all the time
Message-ID: <20050414112318.GL32354@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Marowsky-Bree <lmb@suse.de>

This patches adds the "nbds_max" parameter to the nbd kernel module,
which limits the number of nbds allocated. Previously, always all 128
entries were allocated unconditionally, which used to waste resources
and needlessly flood the hotplug system with events. (Defaults to 16
now.)

Signed-off-by: Lars Marowsky-Bree <lmb@suse.de>

---
 nbd.c |   16 +++++++++++++---
1 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6.11/drivers/block/nbd.c
===================================================================
--- linux-2.6.11.orig/drivers/block/nbd.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11/drivers/block/nbd.c	2005-04-14 13:08:40.100896527 +0200
@@ -78,6 +78,7 @@
 #define DBG_RX          0x0200
 #define DBG_TX          0x0400
 static unsigned int debugflags;
+static unsigned int nbds_max;
 #endif /* NDEBUG */
 
 static struct nbd_device nbd_dev[MAX_NBD];
@@ -647,7 +648,13 @@ static int __init nbd_init(void)
 		return -EIO;
 	}
 
-	for (i = 0; i < MAX_NBD; i++) {
+	if (nbds_max > MAX_NBD) {
+		printk(KERN_CRIT "nbd: cannot allocate more than %u nbds; %u requested.\n", MAX_NBD,
+				nbds_max);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < nbds_max; i++) {
 		struct gendisk *disk = alloc_disk(1);
 		if (!disk)
 			goto out;
@@ -673,7 +680,7 @@ static int __init nbd_init(void)
 	dprintk(DBG_INIT, "nbd: debugflags=0x%x\n", debugflags);
 
 	devfs_mk_dir("nbd");
-	for (i = 0; i < MAX_NBD; i++) {
+	for (i = 0; i < nbds_max; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].file = NULL;
 		nbd_dev[i].magic = LO_MAGIC;
@@ -706,8 +713,9 @@ out:
 static void __exit nbd_cleanup(void)
 {
 	int i;
-	for (i = 0; i < MAX_NBD; i++) {
+	for (i = 0; i < nbds_max; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
+		nbd_dev[i].magic = 0;
 		if (disk) {
 			del_gendisk(disk);
 			blk_cleanup_queue(disk->queue);
@@ -725,6 +733,8 @@ module_exit(nbd_cleanup);
 MODULE_DESCRIPTION("Network Block Device");
 MODULE_LICENSE("GPL");
 
+module_param(nbds_max, int, 16);
+MODULE_PARM_DESC(nbds_max, "How many network block devices to initialize.");
 #ifndef NDEBUG
 module_param(debugflags, int, 0644);
 MODULE_PARM_DESC(debugflags, "flags for controlling debug output");


-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

