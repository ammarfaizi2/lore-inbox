Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRALQk6>; Fri, 12 Jan 2001 11:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbRALQky>; Fri, 12 Jan 2001 11:40:54 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:63762 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S129632AbRALQkg>; Fri, 12 Jan 2001 11:40:36 -0500
Date: Fri, 12 Jan 2001 16:40:33 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH] srcdocs for sysctl
Message-ID: <Pine.LNX.4.21.0101121638220.24398-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is some documentation for sysctl API. It also fixed a warning
with fs/super.c, and makes the default target for the DocBook makefile a
little saner (though everyone should be using make htmldocs of course)

It's against 2.4.0ac8

thanks
john

diff -Naur -X /home/S96/levonj5/disk/dontdiff linux/Documentation/DocBook/Makefile new/Documentation/DocBook/Makefile
--- linux/Documentation/DocBook/Makefile	Sun Dec 31 02:16:13 2000
+++ new/Documentation/DocBook/Makefile	Fri Jan 12 16:01:44 2001
@@ -9,12 +9,12 @@
 EPS-parportbook := $(patsubst %.fig, %.eps, $(IMG-parportbook))
 JPG-parportbook := $(patsubst %.fig, %.jpeg, $(IMG-parportbook))
 
+books:	$(BOOKS)
+
 $(BOOKS): $(TOPDIR)/scripts/docproc
 
 .PHONY:	books ps pdf html clean mrproper
 
-books:	$(BOOKS)
-
 ps:	$(PS)
 
 pdf:	$(PDF)
@@ -79,6 +79,7 @@
 		$(TOPDIR)/drivers/usb/usb.c \
 		$(TOPDIR)/fs/locks.c \
 		$(TOPDIR)/fs/devfs/base.c \
+		$(TOPDIR)/kernel/sysctl.c \
 		$(TOPDIR)/kernel/pm.c \
 		$(TOPDIR)/kernel/ksyms.c \
 		$(TOPDIR)/net/netsyms.c
diff -Naur -X /home/S96/levonj5/disk/dontdiff linux/Documentation/DocBook/kernel-api.tmpl new/Documentation/DocBook/kernel-api.tmpl
--- linux/Documentation/DocBook/kernel-api.tmpl	Fri Jan 12 16:30:14 2001
+++ new/Documentation/DocBook/kernel-api.tmpl	Fri Jan 12 16:27:47 2001
@@ -60,6 +60,14 @@
       </sect1>
   </chapter>
 
+  <chapter id="proc">
+     <title>The proc filesystem</title>
+ 
+     <sect1><title>sysctl interface</title>
+!Ekernel/sysctl.c
+     </sect1>
+  </chapter>
+
   <chapter id="vfs">
      <title>The Linux VFS</title>
      <sect1><title>The Directory Cache</title>
diff -Naur -X /home/S96/levonj5/disk/dontdiff linux/fs/super.c new/fs/super.c
--- linux/fs/super.c	Fri Jan 12 16:30:33 2001
+++ new/fs/super.c	Fri Jan 12 16:28:21 2001
@@ -281,6 +281,8 @@
 
 static LIST_HEAD(vfsmntlist);
 
+static char nomem_name [] = "ENOMEM";
+
 /**
  *	add_vfsmnt - add a new mount node
  *	@nd: location of mountpoint or %NULL if we want a root node
@@ -303,9 +305,6 @@
  *	will have to pass the visibility flag explicitly, so if we will add
  *	support for such beasts we'll have to change prototype.
  */
-
-static char nomem_name [] = "ENOMEM";
-
 static struct vfsmount *add_vfsmnt(struct nameidata *nd,
 				struct dentry *root,
 				const char *dev_name)
diff -Naur -X /home/S96/levonj5/disk/dontdiff linux/kernel/sysctl.c new/kernel/sysctl.c
--- linux/kernel/sysctl.c	Fri Jan 12 16:30:38 2001
+++ new/kernel/sysctl.c	Fri Jan 12 16:27:56 2001
@@ -483,13 +483,82 @@
 	return 0;
 }
 
