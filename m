Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbUDMTgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263703AbUDMTgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:36:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3237 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263705AbUDMTgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:36:33 -0400
Message-ID: <407C4130.8000901@austin.ibm.com>
Date: Tue, 13 Apr 2004 14:36:16 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
Content-Type: multipart/mixed;
 boundary="------------020208020602040801040609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208020602040801040609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi-

On some larger ppc64 configurations /proc/device-tree is exhausting 
procfs' dynamic (non-pid) inode range (16K).  This patch makes the 
dynamic inode range 0xf0000000-0xffffffff and changes the inode number 
allocator to use a growable linked list of bitmaps.  Smaller 
configurations are unlikely to have a need for growing the bitmap list 
beyond the initial reservation of 4096 bits, which should reduce their 
exposure to the change.

The number of dynamic entries we need to be able to support is in the 
hundreds of thousands, so extending the existing range 
(00001000-00001fff) upwards would have collided with the pid range.  The 
range I have chosen should be more than enough.

This has been tested on ppc64 and i386.  AFAICT it does not affect the 
pid /proc entries or tools that use them (top, gdb).

Patch applies cleanly to 2.6.5 and 2.6.5-mm4.  Please cc me on replies.


Nathan

--------------020208020602040801040609
Content-Type: text/x-patch;
 name="procfs_many_inodes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procfs_many_inodes.patch"

diff -pru linux-2.6.5/fs/proc/generic.c linux-2.6.5.new/fs/proc/generic.c
--- linux-2.6.5/fs/proc/generic.c	2004-04-13 11:33:18.000000000 -0500
+++ linux-2.6.5.new/fs/proc/generic.c	2004-04-13 11:52:17.000000000 -0500
@@ -275,24 +275,106 @@ static int xlate_proc_name(const char *n
 	return 0;
 }
 
-static unsigned long proc_alloc_map[(PROC_NDYNAMIC + BITS_PER_LONG - 1) / BITS_PER_LONG];
+/*
+ * Some systems need *lots* of proc entries.  So the proc inode map is
+ * a growable linked list of bitmaps.  Smaller systems are unlikely to
+ * need to grow the map.
+ */
+
+#define PROC_DYNAMIC_FIRST 0xF0000000UL
+#define PROC_DYNAMIC_LAST  0xFFFFFFFFUL
+#define PROC_BITS_PER_MAP  4096
+#define PROC_MAX_BITMAPS   ((PROC_DYNAMIC_LAST - PROC_DYNAMIC_FIRST) / PROC_BITS_PER_MAP + 1)
+
+struct proc_inode_map {
+	int used; /* how many bits are set */
+	struct proc_inode_map *next;
+	unsigned long map[(PROC_BITS_PER_MAP + BITS_PER_LONG - 1) / BITS_PER_LONG];
+};
 
-spinlock_t proc_alloc_map_lock = SPIN_LOCK_UNLOCKED;
+static struct proc_inode_map inode_map;
 
