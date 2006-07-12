Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWGLQla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWGLQla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWGLQla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:41:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:20153 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751354AbWGLQl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:41:28 -0400
Message-ID: <44B52674.8060802@suse.com>
Date: Wed, 12 Jul 2006 12:42:28 -0400
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] reiserfs: fix handling of device names with /'s in them
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

 On systems with block devices containing slashes (virtual dasd, cciss,
 etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
 it being interpreted as a subdirectory. The generic block device code
 changes the / to ! for use in the sysfs tree. This patch uses that
 convention.

 Tested by making dm devices use dm/<number> rather than dm-<number>

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

- --

 fs/reiserfs/procfs.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff -ruNp linux-2.6.17.orig/fs/reiserfs/procfs.c linux-2.6.17.orig.devel/fs/reiserfs/procfs.c
- --- linux-2.6.17.orig/fs/reiserfs/procfs.c	2006-07-12 11:58:56.000000000 -0400
+++ linux-2.6.17.orig.devel/fs/reiserfs/procfs.c	2006-07-12 12:39:17.000000000 -0400
@@ -493,9 +493,17 @@ static void add_file(struct super_block 
 
 int reiserfs_proc_info_init(struct super_block *sb)
 {
+	char bdev[BDEVNAME_SIZE];
+	char *s;
+
+	/* Some block devices use /'s */
+	strlcpy(bdev, reiserfs_bdevname(sb), BDEVNAME_SIZE);
+	s = strchr(bdev, '/');
+	if (s)
+		*s = '!';
+
 	spin_lock_init(&__PINFO(sb).lock);
- -	REISERFS_SB(sb)->procdir =
- -	    proc_mkdir(reiserfs_bdevname(sb), proc_info_root);
+	REISERFS_SB(sb)->procdir = proc_mkdir(bdev, proc_info_root);
 	if (REISERFS_SB(sb)->procdir) {
 		REISERFS_SB(sb)->procdir->owner = THIS_MODULE;
 		REISERFS_SB(sb)->procdir->data = sb;
@@ -509,13 +517,22 @@ int reiserfs_proc_info_init(struct super
 		return 0;
 	}
 	reiserfs_warning(sb, "reiserfs: cannot create /proc/%s/%s",
- -			 proc_info_root_name, reiserfs_bdevname(sb));
+			 proc_info_root_name, bdev);
 	return 1;
 }
 
 int reiserfs_proc_info_done(struct super_block *sb)
 {
 	struct proc_dir_entry *de = REISERFS_SB(sb)->procdir;
+	char bdev[BDEVNAME_SIZE];
+	char *s;
+
+	/* Some block devices use /'s */
+	strlcpy(bdev, reiserfs_bdevname(sb), BDEVNAME_SIZE);
+	s = strchr(bdev, '/');
+	if (s)
+		*s = '!';
+
 	if (de) {
 		remove_proc_entry("journal", de);
 		remove_proc_entry("oidmap", de);
@@ -529,7 +546,7 @@ int reiserfs_proc_info_done(struct super
 	__PINFO(sb).exiting = 1;
 	spin_unlock(&__PINFO(sb).lock);
 	if (proc_info_root) {
- -		remove_proc_entry(reiserfs_bdevname(sb), proc_info_root);
+		remove_proc_entry(bdev, proc_info_root);
 		REISERFS_SB(sb)->procdir = NULL;
 	}
 	return 0;

- -- 
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEtSZ0LPWxlyuTD7IRAkfVAJoChixL9icBa5tpe+A9cqE4OdohywCfVW0f
RgF2ffZyXik8NuDy/m0kXUc=
=X3VE
-----END PGP SIGNATURE-----
