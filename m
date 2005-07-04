Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVGDQk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVGDQk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVGDQk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:40:57 -0400
Received: from [151.97.230.9] ([151.97.230.9]:18410 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261353AbVGDQkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:40:42 -0400
Subject: [patch 1/1] uml: restore hppfs support
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Mon, 04 Jul 2005 18:46:19 +0200
Message-Id: <20050704164619.8F6FC1D8B91@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some time ago a trivial patch broke HPPFS (one var became a pointer, not all
uses were updated). It wasn't fixed at that time because not very used, now
it's been requested so I've fixed this, and it has been tested positively (at
least partially).

Good for merging now.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Kconfig       |    6 +++---
 linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c |    7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/um/Kconfig~uml-hppfs arch/um/Kconfig
--- linux-2.6.git/arch/um/Kconfig~uml-hppfs	2005-07-04 18:37:37.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Kconfig	2005-07-04 18:46:13.000000000 +0200
@@ -128,7 +128,6 @@ config HOSTFS
 
 config HPPFS
 	tristate "HoneyPot ProcFS (EXPERIMENTAL)"
-	depends on BROKEN
 	help
 	hppfs (HoneyPot ProcFS) is a filesystem which allows UML /proc
 	entries to be overridden, removed, or fabricated from the host.
@@ -141,8 +140,9 @@ config HPPFS
 	You only need this if you are setting up a UML honeypot.  Otherwise,
 	it is safe to say 'N' here.
 
-	If you are actively using it, please ask for it to be fixed. In this
-	moment, it does not work on 2.6 (it works somehow on 2.4).
+	If you are actively using it, please report any problems, since it's
+	getting fixed. In this moment, it is experimental on 2.6 (it works on
+	2.4).
 
 config MCONSOLE
 	bool "Management console"
diff -puN fs/hppfs/hppfs_kern.c~uml-hppfs fs/hppfs/hppfs_kern.c
--- linux-2.6.git/fs/hppfs/hppfs_kern.c~uml-hppfs	2005-07-04 18:37:37.000000000 +0200
+++ linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c	2005-07-04 18:37:37.000000000 +0200
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/file.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -491,7 +492,7 @@ static int hppfs_open(struct inode *inod
 		fd = open_host_sock(host_file, &filter);
 		if(fd > 0){
 			data->contents = hppfs_get_data(fd, filter,
-							&data->proc_file,
+							data->proc_file,
 							file, &data->len);
 			if(!IS_ERR(data->contents))
 				data->host_fd = fd;
@@ -543,7 +544,7 @@ static int hppfs_dir_open(struct inode *
 static loff_t hppfs_llseek(struct file *file, loff_t off, int where)
 {
 	struct hppfs_private *data = file->private_data;
-	struct file *proc_file = &data->proc_file;
+	struct file *proc_file = data->proc_file;
 	loff_t (*llseek)(struct file *, loff_t, int);
 	loff_t ret;
 
@@ -586,7 +587,7 @@ static int hppfs_filldir(void *d, const 
 static int hppfs_readdir(struct file *file, void *ent, filldir_t filldir)
 {
 	struct hppfs_private *data = file->private_data;
-	struct file *proc_file = &data->proc_file;
+	struct file *proc_file = data->proc_file;
 	int (*readdir)(struct file *, void *, filldir_t);
 	struct hppfs_dirent dirent = ((struct hppfs_dirent)
 		                      { .vfs_dirent  	= ent,
_
