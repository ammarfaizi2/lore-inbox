Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWGKLxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWGKLxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGKLxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:53:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32953 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751224AbWGKLxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:53:41 -0400
Subject: Re: e1000 vs nfs/net circular locking report
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       jesse.brandeburg@intel.com, trond.myklebust@fys.uio.no
In-Reply-To: <20060711115143.GB4113@suse.de>
References: <20060711115143.GB4113@suse.de>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 13:53:37 +0200
Message-Id: <1152618818.3128.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 13:51 +0200, Jens Axboe wrote:
> Hi,
> 
> Upon cd'ing to an nfs mounted directory, I received this report. It's
> perfectly reproducible.


this patch (about to be merged in mainline) should fix it

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: fix false positives by giving sysfs inodes their own lock class

sysfs has a different i_mutex lock order behavior for i_mutex than the other
filesystems; sysfs i_mutex is called in many places with subsystem locks
held. At the same time, many of the VFS locking rules do not apply to sysfs
at all (cross directory rename for example). To untangle this mess (which
gives false positives in lockdep), we're giving sysfs inodes their own class
for i_mutex.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Index: linux-2.6.18-rc1/fs/sysfs/inode.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/sysfs/inode.c
+++ linux-2.6.18-rc1/fs/sysfs/inode.c
@@ -109,6 +109,17 @@ static inline void set_inode_attr(struct
 	inode->i_ctime = iattr->ia_ctime;
 }
 
+
+/*
+ * sysfs has a different i_mutex lock order behavior for i_mutex than other
+ * filesystems; sysfs i_mutex is called in many places with subsystem locks
+ * held. At the same time, many of the VFS locking rules do not apply to
+ * sysfs at all (cross directory rename for example). To untangle this mess
+ * (which gives false positives in lockdep), we're giving sysfs inodes their
+ * own class for i_mutex.
+ */
+static struct lock_class_key sysfs_inode_imutex_key;
+
 struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent * sd)
 {
 	struct inode * inode = new_inode(sysfs_sb);
@@ -118,6 +129,7 @@ struct inode * sysfs_new_inode(mode_t mo
 		inode->i_mapping->a_ops = &sysfs_aops;
 		inode->i_mapping->backing_dev_info = &sysfs_backing_dev_info;
 		inode->i_op = &sysfs_inode_operations;
+		lockdep_set_class(&inode->i_mutex, &sysfs_inode_imutex_key);
 
 		if (sd->s_iattr) {
 			/* sysfs_dirent has non-default attributes


