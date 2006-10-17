Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWJQQSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWJQQSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWJQQSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:18:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751273AbWJQQSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:18:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200610161658.58288.ak@suse.de> 
References: <200610161658.58288.ak@suse.de> 
To: Andi Kleen <ak@suse.de>, Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: AUTOFS3: Make sure all dentries refs are released before calling kill_anon_super()
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 17 Oct 2006 17:18:02 +0100
Message-ID: <20312.1161101882@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sure all dentries refs are released before calling kill_anon_super() so
that the assumption that generic_shutdown_super() can completely destroy the
dentry tree for there will be no external references holds true.

What was being done in the put_super() superblock op, is now done in the
kill_sb() filesystem op instead, prior to calling kill_anon_super().

The call to shrink_dcache_sb() is removed as it is redundant since
shrink_dcache_for_umount() will now be called after the cleanup routine.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs/autofs_i.h |    1 +
 fs/autofs/dirhash.c  |    1 -
 fs/autofs/init.c     |    2 +-
 fs/autofs/inode.c    |    4 ++--
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index c7700d9..906ba5c 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -149,6 +149,7 @@ extern const struct file_operations auto
 /* Initializing function */
 
 int autofs_fill_super(struct super_block *, void *, int);
+void autofs_kill_sb(struct super_block *sb);
 
 /* Queue management functions */
 
diff --git a/fs/autofs/dirhash.c b/fs/autofs/dirhash.c
index 3fded38..bf8c8af 100644
--- a/fs/autofs/dirhash.c
+++ b/fs/autofs/dirhash.c
@@ -246,5 +246,4 @@ void autofs_hash_nuke(struct autofs_sb_i
 			kfree(ent);
 		}
 	}
-	shrink_dcache_sb(sbi->sb);
 }
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index aca1237..cea5219 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -24,7 +24,7 @@ static struct file_system_type autofs_fs
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.get_sb		= autofs_get_sb,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= autofs_kill_sb,
 };
 
 static int __init init_autofs_fs(void)
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 2c9759b..54c518c 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -20,7 +20,7 @@ #include <linux/magic.h>
 #include "autofs_i.h"
 #include <linux/module.h>
 
-static void autofs_put_super(struct super_block *sb)
+void autofs_kill_sb(struct super_block *sb)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(sb);
 	unsigned int n;
@@ -37,13 +37,13 @@ static void autofs_put_super(struct supe
 	kfree(sb->s_fs_info);
 
 	DPRINTK(("autofs: shutting down\n"));
+	kill_anon_super(sb);
 }
 
 static void autofs_read_inode(struct inode *inode);
 
 static struct super_operations autofs_sops = {
 	.read_inode	= autofs_read_inode,
-	.put_super	= autofs_put_super,
 	.statfs		= simple_statfs,
 };
 
