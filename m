Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLICDP>; Fri, 8 Dec 2000 21:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLICDF>; Fri, 8 Dec 2000 21:03:05 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:10001 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129436AbQLICCs>; Fri, 8 Dec 2000 21:02:48 -0500
Message-ID: <3A318B7E.A4035063@holly-springs.nc.us>
Date: Fri, 08 Dec 2000 20:31:42 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, zapman@interlan.net
Subject: [PATCH] 2.4.0 proc_fs for 2.2.18
In-Reply-To: <E144A1O-000371-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------49BAEFC96193F21E473758A5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------49BAEFC96193F21E473758A5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> > Why is 2.2.18 proc_fs.c different than both 2.2.17 and 2.4.0? Cox, would
> > you accept a patch that makes 2.2.18 define create_proc_info_entry and
> > related functions the same way that 2.4.0 does?
> 
> Send me a diff and I'll be happy to

Here it is, both inlined and as an attachment. It's been tested;
compiles, boots, works. Let me know what you think.

-M

--- linux-2.2.18pre25-VIRGIN/include/linux/proc_fs.h	Fri Dec  8 14:57:08
2000
+++ zinux/include/linux/proc_fs.h	Fri Dec  8 17:57:05 2000
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
 extern int (* dispatch_scsi_info_ptr) (int ino, char *buffer, char
**start,
 				off_t offset, int length, int inout);
 
@@ -433,15 +432,21 @@
 /*
  * generic.c
  */
+extern struct proc_dir_entry *proc_symlink(const char *,
+		struct proc_dir_entry *, const char *);
+extern struct proc_dir_entry *proc_mkdir(const char *,struct
proc_dir_entry *);
+
 struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 					 struct proc_dir_entry *parent);
 void remove_proc_entry(const char *name, struct proc_dir_entry
*parent);
 
-#define create_proc_info_entry(n, m, b, g) \
-	{ \
-		struct proc_dir_entry *r = create_proc_entry(n, m, b); \
-		if (r) r->get_info = g; \
-	}
+extern inline struct proc_dir_entry *create_proc_info_entry(const char
*name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) res->get_info=get_info;
+	return res;
+}
 
 /*
  * proc_tty.c
@@ -470,12 +475,18 @@
 	return NULL;
 }
 
-#define create_proc_info_entry(n, m, b, g) \
-	{ \
-		struct proc_dir_entry *r = create_proc_entry(n, m, b); \
-		if (r) r->get_info = g; \
-	}
-
+extern inline struct proc_dir_entry *create_proc_read_entry(const char
*name,
+	mode_t mode, struct proc_dir_entry *base, 													
+	read_proc_t read_proc,
+	void * data) { return NULL; }
+extern inline struct proc_dir_entry *create_proc_info_entry(const char
*name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+	{ return NULL; }
+
+extern inline struct proc_dir_entry *proc_symlink(const char *name,
+		struct proc_dir_entry *parent,char *dest) {return NULL;}
+extern inline struct proc_dir_entry *proc_mkdir(const char *name,
+	struct proc_dir_entry *parent) {return NULL;}
 
 extern inline void remove_proc_entry(const char *name, struct
proc_dir_entry *parent) {};
 
@@ -485,7 +496,5 @@
 extern struct proc_dir_entry proc_root;
 
 #endif /* CONFIG_PROC_FS */
-
-#define proc_mkdir(buf, usbdir)	create_proc_entry(buf, S_IFDIR, usbdir)
 
 #endif /* _LINUX_PROC_FS_H */
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/generic.c
zinux/fs/proc/generic.c
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
+struct proc_dir_entry *proc_mkdir(const char *name, struct
proc_dir_entry *parent)
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
diff -r -u -x CVS -x *.o linux-2.2.18pre25-VIRGIN/fs/proc/procfs_syms.c
zinux/fs/proc/procfs_syms.c
--- linux-2.2.18pre25-VIRGIN/fs/proc/procfs_syms.c	Fri Dec  8 14:57:07
2000
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
--------------49BAEFC96193F21E473758A5
Content-Type: text/plain; charset=us-ascii;
 name="real-procfs-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="real-procfs-patch"

--- linux-2.2.18pre25-VIRGIN/include/linux/proc_fs.h	Fri Dec  8 14:57:08 2000
+++ zinux/include/linux/proc_fs.h	Fri Dec  8 17:57:05 2000
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
 
@@ -433,15 +432,21 @@
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
-	}
+extern inline struct proc_dir_entry *create_proc_info_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) res->get_info=get_info;
+	return res;
+}
 
 /*
  * proc_tty.c
@@ -470,12 +475,18 @@
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
 
@@ -485,7 +496,5 @@
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

--------------49BAEFC96193F21E473758A5--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
