Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTFHKsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 06:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTFHKsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 06:48:39 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32516 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261422AbTFHKsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 06:48:37 -0400
Date: Sun, 8 Jun 2003 12:01:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: lord@sgi.com, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm5: XFS compile error if CONFIG_SYSCTL && !CONFIG_PROC_FS
Message-ID: <20030608120159.A450@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, lord@sgi.com, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20030607140844.GM15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030607140844.GM15311@fs.tum.de>; from bunk@fs.tum.de on Sat, Jun 07, 2003 at 04:08:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 04:08:44PM +0200, Adrian Bunk wrote:
> I'm getting the following compile error in 2.5.70-mm5 if CONFIG_SYSCTL 
> && !CONFIG_PROC_FS:
> 
> <--  snip  -->
> 
> ...
>   CC      fs/xfs/linux/xfs_sysctl.o
> fs/xfs/linux/xfs_sysctl.c: In function `xfs_stats_clear_proc_handler':
> fs/xfs/linux/xfs_sysctl.c:61: `xfsstats' undeclared (first use in this function)
> fs/xfs/linux/xfs_sysctl.c:61: (Each undeclared identifier is reported only once
> fs/xfs/linux/xfs_sysctl.c:61: for each function it appears in.)
> make[2]: *** [fs/xfs/linux/xfs_sysctl.o] Error 1

This should fix it:


--- 1.10/fs/xfs/linux/xfs_sysctl.c	Mon May 19 20:29:41 2003
+++ edited/fs/xfs/linux/xfs_sysctl.c	Sat Jun  7 12:01:27 2003
@@ -36,12 +36,12 @@
 #include <linux/proc_fs.h>
 
 
-STATIC ulong xfs_min[XFS_PARAM] = { 0, 0, 0, 0, 0,   0, HZ };
-STATIC ulong xfs_max[XFS_PARAM] = { 1, 1, 1, 1, 127, 3, HZ * 60 };
+STATIC ulong xfs_min[XFS_PARAM] = { 0, 0, 0, 0, 0, HZ, 0 };
+STATIC ulong xfs_max[XFS_PARAM] = {  1, 1, 1, 127, 3, HZ * 60, 1 };
 
 static struct ctl_table_header *xfs_table_header;
 
-
+#ifdef CONFIG_PROC_FS
 STATIC int
 xfs_stats_clear_proc_handler(
 	ctl_table	*ctl,
@@ -66,35 +66,39 @@
 
 	return ret;
 }
+#endif /* CONFIG_PROC_FS */
 
 STATIC ctl_table xfs_table[] = {
-	{XFS_STATS_CLEAR, "stats_clear", &xfs_params.stats_clear,
-	sizeof(ulong), 0644, NULL, &xfs_stats_clear_proc_handler,
-	&sysctl_intvec, NULL, &xfs_min[0], &xfs_max[0]},
-
 	{XFS_RESTRICT_CHOWN, "restrict_chown", &xfs_params.restrict_chown,
 	sizeof(ulong), 0644, NULL, &proc_doulongvec_minmax,
-	&sysctl_intvec, NULL, &xfs_min[1], &xfs_max[1]},
+	&sysctl_intvec, NULL, &xfs_min[0], &xfs_max[0]},
 
 	{XFS_SGID_INHERIT, "irix_sgid_inherit", &xfs_params.sgid_inherit,
 	sizeof(ulong), 0644, NULL, &proc_doulongvec_minmax,
-	&sysctl_intvec, NULL, &xfs_min[2], &xfs_max[2]},
+	&sysctl_intvec, NULL, &xfs_min[1], &xfs_max[1]},
 
 	{XFS_SYMLINK_MODE, "irix_symlink_mode", &xfs_params.symlink_mode,
 	sizeof(ulong), 0644, NULL, &proc_doulongvec_minmax,
-	&sysctl_intvec, NULL, &xfs_min[3], &xfs_max[3]},
+	&sysctl_intvec, NULL, &xfs_min[2], &xfs_max[2]},
 
 	{XFS_PANIC_MASK, "panic_mask", &xfs_params.panic_mask,
 	sizeof(ulong), 0644, NULL, &proc_doulongvec_minmax,
-	&sysctl_intvec, NULL, &xfs_min[4], &xfs_max[4]},
+	&sysctl_intvec, NULL, &xfs_min[3], &xfs_max[3]},
 
 	{XFS_ERRLEVEL, "error_level", &xfs_params.error_level,
 	sizeof(ulong), 0644, NULL, &proc_doulongvec_minmax,
-	&sysctl_intvec, NULL, &xfs_min[5], &xfs_max[5]},
+	&sysctl_intvec, NULL, &xfs_min[4], &xfs_max[4]},
 
 	{XFS_SYNC_INTERVAL, "sync_interval", &xfs_params.sync_interval,
 	sizeof(ulong), 0644, NULL, &proc_doulongvec_minmax,
+	&sysctl_intvec, NULL, &xfs_min[5], &xfs_max[5]},
+
+	/* please keep this the last entry */
+#ifdef CONFIG_PROC_FS
+	{XFS_STATS_CLEAR, "stats_clear", &xfs_params.stats_clear,
+	sizeof(ulong), 0644, NULL, &xfs_stats_clear_proc_handler,
 	&sysctl_intvec, NULL, &xfs_min[6], &xfs_max[6]},
+#endif
 
 	{0}
 };
===== fs/xfs/linux/xfs_sysctl.h 1.8 vs edited =====
--- 1.8/fs/xfs/linux/xfs_sysctl.h	Mon May 19 20:29:41 2003
+++ edited/fs/xfs/linux/xfs_sysctl.h	Sat Jun  7 12:01:07 2003
@@ -42,7 +42,6 @@
 #define XFS_PARAM	(sizeof(struct xfs_param) / sizeof(ulong))
 
 typedef struct xfs_param {
-	ulong	stats_clear;	/* Reset all XFS statistics to zero.     */
 	ulong	restrict_chown;	/* Root/non-root can give away files.    */
 	ulong	sgid_inherit;	/* Inherit ISGID bit if process' GID is  */
 				/*  not a member of the parent dir GID.  */
@@ -50,6 +49,7 @@
 	ulong	panic_mask;	/* bitmask to specify panics on errors.  */
 	ulong	error_level;	/* Degree of reporting for internal probs*/
 	ulong	sync_interval;	/* time between sync calls		 */
+	ulong	stats_clear;	/* Reset all XFS statistics to zero.     */
 } xfs_param_t;
 
 /*
@@ -68,13 +68,13 @@
  */
 
 enum {
-	XFS_STATS_CLEAR = 1,
-	XFS_RESTRICT_CHOWN = 2,
-	XFS_SGID_INHERIT = 3,
-	XFS_SYMLINK_MODE = 4,
-	XFS_PANIC_MASK = 5,
-	XFS_ERRLEVEL = 6,
-	XFS_SYNC_INTERVAL = 7,
+	XFS_RESTRICT_CHOWN = 1,
+	XFS_SGID_INHERIT = 2,
+	XFS_SYMLINK_MODE = 3,
+	XFS_PANIC_MASK = 4,
+	XFS_ERRLEVEL = 5,
+	XFS_SYNC_INTERVAL = 6,
+	XFS_STATS_CLEAR = 7,
 };
 
 extern xfs_param_t	xfs_params;
