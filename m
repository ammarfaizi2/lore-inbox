Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWHQNqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWHQNqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWHQNqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:46:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5285 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964998AbWHQNp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:45:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060817004219.44c45bbd.akpm@osdl.org> 
References: <20060817004219.44c45bbd.akpm@osdl.org>  <1155743399.5683.13.camel@localhost> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <5910.1155741329@warthog.cambridge.redhat.com> <13319.1155744959@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 17 Aug 2006 14:45:48 +0100
Message-ID: <9117.1155822348@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> VFS: Busy inodes after unmount of 0:15. Self-destruct in 5 seconds.  Have a
> nice day...

And can you apply this patch as well please?  It should give more information
about the problem.

David
---
VFS: Print more detail on "Busy inode after unmount" messages

From: David Howells <dhowells@redhat.com>

Print more detail on "Busy inode after unmount" messages.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/super.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3bf8e5f..ed853c4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -219,6 +219,33 @@ static int grab_super(struct super_block
 	return 0;
 }
 
+static void super_still_busy(struct super_block *sb)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	int limit;
+
+	printk("VFS: Busy inodes after unmount of %s. "
+	       "Self-destruct in 5 seconds.  Have a nice day...\n",
+	       sb->s_id);
+
+	limit = 24;
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		printk(KERN_ERR "- inode %p{ino=%lx,c=#%d}\n",
+		       inode, inode->i_ino, atomic_read(&inode->i_count));
+		if (--limit <= 0)
+			return;
+
+		list_for_each_entry(dentry, &inode->i_dentry, d_alias) {
+			printk(KERN_ERR "  - dentry %p{'%s',c=#%d}\n",
+			       dentry, dentry->d_name.name,
+			       atomic_read(&inode->i_count));
+			if (--limit <= 0)
+				return;
+		}
+	}
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -252,11 +279,8 @@ void generic_shutdown_super(struct super
 			sop->put_super(sb);
 
 		/* Forget any remaining inodes */
-		if (invalidate_inodes(sb)) {
-			printk("VFS: Busy inodes after unmount of %s. "
-			   "Self-destruct in 5 seconds.  Have a nice day...\n",
-			   sb->s_id);
-		}
+		if (unlikely(invalidate_inodes(sb)))
+			super_still_busy(sb);
 
 		unlock_kernel();
 		unlock_super(sb);
