Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264667AbUEENxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbUEENxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUEENxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:53:32 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:40576 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264667AbUEENxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 09:53:20 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16536.61900.721224.492325@laputa.namesys.com>
Date: Wed, 5 May 2004 17:53:16 +0400
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: alexander viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH-RFC] code for raceless /sys/fs/foofs/*
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

attached patch adds code necessary to safely export per-super-block
information in /sys/fs and /proc/fs.

Common problem with exporting file system information in procfs or sysfs
is a race between method that inputs/outputs data and concurrent umount
of the super-block involved.

To this end patch introduces new struct sb_entry. sb_entries are
embedded into sysfs/procfs objects. When such object is created its
sb_entry is added to the per-super-block list &sb->s_entries protected
by sb->s_umount semaphore. During umount sb->s_entries is scanned and
all entries are marked "dead".

To avoid races with umount, code has to be bracketed between
get_sb_entry() and put_sb_entry(). get_sb_entry() uses sget() to verify
that sb_entry's super-block is still valid, and to pin it in
memory. Super-block is guaranteed to remain valid until corresponding
call to put_sb_entry(). This is the same approach as in Alexander Viro's
fix of fs/reiserfs/procfs.c code.

But there is one more race left: call to put_sb_entry() may cause
file-system module to be unloaded while calling thread is still
executing file-system code. To avoid this (in sysfs case) struct
fs_kobject and struct fs_kattr are added that wrap file-system ->store()
and ->show() methods with calls to {get,put}_sb_entry() done from the
generic code.

Note: there is no in-tree users of this currently, but reiser4 wants to
exports information in /sys/fs/reiser4, hence RFC.

Nikita.
diff -puN -b include/linux/fs.h~kobject-umount-race include/linux/fs.h
--- i386/include/linux/fs.h~kobject-umount-race	Mon May  3 18:44:11 2004
+++ i386-god/include/linux/fs.h	Wed May  5 17:15:54 2004
@@ -679,6 +679,28 @@ extern int send_sigurg(struct fown_struc
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
 
+/*
+ * sb_entry is attached to some super block (register_sb_entry()). It
+ * can be detached manually (unregister_sb_entry()), or automatically by
+ * umount (see deactivate_super()). {get,put}_sb_entry() can be used to
+ * guarantee liveness of entry. Typical usage is to have sb_entry along
+ * with kobject or proc_dir_entry; see struct fs_kobject.
+ */
+
+struct sb_entry {
+	/* linkage into &s->entries */
+	struct list_head linkage;
+	/* true is entry is attached to @s */
+	int live;
+	/* file system type for this entry. This is necessary, because
+	 * entry liveness should be checkable in the situation when ->s
+	 * may already be invalid. */
+	struct file_system_type *type;
+	/* superblock this entry is attached to. Can only be inspected
+	 * after successful call to get_sb_entry() */
+	struct super_block *s;
+};
+
 #define sb_entry(list)	list_entry((list), struct super_block, s_list)
 #define S_BIAS (1<<30)
 struct super_block {
@@ -724,8 +746,52 @@ struct super_block {
 	 * even looking at it. You had been warned.
 	 */
 	struct semaphore s_vfs_rename_sem;	/* Kludge */
+	struct list_head s_entries;             /* list of
+						 * sb_entries. Protected
+						 * by ->s_umount. */
+};
+
+/*
+ * file system kobject.
+ *
+ * fs_kobject is used to export per-super-block information in sysfs
+ * while providing synchronization against concurrent umount. To this
+ * end it includes struct sb_entry that is attached to the super block
+ * by fs_kobject_register() and detached by fs_kobject_unregister().
+ *
+ * We need these wrappers (see fs/super.c:fs_kattr_{show,store}()),
+ * because it's impossible to handle module unloading races properly
+ * from within file-system code. Viz get_sb_entry() avoids umount races
+ * by acquiring reference to the super block (through sget()), but this
+ * may very well be the _last_ reference to the file-system, and
+ * put_sb_entry() will trigger module unload, which means that
+ * put_sb_entry() should be called from the generic code rather than
+ * from file-system module.
+ */
+struct fs_kobject {
+	struct sb_entry entry;
+	struct kobject  kobj; /* it should be kobj for compatibility
+			       * with silly kobject.h macros */
+};
+
+/*
+ * file system kattr. See struct fs_kobject.
+ */
+struct fs_kattr {
+	struct attribute kattr;
+	ssize_t (*show) (struct super_block *,
+			 struct fs_kobject *, struct fs_kattr *, char *);
+	ssize_t (*store) (struct super_block *, struct fs_kobject *,
+			  struct fs_kattr *, const char *, size_t);
 };
 
+/* in fs/super.c */
+
+int fs_kobject_register(struct super_block *s, struct fs_kobject * fskobj);
+void fs_kobject_unregister(struct fs_kobject * fskobj);
+
+extern struct sysfs_ops fs_attr_ops;
+
 /*
  * Superblock locking.
  */
diff -puN -b fs/super.c~kobject-umount-race fs/super.c
--- i386/fs/super.c~kobject-umount-race	Mon May  3 18:44:11 2004
+++ i386-god/fs/super.c	Wed May  5 17:17:40 2004
@@ -67,6 +67,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
+		INIT_LIST_HEAD(&s->s_entries);
 		INIT_HLIST_HEAD(&s->s_anon);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
@@ -98,8 +99,208 @@ static inline void destroy_super(struct 
 	kfree(s);
 }
 
+/* struct sb_entry obmanipulations. */
+
+/**
+ *	register_sb_entry	-	attach sb_entry to a superblock
+ *	@s: superblock to attach to
+ *	@entry: entry to attach to the @s
+ *
+ *	Attaches @entry to the superblock, marks it as live. Called under
+ *	write-taken @s->s_umount.
+ */
+static void register_sb_entry(struct super_block *s, struct sb_entry *entry)
+{
+	entry->live = 1;
+	list_add(&entry->linkage, &s->s_entries);
+	entry->type = s->s_type;
+	get_filesystem(entry->type);
+	entry->s = s;
+}
+
+/**
+ *	unregister_sb_entry	-	detach sb_entry from superblock
+ *	@entry: entry to detach
+ *
+ *	Detaches @entry from the superblock, and marks it as dead. Called
+ *	under write-taken @entry->s->s_umount.
+ */
+static void unregister_sb_entry(struct sb_entry *entry)
+{
+	entry->live = 0;
+	list_del_init(&entry->linkage);
+	if (entry->type != NULL) {
+		put_filesystem(entry->type);
+		entry->type = NULL;
+	}
+}
+
+/* helper (*test) callback for get_sb_entry. Should probably be just declared
+ * local in get_sb_entry(). */
+static int test_sb(struct super_block *sb, void *data)
+{
+	return data == sb;
+}
+
+/* helper (*set) callback for get_sb_entry. */
+static int set_sb(struct super_block *sb, void *data)
+{
+	return -ENOENT;
+}
+
+/**
+ *	get_sb_entry	-	acquire a reference to sb_entry
+ *	@entry: sb_entry to acquire reference to
+ *
+ *	Acquires a reference to the @entry. This means that after successful
+ *	return from this function @entry (and @entry->s) are guaranteed to
+ *	exist until corresponding call to @put_sb_entry. This function is used
+ *	to avoid races between sysfs/procfs methods and umount. Fails if
+ *	sget() failed or @entry->s is already unmounted.
+ */
+static int get_sb_entry(struct sb_entry *entry)
+{
+	int result;
+	struct super_block *s;
+
+	s = sget(entry->type, test_sb, set_sb, entry->s);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+	/* at this point @s is pinned, and s->s_umount is write-taken */
+	result = entry->live ? 0 : -ENOENT;
+	up_write(&s->s_umount);
+	if (result != 0)
+		deactivate_super(s);
+	return result;
+}
+
+/**
+ *	put_sb_entry	-	release a reference to sb_entry
+ *	@entry: sb_entry to release reference to
+ *
+ *	Dual to get_sb_entry(), should always be called if former returned
+ *	success.
+ */
+static void put_sb_entry(struct sb_entry *entry)
+{
+	/* release reference acquired by get_sb_entry() */
+	deactivate_super(entry->s);
+}
+
+/* helper to deactivate_super(): detach all sb_entries from @s */
+static void kill_sb_entries(struct super_block *s)
+{
+	while (!list_empty(&s->s_entries))
+		unregister_sb_entry(container_of(s->s_entries.next,
+						 struct sb_entry, linkage));
+}
+
+/**
+ *	fs_kobject_register	-	register file-system kobject
+ *	@s: superblock @fskobj belongs to
+ *	@fskobj: file-system kobject to register
+ *
+ *	Registers kobject and sb_entry parts of
+ *	@fskobj. Cf. include/linux/fs.h:struct fs_kobject
+ */
+int fs_kobject_register(struct super_block *s, struct fs_kobject * fskobj)
+{
+	int result;
+
+	result = kobject_register(&fskobj->kobj);
+	if (result == 0)
+		register_sb_entry(s, &fskobj->entry);
+	return result;
+}
+EXPORT_SYMBOL(fs_kobject_register);
+
+/**
+ *	fs_kobject_register	-	register file-system kobject
+ *	@fskobj: file-system kobject to register
+ *
+ *	Unregisters kobject and sb_entry parts of @fskobj.
+ */
+void fs_kobject_unregister(struct fs_kobject * fskobj)
+{
+	unregister_sb_entry(&fskobj->entry);
+	kobject_unregister(&fskobj->kobj);
+}
+EXPORT_SYMBOL(fs_kobject_unregister);
+
+/**
+ *	fs_attr_show	-	->show method for fs_attr_ops.
+ *	@kobj: kobject embedded into struct fs_kobject
+ *	@kattr: kattr embedded into struct fs_kattr
+ *
+ *	Calls ->show() method of fs_kattr into which @kattr is
+ *	embedded. Avoids races with umount.
+ */
+static ssize_t
+fs_attr_show(struct kobject *kobj, struct attribute *kattr, char *buf)
+{
+	struct fs_kobject  *fskobj;
+	struct fs_kattr    *fskattr;
+	struct sb_entry    *entry;
+	int                 result;
+
+	fskobj  = container_of(kobj, struct fs_kobject, kobj);
+	fskattr = container_of(kattr, struct fs_kattr, kattr);
+	entry   = &fskobj->entry;
+
+	result = get_sb_entry(entry);
+	if (result == 0) {
+		if (fskattr->show != NULL)
+			result = fskattr->show(entry->s, fskobj, fskattr, buf);
+		else
+			result = 0;
+		put_sb_entry(entry);
+	}
+	return result;
+}
+
+/**
+ *	fs_attr_store	-	->store method for fs_attr_ops.
+ *	@kobj: kobject embedded into struct fs_kobject
+ *	@kattr: kattr embedded into struct fs_kattr
+ *
+ *	Calls ->store() method of fs_kattr into which @kattr is
+ *	embedded. Avoids races with umount.
+ */
+static ssize_t
+fs_attr_store(struct kobject *kobj, struct attribute *kattr,
+	      const char *buf, size_t size)
+{
+	struct fs_kobject  *fskobj;
+	struct fs_kattr    *fskattr;
+	struct sb_entry    *entry;
+	int                 result;
+
+	fskobj  = container_of(kobj, struct fs_kobject, kobj);
+	fskattr = container_of(kattr, struct fs_kattr, kattr);
+	entry   = &fskobj->entry;
+
+	result = get_sb_entry(entry);
+	if (result == 0) {
+		if (fskattr->store != NULL)
+			result = fskattr->store(entry->s,
+						fskobj, fskattr, buf, size);
+		else
+			result = 0;
+		put_sb_entry(entry);
+	}
+	return result;
+}
+
+/* sysfs operations for file systems exporting information in /sys/fs */
+struct sysfs_ops fs_attr_ops = {
+	.show  = fs_attr_show,
+	.store = fs_attr_store
+};
+EXPORT_SYMBOL(fs_attr_ops);
+
 /* Superblock refcounting  */
 
+
 /**
  *	put_super	-	drop a temporary reference to superblock
  *	@s: superblock in question
@@ -131,6 +332,7 @@ void deactivate_super(struct super_block
 		s->s_count -= S_BIAS-1;
 		spin_unlock(&sb_lock);
 		down_write(&s->s_umount);
+		kill_sb_entries(s);
 		fs->kill_sb(s);
 		put_filesystem(fs);
 		put_super(s);

_
