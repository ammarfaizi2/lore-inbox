Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752107AbWCNNAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWCNNAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWCNNAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:00:00 -0500
Received: from thunk.org ([69.25.196.29]:41865 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1752107AbWCNM77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:59:59 -0500
Date: Tue, 14 Mar 2006 07:59:55 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix backwards meaning of MS_VERBOSE
Message-ID: <20060314125955.GA16264@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200603132218.39511.rob@landley.net> <20060313231407.7606f0d3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313231407.7606f0d3.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 11:14:07PM -0800, Andrew Morton wrote:
> >  VFS: Can't find ext3 filesystem on dev loop0.
> 
> That's only printed if the sys_mount() caller set MS_VERBOSE in `flags'.

Well, that and the "ext3: No journal on filesystem on %s" message
which Rob also complained about...

I was just looking at this, and it seemed counterintuitive that
setting the MS_VERBOSE flag actually means "don't be verbose"; but
indeed, this is the way things are, and it's consistently defined as
such, starting with fs/super.c and propgated down into all of the
various filesystem fs/*/super.c which copied that bit of code.

Interestingly, mount doesn't have a way of setting the MS_VERBOSE
flag, but it *does* have the following:

#ifdef MS_SILENT
  { "quiet",	0, 0, MS_SILENT    },	/* be quiet  */
  { "loud",	0, 1, MS_SILENT    },	/* print out messages. */
#endif

.... and fs.h doesn't define MS_SILENT, although it does define the
MS_VERBOSE flag which has the exact opposite meaning.

So....   any objections to the following?

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Index: 2.6.16-rc5/include/linux/fs.h
===================================================================
--- 2.6.16-rc5.orig/include/linux/fs.h	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/include/linux/fs.h	2006-03-14 07:32:10.000000000 -0500
@@ -102,7 +102,9 @@
 #define MS_BIND		4096
 #define MS_MOVE		8192
 #define MS_REC		16384
-#define MS_VERBOSE	32768
+#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
+				   MS_VERBOSE is deprecated. */
+#define MS_SILENT	32768
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
 #define MS_PRIVATE	(1<<18)	/* change to private */
Index: 2.6.16-rc5/fs/super.c
===================================================================
--- 2.6.16-rc5.orig/fs/super.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/super.c	2006-03-14 07:54:38.000000000 -0500
@@ -712,7 +712,7 @@
 		s->s_flags = flags;
 		strlcpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
 		sb_set_blocksize(s, block_size(bdev));
-		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
@@ -756,7 +756,7 @@
 
 	s->s_flags = flags;
 
-	error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+	error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
@@ -785,7 +785,7 @@
 		return s;
 	if (!s->s_root) {
 		s->s_flags = flags;
-		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+		error = fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
Index: 2.6.16-rc5/fs/afs/super.c
===================================================================
--- 2.6.16-rc5.orig/fs/afs/super.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/afs/super.c	2006-03-14 07:32:10.000000000 -0500
@@ -341,7 +341,7 @@
 
 	sb->s_flags = flags;
 
-	ret = afs_fill_super(sb, &params, flags & MS_VERBOSE ? 1 : 0);
+	ret = afs_fill_super(sb, &params, flags & MS_SILENT ? 1 : 0);
 	if (ret < 0) {
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
Index: 2.6.16-rc5/fs/cifs/cifsfs.c
===================================================================
--- 2.6.16-rc5.orig/fs/cifs/cifsfs.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/cifs/cifsfs.c	2006-03-14 07:32:10.000000000 -0500
@@ -479,7 +479,7 @@
 
 	sb->s_flags = flags;
 
-	rc = cifs_read_super(sb, data, dev_name, flags & MS_VERBOSE ? 1 : 0);
+	rc = cifs_read_super(sb, data, dev_name, flags & MS_SILENT ? 1 : 0);
 	if (rc) {
 		up_write(&sb->s_umount);
 		deactivate_super(sb);
Index: 2.6.16-rc5/fs/jffs2/super.c
===================================================================
--- 2.6.16-rc5.orig/fs/jffs2/super.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/jffs2/super.c	2006-03-14 07:54:08.000000000 -0500
@@ -152,7 +152,7 @@
 	sb->s_op = &jffs2_super_operations;
 	sb->s_flags = flags | MS_NOATIME;
 
-	ret = jffs2_do_fill_super(sb, data, (flags&MS_VERBOSE)?1:0);
+	ret = jffs2_do_fill_super(sb, data, flags & MS_SILENT ? 1 : 0);
 
 	if (ret) {
 		/* Failure case... */
@@ -257,7 +257,7 @@
 	}
 
 	if (imajor(nd.dentry->d_inode) != MTD_BLOCK_MAJOR) {
-		if (!(flags & MS_VERBOSE)) /* Yes I mean this. Strangely */
+		if (!(flags & MS_SILENT))
 			printk(KERN_NOTICE "Attempt to mount non-MTD device \"%s\" as JFFS2\n",
 			       dev_name);
 		goto out;
Index: 2.6.16-rc5/fs/nfs/inode.c
===================================================================
--- 2.6.16-rc5.orig/fs/nfs/inode.c	2006-03-14 07:31:33.000000000 -0500
+++ 2.6.16-rc5/fs/nfs/inode.c	2006-03-14 07:53:28.000000000 -0500
@@ -1679,7 +1679,7 @@
 
 	s->s_flags = flags;
 
-	error = nfs_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+	error = nfs_fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
@@ -1996,7 +1996,7 @@
 
 	s->s_flags = flags;
 
-	error = nfs4_fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
+	error = nfs4_fill_super(s, data, flags & MS_SILENT ? 1 : 0);
 	if (error) {
 		up_write(&s->s_umount);
 		deactivate_super(s);
Index: 2.6.16-rc5/init/do_mounts.c
===================================================================
--- 2.6.16-rc5.orig/init/do_mounts.c	2006-03-11 22:17:00.000000000 -0500
+++ 2.6.16-rc5/init/do_mounts.c	2006-03-14 07:56:49.000000000 -0500
@@ -19,7 +19,7 @@
 
 int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
 
-int root_mountflags = MS_RDONLY | MS_VERBOSE;
+int root_mountflags = MS_RDONLY | MS_SILENT;
 char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
 
