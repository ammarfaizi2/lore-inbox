Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUCATxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 14:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUCATxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 14:53:08 -0500
Received: from fungus.teststation.com ([212.32.186.211]:59917 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261409AbUCATxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 14:53:01 -0500
Date: Mon, 1 Mar 2004 20:52:01 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: James Morris <jmorris@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [SELINUX] Handle fuse binary mount data.
In-Reply-To: <Xine.LNX.4.44.0403010809470.24584-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0403011903310.23010-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004, James Morris wrote:

> Well, smb_fill_super() looks like it is dealing with binary mount data 
> initially, and we need to treat it as such.  This should be fixed properly 
> so that different versions of smbfs have different filesystem types, like 
> NFS.

There are no different versions of smbfs, and nfs does not have different
filesystem types for v2 and v3.

The thing smbfs does first is to check if it is binary or ascii^Wutf-8 by
looking at the first 4 bytes which is guaranteed by smbmount to be
(int)6 or the beginning of a string "vers".

I'm not seriously suggesting it, but if the selinux code always passed the
full page of mount data unchanged if it didn't find any of its flags then
it should be ok (in this case) to not mark smbfs as using a binary mount
data. And couldn't that work with all the binary filesystems without
adding any flags?

If smb_get_sb could map to a different "struct file_system_type" from what
it gets from the VFS that should work. Code below is not to be applied to
anything by anyone (yes, that means you Andrew :)

Seems easier to just disable the old smbmounts from working.

/Urban


diff -urN -X exclude linux-2.6.3-rc1-orig/fs/smbfs/inode.c linux-2.6.3-rc1-smbfs/fs/smbfs/inode.c
--- linux-2.6.3-rc1-orig/fs/smbfs/inode.c	Mon Feb  9 19:25:13 2004
+++ linux-2.6.3-rc1-smbfs/fs/smbfs/inode.c	Mon Mar  1 19:58:23 2004
@@ -770,6 +770,19 @@
 static struct super_block *smb_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
+	struct super_block *sb;
+	struct smb_mount_data *oldmnt;
+	int ver;
+
+	oldmnt = (struct smb_mount_data *) data;
+	ver = oldmnt->version;
+	if (ver == SMB_MOUNT_OLDVERSION) {
+		struct file_system_type *type = get_fs_type("smbfs_binary");
+		sb = get_sb_nodev(type, flags, data, smb_fill_super);
+		put_filesystem(type);
+		return sb;
+	}
+
 	return get_sb_nodev(fs_type, flags, data, smb_fill_super);
 }
 
@@ -780,6 +793,14 @@
 	.kill_sb	= kill_anon_super,
 };
 
+static struct file_system_type smb_fs_type_binary = {
+	.owner		= THIS_MODULE,
+	.name		= "smbfs_binary",
+	.get_sb		= smb_get_sb,
+	.kill_sb	= kill_anon_super,
+	.fs_flags	= FS_BINARY_MOUNTDATA,
+};
+
 static int __init init_smb_fs(void)
 {
 	int err;
@@ -799,9 +820,14 @@
 		goto out_request;
 	err = register_filesystem(&smb_fs_type);
 	if (err)
+		goto out_register;
+	err = register_filesystem(&smb_fs_type_binary);
+	if (err)
 		goto out;
 	return 0;
 out:
+	unregister_filesystem(&smb_fs_type);
+out_register:
 	smb_destroy_request_cache();
 out_request:
 	destroy_inodecache();
@@ -813,6 +839,7 @@
 {
 	DEBUG1("unregistering ...\n");
 	unregister_filesystem(&smb_fs_type);
+	unregister_filesystem(&smb_fs_type_binary);
 	smb_destroy_request_cache();
 	destroy_inodecache();
 #ifdef DEBUG_SMB_MALLOC

