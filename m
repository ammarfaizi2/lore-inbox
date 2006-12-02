Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162964AbWLBLOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162964AbWLBLOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162953AbWLBLOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:14:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:63257 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162958AbWLBLOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:14:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=t3qs8preFkqpn/9psjFjY+cYIIWsrhkKQX4vL0mvPm85McewwlRKdoQX4RQIae1FA28XrrATjrpX6wIdDo7tTyWWEhhDCFKvnuG2xn4CcNv6Bf4iiB8aOXJq74CwRA9Za5sCKXOwW3y6sr4/2IOzacm/LJ3YnRScpfG7a0CpDEE=
Subject: [PATCH 2.6.19] jffs2: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org, trivial@kernel.org
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:11:14 +0200
Message-Id: <1165057874.4523.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/fs/jffs2/fs.c linux-2.6.19-rc5_kzalloc/fs/jffs2/fs.c
--- linux-2.6.19-rc5_orig/fs/jffs2/fs.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/jffs2/fs.c	2006-11-11 22:44:04.000000000 +0200
@@ -502,12 +502,11 @@ int jffs2_do_fill_super(struct super_blo
 	if (ret)
 		return ret;
 
-	c->inocache_list = kmalloc(INOCACHE_HASHSIZE * sizeof(struct jffs2_inode_cache *), GFP_KERNEL);
+	c->inocache_list = kcalloc(INOCACHE_HASHSIZE, sizeof(struct jffs2_inode_cache *), GFP_KERNEL);
 	if (!c->inocache_list) {
 		ret = -ENOMEM;
 		goto out_wbuf;
 	}
-	memset(c->inocache_list, 0, INOCACHE_HASHSIZE * sizeof(struct jffs2_inode_cache *));
 
 	jffs2_init_xattr_subsystem(c);
 
diff -rubp linux-2.6.19-rc5_orig/fs/jffs2/readinode.c linux-2.6.19-rc5_kzalloc/fs/jffs2/readinode.c
--- linux-2.6.19-rc5_orig/fs/jffs2/readinode.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/jffs2/readinode.c	2006-11-11 22:44:04.000000000 +0200
@@ -944,13 +944,12 @@ int jffs2_do_read_inode(struct jffs2_sb_
 int jffs2_do_crccheck_inode(struct jffs2_sb_info *c, struct jffs2_inode_cache *ic)
 {
 	struct jffs2_raw_inode n;
-	struct jffs2_inode_info *f = kmalloc(sizeof(*f), GFP_KERNEL);
+	struct jffs2_inode_info *f = kzalloc(sizeof(*f), GFP_KERNEL);
 	int ret;
 
 	if (!f)
 		return -ENOMEM;
 
-	memset(f, 0, sizeof(*f));
 	init_MUTEX_LOCKED(&f->sem);
 	f->inocache = ic;
 
diff -rubp linux-2.6.19-rc5_orig/fs/jffs2/scan.c linux-2.6.19-rc5_kzalloc/fs/jffs2/scan.c
--- linux-2.6.19-rc5_orig/fs/jffs2/scan.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/jffs2/scan.c	2006-11-11 22:44:04.000000000 +0200
@@ -128,12 +128,11 @@ int jffs2_scan_medium(struct jffs2_sb_in
 	}
 
 	if (jffs2_sum_active()) {
-		s = kmalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
+		s = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
 		if (!s) {
 			JFFS2_WARNING("Can't allocate memory for summary\n");
 			return -ENOMEM;
 		}
-		memset(s, 0, sizeof(struct jffs2_summary));
 	}
 
 	for (i=0; i<c->nr_blocks; i++) {

diff -rubp linux-2.6.19-rc5_orig/fs/jffs2/summary.c linux-2.6.19-rc5_kzalloc/fs/jffs2/summary.c
--- linux-2.6.19-rc5_orig/fs/jffs2/summary.c	2006-11-09 12:16:20.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/fs/jffs2/summary.c	2006-11-11 22:44:04.000000000 +0200
@@ -26,15 +26,13 @@
 
 int jffs2_sum_init(struct jffs2_sb_info *c)
 {
-	c->summary = kmalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
+	c->summary = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
 
 	if (!c->summary) {
 		JFFS2_WARNING("Can't allocate memory for summary information!\n");
 		return -ENOMEM;
 	}
 
-	memset(c->summary, 0, sizeof(struct jffs2_summary));
-
 	c->summary->sum_buf = vmalloc(c->sector_size);
 
 	if (!c->summary->sum_buf) {



