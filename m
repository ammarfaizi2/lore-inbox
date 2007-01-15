Return-Path: <linux-kernel-owner+w=401wt.eu-S1751290AbXAOVx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXAOVx0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXAOVx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:53:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:7752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbXAOVxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:53:25 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=PGMl0WhnH4P5sBWZE12ea7Bc9iIhK4UY6Ic4c0KsTp6PilDp/P2VJVHRl6u4azThygcpx34VK6y06ntCHgqU+BKwMWEhzRaDcdPU13feV62X2SLYCTHDsYqmJ1D2b6fysIQefFP5yQz+aHoJYtNHmYfl0lGa4455J6mAi6iNaU0=
Date: Tue, 16 Jan 2007 00:53:05 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jaharkes@cs.cmu.edu
Subject: [PATCH] seq_file conversion: coda
Message-ID: <20070115215305.GC5010@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-tested.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/coda/sysctl.c |   76 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -15,6 +15,7 @@ #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/ctype.h>
@@ -84,15 +85,11 @@ static int do_reset_coda_cache_inv_stats
 	return 0;
 }
 
-static int coda_vfs_stats_get_info( char * buffer, char ** start,
-				    off_t offset, int length)
+static int proc_vfs_stats_show(struct seq_file *m, void *v)
 {
-	int len=0;
-	off_t begin;
 	struct coda_vfs_stats * ps = & coda_vfs_stat;
   
-  /* this works as long as we are below 1024 characters! */
-	len += sprintf( buffer,
+	seq_printf(m,
 			"Coda VFS statistics\n"
 			"===================\n\n"
 			"File Operations:\n"
@@ -132,28 +129,14 @@ static int coda_vfs_stats_get_info( char
 			ps->rmdir,
 			ps->rename,
 			ps->permission); 
-
-	begin = offset;
-	*start = buffer + begin;
-	len -= begin;
-
-	if ( len > length )
-		len = length;
-	if ( len < 0 )
-		len = 0;
-
-	return len;
+	return 0;
 }
 
-static int coda_cache_inv_stats_get_info( char * buffer, char ** start,
-					  off_t offset, int length)
+static int proc_cache_inv_stats_show(struct seq_file *m, void *v)
 {
-	int len=0;
-	off_t begin;
 	struct coda_cache_inv_stats * ps = & coda_cache_inv_stat;
   
-	/* this works as long as we are below 1024 characters! */
-	len += sprintf( buffer,
+	seq_printf(m,
 			"Coda cache invalidation statistics\n"
 			"==================================\n\n"
 			"flush\t\t%9d\n"
@@ -170,19 +153,35 @@ static int coda_cache_inv_stats_get_info
 			ps->zap_vnode,
 			ps->purge_fid,
 			ps->replace );
-  
-	begin = offset;
-	*start = buffer + begin;
-	len -= begin;
+	return 0;
+}
 
-	if ( len > length )
-		len = length;
-	if ( len < 0 )
-		len = 0;
+static int proc_vfs_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_vfs_stats_show, NULL);
+}
 
-	return len;
+static int proc_cache_inv_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_cache_inv_stats_show, NULL);
 }
 
+static const struct file_operations proc_vfs_stats_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_vfs_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_cache_inv_stats_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_cache_inv_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ctl_table coda_table[] = {
  	{CODA_TIMEOUT, "timeout", &coda_timeout, sizeof(int), 0644, NULL, &proc_dointvec},
  	{CODA_HARD, "hard", &coda_hard, sizeof(int), 0644, NULL, &proc_dointvec},
@@ -212,9 +211,6 @@ static struct proc_dir_entry* proc_fs_co
 
 #endif
 
-#define coda_proc_create(name,get_info) \
-	create_proc_info_entry(name, 0, proc_fs_coda, get_info)
-
 void coda_sysctl_init(void)
 {
 	reset_coda_vfs_stats();
@@ -223,9 +219,15 @@ void coda_sysctl_init(void)
 #ifdef CONFIG_PROC_FS
 	proc_fs_coda = proc_mkdir("coda", proc_root_fs);
 	if (proc_fs_coda) {
+		struct proc_dir_entry *pde;
+
 		proc_fs_coda->owner = THIS_MODULE;
-		coda_proc_create("vfs_stats", coda_vfs_stats_get_info);
-		coda_proc_create("cache_inv_stats", coda_cache_inv_stats_get_info);
+		pde = create_proc_entry("vfs_stats", 0, proc_fs_coda);
+		if (pde)
+			pde->proc_fops = &proc_vfs_stats_fops;
+		pde = create_proc_entry("cache_inv_stats", 0, proc_fs_coda);
+		if (pde)
+			pde->proc_fops = &proc_cache_inv_stats_fops;
 	}
 #endif
 

