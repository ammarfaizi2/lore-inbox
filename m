Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOUea>; Fri, 15 Dec 2000 15:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131095AbQLOUeT>; Fri, 15 Dec 2000 15:34:19 -0500
Received: from office.ilan.net ([216.27.3.20]:17169 "EHLO office.ilan.net")
	by vger.kernel.org with ESMTP id <S129340AbQLOUeF>;
	Fri, 15 Dec 2000 15:34:05 -0500
Message-ID: <3A3A7915.5060006@holly-springs.nc.us>
Date: Fri, 15 Dec 2000 15:03:33 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18pre21 i686; en-US; 0.6) Gecko/20001205
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Linux 2.2.19pre1 : procfs api
In-Reply-To: <E1470sk-0001kp-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------090202080608050608060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090202080608050608060600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> Ok this is the first block of changes before we merge the VM stuff. This is
> mostly the bits left over from the 2.2.18 port that were deferred as too
> risky near the end of a prerelease set and some bug swats

Here's the procfs patch again... :) Because the 2.2.18 procfs api is 
different than both 2.2.17 and 2.4.0, this patch makes it work like 
2.4.0. It seems like the 2.2.18 changes were a half-way implementation 
of the 2.4.0 api.


--- linux-2.2.18pre25-VIRGIN/include/linux/proc_fs.h	Fri Dec  8 14:57:08 2000
+++ zinux/include/linux/proc_fs.h	Fri Dec  8 23:21:26 2000
@@ -262,6 +262,12 @@
 
 #define PROC_SUPER_MAGIC 0x9fa0
 
+typedef	int (read_proc_t)(char *page, char **start, off_t off,
+			  int count, int *eof, void *data);
+typedef	int (write_proc_t)(struct file *file, const char *buffer,
+			   unsigned long count, void *data);
+typedef int (get_info_t)(char *, char **, off_t, int, int);
+
 /*
  * This is not completely implemented yet. The idea is to
  * create an in-memory tree (like the actual /proc filesystem
@@ -287,24 +293,17 @@
 	gid_t gid;
 	unsigned long size;
 	struct inode_operations * ops;
-	int (*get_info)(char *, char **, off_t, int, int);
+	get_info_t *get_info;
 	void (*fill_inode)(struct inode *, int);
 	struct proc_dir_entry *next, *parent, *subdir;
 	void *data;
-	int (*read_proc)(char *page, char **start, off_t off,
-			 int count, int *eof, void *data);
-	int (*write_proc)(struct file *file, const char *buffer,
-			  unsigned long count, void *data);
+	read_proc_t *read_proc;
+	write_proc_t *write_proc;
 	int (*readlink_proc)(struct proc_dir_entry *de, char *page);
 	unsigned int count;	/* use count */
 	int deleted;		/* delete flag */
 };
 
-typedef	int (read_proc_t)(char *page, char **start, off_t off,
-			  int count, int *eof, void *data);
-typedef	int (write_proc_t)(struct file *file, const char *buffer,
-			   unsigned long count, void *data);
-
 extern int (* dispatch_scsi_info_ptr) (int ino, char *buffer, char **start,
 				off_t offset, int length, int inout);
 
@@ -433,15 +432,33 @@
 /*
  * generic.c
  */
+extern struct proc_dir_entry *proc_symlink(const char *,
+		struct proc_dir_entry *, const char *);
+extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
+
 struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 					 struct proc_dir_entry *parent);
 void remove_proc_entry(const char *name, struct proc_dir_entry *parent);
 
-#define create_proc_info_entry(n, m, b, g) \
-	{ \
-		struct proc_dir_entry *r = create_proc_entry(n, m, b); \
-		if (r) r->get_info = g; \
+extern inline struct proc_dir_entry *create_proc_read_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, 
+	read_proc_t *read_proc, void * data)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) {
+		res->read_proc=read_proc;
+		res->data=data;
 	}
+	return res;
+}
+
+extern inline struct proc_dir_entry *create_proc_info_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) res->get_info=get_info;
+	return res;
+}
 
 /*
  * proc_tty.c
@@ -470,12 +487,18 @@
 	return NULL;
 }
 
-#define create_proc_info_entry(n, m, b, g) \
-	{ \
-		struct proc_dir_entry *r = create_proc_entry(n, m, b); \
-		if (r) r->get_info = g; \
-	}
-
+extern inline struct proc_dir_entry *create_proc_read_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, 													
+	read_proc_t read_proc,
+	void * data) { return NULL; }
+extern inline struct proc_dir_entry *create_proc_info_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+	{ return NULL; }
+
+extern inline struct proc_dir_entry *proc_symlink(const char *name,
+		struct proc_dir_entry *parent,char *dest) {return NULL;}
+extern inline struct proc_dir_entry *proc_mkdir(const char *name,
+	struct proc_dir_entry *parent) {return NULL;}
 
 extern inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
 
@@ -485,7 +508,5 @@
 extern struct proc_dir_entry proc_root;
 
 #endif /* CONFIG_PROC_FS */
-
-#define proc_mkdir(buf, usbdir)	create_proc_entry(buf, S_IFDIR, usbdir)
 
 #endif /* _LINUX_PROC_FS_H */
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/generic.c zinux/fs/proc/generic.c
--- linux-2.2.18pre25-VIRGIN/fs/proc/generic.c	Fri Dec  8 14:57:07 2000
+++ zinux/fs/proc/generic.c	Fri Dec  8 17:58:34 2000
@@ -246,6 +246,65 @@
 	return 0;
 }
 
+struct proc_dir_entry *proc_symlink(const char *name,
+		struct proc_dir_entry *parent, const char *dest)
+{
+	struct proc_dir_entry *ent = NULL;
+	const char *fn = name;
+	int len;
+
+	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
+		goto out;
+	len = strlen(fn);
+
+	ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);
+	if (!ent)
+		goto out;
+	memset(ent, 0, sizeof(struct proc_dir_entry));
+	memcpy(((char *) ent) + sizeof(*ent), fn, len + 1);
+	ent->name = ((char *) ent) + sizeof(*ent);
+	ent->namelen = len;
+	ent->nlink = 1;
+	ent->mode = S_IFLNK|S_IRUGO|S_IWUGO|S_IXUGO;
+	ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
+	if (!ent->data) {
+		kfree(ent);
+		goto out;
+	}
+	strcpy((char*)ent->data,dest);
+
+	proc_register(parent, ent);
+	
+out:
+	return ent;
+}
+
+struct proc_dir_entry *proc_mkdir(const char *name, struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry *ent = NULL;
+	const char *fn = name;
+	int len;
+
+	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
+		goto out;
+	len = strlen(fn);
+
+	ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);
+	if (!ent)
+		goto out;
+	memset(ent, 0, sizeof(struct proc_dir_entry));
+	memcpy(((char *) ent) + sizeof(*ent), fn, len + 1);
+	ent->name = ((char *) ent) + sizeof(*ent);
+	ent->namelen = len;
+	ent->nlink = 2;
+	ent->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+
+	proc_register(parent, ent);
+	
+out:
+	return ent;
+}
+
 struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 					 struct proc_dir_entry *parent)
 {
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c zinux/fs/proc/openpromfs.c
--- linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c	Fri Dec  8 14:57:07 2000
+++ zinux/fs/proc/openpromfs.c	Fri Dec  8 15:08:59 2000
@@ -1,4 +1,4 @@
-/* $Id: openpromfs.c,v 1.33 1999/04/28 11:57:33 davem Exp $
+/* $Id: openpromfs.c,v 1.1.1.1 2000/12/08 20:08:59 zapman Exp $
  * openpromfs.c: /proc/openprom handling routines
  *
  * Copyright (C) 1996-1998 Jakub Jelinek  (jj@sunsite.mff.cuni.cz)
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/procfs_syms.c zinux/fs/proc/procfs_syms.c
--- linux-2.2.18pre25-VIRGIN/fs/proc/procfs_syms.c	Fri Dec  8 14:57:07 2000
+++ zinux/fs/proc/procfs_syms.c	Fri Dec  8 18:12:37 2000
@@ -19,6 +19,8 @@
 EXPORT_SYMBOL(proc_register);
 EXPORT_SYMBOL(proc_unregister);
 EXPORT_SYMBOL(create_proc_entry);
+EXPORT_SYMBOL(proc_mkdir);
+EXPORT_SYMBOL(proc_symlink);
 EXPORT_SYMBOL(remove_proc_entry);
 EXPORT_SYMBOL(proc_root);
 EXPORT_SYMBOL(proc_root_fs);


--------------090202080608050608060600
Content-Type: text/plain;
 name="2.2.19-procfs-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.2.19-procfs-patch"

--- linux-2.2.18pre25-VIRGIN/include/linux/proc_fs.h	Fri Dec  8 14:57:08 2000
+++ zinux/include/linux/proc_fs.h	Fri Dec  8 23:21:26 2000
@@ -262,6 +262,12 @@
 
 #define PROC_SUPER_MAGIC 0x9fa0
 
+typedef	int (read_proc_t)(char *page, char **start, off_t off,
+			  int count, int *eof, void *data);
+typedef	int (write_proc_t)(struct file *file, const char *buffer,
+			   unsigned long count, void *data);
+typedef int (get_info_t)(char *, char **, off_t, int, int);
+
 /*
  * This is not completely implemented yet. The idea is to
  * create an in-memory tree (like the actual /proc filesystem
@@ -287,24 +293,17 @@
 	gid_t gid;
 	unsigned long size;
 	struct inode_operations * ops;
-	int (*get_info)(char *, char **, off_t, int, int);
+	get_info_t *get_info;
 	void (*fill_inode)(struct inode *, int);
 	struct proc_dir_entry *next, *parent, *subdir;
 	void *data;
-	int (*read_proc)(char *page, char **start, off_t off,
-			 int count, int *eof, void *data);
-	int (*write_proc)(struct file *file, const char *buffer,
-			  unsigned long count, void *data);
+	read_proc_t *read_proc;
+	write_proc_t *write_proc;
 	int (*readlink_proc)(struct proc_dir_entry *de, char *page);
 	unsigned int count;	/* use count */
 	int deleted;		/* delete flag */
 };
 
-typedef	int (read_proc_t)(char *page, char **start, off_t off,
-			  int count, int *eof, void *data);
-typedef	int (write_proc_t)(struct file *file, const char *buffer,
-			   unsigned long count, void *data);
-
 extern int (* dispatch_scsi_info_ptr) (int ino, char *buffer, char **start,
 				off_t offset, int length, int inout);
 
@@ -433,15 +432,33 @@
 /*
  * generic.c
  */
+extern struct proc_dir_entry *proc_symlink(const char *,
+		struct proc_dir_entry *, const char *);
+extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
+
 struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 					 struct proc_dir_entry *parent);
 void remove_proc_entry(const char *name, struct proc_dir_entry *parent);
 
-#define create_proc_info_entry(n, m, b, g) \
-	{ \
-		struct proc_dir_entry *r = create_proc_entry(n, m, b); \
-		if (r) r->get_info = g; \
+extern inline struct proc_dir_entry *create_proc_read_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, 
+	read_proc_t *read_proc, void * data)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) {
+		res->read_proc=read_proc;
+		res->data=data;
 	}
+	return res;
+}
+
+extern inline struct proc_dir_entry *create_proc_info_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) res->get_info=get_info;
+	return res;
+}
 
 /*
  * proc_tty.c
@@ -470,12 +487,18 @@
 	return NULL;
 }
 
-#define create_proc_info_entry(n, m, b, g) \
-	{ \
-		struct proc_dir_entry *r = create_proc_entry(n, m, b); \
-		if (r) r->get_info = g; \
-	}
-
+extern inline struct proc_dir_entry *create_proc_read_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, 													
+	read_proc_t read_proc,
+	void * data) { return NULL; }
+extern inline struct proc_dir_entry *create_proc_info_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+	{ return NULL; }
+
+extern inline struct proc_dir_entry *proc_symlink(const char *name,
+		struct proc_dir_entry *parent,char *dest) {return NULL;}
+extern inline struct proc_dir_entry *proc_mkdir(const char *name,
+	struct proc_dir_entry *parent) {return NULL;}
 
 extern inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
 
@@ -485,7 +508,5 @@
 extern struct proc_dir_entry proc_root;
 
 #endif /* CONFIG_PROC_FS */
-
-#define proc_mkdir(buf, usbdir)	create_proc_entry(buf, S_IFDIR, usbdir)
 
 #endif /* _LINUX_PROC_FS_H */
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/generic.c zinux/fs/proc/generic.c
--- linux-2.2.18pre25-VIRGIN/fs/proc/generic.c	Fri Dec  8 14:57:07 2000
+++ zinux/fs/proc/generic.c	Fri Dec  8 17:58:34 2000
@@ -246,6 +246,65 @@
 	return 0;
 }
 
+struct proc_dir_entry *proc_symlink(const char *name,
+		struct proc_dir_entry *parent, const char *dest)
+{
+	struct proc_dir_entry *ent = NULL;
+	const char *fn = name;
+	int len;
+
+	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
+		goto out;
+	len = strlen(fn);
+
+	ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);
+	if (!ent)
+		goto out;
+	memset(ent, 0, sizeof(struct proc_dir_entry));
+	memcpy(((char *) ent) + sizeof(*ent), fn, len + 1);
+	ent->name = ((char *) ent) + sizeof(*ent);
+	ent->namelen = len;
+	ent->nlink = 1;
+	ent->mode = S_IFLNK|S_IRUGO|S_IWUGO|S_IXUGO;
+	ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
+	if (!ent->data) {
+		kfree(ent);
+		goto out;
+	}
+	strcpy((char*)ent->data,dest);
+
+	proc_register(parent, ent);
+	
+out:
+	return ent;
+}
+
+struct proc_dir_entry *proc_mkdir(const char *name, struct proc_dir_entry *parent)
+{
+	struct proc_dir_entry *ent = NULL;
+	const char *fn = name;
+	int len;
+
+	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
+		goto out;
+	len = strlen(fn);
+
+	ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);
+	if (!ent)
+		goto out;
+	memset(ent, 0, sizeof(struct proc_dir_entry));
+	memcpy(((char *) ent) + sizeof(*ent), fn, len + 1);
+	ent->name = ((char *) ent) + sizeof(*ent);
+	ent->namelen = len;
+	ent->nlink = 2;
+	ent->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+
+	proc_register(parent, ent);
+	
+out:
+	return ent;
+}
+
 struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 					 struct proc_dir_entry *parent)
 {
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c zinux/fs/proc/openpromfs.c
--- linux-2.2.18pre25-VIRGIN/fs/proc/openpromfs.c	Fri Dec  8 14:57:07 2000
+++ zinux/fs/proc/openpromfs.c	Fri Dec  8 15:08:59 2000
@@ -1,4 +1,4 @@
-/* $Id: openpromfs.c,v 1.33 1999/04/28 11:57:33 davem Exp $
+/* $Id: openpromfs.c,v 1.1.1.1 2000/12/08 20:08:59 zapman Exp $
  * openpromfs.c: /proc/openprom handling routines
  *
  * Copyright (C) 1996-1998 Jakub Jelinek  (jj@sunsite.mff.cuni.cz)
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/procfs_syms.c zinux/fs/proc/procfs_syms.c
--- linux-2.2.18pre25-VIRGIN/fs/proc/procfs_syms.c	Fri Dec  8 14:57:07 2000
+++ zinux/fs/proc/procfs_syms.c	Fri Dec  8 18:12:37 2000
@@ -19,6 +19,8 @@
 EXPORT_SYMBOL(proc_register);
 EXPORT_SYMBOL(proc_unregister);
 EXPORT_SYMBOL(create_proc_entry);
+EXPORT_SYMBOL(proc_mkdir);
+EXPORT_SYMBOL(proc_symlink);
 EXPORT_SYMBOL(remove_proc_entry);
 EXPORT_SYMBOL(proc_root);
 EXPORT_SYMBOL(proc_root_fs);

--------------090202080608050608060600--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
