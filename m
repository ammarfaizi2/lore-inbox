Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbVIARtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVIARtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVIARtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:49:08 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:58384 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1030261AbVIARtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:49:07 -0400
To: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>
	<874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp>
	<87irxm83eq.fsf@devron.myhome.or.jp> <431696BB.8050104@sm.sony.co.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 02 Sep 2005 02:48:51 +0900
In-Reply-To: <431696BB.8050104@sm.sony.co.jp> (Hiroyuki Machida's message of "Thu, 01 Sep 2005 14:50:51 +0900")
Message-ID: <87hdd47k70.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Machida, Hiroyuki" <machida@sm.sony.co.jp> writes:

> Once concern about global URL in general, it tends to be occupied
> by specific pattern, like accesses from one process or to on dir.
> It prevents to realize locality.
>
> I think it's better to have limitations like;
> 	entries for same process would be limited to 2/3
> 	entries for same dir would be limited to 1/3

[...]

> Does this mean for each process recording last recent 16
> accesses to FAT file system ? If true, pid would be eliminated.
>
> I guess it's better to record nr_slots for this entry.

The fat_lookup_hint is one per task. And fat_lookup_hint is tracking
the task's access. If access is sequential, it returns the hint, and
if not, it returns 0.  I made the dirty patch just for explaining what
I said.

However, these lookup-hint approaches seems the hack after all....
Hhmmm...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fat_lookup-hint.patch



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/dir.c   |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/fat/inode.c |    2 
 2 files changed, 164 insertions(+), 4 deletions(-)

diff -puN fs/fat/dir.c~fat_lookup-hint fs/fat/dir.c
--- linux-2.6.13/fs/fat/dir.c~fat_lookup-hint	2005-09-02 01:04:47.000000000 +0900
+++ linux-2.6.13-hirofumi/fs/fat/dir.c	2005-09-02 01:06:50.000000000 +0900
@@ -22,6 +22,148 @@
 #include <linux/buffer_head.h>
 #include <asm/uaccess.h>
 
+#define FAT_LOOKUP_HINT_MAX	16
+
+struct fat_lookup_hint {
+	struct list_head lru_list;
+	pid_t pid;
+	struct super_block *sb;
+	struct inode *dir;
+	loff_t last_pos;
+#define HINT_STATE_RANDOM	1
+	int state;
+};
+
+static spinlock_t fat_lookup_hint_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(fat_lookup_hint_head);
+static int fat_lookup_hint_count;
+
+#if 0
+static int fat_lkup_hint_init(void)
+{
+	/* replace with kmem_cache */
+	return 0;
+}
+#endif
+
+static inline struct fat_lookup_hint *fat_lkup_hint_alloc(void)
+{
+	struct fat_lookup_hint *hint;
+
+	/* replace with kmem_cache */
+	hint = kmalloc(sizeof(*hint), GFP_KERNEL);
+	if (hint) {
+		INIT_LIST_HEAD(&hint->lru_list);
+		hint->pid = 0;
+		hint->sb = NULL;
+		hint->dir = NULL;
+		hint->last_pos = 0;
+	}
+	return hint;
+}
+
+static inline void fat_lkup_hint_free(struct fat_lookup_hint *hint)
+{
+	/* replace with kmem_cache */
+	BUG_ON(!list_empty(&hint->lru_list));
+	kfree(hint);
+}
+
+void fat_lkup_hint_inval(struct inode *dir)
+{
+	struct super_block *sb = dir->i_sb;
+	struct fat_lookup_hint *hint, *n;
+
+	spin_lock(&fat_lookup_hint_lock);
+	list_for_each_entry_safe(hint, n, &fat_lookup_hint_head, lru_list) {
+		if (hint->sb == sb && hint->dir == dir) {
+			list_del_init(&hint->lru_list);
+			fat_lkup_hint_free(hint);
+			fat_lookup_hint_count--;
+		}
+	}
+	spin_unlock(&fat_lookup_hint_lock);
+}
+
+#define WIN_TOP		(2 * MSDOS_SLOTS * sizeof(struct msdos_dir_entry))
+#define WIN_BOTTOM	(5 * MSDOS_SLOTS * sizeof(struct msdos_dir_entry))
+static loff_t fat_lkup_hint_get(struct inode *dir)
+{
+	struct super_block *sb = dir->i_sb;
+	struct fat_lookup_hint *hint;
+	loff_t pos = 0;
+
+	spin_lock(&fat_lookup_hint_lock);
+	list_for_each_entry(hint, &fat_lookup_hint_head, lru_list) {
+		if (hint->pid == current->pid &&
+		    hint->sb == sb &&
+		    hint->dir == dir) {
+			if (!(hint->state & HINT_STATE_RANDOM))
+				pos = hint->last_pos;
+			break;
+		}
+	}
+	spin_unlock(&fat_lookup_hint_lock);
+	return max(0LL, pos - WIN_TOP);
+}
+
+/* caller must hold dir->i_sem */
+static void fat_lkup_hint_add(struct inode *dir, loff_t pos)
+{
+	struct super_block *sb = dir->i_sb;
+	struct fat_lookup_hint *p, *hint = NULL;
+	loff_t win_start, win_end;
+
+	spin_lock(&fat_lookup_hint_lock);
+	list_for_each_entry(p, &fat_lookup_hint_head, lru_list) {
+		if (p->pid == current->pid) {
+			hint = p;
+			break;
+		}
+	}
+	if (hint == NULL) {
+		if (fat_lookup_hint_count < FAT_LOOKUP_HINT_MAX) {
+			fat_lookup_hint_count++;
+			spin_unlock(&fat_lookup_hint_lock);
+
+			hint = fat_lkup_hint_alloc();
+			if (hint == NULL)
+				return;
+			spin_lock(&fat_lookup_hint_lock);
+			/* don't need to recheck hint */
+		} else {
+			struct list_head *p = fat_lookup_hint_head.prev;
+			hint = list_entry(p, struct fat_lookup_hint, lru_list);
+		}
+		hint->pid = current->pid;
+		hint->sb = sb;
+		hint->dir = dir;
+	}
+
+	if (hint->sb != sb || hint->dir != dir) {
+		hint->sb = sb;
+		hint->dir = dir;
+		hint->state |= HINT_STATE_RANDOM;
+	} else {
+		win_start = hint->last_pos - WIN_TOP;
+		win_end = hint->last_pos + WIN_BOTTOM;
+		if (win_start <= pos && pos <= win_end) {
+			hint->state &= ~HINT_STATE_RANDOM;
+			hint->last_pos = pos;
+		} else {
+			/* seems random access */
+			hint->last_pos = pos;
+			hint->state |= HINT_STATE_RANDOM;
+		}
+	}
+	hint->last_pos = pos;
+
+	/* update LRU */
+	list_del(&hint->lru_list);
+	list_add(&hint->lru_list, &fat_lookup_hint_head);
+	spin_unlock(&fat_lookup_hint_lock);
+}
+
 static inline loff_t fat_make_i_pos(struct super_block *sb,
 				    struct buffer_head *bh,
 				    struct msdos_dir_entry *de)
@@ -243,13 +385,23 @@ int fat_search_long(struct inode *inode,
 	int utf8 = sbi->options.utf8;
 	int anycase = (sbi->options.name_check != 's');
 	unsigned short opt_shortname = sbi->options.shortname;
-	loff_t cpos = 0;
 	int chl, i, j, last_u, err;
+	loff_t cpos, start_off;
+	int reach_bottom = 0;
 
+	start_off = cpos = fat_lkup_hint_get(inode);
 	err = -ENOENT;
 	while(1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+top:
+		if (reach_bottom && cpos >= start_off)
 			goto EODir;
+		if (fat_get_entry(inode, &cpos, &bh, &de) == -1) {
+			if (!start_off)
+				goto EODir;
+			reach_bottom++;
+			cpos = 0;
+			continue;
+		}
 parse_record:
 		nr_slots = 0;
 		if (de->name[0] == DELETED_FLAG)
@@ -298,8 +450,13 @@ parse_long:
 				if (ds->id & 0x40) {
 					unicode[offset + 13] = 0;
 				}
-				if (fat_get_entry(inode, &cpos, &bh, &de) < 0)
-					goto EODir;
+				if (fat_get_entry(inode, &cpos, &bh, &de) < 0) {
+					if (!start_off)
+						goto EODir;
+					reach_bottom++;
+					cpos = 0;
+					goto top;
+				}
 				if (slot == 0)
 					break;
 				ds = (struct msdos_dir_slot *) de;
@@ -385,6 +542,7 @@ Found:
 	sinfo->de = de;
 	sinfo->bh = bh;
 	sinfo->i_pos = fat_make_i_pos(sb, sinfo->bh, sinfo->de);
+	fat_lkup_hint_add(inode, sinfo->slot_off);
 	err = 0;
 EODir:
 	if (unicode)
diff -puN fs/fat/inode.c~fat_lookup-hint fs/fat/inode.c
--- linux-2.6.13/fs/fat/inode.c~fat_lookup-hint	2005-09-02 01:04:47.000000000 +0900
+++ linux-2.6.13-hirofumi/fs/fat/inode.c	2005-09-02 01:04:47.000000000 +0900
@@ -342,6 +342,7 @@ static void fat_delete_inode(struct inod
 	clear_inode(inode);
 }
 
+extern void fat_lkup_hint_inval(struct inode*);
 static void fat_clear_inode(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
@@ -349,6 +350,7 @@ static void fat_clear_inode(struct inode
 	if (is_bad_inode(inode))
 		return;
 	lock_kernel();
+	fat_lkup_hint_inval(inode);
 	spin_lock(&sbi->inode_hash_lock);
 	fat_cache_inval_inode(inode);
 	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
_

--=-=-=--
