Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVBQV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVBQV3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVBQV3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:29:41 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:61099 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261182AbVBQV24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 16:28:56 -0500
Date: Thu, 17 Feb 2005 22:28:52 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] remove mount option parsing from procfs
Message-ID: <20050217212852.GA24102@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, my previous patches on the subject were _so_ bad that noone even
bothered to flame me.  Here's an attempt to fix this. :]

This patch removes the mount options of the proc filesystem.  They don't
have any effect since 2.4.something.

Explanation: Only proc_fill_super() calls parse_options, notably
proc_remount() does not.  And proc_fill_super() is only called at the
very first mount which in turn is the one caused by kern_mount() in
fs/proc/root.c and that passes a NULL pointer as mount options
string.  It is called only once because proc is a filesystem with a
single super_block (i.e. it uses get_sb_single()).

Since noone seems to miss the uid and gid options so far I suggest to
simply remove them.  Their function can be easily performed in
userspace.  E.g. this (if it worked like intended):

    # mount -t proc -o uid=procuser,gid=procgrp proc /proc

can be done like so, probably in some init script:

    # mount -t proc proc /proc && chown procuser:procgrp /proc

But I don't see why anyone would want to do that in the first place.

Comments?

Rene


--- linux-2.6.11-rc4/fs/proc/inode.c~	2005-02-05 03:21:58.000000000 +0100
+++ linux-2.6.11-rc4/fs/proc/inode.c	2005-02-11 05:33:47.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/parser.h>
 #include <linux/smp_lock.h>
 
 #include <asm/system.h>
@@ -143,51 +142,6 @@ static struct super_operations proc_sops
 	.remount_fs	= proc_remount,
 };
 
-enum {
-	Opt_uid, Opt_gid, Opt_err
-};
-
-static match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_err, NULL}
-};
-
-static int parse_options(char *options,uid_t *uid,gid_t *gid)
-{
-	char *p;
-	int option;
-
-	*uid = current->uid;
-	*gid = current->gid;
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(args, &option))
-				return 0;
-			*uid = option;
-			break;
-		case Opt_gid:
-			if (match_int(args, &option))
-				return 0;
-			*gid = option;
-			break;
-		default:
-			return 0;
-		}
-	}
-	return 1;
-}
-
 struct inode *proc_get_inode(struct super_block *sb, unsigned int ino,
 				struct proc_dir_entry *de)
 {
@@ -249,10 +203,11 @@ int proc_fill_super(struct super_block *
 	 * Fixup the root inode's nlink value
 	 */
 	root_inode->i_nlink += nr_processes();
+	root_inode->i_uid = 0;
+	root_inode->i_gid = 0;
 	s->s_root = d_alloc_root(root_inode);
 	if (!s->s_root)
 		goto out_no_root;
-	parse_options(data, &root_inode->i_uid, &root_inode->i_gid);
 	return 0;
 
 out_no_root:
