Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRJQCJE>; Tue, 16 Oct 2001 22:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJQCIu>; Tue, 16 Oct 2001 22:08:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52179 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273854AbRJQCIf>;
	Tue, 16 Oct 2001 22:08:35 -0400
Date: Tue, 16 Oct 2001 22:09:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.LNX.4.33.0110152132110.8730-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110162137130.14170-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Linus Torvalds wrote:

> Actually, the "seek" is obviously unconditional. Duh.
> 
> And we really want to pass in the "file" to the next/seek functions,

I doubt it.  First of all, we don't really need a new method.
Now it looks so:
  
        pos = *ppos;
        p = m->op->start(m, &pos);
 
and
        loff_t next = pos;
        p = m->op->next(m, p, &next);
        /* do stuff, possibly exit the loop */
        pos = next;
 
(and assignements _are_ needed if we don't want it sequential, since we
want to able to bail out if next record won't fit into buffer).

As for passing the file to it... Not really, since we
	a) want to return new position
	b) _don't_ want to screw ->f_pos, since we may need to leave it at
the old value
	c) don't have any other interesting fields to look at.

New variant of patch follows.  Again, that's in "it works here" department -
it _does_ need mor testing.

It's against 2.4.13-pre3 + fixes I've sent (minor cleanups in fs/namespace.c +
couple of fixes in places that are not affected by this patch).

Comments (and help with testing) are welcome...

diff -urN S13-pre3-fixes/fs/Makefile S13-pre3-seq/fs/Makefile
--- S13-pre3-fixes/fs/Makefile	Tue Oct  9 21:47:26 2001
+++ S13-pre3-seq/fs/Makefile	Tue Oct 16 00:10:00 2001
@@ -14,7 +14,7 @@
 		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
 		fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
-		filesystems.o namespace.o
+		filesystems.o namespace.o seq_file.o
 
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
diff -urN S13-pre3-fixes/fs/namespace.c S13-pre3-seq/fs/namespace.c
--- S13-pre3-fixes/fs/namespace.c	Mon Oct 15 22:22:19 2001
+++ S13-pre3-seq/fs/namespace.c	Tue Oct 16 21:52:35 2001
@@ -22,6 +22,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
+#include <linux/seq_file.h>
 
 struct vfsmount *do_kern_mount(char *type, int flags, char *name, void *data);
 int do_remount_sb(struct super_block *sb, int flags, void * data);
@@ -167,159 +168,131 @@
 	kill_super(sb);
 }
 
-/* Use octal escapes, like mount does, for embedded spaces etc. */
-static unsigned char need_escaping[] = { ' ', '\t', '\n', '\\' };
+/* iterator */
+static void *m_start(struct seq_file *m, loff_t *pos)
+{
+	struct list_head *p;
+	loff_t n = *pos;
 
-static int
-mangle(const unsigned char *s, char *buf, int len) {
-        char *sp;
-        int n;
-
-        sp = buf;
-        while(*s && sp-buf < len-3) {
-                for (n = 0; n < sizeof(need_escaping); n++) {
-                        if (*s == need_escaping[n]) {
-                                *sp++ = '\\';
-                                *sp++ = '0' + ((*s & 0300) >> 6);
-                                *sp++ = '0' + ((*s & 070) >> 3);
-                                *sp++ = '0' + (*s & 07);
-                                goto next;
-                        }
-                }
-                *sp++ = *s;
-        next:
-                s++;
-        }
-        return sp - buf;	/* no trailing NUL */
-}
-
-static struct proc_fs_info {
-	int flag;
-	char *str;
-} fs_info[] = {
-	{ MS_SYNCHRONOUS, ",sync" },
-	{ MS_MANDLOCK, ",mand" },
-	{ MS_NOATIME, ",noatime" },
-	{ MS_NODIRATIME, ",nodiratime" },
-	{ 0, NULL }
-};
+	down(&mount_sem);
+	list_for_each(p, &vfsmntlist)
+		if (!n--)
+			return list_entry(p, struct vfsmount, mnt_list);
+	return NULL;
+}
 
-static struct proc_fs_info mnt_info[] = {
-	{ MNT_NOSUID, ",nosuid" },
-	{ MNT_NODEV, ",nodev" },
-	{ MNT_NOEXEC, ",noexec" },
-	{ 0, NULL }
-};
+static void *m_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct list_head *p = ((struct vfsmount *)v)->mnt_list.next;
+	(*pos)++;
+	return p==&vfsmntlist ? NULL : list_entry(p, struct vfsmount, mnt_list);
+}
 
-static struct proc_nfs_info {
-	int flag;
-	char *str;
-	char *nostr;
-} nfs_info[] = {
-	{ NFS_MOUNT_SOFT, ",soft", ",hard" },
-	{ NFS_MOUNT_INTR, ",intr", "" },
-	{ NFS_MOUNT_POSIX, ",posix", "" },
-	{ NFS_MOUNT_TCP, ",tcp", ",udp" },
-	{ NFS_MOUNT_NOCTO, ",nocto", "" },
-	{ NFS_MOUNT_NOAC, ",noac", "" },
-	{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
-	{ NFS_MOUNT_BROKEN_SUID, ",broken_suid", "" },
-	{ 0, NULL, NULL }
-};
+static void m_stop(struct seq_file *m, void *v)
+{
+	up(&mount_sem);
+}
 
-int get_filesystem_info( char *buf )
+static inline void mangle(struct seq_file *m, const char *s)
 {
-	struct list_head *p;
-	struct proc_fs_info *fs_infop;
+	seq_escape(m, s, " \t\n\\");
+}
+
+static void show_nfs_mount(struct seq_file *m, struct vfsmount *mnt)
+{
+	static struct proc_nfs_info {
+		int flag;
+		char *str;
+		char *nostr;
+	} nfs_info[] = {
+		{ NFS_MOUNT_SOFT, ",soft", ",hard" },
+		{ NFS_MOUNT_INTR, ",intr", "" },
+		{ NFS_MOUNT_POSIX, ",posix", "" },
+		{ NFS_MOUNT_TCP, ",tcp", ",udp" },
+		{ NFS_MOUNT_NOCTO, ",nocto", "" },
+		{ NFS_MOUNT_NOAC, ",noac", "" },
+		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
+		{ NFS_MOUNT_BROKEN_SUID, ",broken_suid", "" },
+		{ 0, NULL, NULL }
+	};
 	struct proc_nfs_info *nfs_infop;
-	struct nfs_server *nfss;
-	int len, prevlen;
-	char *path, *buffer = (char *) __get_free_page(GFP_KERNEL);
-
-	if (!buffer) return 0;
-	len = prevlen = 0;
-
-#define FREEROOM	((int)PAGE_SIZE-200-len)
-#define MANGLE(s)	len += mangle((s), buf+len, FREEROOM);
-
-	for (p = vfsmntlist.next; p != &vfsmntlist; p = p->next) {
-		struct vfsmount *tmp = list_entry(p, struct vfsmount, mnt_list);
-		path = d_path(tmp->mnt_root, tmp, buffer, PAGE_SIZE);
-		if (!path)
-			continue;
-		MANGLE(tmp->mnt_devname ? tmp->mnt_devname : "none");
-		buf[len++] = ' ';
-		MANGLE(path);
-		buf[len++] = ' ';
-		MANGLE(tmp->mnt_sb->s_type->name);
-		len += sprintf(buf+len, " %s",
-			       tmp->mnt_sb->s_flags & MS_RDONLY ? "ro" : "rw");
-		for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
-			if (tmp->mnt_sb->s_flags & fs_infop->flag)
-				MANGLE(fs_infop->str);
-		}
-		for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
-			if (tmp->mnt_flags & fs_infop->flag)
-				MANGLE(fs_infop->str);
-		}
-		if (!strcmp("nfs", tmp->mnt_sb->s_type->name)) {
-			nfss = &tmp->mnt_sb->u.nfs_sb.s_server;
-			len += sprintf(buf+len, ",v%d", nfss->rpc_ops->version);
-
-			len += sprintf(buf+len, ",rsize=%d", nfss->rsize);
-
-			len += sprintf(buf+len, ",wsize=%d", nfss->wsize);
-#if 0
-			if (nfss->timeo != 7*HZ/10) {
-				len += sprintf(buf+len, ",timeo=%d",
-					       nfss->timeo*10/HZ);
-			}
-			if (nfss->retrans != 3) {
-				len += sprintf(buf+len, ",retrans=%d",
-					       nfss->retrans);
-			}
-#endif
-			if (nfss->acregmin != 3*HZ) {
-				len += sprintf(buf+len, ",acregmin=%d",
-					       nfss->acregmin/HZ);
-			}
-			if (nfss->acregmax != 60*HZ) {
-				len += sprintf(buf+len, ",acregmax=%d",
-					       nfss->acregmax/HZ);
-			}
-			if (nfss->acdirmin != 30*HZ) {
-				len += sprintf(buf+len, ",acdirmin=%d",
-					       nfss->acdirmin/HZ);
-			}
-			if (nfss->acdirmax != 60*HZ) {
-				len += sprintf(buf+len, ",acdirmax=%d",
-					       nfss->acdirmax/HZ);
-			}
-			for (nfs_infop = nfs_info; nfs_infop->flag; nfs_infop++) {
-				char *str;
-				if (nfss->flags & nfs_infop->flag)
-					str = nfs_infop->str;
-				else
-					str = nfs_infop->nostr;
-				MANGLE(str);
-			}
-			len += sprintf(buf+len, ",addr=");
-			MANGLE(nfss->hostname);
-		}
-		len += sprintf(buf + len, " 0 0\n");
-		if (FREEROOM <= 3) {
-			len = prevlen;
-			len += sprintf(buf+len, "# truncated\n");
-			break;
-		}
-		prevlen = len;
+	struct nfs_server *nfss = &mnt->mnt_sb->u.nfs_sb.s_server;
+
+	seq_printf(m, ",v%d", nfss->rpc_ops->version);
+	seq_printf(m, ",rsize=%d", nfss->rsize);
+	seq_printf(m, ",wsize=%d", nfss->wsize);
+	if (nfss->acregmin != 3*HZ)
+		seq_printf(m, ",acregmin=%d", nfss->acregmin/HZ);
+	if (nfss->acregmax != 60*HZ)
+		seq_printf(m, ",acregmax=%d", nfss->acregmax/HZ);
+	if (nfss->acdirmin != 30*HZ)
+		seq_printf(m, ",acdirmin=%d", nfss->acdirmin/HZ);
+	if (nfss->acdirmax != 60*HZ)
+		seq_printf(m, ",acdirmax=%d", nfss->acdirmax/HZ);
+	for (nfs_infop = nfs_info; nfs_infop->flag; nfs_infop++) {
+		if (nfss->flags & nfs_infop->flag)
+			seq_puts(m, nfs_infop->str);
+		else
+			seq_puts(m, nfs_infop->nostr);
 	}
+	seq_puts(m, ",addr=");
+	mangle(m, nfss->hostname);
+}
 
-	free_page((unsigned long) buffer);
-	return len;
-#undef MANGLE
-#undef FREEROOM
+static int show_vfsmnt(struct seq_file *m, void *v)
+{
+	struct vfsmount *mnt = v;
+	static struct proc_fs_info {
+		int flag;
+		char *str;
+	} fs_info[] = {
+		{ MS_SYNCHRONOUS, ",sync" },
+		{ MS_MANDLOCK, ",mand" },
+		{ MS_NOATIME, ",noatime" },
+		{ MS_NODIRATIME, ",nodiratime" },
+		{ 0, NULL }
+	};
+	static struct proc_fs_info mnt_info[] = {
+		{ MNT_NOSUID, ",nosuid" },
+		{ MNT_NODEV, ",nodev" },
+		{ MNT_NOEXEC, ",noexec" },
+		{ 0, NULL }
+	};
+	struct proc_fs_info *fs_infop;
+	char *path_buf, *path;
+
+	path_buf = (char *) __get_free_page(GFP_KERNEL);
+	if (!path_buf)
+		return -ENOMEM;
+	path = d_path(mnt->mnt_root, mnt, path_buf, PAGE_SIZE);
+
+	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
+	seq_putc(m, ' ');
+	mangle(m, path);
+	free_page((unsigned long) path_buf);
+	seq_putc(m, ' ');
+	mangle(m, mnt->mnt_sb->s_type->name);
+	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
+		if (mnt->mnt_sb->s_flags & fs_infop->flag)
+			seq_puts(m, fs_infop->str);
+	}
+	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
+		if (mnt->mnt_flags & fs_infop->flag)
+			seq_puts(m, fs_infop->str);
+	}
+	if (strcmp("nfs", mnt->mnt_sb->s_type->name) == 0)
+		show_nfs_mount(m, mnt);
+	seq_puts(m, " 0 0\n");
+	return 0;
 }
+
+struct seq_operations mounts_op = {
+	start:	m_start,
+	next:	m_next,
+	stop:	m_stop,
+	show:	show_vfsmnt
+};
 
 /*
  * Doesn't take quota and stuff into account. IOW, in some cases it will
diff -urN S13-pre3-fixes/fs/proc/proc_misc.c S13-pre3-seq/fs/proc/proc_misc.c
--- S13-pre3-fixes/fs/proc/proc_misc.c	Mon Oct 15 20:12:19 2001
+++ S13-pre3-seq/fs/proc/proc_misc.c	Tue Oct 16 00:10:00 2001
@@ -35,6 +35,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -57,12 +58,10 @@
 #endif
 #ifdef CONFIG_MODULES
 extern int get_module_list(char *);
-extern int get_ksyms_list(char *, char **, off_t, int);
 #endif
 extern int get_device_list(char *);
 extern int get_partition_list(char *, char **, off_t, int);
 extern int get_filesystem_list(char *);
-extern int get_filesystem_info(char *);
 extern int get_exec_domain_list(char *);
 extern int get_irq_list(char *);
 extern int get_dma_list(char *);
@@ -251,13 +250,17 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
-static int ksyms_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
+extern struct seq_operations ksyms_op;
+static int ksyms_open(struct inode *inode, struct file *file)
 {
-	int len = get_ksyms_list(page, start, off, count);
-	if (len < count) *eof = 1;
-	return len;
+	return seq_open(file, &ksyms_op);
 }
+static struct file_operations proc_ksyms_operations = {
+	open:		ksyms_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
 #endif
 
 static int kstat_read_proc(char *page, char **start, off_t off,
@@ -414,13 +417,6 @@
 	return len;
 }
 
-static int mounts_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int len = get_filesystem_info(page);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 static int execdomains_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -505,6 +501,18 @@
 	write:		write_profile,
 };
 
+extern struct seq_operations mounts_op;
+static int mounts_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &mounts_op);
+}
+static struct file_operations proc_mounts_operations = {
+	open:		mounts_open,
+	read:		seq_read,
+	llseek:		seq_lseek,
+	release:	seq_release,
+};
+
 struct proc_dir_entry *proc_root_kcore;
 
 void __init proc_misc_init(void)
@@ -530,7 +538,6 @@
 #endif
 #ifdef CONFIG_MODULES
 		{"modules",	modules_read_proc},
-		{"ksyms",	ksyms_read_proc},
 #endif
 		{"stat",	kstat_read_proc},
 		{"devices",	devices_read_proc},
@@ -546,7 +553,6 @@
 		{"rtc",		ds1286_read_proc},
 #endif
 		{"locks",	locks_read_proc},
-		{"mounts",	mounts_read_proc},
 		{"swaps",	swaps_read_proc},
 		{"iomem",	memory_read_proc},
 		{"execdomains",	execdomains_read_proc},
@@ -559,6 +565,12 @@
 	entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
+	entry = create_proc_entry("mounts", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_mounts_operations;
+	entry = create_proc_entry("ksyms", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_ksyms_operations;
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
 		proc_root_kcore->proc_fops = &proc_kcore_operations;
diff -urN S13-pre3-fixes/fs/seq_file.c S13-pre3-seq/fs/seq_file.c
--- S13-pre3-fixes/fs/seq_file.c	Wed Dec 31 19:00:00 1969
+++ S13-pre3-seq/fs/seq_file.c	Tue Oct 16 21:36:17 2001
@@ -0,0 +1,236 @@
+/*
+ * linux/fs/seq_file.c
+ *
+ * helper functions for making syntetic files from sequences of records.
+ * initial implementation -- AV, Oct 2001.
+ */
+
+#include <linux/malloc.h>
+#include <linux/fs.h>
+#include <linux/seq_file.h>
+#include <asm/uaccess.h>
+
+/**
+ *	seq_open -	initialize sequential file
+ *	@file: file we initialize
+ *	@op: method table describing the sequence
+ *
+ *	seq_open() sets @file, associating it with a sequence described
+ *	by @op.  @op->start() sets the iterator up and returns the first
+ *	element of sequence. @op->stop() shuts it down.  @op->next()
+ *	returns the next element of sequence.  @op->show() prints element
+ *	into the buffer.  In case of error ->start() and ->next() return
+ *	ERR_PTR(error).  In the end of sequence they return %NULL. ->show()
+ *	returns 0 in case of success and negative number in case of error.
+ */
+int seq_open(struct file *file, struct seq_operations *op)
+{
+	struct seq_file *p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	memset(p, 0, sizeof(*p));
+	sema_init(&p->sem, 1);
+	p->op = op;
+	file->private_data = p;
+	return 0;
+}
+
+/**
+ *	seq_read -	->read() method for sequential files.
+ *	@file, @buf, @size, @ppos: see file_operations method
+ *
+ *	Ready-made ->f_op->read()
+ */
+ssize_t seq_read(struct file *file, char *buf, size_t size, loff_t *ppos)
+{
+	struct seq_file *m = (struct seq_file *)file->private_data;
+	size_t copied = 0;
+	loff_t pos;
+	size_t n;
+	void *p;
+	int err = 0;
+
+	if (ppos != &file->f_pos)
+		return -EPIPE;
+
+	down(&m->sem);
+	/* grab buffer if we didn't have one */
+	if (!m->buf) {
+		m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);
+		if (!m->buf)
+			goto Enomem;
+	}
+	/* if not empty - flush it first */
+	if (m->count) {
+		n = min(m->count, size);
+		err = copy_to_user(buf, m->buf + m->from, n);
+		if (err)
+			goto Efault;
+		m->count -= n;
+		m->from += n;
+		size -= n;
+		buf += n;
+		copied += n;
+		if (!m->count)
+			(*ppos)++;
+		if (!size)
+			goto Done;
+	}
+	/* we need at least one record in buffer */
+	while (1) {
+		pos = *ppos;
+		p = m->op->start(m, &pos);
+		err = PTR_ERR(p);
+		if (!p || IS_ERR(p))
+			break;
+		err = m->op->show(m, p);
+		if (err)
+			break;
+		if (m->count < m->size)
+			goto Fill;
+		m->op->stop(m, p);
+		kfree(m->buf);
+		m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
+		if (!m->buf)
+			goto Enomem;
+	}
+	m->op->stop(m, p);
+	goto Done;
+Fill:
+	/* they want more? let's try to get some more */
+	while (m->count < size) {
+		size_t offs = m->count;
+		loff_t next = pos;
+		p = m->op->next(m, p, &next);
+		if (!p || IS_ERR(p)) {
+			err = PTR_ERR(p);
+			break;
+		}
+		err = m->op->show(m, p);
+		if (err || m->count == m->size) {
+			m->count = offs;
+			break;
+		}
+		pos = next;
+	}
+	m->op->stop(m, p);
+	n = min(m->count, size);
+	err = copy_to_user(buf, m->buf, n);
+	if (err)
+		goto Efault;
+	copied += n;
+	m->count -= n;
+	if (m->count)
+		m->from = n;
+	else
+		pos++;
+	*ppos = pos;
+Done:
+	if (!copied)
+		copied = err;
+	up(&m->sem);
+	return copied;
+Enomem:
+	err = -ENOMEM;
+	goto Done;
+Efault:
+	err = -EFAULT;
+	goto Done;
+}
+
+/**
+ *	seq_lseek -	->llseek() method for sequential files.
+ *	@file, @offset, @origin: see file_operations method
+ *
+ *	Ready-made ->f_op->llseek()
+ */
+loff_t seq_lseek(struct file *file, loff_t offset, int origin)
+{
+	struct seq_file *m = (struct seq_file *)file->private_data;
+	long long retval = -EINVAL;
+
+	down(&m->sem);
+	switch (origin) {
+		case 1:
+			offset += file->f_pos;
+		case 0:
+			if (offset < 0)
+				break;
+			if (offset != file->f_pos) {
+				file->f_pos = offset;
+				m->count = 0;
+			}
+			retval = offset;
+	}
+	up(&m->sem);
+	return retval;
+}
+
+/**
+ *	seq_release -	free the structures associated with sequential file.
+ *	@file: file in question
+ *	@inode: file->f_dentry->d_inode
+ *
+ *	Frees the structures associated with sequential file; can be used
+ *	as ->f_op->release() if you don't have private data to destroy.
+ */
+int seq_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = (struct seq_file *)file->private_data;
+	kfree(m->buf);
+	kfree(m);
+	return 0;
+}
+
+/**
+ *	seq_escape -	print string into buffer, escaping some characters
+ *	@m:	target buffer
+ *	@s:	string
+ *	@esc:	set of characters that need escaping
+ *
+ *	Puts string into buffer, replacing each occurence of character from
+ *	@esc with usual octal escape.  Returns 0 in case of success, -1 - in
+ *	case of overflow.
+ */
+int seq_escape(struct seq_file *m, const char *s, const char *esc)
+{
+	char *end = m->buf + m->size;
+        char *p;
+	char c;
+
+        for (p = m->buf + m->count; (c = *s) != '\0' && p < end; s++) {
+		if (!strchr(esc, c)) {
+			*p++ = c;
+			continue;
+		}
+		if (p + 3 < end) {
+			*p++ = '\\';
+			*p++ = '0' + ((c & 0300) >> 6);
+			*p++ = '0' + ((c & 070) >> 3);
+			*p++ = '0' + (c & 07);
+			continue;
+		}
+		m->count = m->size;
+		return -1;
+        }
+	m->count = p - m->buf;
+        return 0;
+}
+
+int seq_printf(struct seq_file *m, const char *f, ...)
+{
+	va_list args;
+	int len;
+
+	if (m->count < m->size) {
+		va_start(args, f);
+		len = vsnprintf(m->buf + m->count, m->size - m->count, f, args);
+		va_end(args);
+		if (m->count + len < m->size) {
+			m->count += len;
+			return 0;
+		}
+	}
+	m->count = m->size;
+	return -1;
+}
diff -urN S13-pre3-fixes/include/linux/seq_file.h S13-pre3-seq/include/linux/seq_file.h
--- S13-pre3-fixes/include/linux/seq_file.h	Wed Dec 31 19:00:00 1969
+++ S13-pre3-seq/include/linux/seq_file.h	Tue Oct 16 20:33:50 2001
@@ -0,0 +1,55 @@
+#ifndef _LINUX_SEQ_FILE_H
+#define _LINUX_SEQ_FILE_H
+#ifdef __KERNEL__
+
+struct seq_operations;
+
+struct seq_file {
+	char *buf;
+	size_t size;
+	size_t from;
+	size_t count;
+	loff_t index;
+	struct semaphore sem;
+	struct seq_operations *op;
+};
+
+struct seq_operations {
+	void * (*start) (struct seq_file *m, loff_t *pos);
+	void (*stop) (struct seq_file *m, void *v);
+	void * (*next) (struct seq_file *m, void *v, loff_t *pos);
+	int (*show) (struct seq_file *m, void *v);
+};
+
+int seq_open(struct file *, struct seq_operations *);
+ssize_t seq_read(struct file *, char *, size_t, loff_t *);
+loff_t seq_lseek(struct file *, loff_t, int);
+int seq_release(struct inode *, struct file *);
+int seq_escape(struct seq_file *, const char *, const char *);
+
+static inline int seq_putc(struct seq_file *m, char c)
+{
+	if (m->count < m->size) {
+		m->buf[m->count++] = c;
+		return 0;
+	}
+	return -1;
+}
+
+static inline int seq_puts(struct seq_file *m, const char *s)
+{
+	int len = strlen(s);
+	if (m->count + len < m->size) {
+		memcpy(m->buf + m->count, s, len);
+		m->count += len;
+		return 0;
+	}
+	m->count = m->size;
+	return -1;
+}
+
+int seq_printf(struct seq_file *, const char *, ...)
+	__attribute__ ((format (printf,2,3)));
+
+#endif
+#endif
diff -urN S13-pre3-fixes/kernel/module.c S13-pre3-seq/kernel/module.c
--- S13-pre3-fixes/kernel/module.c	Sun Sep 23 16:12:09 2001
+++ S13-pre3-seq/kernel/module.c	Tue Oct 16 21:46:26 2001
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
+#include <linux/seq_file.h>
 
 /*
  * Originally by Anonymous (as far as I know...)
@@ -1156,51 +1157,83 @@
  * Called by the /proc file system to return a current list of ksyms.
  */
 
