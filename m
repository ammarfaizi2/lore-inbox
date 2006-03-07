Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWCGLI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWCGLI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWCGLI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:08:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19352 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751551AbWCGLI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:08:56 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
To: Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix multiple blockdev-based filesystem mounts
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 07 Mar 2006 11:08:41 +0000
Message-ID: <15962.1141729721@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes multiple mounts of the same blockdev-based filesystem
(such as EXT3). The problem is that the path through the function that deals
with a second mount of an already extant superblock is going out through the
error path and not the success path that sets up the vfsmount.

The error can be checked by doing something like:

	mount /dev/hda6 /a
	mount /dev/hda6 /b

Where /dev/hda6 has something like an EXT3 filesystem on it. The second mount
should succeed, but doesn't without this patch.

This patch is dependent on the getsb patch submitted earlier.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/get_sb_bdev.diff 
 fs/super.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 7353011..8fe179e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -697,15 +697,17 @@ int get_sb_bdev(struct file_system_type 
 	s = sget(fs_type, test_bdev_super, set_bdev_super, bdev);
 	up(&bdev->bd_mount_sem);
 	if (IS_ERR(s))
-		goto out_s_error;
+		goto error_s;
 
 	if (s->s_root) {
 		if ((flags ^ s->s_flags) & MS_RDONLY) {
 			up_write(&s->s_umount);
 			deactivate_super(s);
 			error = -EBUSY;
+			goto error_bdev;
 		}
-		goto out;
+
+		close_bdev_excl(bdev);
 	} else {
 		char b[BDEVNAME_SIZE];
 
@@ -725,9 +727,9 @@ int get_sb_bdev(struct file_system_type 
 
 	return simple_set_mnt(mnt, s);
 
-out_s_error:
+error_s:
 	error = PTR_ERR(s);
-out:
+error_bdev:
 	close_bdev_excl(bdev);
 error:
 	return error;
