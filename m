Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWAEPjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWAEPjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWAEPjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:39:16 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50386 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932115AbWAEPjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:39:07 -0500
Date: Thu, 5 Jan 2006 16:38:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 16/21] mutex subsystem, semaphore to mutex: VFS, sb->s_lock
Message-ID: <20060105153857.GQ31013@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch converts the superblock-lock semaphore to a mutex, affecting
lock_super()/unlock_super(). Tested on ext3 and XFS.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 fs/ext3/super.c    |    2 +-
 fs/super.c         |    2 +-
 include/linux/fs.h |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/fs/ext3/super.c
===================================================================
--- linux.orig/fs/ext3/super.c
+++ linux/fs/ext3/super.c
@@ -2116,7 +2116,7 @@ int ext3_force_commit(struct super_block
 
 static void ext3_write_super (struct super_block * sb)
 {
-	if (down_trylock(&sb->s_lock) == 0)
+	if (mutex_trylock(&sb->s_lock) != 0)
 		BUG();
 	sb->s_dirt = 0;
 }
Index: linux/fs/super.c
===================================================================
--- linux.orig/fs/super.c
+++ linux/fs/super.c
@@ -72,7 +72,7 @@ static struct super_block *alloc_super(v
 		INIT_HLIST_HEAD(&s->s_anon);
 		INIT_LIST_HEAD(&s->s_inodes);
 		init_rwsem(&s->s_umount);
-		sema_init(&s->s_lock, 1);
+		mutex_init(&s->s_lock);
 		down_write(&s->s_umount);
 		s->s_count = S_BIAS;
 		atomic_set(&s->s_active, 1);
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -791,7 +791,7 @@ struct super_block {
 	unsigned long		s_magic;
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
-	struct semaphore	s_lock;
+	struct mutex		s_lock;
 	int			s_count;
 	int			s_syncing;
 	int			s_need_sync_fs;
@@ -863,13 +863,13 @@ static inline int has_fs_excl(void)
 static inline void lock_super(struct super_block * sb)
 {
 	get_fs_excl();
-	down(&sb->s_lock);
+	mutex_lock(&sb->s_lock);
 }
 
 static inline void unlock_super(struct super_block * sb)
 {
 	put_fs_excl();
-	up(&sb->s_lock);
+	mutex_unlock(&sb->s_lock);
 }
 
 /*