-int
-get_ksyms_list(char *buf, char **start, off_t offset, int length)
-{
+struct mod_sym {
 	struct module *mod;
-	char *p = buf;
-	int len     = 0;	/* code from  net/ipv4/proc.c */
-	off_t pos   = 0;
-	off_t begin = 0;
-
-	for (mod = module_list; mod; mod = mod->next) {
-		unsigned i;
-		struct module_symbol *sym;
+	int index;
+};
 
-		if (!MOD_CAN_QUERY(mod))
-			continue;
+/* iterator */
 
-		for (i = mod->nsyms, sym = mod->syms; i > 0; --i, ++sym) {
-			p = buf + len;
-			if (*mod->name) {
-				len += sprintf(p, "%0*lx %s\t[%s]\n",
-					       (int)(2*sizeof(void*)),
-					       sym->value, sym->name,
-					       mod->name);
-			} else {
-				len += sprintf(p, "%0*lx %s\n",
-					       (int)(2*sizeof(void*)),
-					       sym->value, sym->name);
-			}
-			pos = begin + len;
-			if (pos < offset) {
-				len = 0;
-				begin = pos;
-			}
-			pos = begin + len;
-			if (pos > offset+length)
-				goto leave_the_loop;
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+	struct mod_sym *p = kmalloc(sizeof(*p), GFP_KERNEL);
+	struct module *v;
+	loff_t n = *pos;
+
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+	lock_kernel();
+	for (v = module_list, n = *pos; v; n -= v->nsyms, v = v->next) {
+		if (n < v->nsyms) {
+			p->mod = v;
+			p->index = n;
+			return p;
 		}
 	}
-leave_the_loop:
-	*start = buf + (offset - begin);
-	len -= (offset - begin);
-	if (len > length)
-		len = length;
-	return len;
+	unlock_kernel();
+	kfree(p);
+	return NULL;
+}
+
+static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct mod_sym *v = p;
+	(*pos)++;
+	if (++v->index >= v->mod->nsyms) {
+		do {
+			v->mod = v->mod->next;
+			if (!v->mod) {
+				unlock_kernel();
+				kfree(p);
+				return NULL;
+			}
+		} while (!v->mod->nsyms);
+		v->index = 0;
+	}
+	return p;
+}
+
+static void s_stop(struct seq_file *m, void *p)
+{
+	if (p && !IS_ERR(p)) {
+		unlock_kernel();
+		kfree(p);
+	}
+}
+
+static int s_show(struct seq_file *m, void *p)
+{
+	struct mod_sym *v = p;
+	struct module_symbol *sym;
+
+	if (!MOD_CAN_QUERY(v->mod))
+		return 0;
+	sym = &v->mod->syms[v->index];
+	if (*v->mod->name)
+		seq_printf(m, "%0*lx %s\t[%s]\n", (int)(2*sizeof(void*)),
+			       sym->value, sym->name, v->mod->name);
+	else
+		seq_printf(m, "%0*lx %s\n", (int)(2*sizeof(void*)),
+			       sym->value, sym->name);
+	return 0;
 }
+
+struct seq_operations ksyms_op = {
+	start:	s_start,
+	next:	s_next,
+	stop:	s_stop,
+	show:	s_show
+};
 
 #else		/* CONFIG_MODULES */
 