+/**
+ * register_sysctl_table - register a sysctl heirarchy
+ * @table: the top-level table structure
+ * @insert_at_head: whether the entry should be inserted in front or at the end
+ *
+ * Register a sysctl table heirarchy. @table should be a filled in ctl_table
+ * array. An entry with a ctl_name of 0 terminates the table. 
+ *
+ * The members of the &ctl_table structure are used as follows:
+ *
+ * ctl_name - This is the numeric sysctl value used by sysctl(2). The number
+ *            must be unique within that level of sysctl
+ *
+ * procname - the name of the sysctl file under /proc/sys. Set to %NULL to not
+ *            enter a sysctl file
+ *
+ * data - a pointer to data for use by proc_handler
+ *
+ * maxlen - the maximum size in bytes of the data
+ *
+ * mode - the file permissions for the /proc/sys file, and for sysctl(2)
+ *
+ * child - a pointer to the child sysctl table if this entry is a directory, or
+ *         %NULL.
+ *
+ * proc_handler - the text handler routine (described below)
+ *
+ * strategy - the strategy routine (described below)
+ *
+ * de - for internal use by the sysctl routines
+ *
+ * extra1, extra2 - extra pointers usable by the proc handler routines
+ *
+ * Leaf nodes in the sysctl tree will be represented by a single file
+ * under /proc; non-leaf nodes will be represented by directories.
+ *
+ * sysctl(2) can automatically manage read and write requests through
+ * the sysctl table.  The data and maxlen fields of the ctl_table
+ * struct enable minimal validation of the values being written to be
+ * performed, and the mode field allows minimal authentication.
+ *
+ * More sophisticated management can be enabled by the provision of a
+ * strategy routine with the table entry.  This will be called before
+ * any automatic read or write of the data is performed.
+ *
+ * The strategy routine may return
+ *
+ * < 0 - Error occurred (error is passed to user process)
+ *
+ * 0   - OK - proceed with automatic read or write.
+ *
+ * > 0 - OK - read or write has been done by the strategy routine, so
+ *       return immediately.
+ *
+ * There must be a proc_handler routine for any terminal nodes
+ * mirrored under /proc/sys (non-terminals are handled by a built-in
+ * directory handler).  Several default handlers are available to
+ * cover common cases -
+ *
+ * proc_dostring(), proc_dointvec(), proc_dointvec_jiffies(),
+ * proc_dointvec_minmax(), proc_doulongvec_ms_jiffies_minmax(),
+ * proc_doulongvec_minmax()
+ *
+ * It is the handler's job to read the input buffer from user memory
+ * and process it. The handler should return 0 on success.
+ *
+ * This routine returns %NULL on a failure to register, and a pointer
+ * to the table header on success.
+ */
 struct ctl_table_header *register_sysctl_table(ctl_table * table, 
 					       int insert_at_head)
 {
 	struct ctl_table_header *tmp;
 	tmp = kmalloc(sizeof(struct ctl_table_header), GFP_KERNEL);
 	if (!tmp)
-		return 0;
+		return NULL;
 	tmp->ctl_table = table;
 	INIT_LIST_HEAD(&tmp->ctl_entry);
 	if (insert_at_head)
@@ -502,8 +571,12 @@
 	return tmp;
 }
 
-/*
- * Unlink and free a ctl_table.
+/**
+ * unregister_sysctl_table - unregister a sysctl table heirarchy
+ * @header: the header returned from register_sysctl_table
+ *
+ * Unregisters the sysctl table and all children. proc entries may not
+ * actually be removed until they are no longer used by anyone.
  */
 void unregister_sysctl_table(struct ctl_table_header * header)
 {
@@ -647,6 +720,23 @@
 	return test_perm(inode->i_mode, op);
 }
 
+/**
+ * proc_dostring - read a string sysctl
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes a string from/to the user buffer. If the kernel
+ * buffer provided is not large enough to hold the string, the
+ * string is truncated. The copied string is %NULL-terminated.
+ * If the string is being read by the user process, it is copied
+ * and a newline '\n' is added. It is truncated if the buffer is
+ * not large enough.
+ *
+ * Returns 0 on success.
+ */
 int proc_dostring(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp)
 {
@@ -824,6 +914,19 @@
 	return 0;
 }
 
+/**
+ * proc_dointvec - read a vector of integers
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string. 
+ *
+ * Returns 0 on success.
+ */
 int proc_dointvec(ctl_table *table, int write, struct file *filp,
 		     void *buffer, size_t *lenp)
 {
@@ -844,6 +947,22 @@
 				(current->pid == 1) ? OP_SET : OP_AND);
 }
 
+/**
+ * proc_dointvec_minmax - read a vector of integers with min/max values
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ *
+ * This routine will ensure the values are within the range specified by
+ * table->extra1 (min) and table->extra2 (max).
+ *
+ * Returns 0 on success.
+ */
 int proc_dointvec_minmax(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp)
 {
@@ -942,10 +1061,6 @@
 	return 0;
 }
 
-/*
- * an unsigned long function version
- */
-
 static int do_proc_doulongvec_minmax(ctl_table *table, int write,
 				     struct file *filp,
 				     void *buffer, size_t *lenp,
@@ -1051,12 +1166,45 @@
 #undef TMPBUFLEN
 }
 
+/**
+ * proc_doulongvec_minmax - read a vector of long integers with min/max values
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
+ * values from/to the user buffer, treated as an ASCII string.
+ *
+ * This routine will ensure the values are within the range specified by
+ * table->extra1 (min) and table->extra2 (max).
+ *
+ * Returns 0 on success.
+ */
 int proc_doulongvec_minmax(ctl_table *table, int write, struct file *filp,
 			   void *buffer, size_t *lenp)
 {
     return do_proc_doulongvec_minmax(table, write, filp, buffer, lenp, 1l, 1l);
 }
 
+/**
+ * proc_doulongvec_ms_jiffies_minmax - read a vector of millisecond values with min/max values
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
+ * values from/to the user buffer, treated as an ASCII string. The values
+ * are treated as milliseconds, and converted to jiffies when they are stored.
+ *
+ * This routine will ensure the values are within the range specified by
+ * table->extra1 (min) and table->extra2 (max).
+ *
+ * Returns 0 on success.
+ */
 int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int write,
 				      struct file *filp,
 				      void *buffer, size_t *lenp)
@@ -1066,7 +1214,21 @@
 }
 
 
-/* Like proc_dointvec, but converts seconds to jiffies */
+/**
+ * proc_dointvec_jiffies - read a vector of integers as seconds
+ * @table: the sysctl table
+ * @write: %TRUE if this is a write to the sysctl file
+ * @filp: the file structure
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string. 
+ * The values read are assumed to be in seconds, and are converted into
+ * jiffies.
+ *
+ * Returns 0 on success.
+ */
 int proc_dointvec_jiffies(ctl_table *table, int write, struct file *filp,
 			  void *buffer, size_t *lenp)
 {


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
