Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUINJqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUINJqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269090AbUINJqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:46:53 -0400
Received: from asplinux.ru ([195.133.213.194]:15621 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S269241AbUINJqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:46:00 -0400
Message-ID: <4146C093.3070904@sw.ru>
Date: Tue, 14 Sep 2004 13:57:39 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: mason@suse.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix of race in writeback_inodes()
Content-Type: multipart/mixed;
 boundary="------------040807090300020803050702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040807090300020803050702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes race in writeback_inodes() described below:

writeback_inodes()
{
     ....
     sb->s_count++;
     spin_unlock(&sb_lock);
     ....
     spin_lock(&sb_lock);
     if (__put_super(sb))        <<< X
         goto restart;
     }
}

deactivate_super()
{
     fs->kill_sb(s);
         kill_block_super(sb)
             generic_shutdown_super(sb)
                     spin_lock(&sb_lock);
                     list_del(&sb->s_list);    <<< Y
                     spin_unlock(&sb_lock);
     ....
     put_super(s);
             spin_lock(&sb_lock);
             __put_super(sb);            <<< Z
             spin_unlock(&sb_lock);
}

The problem with it is that writeback_inodes() supposes that if 
__put_super() returns 0 then no super block was deleted from the list 
and we can safely traverse sb list further.

But as it is obvious from the deactivate_super() it's not actually true. 
because at point Y we delete super block from the list and drop the 
lock. We do __put_super() very much later... So we can find sb with 
poisoned sb->s_list at point X and we won't be the last sb reference 
holders. The last reference will be dropped in point Z.

So in case of the following sequence of execution Y -> X -> Z we'll get 
an oops after point X in writeback_inodes().

This patch introduces __put_super_and_need_restart() function which 
allows safe traversing of sb list. I'll send a couple of patches later 
which remove O(n^2) algos and using this function.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------040807090300020803050702
Content-Type: text/plain;
 name="diff-sb-race"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-sb-race"

--- ./include/linux/fs.h.sbrace	2004-09-14 13:33:55.835241408 +0400
+++ ./include/linux/fs.h	2004-09-14 13:33:20.065679208 +0400
@@ -1129,6 +1129,7 @@ struct super_block *sget(struct file_sys
 struct super_block *get_sb_pseudo(struct file_system_type *, char *,
 			struct super_operations *ops, unsigned long);
 int __put_super(struct super_block *sb);
+int __put_super_and_need_restart(struct super_block *sb);
 void unnamed_dev_init(void);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
--- ./fs/super.c.sbrace	2004-08-14 14:55:22.000000000 +0400
+++ ./fs/super.c	2004-09-14 13:20:22.365907544 +0400
@@ -116,6 +116,27 @@ int __put_super(struct super_block *sb)
 	return ret;
 }
 
+/*
+ * Drop a superblock's refcount.
+ * Returns non-zero if the superblock is about to be destroyed and
+ * at least is already removed from super_blocks list, so if we are
+ * making a loop through super blocks then we need to restart.
+ * The caller must hold sb_lock.
+ */
+int __put_super_and_need_restart(struct super_block *sb)
+{
+	/* check for race with generic_shutdown_super() */
+	if (list_empty(&sb->s_list)) {
+		/* super block is removed, need to restart... */
+		__put_super(sb);
+		return 1;
+	}
+	/* can't be the last, since s_list is still in use */
+	sb->s_count--;
+	BUG_ON(sb->s_count == 0);
+	return 0;
+}
+
 /**
  *	put_super	-	drop a temporary reference to superblock
  *	@s: superblock in question
@@ -229,7 +250,8 @@ void generic_shutdown_super(struct super
 		unlock_super(sb);
 	}
 	spin_lock(&sb_lock);
-	list_del(&sb->s_list);
+	/* should be initialized for __put_super_and_need_restart() */
+	list_del_init(&sb->s_list);
 	list_del(&sb->s_instances);
 	spin_unlock(&sb_lock);
 	up_write(&sb->s_umount);
@@ -282,7 +304,7 @@ retry:
 	}
 	s->s_type = type;
 	strlcpy(s->s_id, type->name, sizeof(s->s_id));
-	list_add(&s->s_list, super_blocks.prev);
+	list_add_tail(&s->s_list, &super_blocks);
 	list_add(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
--- ./fs/fs-writeback.c.sbrace	2004-08-14 14:56:24.000000000 +0400
+++ ./fs/fs-writeback.c	2004-09-14 13:53:44.258573600 +0400
@@ -412,7 +412,7 @@ restart:
 				up_read(&sb->s_umount);
 			}
 			spin_lock(&sb_lock);
-			if (__put_super(sb))
+			if (__put_super_and_need_restart(sb))
 				goto restart;
 		}
 		if (wbc->nr_to_write <= 0)

--------------040807090300020803050702--

