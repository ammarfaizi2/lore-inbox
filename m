Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVDOI1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDOI1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDOI0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:26:10 -0400
Received: from gate.in-addr.de ([212.8.193.158]:17063 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261774AbVDOIYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:24:01 -0400
Date: Fri, 15 Apr 2005 10:22:42 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Domen Puncer <domen@coderock.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 1/1] nbd: Don't create all MAX_NBD devices by default all the time
Message-ID: <20050415082242.GN22931@marowsky-bree.de>
References: <20050414112318.GL32354@marowsky-bree.de> <20050414225635.GA3983@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050414225635.GA3983@nd47.coderock.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-15T00:56:35, Domen Puncer <domen@coderock.org> wrote:

> This is permissions in sysfs (or 0 if no file is to be created).

Duh. Should have caught that. Try this one.

Index: linux-2.6.11/drivers/block/nbd.c
===================================================================
--- linux-2.6.11.orig/drivers/block/nbd.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11/drivers/block/nbd.c	2005-04-15 09:36:10.374854551 +0200
@@ -78,6 +78,7 @@
 #define DBG_RX          0x0200
 #define DBG_TX          0x0400
 static unsigned int debugflags;
+static unsigned int nbds_max = 16;
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
 
+module_param(nbds_max, int, 0444);
+MODULE_PARM_DESC(nbds_max, "How many network block devices to initialize.");
 #ifndef NDEBUG
 module_param(debugflags, int, 0644);
 MODULE_PARM_DESC(debugflags, "flags for controlling debug output");


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