-static int make_inode_number(void)
+DECLARE_MUTEX(proc_alloc_map_sem);
+
+/* Allocate a new inode number, creating a new bitmap if necessary.
+ * Return 0 if we run out of inodes, since that is reserved for the
+ * root inode.
+ */
+static unsigned long get_inode_number(void)
 {
-	int i;
-	spin_lock(&proc_alloc_map_lock);
-	i = find_first_zero_bit(proc_alloc_map, PROC_NDYNAMIC);
-	if (i < 0 || i >= PROC_NDYNAMIC) {
-		i = -1;
+	int bitno; /* bit to set in map */
+	unsigned long ino = 0; /* inode number to return */
+	int map_idx = 0;
+	struct proc_inode_map *map = &inode_map;
+
+	down(&proc_alloc_map_sem);
+
+	/* Find either the first non-empty map, or the last map */
+	while (PROC_BITS_PER_MAP == map->used && map->next) {
+		map_idx++;
+		map = map->next;
+	}
+
+	/* Check for overflow */
+	if (map_idx == PROC_MAX_BITMAPS-1 && map->used == PROC_BITS_PER_MAP) {
+		printk(KERN_WARNING "procfs ran out of inodes!\n");
 		goto out;
 	}
-	set_bit(i, proc_alloc_map);
-	i += PROC_DYNAMIC_FIRST;
+
+	/* Allocate a new map if the last one is full */
+	if (PROC_BITS_PER_MAP == map->used) {
+		pr_debug("%s: extending inode map\n", __FUNCTION__);
+		map->next = kmalloc(sizeof(*map), GFP_KERNEL);
+		if (!map->next)
+			goto out;
+		map = map->next;
+		memset(map, 0, sizeof(*map));
+		bitno = 0;
+		map_idx++;
+	} else
+		bitno = find_first_zero_bit(map->map, PROC_BITS_PER_MAP);
+
+	BUG_ON(bitno < 0 || bitno >= PROC_BITS_PER_MAP);
+
+	set_bit(bitno, map->map);
+	map->used++;
+
+	ino = (map_idx * PROC_BITS_PER_MAP) + bitno + PROC_DYNAMIC_FIRST;
+
+	pr_debug("%s: setting bit %d in map %d, returning %lx\n",
+		 __FUNCTION__, bitno, map_idx, ino);
+
+	if (PROC_BITS_PER_MAP == map->used) {
+		pr_debug("%s: map #%d has filled\n", __FUNCTION__, map_idx);
+	}
+
 out:
-	spin_unlock(&proc_alloc_map_lock);
-	return i;
+	up(&proc_alloc_map_sem);
+	return ino;
+}
+
+static void release_inode_number(unsigned long inode)
+{
+	struct proc_inode_map *map = &inode_map;
+	int map_idx = (inode - PROC_DYNAMIC_FIRST) / PROC_BITS_PER_MAP;
+	int bitno = (inode - PROC_DYNAMIC_FIRST) % PROC_BITS_PER_MAP;
+
+	BUG_ON(bitno < 0 || bitno >= PROC_BITS_PER_MAP);
+
+	down(&proc_alloc_map_sem);
+
+	pr_debug("%s: releasing inode %lu, bit %d, map %d\n",
+		 __FUNCTION__, inode, bitno, map_idx);
+
+	while (map_idx--)
+		map = map->next;
+
+	clear_bit(bitno, map->map);
+	map->used--;
+
+	BUG_ON(map->used < 0 || map->used > PROC_BITS_PER_MAP);
+
+	up(&proc_alloc_map_sem);
 }
 
 static int
@@ -452,10 +534,10 @@ static struct inode_operations proc_dir_
 
 static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
 {
-	int	i;
+	unsigned long i;
 	
-	i = make_inode_number();
-	if (i < 0)
+	i = get_inode_number();
+	if (i == 0)
 		return -EAGAIN;
 	dp->low_ino = i;
 	dp->next = dir->subdir;
@@ -621,13 +703,13 @@ struct proc_dir_entry *create_proc_entry
 
 void free_proc_entry(struct proc_dir_entry *de)
 {
-	int ino = de->low_ino;
+	unsigned long ino = de->low_ino;
 
-	if (ino < PROC_DYNAMIC_FIRST ||
-	    ino >= PROC_DYNAMIC_FIRST+PROC_NDYNAMIC)
+	if (ino < PROC_DYNAMIC_FIRST)
 		return;
 	if (S_ISLNK(de->mode) && de->data)
 		kfree(de->data);
+	release_inode_number(ino);
 	kfree(de);
 }
 
@@ -653,8 +735,6 @@ void remove_proc_entry(const char *name,
 		de->next = NULL;
 		if (S_ISDIR(de->mode))
 			parent->nlink--;
-		clear_bit(de->low_ino - PROC_DYNAMIC_FIRST,
-			  proc_alloc_map);
 		proc_kill_inodes(de);
 		de->nlink = 0;
 		WARN_ON(de->subdir);
diff -pru linux-2.6.5/fs/proc/inode-alloc.txt linux-2.6.5.new/fs/proc/inode-alloc.txt
--- linux-2.6.5/fs/proc/inode-alloc.txt	2004-01-09 00:59:26.000000000 -0600
+++ linux-2.6.5.new/fs/proc/inode-alloc.txt	2004-04-13 11:41:11.000000000 -0500
@@ -4,9 +4,10 @@ Current inode allocations in the proc-fs
   00000001-00000fff	static entries	(goners)
        001		root-ino
 
-  00001000-00001fff	dynamic entries
+  00001000-00001fff	unused
   0001xxxx-7fffxxxx	pid-dir entries for pid 1-7fff
-  80000000-ffffffff	unused
+  80000000-efffffff	unused
+  f0000000-ffffffff	dynamic entries
 
 Goal:
 	a) once we'll split the thing into several virtual filesystems we
diff -pru linux-2.6.5/fs/proc/inode.c linux-2.6.5.new/fs/proc/inode.c
--- linux-2.6.5/fs/proc/inode.c	2004-04-13 11:33:18.000000000 -0500
+++ linux-2.6.5.new/fs/proc/inode.c	2004-04-13 11:41:11.000000000 -0500
@@ -181,7 +181,7 @@ static int parse_options(char *options,u
 	return 1;
 }
 
-struct inode * proc_get_inode(struct super_block * sb, int ino,
+struct inode * proc_get_inode(struct super_block * sb, unsigned long ino,
 				struct proc_dir_entry * de)
 {
 	struct inode * inode;
diff -pru linux-2.6.5/include/linux/proc_fs.h linux-2.6.5.new/include/linux/proc_fs.h
--- linux-2.6.5/include/linux/proc_fs.h	2004-04-13 11:33:20.000000000 -0500
+++ linux-2.6.5.new/include/linux/proc_fs.h	2004-04-13 11:41:11.000000000 -0500
@@ -24,11 +24,6 @@ enum {
 	PROC_ROOT_INO = 1,
 };
 
-/* Finally, the dynamically allocatable proc entries are reserved: */
-
-#define PROC_DYNAMIC_FIRST 4096
-#define PROC_NDYNAMIC      16384
-
 #define PROC_SUPER_MAGIC 0x9fa0
 
 /*
@@ -53,7 +48,7 @@ typedef	int (write_proc_t)(struct file *
 typedef int (get_info_t)(char *, char **, off_t, int);
 
 struct proc_dir_entry {
-	unsigned short low_ino;
+	unsigned long low_ino;
 	unsigned short namelen;
 	const char *name;
 	mode_t mode;
@@ -102,7 +97,7 @@ extern void remove_proc_entry(const char
 
 extern struct vfsmount *proc_mnt;
 extern int proc_fill_super(struct super_block *,void *,int);
-extern struct inode * proc_get_inode(struct super_block *, int, struct proc_dir_entry *);
+extern struct inode * proc_get_inode(struct super_block *, unsigned long, struct proc_dir_entry *);
 
 extern int proc_match(int, const char *,struct proc_dir_entry *);
 

--------------020208020602040801040609--
