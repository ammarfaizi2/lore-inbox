Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVFWR0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVFWR0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVFWRZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:25:54 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:19916 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262636AbVFWRHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:07:15 -0400
Date: Thu, 23 Jun 2005 19:07:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, holzheu@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/3] s390: debug feature changes.
Message-ID: <20050623170716.GC7262@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/3] s390: debug feature changes.

From: Michael Holzheu <holzheu@de.ibm.com>

This patch changes the memory allocation method for the s390
debug feature. Trace buffers had been allocated using the
get_free_pages() function before. Therefore it was not possible to
get big memory areas in a running system due to memory
fragmentation. Now the trace buffers are subdivided into several
subbuffers with pagesize. Therefore it is now possible to allocate
more memory for the trace buffers and more trace records can be
written.

In addition to that, dynamic specification of the size of the
trace buffers is implemented. It is now possible to change the
size of a trace buffer using a new debugfs file instance. When
writing a number into this file, the trace buffer size is changed
to 'number * pagesize'.

In the past all the traces could be obtained from userspace by
accessing files in the "proc" filesystem. Now with debugfs
we have a new filesystem which should be used for debugging
purposes. This patch moves the debug feature from procfs
to debugfs.

Since the interface of debug_register() changed, all device
drivers, which use the debug feature had to be adjusted.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 Documentation/s390/s390dbf.txt |   79 ++-
 arch/s390/kernel/debug.c       |  828 ++++++++++++++++++++++++++---------------
 drivers/s390/block/dasd.c      |    4 
 drivers/s390/block/dasd_proc.c |    3 
 drivers/s390/char/tape_34xx.c  |    6 
 drivers/s390/char/tape_core.c  |    2 
 drivers/s390/char/tape_proc.c  |    1 
 drivers/s390/char/vmcp.c       |    2 
 drivers/s390/cio/cio.c         |    8 
 drivers/s390/cio/qdio.c        |   14 
 drivers/s390/cio/qdio.h        |   16 
 drivers/s390/net/claw.c        |    4 
 drivers/s390/net/ctcdbug.c     |   10 
 drivers/s390/net/ctcdbug.h     |   10 
 drivers/s390/net/iucv.h        |    6 
 drivers/s390/net/lcs.c         |    8 
 drivers/s390/net/netiucv.c     |   12 
 drivers/s390/net/qeth.h        |   14 
 drivers/s390/net/qeth_main.c   |   14 
 include/asm-s390/debug.h       |   48 +-
 20 files changed, 682 insertions(+), 407 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/debug.c linux-2.6-patched/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/debug.c	2005-06-23 18:57:55.000000000 +0200
@@ -19,22 +19,27 @@
 #include <linux/sysctl.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
-
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/debugfs.h>
 
 #include <asm/debug.h>
 
 #define DEBUG_PROLOG_ENTRY -1
 
+#define ALL_AREAS 0 /* copy all debug areas */
+#define NO_AREAS  1 /* copy no debug areas */
+
 /* typedefs */
 
 typedef struct file_private_info {
 	loff_t offset;			/* offset of last read in file */
 	int    act_area;                /* number of last formated area */
+	int    act_page;                /* act page in given area */
 	int    act_entry;               /* last formated entry (offset */
                                         /* relative to beginning of last */
-                                        /* formated area) */ 
+                                        /* formated page) */
 	size_t act_entry_offset;        /* up to this offset we copied */
 					/* in last read the last formated */
 					/* entry to userland */
@@ -51,8 +56,8 @@ typedef struct
 	 * This assumes that all args are converted into longs 
 	 * on L/390 this is the case for all types of parameter 
 	 * except of floats, and long long (32 bit) 
-         *
-         */
+	 *
+	 */
 	long args[0];
 } debug_sprintf_entry_t;
 
@@ -63,32 +68,38 @@ extern void tod_to_timeval(uint64_t todv
 
 static int debug_init(void);
 static ssize_t debug_output(struct file *file, char __user *user_buf,
-			    size_t user_len, loff_t * offset);
+			size_t user_len, loff_t * offset);
 static ssize_t debug_input(struct file *file, const char __user *user_buf,
-			   size_t user_len, loff_t * offset);
+			size_t user_len, loff_t * offset);
 static int debug_open(struct inode *inode, struct file *file);
 static int debug_close(struct inode *inode, struct file *file);
-static debug_info_t*  debug_info_create(char *name, int page_order, int nr_areas, int buf_size);
+static debug_info_t*  debug_info_create(char *name, int pages_per_area,
+			int nr_areas, int buf_size);
 static void debug_info_get(debug_info_t *);
 static void debug_info_put(debug_info_t *);
 static int debug_prolog_level_fn(debug_info_t * id,
-				 struct debug_view *view, char *out_buf);
+			struct debug_view *view, char *out_buf);
 static int debug_input_level_fn(debug_info_t * id, struct debug_view *view,
-				struct file *file, const char __user *user_buf,
-				size_t user_buf_size, loff_t * offset);
+			struct file *file, const char __user *user_buf,
+			size_t user_buf_size, loff_t * offset);
+static int debug_prolog_pages_fn(debug_info_t * id,
+			struct debug_view *view, char *out_buf);
+static int debug_input_pages_fn(debug_info_t * id, struct debug_view *view,
+			struct file *file, const char __user *user_buf,
+			size_t user_buf_size, loff_t * offset);
 static int debug_input_flush_fn(debug_info_t * id, struct debug_view *view,
-                                struct file *file, const char __user *user_buf,
-                                size_t user_buf_size, loff_t * offset);
+			struct file *file, const char __user *user_buf,
+			size_t user_buf_size, loff_t * offset);
 static int debug_hex_ascii_format_fn(debug_info_t * id, struct debug_view *view,
-                                char *out_buf, const char *in_buf);
+			char *out_buf, const char *in_buf);
 static int debug_raw_format_fn(debug_info_t * id,
-				 struct debug_view *view, char *out_buf,
-				 const char *in_buf);
+			struct debug_view *view, char *out_buf,
+			const char *in_buf);
 static int debug_raw_header_fn(debug_info_t * id, struct debug_view *view,
-                         int area, debug_entry_t * entry, char *out_buf);
+			int area, debug_entry_t * entry, char *out_buf);
 
 static int debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
-				   char *out_buf, debug_sprintf_entry_t *curr_event);
+			char *out_buf, debug_sprintf_entry_t *curr_event);
 
 /* globals */
 
@@ -119,6 +130,15 @@ struct debug_view debug_level_view = {
 	NULL
 };
 
+struct debug_view debug_pages_view = {
+	"pages",
+	&debug_prolog_pages_fn,
+	NULL,
+	NULL,
+	&debug_input_pages_fn,
+	NULL
+};
+
 struct debug_view debug_flush_view = {
         "flush",
         NULL,
@@ -149,98 +169,161 @@ DECLARE_MUTEX(debug_lock);
 static int initialized;
 
 static struct file_operations debug_file_ops = {
-	.owner	 = THIS_MODULE,
+	.owner   = THIS_MODULE,
 	.read    = debug_output,
-	.write   = debug_input,	
+	.write   = debug_input,
 	.open    = debug_open,
 	.release = debug_close,
 };
 
-static struct proc_dir_entry *debug_proc_root_entry;
+static struct dentry *debug_debugfs_root_entry;
 
 /* functions */
 
 /*
+ * debug_areas_alloc
+ * - Debug areas are implemented as a threedimensonal array:
+ *   areas[areanumber][pagenumber][pageoffset]
+ */
+
+static debug_entry_t***
+debug_areas_alloc(int pages_per_area, int nr_areas)
+{
+	debug_entry_t*** areas;
+	int i,j;
+
+	areas = (debug_entry_t ***) kmalloc(nr_areas *
+					sizeof(debug_entry_t**),
+					GFP_KERNEL);
+	if (!areas)
+		goto fail_malloc_areas;
+	for (i = 0; i < nr_areas; i++) {
+		areas[i] = (debug_entry_t**) kmalloc(pages_per_area *
+				sizeof(debug_entry_t*),GFP_KERNEL);
+		if (!areas[i]) {
+			goto fail_malloc_areas2;
+		}
+		for(j = 0; j < pages_per_area; j++) {
+			areas[i][j] = (debug_entry_t*)kmalloc(PAGE_SIZE,
+						GFP_KERNEL);
+			if(!areas[i][j]) {
+				for(j--; j >=0 ; j--) {
+					kfree(areas[i][j]);
+				}
+				kfree(areas[i]);
+				goto fail_malloc_areas2;
+			} else {
+				memset(areas[i][j],0,PAGE_SIZE);
+			}
+		}
+	}
+	return areas;
+
+fail_malloc_areas2:
+	for(i--; i >= 0; i--){
+		for(j=0; j < pages_per_area;j++){
+			kfree(areas[i][j]);
+		}
+		kfree(areas[i]);
+	}
+	kfree(areas);
+fail_malloc_areas:
+	return NULL;
+
+}
+
+
+/*
  * debug_info_alloc
  * - alloc new debug-info
  */
 
-static debug_info_t*  debug_info_alloc(char *name, int page_order,
-                                        int nr_areas, int buf_size)
+static debug_info_t*
+debug_info_alloc(char *name, int pages_per_area, int nr_areas, int buf_size,
+		int level, int mode)
 {
 	debug_info_t* rc;
-	int i;
 
 	/* alloc everything */
 
-	rc = (debug_info_t*) kmalloc(sizeof(debug_info_t), GFP_ATOMIC);
+	rc = (debug_info_t*) kmalloc(sizeof(debug_info_t), GFP_KERNEL);
 	if(!rc)
 		goto fail_malloc_rc;
-	rc->active_entry = (int*)kmalloc(nr_areas * sizeof(int), GFP_ATOMIC);
-	if(!rc->active_entry)
-		goto fail_malloc_active_entry;
-	memset(rc->active_entry, 0, nr_areas * sizeof(int));
-	rc->areas = (debug_entry_t **) kmalloc(nr_areas *
-						sizeof(debug_entry_t *),
-						GFP_ATOMIC);
-	if (!rc->areas)
-		goto fail_malloc_areas;
-	for (i = 0; i < nr_areas; i++) {
-		rc->areas[i] = (debug_entry_t *) __get_free_pages(GFP_ATOMIC,
-								page_order);
-		if (!rc->areas[i]) {
-			for (i--; i >= 0; i--) {
-				free_pages((unsigned long) rc->areas[i],
-						page_order);
-			}
-			goto fail_malloc_areas2;
-		} else {
-			memset(rc->areas[i], 0, PAGE_SIZE << page_order);
-		}
+	rc->active_entries = (int*)kmalloc(nr_areas * sizeof(int), GFP_KERNEL);
+	if(!rc->active_entries)
+		goto fail_malloc_active_entries;
+	memset(rc->active_entries, 0, nr_areas * sizeof(int));
+	rc->active_pages = (int*)kmalloc(nr_areas * sizeof(int), GFP_KERNEL);
+	if(!rc->active_pages)
+		goto fail_malloc_active_pages;
+	memset(rc->active_pages, 0, nr_areas * sizeof(int));
+	if((mode == ALL_AREAS) && (pages_per_area != 0)){
+		rc->areas = debug_areas_alloc(pages_per_area, nr_areas);
+		if(!rc->areas)
+			goto fail_malloc_areas;
+	} else {
+		rc->areas = NULL;
 	}
 
 	/* initialize members */
 
 	spin_lock_init(&rc->lock);
-	rc->page_order  = page_order;
-	rc->nr_areas    = nr_areas;
-	rc->active_area = 0;
-	rc->level       = DEBUG_DEFAULT_LEVEL;
-	rc->buf_size    = buf_size;
-	rc->entry_size  = sizeof(debug_entry_t) + buf_size;
-	strlcpy(rc->name, name, sizeof(rc->name));
+	rc->pages_per_area = pages_per_area;
+	rc->nr_areas       = nr_areas;
+	rc->active_area    = 0;
+	rc->level          = level;
+	rc->buf_size       = buf_size;
+	rc->entry_size     = sizeof(debug_entry_t) + buf_size;
+	strlcpy(rc->name, name, sizeof(rc->name)-1);
 	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
-#ifdef CONFIG_PROC_FS
-	memset(rc->proc_entries, 0 ,DEBUG_MAX_VIEWS *
-		sizeof(struct proc_dir_entry*));
-#endif /* CONFIG_PROC_FS */
+	memset(rc->debugfs_entries, 0 ,DEBUG_MAX_VIEWS *
+		sizeof(struct dentry*));
 	atomic_set(&(rc->ref_count), 0);
 
 	return rc;
 
-fail_malloc_areas2:
-	kfree(rc->areas);
 fail_malloc_areas:
-	kfree(rc->active_entry);
-fail_malloc_active_entry:
+	kfree(rc->active_pages);
+fail_malloc_active_pages:
+	kfree(rc->active_entries);
+fail_malloc_active_entries:
 	kfree(rc);
 fail_malloc_rc:
 	return NULL;
 }
 
 /*
- * debug_info_free
- * - free memory debug-info
+ * debug_areas_free
+ * - free all debug areas
  */
 
-static void debug_info_free(debug_info_t* db_info){
-	int i;
+static void
+debug_areas_free(debug_info_t* db_info)
+{
+	int i,j;
+
+	if(!db_info->areas)
+		return;
 	for (i = 0; i < db_info->nr_areas; i++) {
-		free_pages((unsigned long) db_info->areas[i],
-		db_info->page_order);
+		for(j = 0; j < db_info->pages_per_area; j++) {
+			kfree(db_info->areas[i][j]);
+		}
+		kfree(db_info->areas[i]);
 	}
 	kfree(db_info->areas);
-	kfree(db_info->active_entry);
+	db_info->areas = NULL;
+}
+
+/*
+ * debug_info_free
+ * - free memory debug-info
+ */
+
+static void
+debug_info_free(debug_info_t* db_info){
+	debug_areas_free(db_info);
+	kfree(db_info->active_entries);
+	kfree(db_info->active_pages);
 	kfree(db_info);
 }
 
@@ -249,21 +332,22 @@ static void debug_info_free(debug_info_t
  * - create new debug-info
  */
 
-static debug_info_t*  debug_info_create(char *name, int page_order, 
-                                        int nr_areas, int buf_size)
+static debug_info_t*
+debug_info_create(char *name, int pages_per_area, int nr_areas, int buf_size)
 {
 	debug_info_t* rc;
 
-        rc = debug_info_alloc(name, page_order, nr_areas, buf_size);
+        rc = debug_info_alloc(name, pages_per_area, nr_areas, buf_size,
+				DEBUG_DEFAULT_LEVEL, ALL_AREAS);
         if(!rc) 
 		goto out;
 
-
-	/* create proc rood directory */
-        rc->proc_root_entry = proc_mkdir(rc->name, debug_proc_root_entry);
+	/* create root directory */
+        rc->debugfs_root_entry = debugfs_create_dir(rc->name,
+					debug_debugfs_root_entry);
 
 	/* append new element to linked list */
-        if (debug_area_first == NULL) {
+        if (!debug_area_first) {
                 /* first element in list */
                 debug_area_first = rc;
                 rc->prev = NULL;
@@ -285,17 +369,21 @@ out:
  * - copy debug-info
  */
 
-static debug_info_t* debug_info_copy(debug_info_t* in)
+static debug_info_t*
+debug_info_copy(debug_info_t* in, int mode)
 {
-        int i;
+        int i,j;
         debug_info_t* rc;
-        rc = debug_info_alloc(in->name, in->page_order, 
-                                in->nr_areas, in->buf_size);
-        if(!rc)
-                goto out;
 
+        rc = debug_info_alloc(in->name, in->pages_per_area, in->nr_areas,
+				in->buf_size, in->level, mode);
+        if(!rc || (mode == NO_AREAS))
+                goto out;
+
         for(i = 0; i < in->nr_areas; i++){
-                memcpy(rc->areas[i],in->areas[i], PAGE_SIZE << in->page_order);
+		for(j = 0; j < in->pages_per_area; j++) {
+			memcpy(rc->areas[i][j], in->areas[i][j],PAGE_SIZE);
+		}
         }
 out:
         return rc;
@@ -306,7 +394,8 @@ out:
  * - increments reference count for debug-info
  */
 
-static void debug_info_get(debug_info_t * db_info)
+static void
+debug_info_get(debug_info_t * db_info)
 {
 	if (db_info)
 		atomic_inc(&db_info->ref_count);
@@ -317,29 +406,20 @@ static void debug_info_get(debug_info_t 
  * - decreases reference count for debug-info and frees it if necessary
  */
 
-static void debug_info_put(debug_info_t *db_info)
+static void
+debug_info_put(debug_info_t *db_info)
 {
 	int i;
 
 	if (!db_info)
 		return;
 	if (atomic_dec_and_test(&db_info->ref_count)) {
-#ifdef DEBUG
-		printk(KERN_INFO "debug: freeing debug area %p (%s)\n",
-		       db_info, db_info->name);
-#endif
 		for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
-			if (db_info->views[i] == NULL)
+			if (!db_info->views[i])
 				continue;
-#ifdef CONFIG_PROC_FS
-			remove_proc_entry(db_info->proc_entries[i]->name,
-					  db_info->proc_root_entry);
-#endif
+			debugfs_remove(db_info->debugfs_entries[i]);
 		}
-#ifdef CONFIG_PROC_FS
-		remove_proc_entry(db_info->proc_root_entry->name,
-				  debug_proc_root_entry);
-#endif
+		debugfs_remove(db_info->debugfs_root_entry);
 		if(db_info == debug_area_first)
 			debug_area_first = db_info->next;
 		if(db_info == debug_area_last)
@@ -355,9 +435,9 @@ static void debug_info_put(debug_info_t 
  * - format one debug entry and return size of formated data
  */
 
-static int debug_format_entry(file_private_info_t *p_info)
+static int
+debug_format_entry(file_private_info_t *p_info)
 {
-	debug_info_t *id_org    = p_info->debug_info_org;
 	debug_info_t *id_snap   = p_info->debug_info_snap;
 	struct debug_view *view = p_info->view;
 	debug_entry_t *act_entry;
@@ -365,22 +445,23 @@ static int debug_format_entry(file_priva
 	if(p_info->act_entry == DEBUG_PROLOG_ENTRY){
 		/* print prolog */
         	if (view->prolog_proc)
-                	len += view->prolog_proc(id_org, view,p_info->temp_buf);
+                	len += view->prolog_proc(id_snap,view,p_info->temp_buf);
 		goto out;
 	}
-
-	act_entry = (debug_entry_t *) ((char*)id_snap->areas[p_info->act_area] +
-					p_info->act_entry);
+	if (!id_snap->areas) /* this is true, if we have a prolog only view */
+		goto out;    /* or if 'pages_per_area' is 0 */
+	act_entry = (debug_entry_t *) ((char*)id_snap->areas[p_info->act_area]
+				[p_info->act_page] + p_info->act_entry);
                         
 	if (act_entry->id.stck == 0LL)
 			goto out;  /* empty entry */
 	if (view->header_proc)
-		len += view->header_proc(id_org, view, p_info->act_area, 
+		len += view->header_proc(id_snap, view, p_info->act_area,
 					act_entry, p_info->temp_buf + len);
 	if (view->format_proc)
-		len += view->format_proc(id_org, view, p_info->temp_buf + len,
+		len += view->format_proc(id_snap, view, p_info->temp_buf + len,
 						DEBUG_DATA(act_entry));
-      out:
+out:
         return len;
 }
 
@@ -389,20 +470,30 @@ static int debug_format_entry(file_priva
  * - goto next entry in p_info
  */
 
-extern inline int debug_next_entry(file_private_info_t *p_info)
+extern inline int
+debug_next_entry(file_private_info_t *p_info)
 {
-	debug_info_t *id = p_info->debug_info_snap;
+	debug_info_t *id;
+
+	id = p_info->debug_info_snap;
 	if(p_info->act_entry == DEBUG_PROLOG_ENTRY){
 		p_info->act_entry = 0;
+		p_info->act_page  = 0;
 		goto out;
 	}
-	if ((p_info->act_entry += id->entry_size)
-		> ((PAGE_SIZE << (id->page_order)) 
-		- id->entry_size)){
-
-		/* next area */
+	if(!id->areas)
+		return 1;
+	p_info->act_entry += id->entry_size;
+	/* switch to next page, if we reached the end of the page  */
+	if (p_info->act_entry > (PAGE_SIZE - id->entry_size)){
+		/* next page */
 		p_info->act_entry = 0;
-        	p_info->act_area++;
+		p_info->act_page += 1;
+		if((p_info->act_page % id->pages_per_area) == 0) {
+			/* next area */
+        		p_info->act_area++;
+			p_info->act_page=0;
+		}
         	if(p_info->act_area >= id->nr_areas)
 			return 1;
 	}
@@ -416,13 +507,14 @@ out:
  * - copies formated debug entries to the user buffer
  */
 
-static ssize_t debug_output(struct file *file,		/* file descriptor */
-			    char __user *user_buf,	/* user buffer */
-			    size_t  len,		/* length of buffer */
-			    loff_t *offset)	      /* offset in the file */
+static ssize_t
+debug_output(struct file *file,		/* file descriptor */
+	    char __user *user_buf,	/* user buffer */
+	    size_t  len,		/* length of buffer */
+	    loff_t *offset)		/* offset in the file */
 {
 	size_t count = 0;
-	size_t entry_offset, size = 0;
+	size_t entry_offset;
 	file_private_info_t *p_info;
 
 	p_info = ((file_private_info_t *) file->private_data);
@@ -430,27 +522,33 @@ static ssize_t debug_output(struct file 
 		return -EPIPE;
 	if(p_info->act_area >= p_info->debug_info_snap->nr_areas)
 		return 0;
-
 	entry_offset = p_info->act_entry_offset;
-
 	while(count < len){
-		size = debug_format_entry(p_info);
-		size = min((len - count), (size - entry_offset));
-
-		if(size){
-			if (copy_to_user(user_buf + count, 
-					p_info->temp_buf + entry_offset, size))
-			return -EFAULT;
+		int formatted_line_size;
+		int formatted_line_residue;
+		int user_buf_residue;
+		size_t copy_size;
+
+		formatted_line_size = debug_format_entry(p_info);
+		formatted_line_residue = formatted_line_size - entry_offset;
+		user_buf_residue = len-count;
+		copy_size = min(user_buf_residue, formatted_line_residue);
+		if(copy_size){
+			if (copy_to_user(user_buf + count, p_info->temp_buf
+					+ entry_offset, copy_size))
+				return -EFAULT;
+			count += copy_size;
+			entry_offset += copy_size;
 		}
-		count += size;
-		entry_offset = 0;
-		if(count != len)
-			if(debug_next_entry(p_info)) 
+		if(copy_size == formatted_line_residue){
+			entry_offset = 0;
+			if(debug_next_entry(p_info))
 				goto out;
+		}
 	}
 out:
 	p_info->offset           = *offset + count;
-	p_info->act_entry_offset = size;	
+	p_info->act_entry_offset = entry_offset;
 	*offset = p_info->offset;
 	return count;
 }
@@ -461,9 +559,9 @@ out:
  * - calls input function of view
  */
 
-static ssize_t debug_input(struct file *file,
-			   const char __user *user_buf, size_t length,
-			   loff_t *offset)
+static ssize_t
+debug_input(struct file *file, const char __user *user_buf, size_t length,
+		loff_t *offset)
 {
 	int rc = 0;
 	file_private_info_t *p_info;
@@ -487,26 +585,23 @@ static ssize_t debug_input(struct file *
  *   handle
  */
 
-static int debug_open(struct inode *inode, struct file *file)
+static int
+debug_open(struct inode *inode, struct file *file)
 {
 	int i = 0, rc = 0;
 	file_private_info_t *p_info;
 	debug_info_t *debug_info, *debug_info_snapshot;
 
-#ifdef DEBUG
-	printk("debug_open\n");
-#endif
 	down(&debug_lock);
 
 	/* find debug log and view */
-
 	debug_info = debug_area_first;
 	while(debug_info != NULL){
 		for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
-			if (debug_info->views[i] == NULL)
+			if (!debug_info->views[i])
 				continue;
-			else if (debug_info->proc_entries[i] ==
-				 PDE(file->f_dentry->d_inode)) {
+			else if (debug_info->debugfs_entries[i] ==
+				 file->f_dentry) {
 				goto found;	/* found view ! */
 			}
 		}
@@ -516,41 +611,42 @@ static int debug_open(struct inode *inod
 	rc = -EINVAL;
 	goto out;
 
-      found:
-
-	/* make snapshot of current debug areas to get it consistent */
+found:
 
-	debug_info_snapshot = debug_info_copy(debug_info);
+	/* Make snapshot of current debug areas to get it consistent.     */
+	/* To copy all the areas is only needed, if we have a view which  */
+	/* formats the debug areas. */
+
+	if(!debug_info->views[i]->format_proc &&
+		!debug_info->views[i]->header_proc){
+		debug_info_snapshot = debug_info_copy(debug_info, NO_AREAS);
+	} else {
+		debug_info_snapshot = debug_info_copy(debug_info, ALL_AREAS);
+	}
 
 	if(!debug_info_snapshot){
-#ifdef DEBUG
-		printk(KERN_ERR "debug_open: debug_info_copy failed (out of mem)\n");
-#endif
 		rc = -ENOMEM;
 		goto out;
 	}
-
-	if ((file->private_data =
-	     kmalloc(sizeof(file_private_info_t), GFP_ATOMIC)) == 0) {
-#ifdef DEBUG
-		printk(KERN_ERR "debug_open: kmalloc failed\n");
-#endif
-		debug_info_free(debug_info_snapshot);	
+	p_info = (file_private_info_t *) kmalloc(sizeof(file_private_info_t),
+						GFP_KERNEL);
+	if(!p_info){
+		if(debug_info_snapshot)
+			debug_info_free(debug_info_snapshot);
 		rc = -ENOMEM;
 		goto out;
 	}
-	p_info = (file_private_info_t *) file->private_data;
 	p_info->offset = 0;
 	p_info->debug_info_snap = debug_info_snapshot;
 	p_info->debug_info_org  = debug_info;
 	p_info->view = debug_info->views[i];
 	p_info->act_area = 0;
+	p_info->act_page = 0;
 	p_info->act_entry = DEBUG_PROLOG_ENTRY;
 	p_info->act_entry_offset = 0;
-
+	file->private_data = p_info;
 	debug_info_get(debug_info);
-
-      out:
+out:
 	up(&debug_lock);
 	return rc;
 }
@@ -561,14 +657,13 @@ static int debug_open(struct inode *inod
  * - deletes  private_data area of the file handle
  */
 
-static int debug_close(struct inode *inode, struct file *file)
+static int
+debug_close(struct inode *inode, struct file *file)
 {
 	file_private_info_t *p_info;
-#ifdef DEBUG
-	printk("debug_close\n");
-#endif
 	p_info = (file_private_info_t *) file->private_data;
-	debug_info_free(p_info->debug_info_snap);
+	if(p_info->debug_info_snap)
+		debug_info_free(p_info->debug_info_snap);
 	debug_info_put(p_info->debug_info_org);
 	kfree(file->private_data);
 	return 0;		/* success */
@@ -580,8 +675,8 @@ static int debug_close(struct inode *ino
  * - returns handle for debug area
  */
 
-debug_info_t *debug_register
-    (char *name, int page_order, int nr_areas, int buf_size) 
+debug_info_t*
+debug_register (char *name, int pages_per_area, int nr_areas, int buf_size)
 {
 	debug_info_t *rc = NULL;
 
@@ -591,18 +686,14 @@ debug_info_t *debug_register
 
         /* create new debug_info */
 
-	rc = debug_info_create(name, page_order, nr_areas, buf_size);
+	rc = debug_info_create(name, pages_per_area, nr_areas, buf_size);
 	if(!rc) 
 		goto out;
 	debug_register_view(rc, &debug_level_view);
         debug_register_view(rc, &debug_flush_view);
-#ifdef DEBUG
-	printk(KERN_INFO
-	       "debug: reserved %d areas of %d pages for debugging %s\n",
-	       nr_areas, 1 << page_order, rc->name);
-#endif
-      out:
-        if (rc == NULL){
+	debug_register_view(rc, &debug_pages_view);
+out:
+        if (!rc){
 		printk(KERN_ERR "debug: debug_register failed for %s\n",name);
         }
 	up(&debug_lock);
@@ -614,27 +705,65 @@ debug_info_t *debug_register
  * - give back debug area
  */
 
-void debug_unregister(debug_info_t * id)
+void
+debug_unregister(debug_info_t * id)
 {
 	if (!id)
 		goto out;
 	down(&debug_lock);
-#ifdef DEBUG
-	printk(KERN_INFO "debug: unregistering %s\n", id->name);
-#endif
 	debug_info_put(id);
 	up(&debug_lock);
 
-      out:
+out:
 	return;
 }
 
 /*
+ * debug_set_size:
+ * - set area size (number of pages) and number of areas
+ */
+static int
+debug_set_size(debug_info_t* id, int nr_areas, int pages_per_area)
+{
+	unsigned long flags;
+	debug_entry_t *** new_areas;
+	int rc=0;
+
+	if(!id || (nr_areas <= 0) || (pages_per_area < 0))
+		return -EINVAL;
+	if(pages_per_area > 0){
+		new_areas = debug_areas_alloc(pages_per_area, nr_areas);
+		if(!new_areas) {
+			printk(KERN_WARNING "debug: could not allocate memory "\
+					 "for pagenumber: %i\n",pages_per_area);
+			rc = -ENOMEM;
+			goto out;
+		}
+	} else {
+		new_areas = NULL;
+	}
+	spin_lock_irqsave(&id->lock,flags);
+	debug_areas_free(id);
+	id->areas = new_areas;
+	id->nr_areas = nr_areas;
+	id->pages_per_area = pages_per_area;
+	id->active_area = 0;
+	memset(id->active_entries,0,sizeof(int)*id->nr_areas);
+	memset(id->active_pages, 0, sizeof(int)*id->nr_areas);
+	spin_unlock_irqrestore(&id->lock,flags);
+	printk(KERN_INFO "debug: %s: set new size (%i pages)\n"\
+			 ,id->name, pages_per_area);
+out:
+	return rc;
+}
+
+/*
  * debug_set_level:
  * - set actual debug level
  */
 
-void debug_set_level(debug_info_t* id, int new_level)
+void
+debug_set_level(debug_info_t* id, int new_level)
 {
 	unsigned long flags;
 	if(!id)
@@ -649,10 +778,6 @@ void debug_set_level(debug_info_t* id, i
                         id->name, new_level, 0, DEBUG_MAX_LEVEL);
         } else {
                 id->level = new_level;
-#ifdef DEBUG
-                printk(KERN_INFO 
-			"debug: %s: new level %i\n",id->name,id->level);
-#endif
         }
 	spin_unlock_irqrestore(&id->lock,flags);
 }
@@ -663,11 +788,16 @@ void debug_set_level(debug_info_t* id, i
  * - set active entry to next in the ring buffer
  */
 
-extern inline void proceed_active_entry(debug_info_t * id)
+extern inline void
+proceed_active_entry(debug_info_t * id)
 {
-	if ((id->active_entry[id->active_area] += id->entry_size)
-	    > ((PAGE_SIZE << (id->page_order)) - id->entry_size))
-		id->active_entry[id->active_area] = 0;
+	if ((id->active_entries[id->active_area] += id->entry_size)
+	    > (PAGE_SIZE - id->entry_size)){
+		id->active_entries[id->active_area] = 0;
+		id->active_pages[id->active_area] =
+			(id->active_pages[id->active_area] + 1) %
+			id->pages_per_area;
+	}
 }
 
 /*
@@ -675,7 +805,8 @@ extern inline void proceed_active_entry(
  * - set active area to next in the ring buffer
  */
 
-extern inline void proceed_active_area(debug_info_t * id)
+extern inline void
+proceed_active_area(debug_info_t * id)
 {
 	id->active_area++;
 	id->active_area = id->active_area % id->nr_areas;
@@ -685,10 +816,12 @@ extern inline void proceed_active_area(d
  * get_active_entry:
  */
 
-extern inline debug_entry_t *get_active_entry(debug_info_t * id)
+extern inline debug_entry_t*
+get_active_entry(debug_info_t * id)
 {
-	return (debug_entry_t *) ((char *) id->areas[id->active_area] +
-				  id->active_entry[id->active_area]);
+	return (debug_entry_t *) (((char *) id->areas[id->active_area]
+					[id->active_pages[id->active_area]]) +
+					id->active_entries[id->active_area]);
 }
 
 /*
@@ -696,8 +829,9 @@ extern inline debug_entry_t *get_active_
  * - set timestamp, caller address, cpu number etc.
  */
 
-extern inline void debug_finish_entry(debug_info_t * id, debug_entry_t* active,
-		int level, int exception)
+extern inline void
+debug_finish_entry(debug_info_t * id, debug_entry_t* active, int level,
+			int exception)
 {
 	STCK(active->id.stck);
 	active->id.fields.cpuid = smp_processor_id();
@@ -721,7 +855,8 @@ static int debug_active=1;
  * always allow read, allow write only if debug_stoppable is set or
  * if debug_active is already off
  */
-static int s390dbf_procactive(ctl_table *table, int write, struct file *filp,
+static int
+s390dbf_procactive(ctl_table *table, int write, struct file *filp,
                      void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!write || debug_stoppable || !debug_active)
@@ -766,7 +901,8 @@ static struct ctl_table s390dbf_dir_tabl
 
 struct ctl_table_header *s390dbf_sysctl_header;
 
-void debug_stop_all(void)
+void
+debug_stop_all(void)
 {
 	if (debug_stoppable)
 		debug_active = 0;
@@ -778,13 +914,13 @@ void debug_stop_all(void)
  * - write debug entry with given size
  */
 
-debug_entry_t *debug_event_common(debug_info_t * id, int level, const void *buf,
-			          int len)
+debug_entry_t*
+debug_event_common(debug_info_t * id, int level, const void *buf, int len)
 {
 	unsigned long flags;
 	debug_entry_t *active;
 
-	if (!debug_active)
+	if (!debug_active || !id->areas)
 		return NULL;
 	spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
@@ -801,13 +937,13 @@ debug_entry_t *debug_event_common(debug_
  * - write debug entry with given size and switch to next debug area
  */
 
-debug_entry_t *debug_exception_common(debug_info_t * id, int level, 
-                                      const void *buf, int len)
+debug_entry_t
+*debug_exception_common(debug_info_t * id, int level, const void *buf, int len)
 {
 	unsigned long flags;
 	debug_entry_t *active;
 
-	if (!debug_active)
+	if (!debug_active || !id->areas)
 		return NULL;
 	spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
@@ -823,7 +959,8 @@ debug_entry_t *debug_exception_common(de
  * counts arguments in format string for sprintf view
  */
 
-extern inline int debug_count_numargs(char *string)
+extern inline int
+debug_count_numargs(char *string)
 {
 	int numargs=0;
 
@@ -838,8 +975,8 @@ extern inline int debug_count_numargs(ch
  * debug_sprintf_event:
  */
 
-debug_entry_t *debug_sprintf_event(debug_info_t* id,
-                                   int level,char *string,...)
+debug_entry_t*
+debug_sprintf_event(debug_info_t* id, int level,char *string,...)
 {
 	va_list   ap;
 	int numargs,idx;
@@ -849,7 +986,7 @@ debug_entry_t *debug_sprintf_event(debug
 
 	if((!id) || (level > id->level))
 		return NULL;
-	if (!debug_active)
+	if (!debug_active || !id->areas)
 		return NULL;
 	numargs=debug_count_numargs(string);
 
@@ -871,8 +1008,8 @@ debug_entry_t *debug_sprintf_event(debug
  * debug_sprintf_exception:
  */
 
-debug_entry_t *debug_sprintf_exception(debug_info_t* id,
-                                       int level,char *string,...)
+debug_entry_t*
+debug_sprintf_exception(debug_info_t* id, int level,char *string,...)
 {
 	va_list   ap;
 	int numargs,idx;
@@ -882,7 +1019,7 @@ debug_entry_t *debug_sprintf_exception(d
 
 	if((!id) || (level > id->level))
 		return NULL;
-	if (!debug_active)
+	if (!debug_active || !id->areas)
 		return NULL;
 
 	numargs=debug_count_numargs(string);
@@ -906,15 +1043,14 @@ debug_entry_t *debug_sprintf_exception(d
  * - is called exactly once to initialize the debug feature
  */
 
-static int __init debug_init(void)
+static int
+__init debug_init(void)
 {
 	int rc = 0;
 
 	s390dbf_sysctl_header = register_sysctl_table(s390dbf_dir_table, 1);
 	down(&debug_lock);
-#ifdef CONFIG_PROC_FS
-	debug_proc_root_entry = proc_mkdir(DEBUG_DIR_ROOT, NULL);
-#endif /* CONFIG_PROC_FS */
+	debug_debugfs_root_entry = debugfs_create_dir(DEBUG_DIR_ROOT,NULL);
 	printk(KERN_INFO "debug: Initialization complete\n");
 	initialized = 1;
 	up(&debug_lock);
@@ -926,13 +1062,14 @@ static int __init debug_init(void)
  * debug_register_view:
  */
 
-int debug_register_view(debug_info_t * id, struct debug_view *view)
+int
+debug_register_view(debug_info_t * id, struct debug_view *view)
 {
 	int rc = 0;
 	int i;
 	unsigned long flags;
 	mode_t mode = S_IFREG;
-	struct proc_dir_entry *pde;
+	struct dentry *pde;
 
 	if (!id)
 		goto out;
@@ -940,16 +1077,17 @@ int debug_register_view(debug_info_t * i
 		mode |= S_IRUSR;
 	if (view->input_proc)
 		mode |= S_IWUSR;
-	pde = create_proc_entry(view->name, mode, id->proc_root_entry);
+	pde = debugfs_create_file(view->name, mode, id->debugfs_root_entry,
+				NULL, &debug_file_ops);
 	if (!pde){
-		printk(KERN_WARNING "debug: create_proc_entry() failed! Cannot register view %s/%s\n", id->name,view->name);
+		printk(KERN_WARNING "debug: debugfs_create_file() failed!"\
+			" Cannot register view %s/%s\n", id->name,view->name);
 		rc = -1;
 		goto out;
 	}
-
 	spin_lock_irqsave(&id->lock, flags);
 	for (i = 0; i < DEBUG_MAX_VIEWS; i++) {
-		if (id->views[i] == NULL)
+		if (!id->views[i])
 			break;
 	}
 	if (i == DEBUG_MAX_VIEWS) {
@@ -957,16 +1095,14 @@ int debug_register_view(debug_info_t * i
 			id->name,view->name);
 		printk(KERN_WARNING 
 			"debug: maximum number of views reached (%i)!\n", i);
-		remove_proc_entry(pde->name, id->proc_root_entry);
+		debugfs_remove(pde);
 		rc = -1;
-	}
-	else {
+	} else {
 		id->views[i] = view;
-		pde->proc_fops = &debug_file_ops;
-		id->proc_entries[i] = pde;
+		id->debugfs_entries[i] = pde;
 	}
 	spin_unlock_irqrestore(&id->lock, flags);
-      out:
+out:
 	return rc;
 }
 
@@ -974,7 +1110,8 @@ int debug_register_view(debug_info_t * i
  * debug_unregister_view:
  */
 
-int debug_unregister_view(debug_info_t * id, struct debug_view *view)
+int
+debug_unregister_view(debug_info_t * id, struct debug_view *view)
 {
 	int rc = 0;
 	int i;
@@ -990,15 +1127,46 @@ int debug_unregister_view(debug_info_t *
 	if (i == DEBUG_MAX_VIEWS)
 		rc = -1;
 	else {
-#ifdef CONFIG_PROC_FS
-		remove_proc_entry(id->proc_entries[i]->name,
-				  id->proc_root_entry);
-#endif
+		debugfs_remove(id->debugfs_entries[i]);
 		id->views[i] = NULL;
 		rc = 0;
 	}
 	spin_unlock_irqrestore(&id->lock, flags);
-      out:
+out:
+	return rc;
+}
+
+static inline char *
+debug_get_user_string(const char __user *user_buf, size_t user_len)
+{
+	char* buffer;
+
+	buffer = kmalloc(user_len + 1, GFP_KERNEL);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	if (copy_from_user(buffer, user_buf, user_len) != 0) {
+		kfree(buffer);
+		return ERR_PTR(-EFAULT);
+	}
+	/* got the string, now strip linefeed. */
+	if (buffer[user_len - 1] == '\n')
+		buffer[user_len - 1] = 0;
+	else
+		buffer[user_len] = 0;
+        return buffer;
+}
+
+static inline int
+debug_get_uint(char *buf)
+{
+	int rc;
+
+	for(; isspace(*buf); buf++);
+	rc = simple_strtoul(buf, &buf, 10);
+	if(*buf){
+		printk("debug: no integer specified!\n");
+		rc = -EINVAL;
+	}
 	return rc;
 }
 
@@ -1011,13 +1179,69 @@ int debug_unregister_view(debug_info_t *
  * prints out actual debug level
  */
 
-static int debug_prolog_level_fn(debug_info_t * id,
+static int
+debug_prolog_pages_fn(debug_info_t * id,
 				 struct debug_view *view, char *out_buf)
 {
+	return sprintf(out_buf, "%i\n", id->pages_per_area);
+}
+
+/*
+ * reads new size (number of pages per debug area)
+ */
+
+static int
+debug_input_pages_fn(debug_info_t * id, struct debug_view *view,
+			struct file *file, const char __user *user_buf,
+			size_t user_len, loff_t * offset)
+{
+	char *str;
+	int rc,new_pages;
+
+	if (user_len > 0x10000)
+                user_len = 0x10000;
+	if (*offset != 0){
+		rc = -EPIPE;
+		goto out;
+	}
+	str = debug_get_user_string(user_buf,user_len);
+	if(IS_ERR(str)){
+		rc = PTR_ERR(str);
+		goto out;
+	}
+	new_pages = debug_get_uint(str);
+	if(new_pages < 0){
+		rc = -EINVAL;
+		goto free_str;
+	}
+	rc = debug_set_size(id,id->nr_areas, new_pages);
+	if(rc != 0){
+		rc = -EINVAL;
+		goto free_str;
+	}
+	rc = user_len;
+free_str:
+	kfree(str);
+out:
+	*offset += user_len;
+	return rc;		/* number of input characters */
+}
+
+/*
+ * prints out actual debug level
+ */
+
+static int
+debug_prolog_level_fn(debug_info_t * id, struct debug_view *view, char *out_buf)
+{
 	int rc = 0;
 
-	if(id->level == -1) rc = sprintf(out_buf,"-\n");
-	else rc = sprintf(out_buf, "%i\n", id->level);
+	if(id->level == DEBUG_OFF_LEVEL) {
+		rc = sprintf(out_buf,"-\n");
+	}
+	else {
+		rc = sprintf(out_buf, "%i\n", id->level);
+	}
 	return rc;
 }
 
@@ -1025,30 +1249,43 @@ static int debug_prolog_level_fn(debug_i
  * reads new debug level
  */
 
-static int debug_input_level_fn(debug_info_t * id, struct debug_view *view,
-				struct file *file, const char __user *user_buf,
-				size_t in_buf_size, loff_t * offset)
-{
-	char input_buf[1];
-	int rc = in_buf_size;
-
-	if (*offset != 0)
+static int
+debug_input_level_fn(debug_info_t * id, struct debug_view *view,
+			struct file *file, const char __user *user_buf,
+			size_t user_len, loff_t * offset)
+{
+	char *str;
+	int rc,new_level;
+
+	if (user_len > 0x10000)
+                user_len = 0x10000;
+	if (*offset != 0){
+		rc = -EPIPE;
 		goto out;
-	if (copy_from_user(input_buf, user_buf, 1)){
-		rc = -EFAULT;
+	}
+	str = debug_get_user_string(user_buf,user_len);
+	if(IS_ERR(str)){
+		rc = PTR_ERR(str);
 		goto out;
 	}
-	if (isdigit(input_buf[0])) {
-		int new_level = ((int) input_buf[0] - (int) '0');
-		debug_set_level(id, new_level);
-	} else if(input_buf[0] == '-') {
+	if(str[0] == '-'){
 		debug_set_level(id, DEBUG_OFF_LEVEL);
+		rc = user_len;
+		goto free_str;
 	} else {
-		printk(KERN_INFO "debug: level `%c` is not valid\n",
-		       input_buf[0]);
+		new_level = debug_get_uint(str);
 	}
-      out:
-	*offset += in_buf_size;
+	if(new_level < 0) {
+		printk(KERN_INFO "debug: level `%s` is not valid\n", str);
+		rc = -EINVAL;
+	} else {
+		debug_set_level(id, new_level);
+		rc = user_len;
+	}
+free_str:
+	kfree(str);
+out:
+	*offset += user_len;
 	return rc;		/* number of input characters */
 }
 
@@ -1057,29 +1294,36 @@ static int debug_input_level_fn(debug_in
  * flushes debug areas
  */
  
-void debug_flush(debug_info_t* id, int area)
+void
+debug_flush(debug_info_t* id, int area)
 {
         unsigned long flags;
-        int i;
+        int i,j;
 
-        if(!id)
+        if(!id || !id->areas)
                 return;
         spin_lock_irqsave(&id->lock,flags);
         if(area == DEBUG_FLUSH_ALL){
                 id->active_area = 0;
-                memset(id->active_entry, 0, id->nr_areas * sizeof(int));
-                for (i = 0; i < id->nr_areas; i++) 
-                        memset(id->areas[i], 0, PAGE_SIZE << id->page_order);
+                memset(id->active_entries, 0, id->nr_areas * sizeof(int));
+                for (i = 0; i < id->nr_areas; i++) {
+			id->active_pages[i] = 0;
+			for(j = 0; j < id->pages_per_area; j++) {
+                        	memset(id->areas[i][j], 0, PAGE_SIZE);
+			}
+		}
                 printk(KERN_INFO "debug: %s: all areas flushed\n",id->name);
         } else if(area >= 0 && area < id->nr_areas) {
-                id->active_entry[area] = 0;
-                memset(id->areas[area], 0, PAGE_SIZE << id->page_order);
-                printk(KERN_INFO
-                        "debug: %s: area %i has been flushed\n",
+                id->active_entries[area] = 0;
+		id->active_pages[area] = 0;
+		for(i = 0; i < id->pages_per_area; i++) {
+                	memset(id->areas[area][i],0,PAGE_SIZE);
+		}
+                printk(KERN_INFO "debug: %s: area %i has been flushed\n",
                         id->name, area);
         } else {
                 printk(KERN_INFO
-                        "debug: %s: area %i cannot be flushed (range: %i - %i)\n",
+                      "debug: %s: area %i cannot be flushed (range: %i - %i)\n",
                         id->name, area, 0, id->nr_areas-1);
         }
         spin_unlock_irqrestore(&id->lock,flags);
@@ -1089,15 +1333,20 @@ void debug_flush(debug_info_t* id, int a
  * view function: flushes debug areas 
  */
 
-static int debug_input_flush_fn(debug_info_t * id, struct debug_view *view,
-                                struct file *file, const char __user *user_buf,
-                                size_t in_buf_size, loff_t * offset)
+static int
+debug_input_flush_fn(debug_info_t * id, struct debug_view *view,
+			struct file *file, const char __user *user_buf,
+			size_t user_len, loff_t * offset)
 {
         char input_buf[1];
-        int rc = in_buf_size;
- 
-        if (*offset != 0)
+        int rc = user_len;
+
+	if (user_len > 0x10000)
+                user_len = 0x10000;
+        if (*offset != 0){
+		rc = -EPIPE;
                 goto out;
+	}
         if (copy_from_user(input_buf, user_buf, 1)){
                 rc = -EFAULT;
                 goto out;
@@ -1114,8 +1363,8 @@ static int debug_input_flush_fn(debug_in
 
         printk(KERN_INFO "debug: area `%c` is not valid\n", input_buf[0]);
 
-      out:
-        *offset += in_buf_size;
+out:
+        *offset += user_len;
         return rc;              /* number of input characters */
 }
 
@@ -1123,8 +1372,9 @@ static int debug_input_flush_fn(debug_in
  * prints debug header in raw format
  */
 
-int debug_raw_header_fn(debug_info_t * id, struct debug_view *view,
-                         int area, debug_entry_t * entry, char *out_buf)
+static int
+debug_raw_header_fn(debug_info_t * id, struct debug_view *view,
+			int area, debug_entry_t * entry, char *out_buf)
 {
         int rc;
 
@@ -1137,7 +1387,8 @@ int debug_raw_header_fn(debug_info_t * i
  * prints debug data in raw format
  */
 
-static int debug_raw_format_fn(debug_info_t * id, struct debug_view *view,
+static int
+debug_raw_format_fn(debug_info_t * id, struct debug_view *view,
 			       char *out_buf, const char *in_buf)
 {
 	int rc;
@@ -1151,8 +1402,9 @@ static int debug_raw_format_fn(debug_inf
  * prints debug data in hex/ascii format
  */
 
-static int debug_hex_ascii_format_fn(debug_info_t * id, struct debug_view *view,
-		    		  char *out_buf, const char *in_buf)
+static int
+debug_hex_ascii_format_fn(debug_info_t * id, struct debug_view *view,
+	    		  char *out_buf, const char *in_buf)
 {
 	int i, rc = 0;
 
@@ -1176,7 +1428,8 @@ static int debug_hex_ascii_format_fn(deb
  * prints header for debug entry
  */
 
-int debug_dflt_header_fn(debug_info_t * id, struct debug_view *view,
+int
+debug_dflt_header_fn(debug_info_t * id, struct debug_view *view,
 			 int area, debug_entry_t * entry, char *out_buf)
 {
 	struct timeval time_val;
@@ -1210,8 +1463,9 @@ int debug_dflt_header_fn(debug_info_t * 
 
 #define DEBUG_SPRINTF_MAX_ARGS 10
 
-int debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
-                            char *out_buf, debug_sprintf_entry_t *curr_event)
+static int
+debug_sprintf_format_fn(debug_info_t * id, struct debug_view *view,
+                        char *out_buf, debug_sprintf_entry_t *curr_event)
 {
 	int num_longs, num_used_args = 0,i, rc = 0;
 	int index[DEBUG_SPRINTF_MAX_ARGS];
@@ -1251,14 +1505,10 @@ out:
 /*
  * clean up module
  */
-void __exit debug_exit(void)
+void
+__exit debug_exit(void)
 {
-#ifdef DEBUG
-	printk("debug_cleanup_module: \n");
-#endif
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry(debug_proc_root_entry->name, NULL);
-#endif /* CONFIG_PROC_FS */
+	debugfs_remove(debug_debugfs_root_entry);
 	unregister_sysctl_table(s390dbf_sysctl_header);
 	return;
 }
@@ -1266,7 +1516,7 @@ void __exit debug_exit(void)
 /*
  * module definitions
  */
-core_initcall(debug_init);
+postcore_initcall(debug_init);
 module_exit(debug_exit);
 MODULE_LICENSE("GPL");
 
diff -urpN linux-2.6/Documentation/s390/s390dbf.txt linux-2.6-patched/Documentation/s390/s390dbf.txt
--- linux-2.6/Documentation/s390/s390dbf.txt	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/Documentation/s390/s390dbf.txt	2005-06-23 18:57:55.000000000 +0200
@@ -12,8 +12,8 @@ where log records can be stored efficien
 One purpose of this is to inspect the debug logs after a production system crash
 in order to analyze the reason for the crash.
 If the system still runs but only a subcomponent which uses dbf failes,
-it is possible to look at the debug logs on a live system via the Linux proc
-filesystem.
+it is possible to look at the debug logs on a live system via the Linux
+debugfs filesystem.
 The debug feature may also very useful for kernel and driver development.
 
 Design:
@@ -52,16 +52,18 @@ Each debug entry contains the following 
 - Flag, if entry is an exception or not
 
 The debug logs can be inspected in a live system through entries in
-the proc-filesystem. Under the path /proc/s390dbf there is 
+the debugfs-filesystem. Under the toplevel directory "s390dbf" there is
 a directory for each registered component, which is named like the
-corresponding component.
+corresponding component. The debugfs normally should be mounted to
+/sys/kernel/debug therefore the debug feature can be accessed unter
+/sys/kernel/debug/s390dbf.
 
 The content of the directories are files which represent different views
 to the debug log. Each component can decide which views should be
 used through registering them with the function debug_register_view().
 Predefined views for hex/ascii, sprintf and raw binary data are provided.
 It is also possible to define other views. The content of
-a view can be inspected simply by reading the corresponding proc file.
+a view can be inspected simply by reading the corresponding debugfs file.
 
 All debug logs have an an actual debug level (range from 0 to 6).
 The default level is 3. Event and Exception functions have a 'level'
@@ -69,14 +71,14 @@ parameter. Only debug entries with a lev
 than the actual level are written to the log. This means, when
 writing events, high priority log entries should have a low level
 value whereas low priority entries should have a high one.
-The actual debug level can be changed with the help of the proc-filesystem 
-through writing a number string "x" to the 'level' proc file which is
+The actual debug level can be changed with the help of the debugfs-filesystem
+through writing a number string "x" to the 'level' debugfs file which is
 provided for every debug log. Debugging can be switched off completely
-by using "-" on the 'level' proc file.
+by using "-" on the 'level' debugfs file.
 
 Example:
 
-> echo "-" > /proc/s390dbf/dasd/level
+> echo "-" > /sys/kernel/debug/s390dbf/dasd/level
 
 It is also possible to deactivate the debug feature globally for every
 debug log. You can change the behavior using  2 sysctl parameters in
@@ -99,11 +101,11 @@ Kernel Interfaces:
 ------------------
 
 ----------------------------------------------------------------------------
-debug_info_t *debug_register(char *name, int pages_index, int nr_areas,
+debug_info_t *debug_register(char *name, int pages, int nr_areas,
                              int buf_size);
 
-Parameter:    name:        Name of debug log (e.g. used for proc entry) 
-              pages_index: 2^pages_index pages will be allocated per area
+Parameter:    name:        Name of debug log (e.g. used for debugfs entry)
+              pages:       number of pages, which will be allocated per area
               nr_areas:    number of debug areas
               buf_size:    size of data area in each debug entry
 
@@ -134,7 +136,7 @@ Return Value:  none 
 Description:   Sets new actual debug level if new_level is valid. 
 
 ---------------------------------------------------------------------------
-+void debug_stop_all(void);
+void debug_stop_all(void);
 
 Parameter:     none
 
@@ -270,7 +272,7 @@ Parameter:     id:    handle for debug l
 Return Value:  0  : ok 
                < 0: Error 
 
-Description:   registers new debug view and creates proc dir entry 
+Description:   registers new debug view and creates debugfs dir entry
 
 ---------------------------------------------------------------------------
 int debug_unregister_view (debug_info_t * id, struct debug_view *view); 
@@ -281,7 +283,7 @@ Parameter:     id:    handle for debug l
 Return Value:  0  : ok 
                < 0: Error 
 
-Description:   unregisters debug view and removes proc dir entry 
+Description:   unregisters debug view and removes debugfs dir entry
 
 
 
@@ -308,7 +310,7 @@ static int init(void)
 {
     /* register 4 debug areas with one page each and 4 byte data field */
 
-    debug_info = debug_register ("test", 0, 4, 4 );
+    debug_info = debug_register ("test", 1, 4, 4 );
     debug_register_view(debug_info,&debug_hex_ascii_view);
     debug_register_view(debug_info,&debug_raw_view);
 
@@ -343,7 +345,7 @@ static int init(void)
     /* register 4 debug areas with one page each and data field for */
     /* format string pointer + 2 varargs (= 3 * sizeof(long))       */
 
-    debug_info = debug_register ("test", 0, 4, sizeof(long) * 3);
+    debug_info = debug_register ("test", 1, 4, sizeof(long) * 3);
     debug_register_view(debug_info,&debug_sprintf_view);
 
     debug_sprintf_event(debug_info, 2 , "first event in %s:%i\n",__FILE__,__LINE__);
@@ -362,16 +364,16 @@ module_exit(cleanup);
 
 
 
-ProcFS Interface
+Debugfs Interface
 ----------------
 Views to the debug logs can be investigated through reading the corresponding 
-proc-files:
+debugfs-files:
 
 Example:
 
-> ls /proc/s390dbf/dasd
-flush  hex_ascii  level      raw 
-> cat /proc/s390dbf/dasd/hex_ascii | sort +1
+> ls /sys/kernel/debug/s390dbf/dasd
+flush  hex_ascii  level pages raw
+> cat /sys/kernel/debug/s390dbf/dasd/hex_ascii | sort +1
 00 00974733272:680099 2 - 02 0006ad7e  07 ea 4a 90 | ....
 00 00974733272:682210 2 - 02 0006ade6  46 52 45 45 | FREE
 00 00974733272:682213 2 - 02 0006adf6  07 ea 4a 90 | ....
@@ -391,25 +393,36 @@ Changing the debug level
 Example:
 
 
-> cat /proc/s390dbf/dasd/level
+> cat /sys/kernel/debug/s390dbf/dasd/level
 3
-> echo "5" > /proc/s390dbf/dasd/level
-> cat /proc/s390dbf/dasd/level
+> echo "5" > /sys/kernel/debug/s390dbf/dasd/level
+> cat /sys/kernel/debug/s390dbf/dasd/level
 5
 
 Flushing debug areas
 --------------------
 Debug areas can be flushed with piping the number of the desired
-area (0...n) to the proc file "flush". When using "-" all debug areas
+area (0...n) to the debugfs file "flush". When using "-" all debug areas
 are flushed.
 
 Examples:
 
 1. Flush debug area 0:
-> echo "0" > /proc/s390dbf/dasd/flush  
+> echo "0" > /sys/kernel/debug/s390dbf/dasd/flush
 
 2. Flush all debug areas:
-> echo "-" > /proc/s390dbf/dasd/flush
+> echo "-" > /sys/kernel/debug/s390dbf/dasd/flush
+
+Changing the size of debug areas
+------------------------------------
+It is possible the change the size of debug areas through piping
+the number of pages to the debugfs file "pages". The resize request will
+also flush the debug areas.
+
+Example:
+
+Define 4 pages for the debug areas of debug feature "dasd":
+> echo "4" > /sys/kernel/debug/s390dbf/dasd/pages
 
 Stooping the debug feature
 --------------------------
@@ -491,7 +504,7 @@ Defining views
 --------------
 
 Views are specified with the 'debug_view' structure. There are defined
-callback functions which are used for reading and writing the proc files:
+callback functions which are used for reading and writing the debugfs files:
 
 struct debug_view {
         char name[DEBUG_MAX_PROCF_LEN];  
@@ -525,7 +538,7 @@ typedef int (debug_input_proc_t) (debug_
 The "private_data" member can be used as pointer to view specific data.
 It is not used by the debug feature itself.
 
-The output when reading a debug-proc file is structured like this:
+The output when reading a debugfs file is structured like this:
 
 "prolog_proc output"
 
@@ -534,13 +547,13 @@ The output when reading a debug-proc fil
 "header_proc output 3"  "format_proc output 3"
 ...
 
-When a view is read from the proc fs, the Debug Feature calls the 
+When a view is read from the debugfs, the Debug Feature calls the
 'prolog_proc' once for writing the prolog.
 Then 'header_proc' and 'format_proc' are called for each 
 existing debug entry.
 
 The input_proc can be used to implement functionality when it is written to 
-the view (e.g. like with 'echo "0" > /proc/s390dbf/dasd/level).
+the view (e.g. like with 'echo "0" > /sys/kernel/debug/s390dbf/dasd/level).
 
 For header_proc there can be used the default function
 debug_dflt_header_fn() which is defined in in debug.h.
@@ -602,7 +615,7 @@ debug_info = debug_register ("test", 0, 
 debug_register_view(debug_info, &debug_test_view);
 for(i = 0; i < 10; i ++) debug_int_event(debug_info, 1, i);
 
-> cat /proc/s390dbf/test/myview
+> cat /sys/kernel/debug/s390dbf/test/myview
 00 00964419734:611402 1 - 00 88042ca   This error...........
 00 00964419734:611405 1 - 00 88042ca   That error...........
 00 00964419734:611408 1 - 00 88042ca   Problem..............
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-06-23 18:57:55.000000000 +0200
@@ -176,7 +176,7 @@ dasd_state_known_to_basic(struct dasd_de
 		return rc;
 
 	/* register 'device' debug area, used for all DBF_DEV_XXX calls */
-	device->debug_area = debug_register(device->cdev->dev.bus_id, 0, 2,
+	device->debug_area = debug_register(device->cdev->dev.bus_id, 1, 2,
 					    8 * sizeof (long));
 	debug_register_view(device->debug_area, &debug_sprintf_view);
 	debug_set_level(device->debug_area, DBF_EMERG);
@@ -1983,7 +1983,7 @@ dasd_init(void)
 	init_waitqueue_head(&dasd_init_waitq);
 
 	/* register 'common' DASD debug area, used for all DBF_XXX calls */
-	dasd_debug_area = debug_register("dasd", 0, 2, 8 * sizeof (long));
+	dasd_debug_area = debug_register("dasd", 1, 2, 8 * sizeof (long));
 	if (dasd_debug_area == NULL) {
 		rc = -ENOMEM;
 		goto failed;
diff -urpN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-patched/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_proc.c	2005-06-23 18:57:55.000000000 +0200
@@ -9,13 +9,14 @@
  *
  * /proc interface for the dasd driver.
  *
- * $Revision: 1.31 $
+ * $Revision: 1.32 $
  */
 
 #include <linux/config.h>
 #include <linux/ctype.h>
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
+#include <linux/proc_fs.h>
 
 #include <asm/debug.h>
 #include <asm/uaccess.h>
diff -urpN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-patched/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_34xx.c	2005-06-23 18:57:55.000000000 +0200
@@ -1351,13 +1351,13 @@ tape_34xx_init (void)
 {
 	int rc;
 
-	TAPE_DBF_AREA = debug_register ( "tape_34xx", 1, 2, 4*sizeof(long));
+	TAPE_DBF_AREA = debug_register ( "tape_34xx", 2, 2, 4*sizeof(long));
 	debug_register_view(TAPE_DBF_AREA, &debug_sprintf_view);
 #ifdef DBF_LIKE_HELL
 	debug_set_level(TAPE_DBF_AREA, 6);
 #endif
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.21 $\n");
+	DBF_EVENT(3, "34xx init: $Revision: 1.23 $\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1378,7 +1378,7 @@ tape_34xx_exit(void)
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
 MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.21 $)");
+		   "device driver ($Revision: 1.23 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2005-06-23 18:57:45.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2005-06-23 18:57:55.000000000 +0200
@@ -1186,7 +1186,7 @@ tape_mtop(struct tape_device *device, in
 static int
 tape_init (void)
 {
-	TAPE_DBF_AREA = debug_register ( "tape", 1, 2, 4*sizeof(long));
+	TAPE_DBF_AREA = debug_register ( "tape", 2, 2, 4*sizeof(long));
 	debug_register_view(TAPE_DBF_AREA, &debug_sprintf_view);
 #ifdef DBF_LIKE_HELL
 	debug_set_level(TAPE_DBF_AREA, 6);
diff -urpN linux-2.6/drivers/s390/char/tape_proc.c linux-2.6-patched/drivers/s390/char/tape_proc.c
--- linux-2.6/drivers/s390/char/tape_proc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_proc.c	2005-06-23 18:57:55.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 
 #define TAPE_DBF_AREA	tape_core_dbf
 
diff -urpN linux-2.6/drivers/s390/char/vmcp.c linux-2.6-patched/drivers/s390/char/vmcp.c
--- linux-2.6/drivers/s390/char/vmcp.c	2005-06-23 18:57:55.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/vmcp.c	2005-06-23 18:57:55.000000000 +0200
@@ -203,7 +203,7 @@ static int __init vmcp_init(void)
 	else
 		printk(KERN_WARNING
 		       "z/VM CP interface not loaded. Could not register misc device.\n");
-	vmcp_debug = debug_register("vmcp", 0, 1, 240);
+	vmcp_debug = debug_register("vmcp", 1, 1, 240);
 	debug_register_view(vmcp_debug, &debug_hex_ascii_view);
 	return ret;
 }
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-06-23 18:57:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.133 $
+ *   $Revision: 1.134 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -63,17 +63,17 @@ __setup ("cio_msg=", cio_setup);
 static int __init
 cio_debug_init (void)
 {
-	cio_debug_msg_id = debug_register ("cio_msg", 4, 4, 16*sizeof (long));
+	cio_debug_msg_id = debug_register ("cio_msg", 16, 4, 16*sizeof (long));
 	if (!cio_debug_msg_id)
 		goto out_unregister;
 	debug_register_view (cio_debug_msg_id, &debug_sprintf_view);
 	debug_set_level (cio_debug_msg_id, 2);
-	cio_debug_trace_id = debug_register ("cio_trace", 4, 4, 8);
+	cio_debug_trace_id = debug_register ("cio_trace", 16, 4, 8);
 	if (!cio_debug_trace_id)
 		goto out_unregister;
 	debug_register_view (cio_debug_trace_id, &debug_hex_ascii_view);
 	debug_set_level (cio_debug_trace_id, 2);
-	cio_debug_crw_id = debug_register ("cio_crw", 2, 4, 16*sizeof (long));
+	cio_debug_crw_id = debug_register ("cio_crw", 4, 4, 16*sizeof (long));
 	if (!cio_debug_crw_id)
 		goto out_unregister;
 	debug_register_view (cio_debug_crw_id, &debug_sprintf_view);
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2005-06-23 18:57:55.000000000 +0200
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.98 $"
+#define VERSION_QDIO_C "$Revision: 1.101 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -3342,7 +3342,7 @@ static int
 qdio_register_dbf_views(void)
 {
 	qdio_dbf_setup=debug_register(QDIO_DBF_SETUP_NAME,
-				      QDIO_DBF_SETUP_INDEX,
+				      QDIO_DBF_SETUP_PAGES,
 				      QDIO_DBF_SETUP_NR_AREAS,
 				      QDIO_DBF_SETUP_LEN);
 	if (!qdio_dbf_setup)
@@ -3351,7 +3351,7 @@ qdio_register_dbf_views(void)
 	debug_set_level(qdio_dbf_setup,QDIO_DBF_SETUP_LEVEL);
 
 	qdio_dbf_sbal=debug_register(QDIO_DBF_SBAL_NAME,
-				     QDIO_DBF_SBAL_INDEX,
+				     QDIO_DBF_SBAL_PAGES,
 				     QDIO_DBF_SBAL_NR_AREAS,
 				     QDIO_DBF_SBAL_LEN);
 	if (!qdio_dbf_sbal)
@@ -3361,7 +3361,7 @@ qdio_register_dbf_views(void)
 	debug_set_level(qdio_dbf_sbal,QDIO_DBF_SBAL_LEVEL);
 
 	qdio_dbf_sense=debug_register(QDIO_DBF_SENSE_NAME,
-				      QDIO_DBF_SENSE_INDEX,
+				      QDIO_DBF_SENSE_PAGES,
 				      QDIO_DBF_SENSE_NR_AREAS,
 				      QDIO_DBF_SENSE_LEN);
 	if (!qdio_dbf_sense)
@@ -3371,7 +3371,7 @@ qdio_register_dbf_views(void)
 	debug_set_level(qdio_dbf_sense,QDIO_DBF_SENSE_LEVEL);
 
 	qdio_dbf_trace=debug_register(QDIO_DBF_TRACE_NAME,
-				      QDIO_DBF_TRACE_INDEX,
+				      QDIO_DBF_TRACE_PAGES,
 				      QDIO_DBF_TRACE_NR_AREAS,
 				      QDIO_DBF_TRACE_LEN);
 	if (!qdio_dbf_trace)
@@ -3382,7 +3382,7 @@ qdio_register_dbf_views(void)
 
 #ifdef CONFIG_QDIO_DEBUG
         qdio_dbf_slsb_out=debug_register(QDIO_DBF_SLSB_OUT_NAME,
-                                         QDIO_DBF_SLSB_OUT_INDEX,
+                                         QDIO_DBF_SLSB_OUT_PAGES,
                                          QDIO_DBF_SLSB_OUT_NR_AREAS,
                                          QDIO_DBF_SLSB_OUT_LEN);
         if (!qdio_dbf_slsb_out)
@@ -3391,7 +3391,7 @@ qdio_register_dbf_views(void)
         debug_set_level(qdio_dbf_slsb_out,QDIO_DBF_SLSB_OUT_LEVEL);
 
         qdio_dbf_slsb_in=debug_register(QDIO_DBF_SLSB_IN_NAME,
-                                        QDIO_DBF_SLSB_IN_INDEX,
+                                        QDIO_DBF_SLSB_IN_PAGES,
                                         QDIO_DBF_SLSB_IN_NR_AREAS,
                                         QDIO_DBF_SLSB_IN_LEN);
         if (!qdio_dbf_slsb_in)
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2005-06-23 18:57:55.000000000 +0200
@@ -3,7 +3,7 @@
 
 #include <asm/page.h>
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.32 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.33 $"
 
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_VERBOSE_LEVEL 9
@@ -132,7 +132,7 @@ enum qdio_irq_states {
 
 #define QDIO_DBF_SETUP_NAME "qdio_setup"
 #define QDIO_DBF_SETUP_LEN 8
-#define QDIO_DBF_SETUP_INDEX 2
+#define QDIO_DBF_SETUP_PAGES 4
 #define QDIO_DBF_SETUP_NR_AREAS 1
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_SETUP_LEVEL 6
@@ -142,7 +142,7 @@ enum qdio_irq_states {
 
 #define QDIO_DBF_SBAL_NAME "qdio_labs" /* sbal */
 #define QDIO_DBF_SBAL_LEN 256
-#define QDIO_DBF_SBAL_INDEX 2
+#define QDIO_DBF_SBAL_PAGES 4
 #define QDIO_DBF_SBAL_NR_AREAS 2
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_SBAL_LEVEL 6
@@ -154,16 +154,16 @@ enum qdio_irq_states {
 #define QDIO_DBF_TRACE_LEN 8
 #define QDIO_DBF_TRACE_NR_AREAS 2
 #ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_TRACE_INDEX 4
+#define QDIO_DBF_TRACE_PAGES 16
 #define QDIO_DBF_TRACE_LEVEL 4 /* -------- could be even more verbose here */
 #else /* CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_TRACE_INDEX 2
+#define QDIO_DBF_TRACE_PAGES 4
 #define QDIO_DBF_TRACE_LEVEL 2
 #endif /* CONFIG_QDIO_DEBUG */
 
 #define QDIO_DBF_SENSE_NAME "qdio_sense"
 #define QDIO_DBF_SENSE_LEN 64
-#define QDIO_DBF_SENSE_INDEX 1
+#define QDIO_DBF_SENSE_PAGES 2
 #define QDIO_DBF_SENSE_NR_AREAS 1
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_DBF_SENSE_LEVEL 6
@@ -176,13 +176,13 @@ enum qdio_irq_states {
 
 #define QDIO_DBF_SLSB_OUT_NAME "qdio_slsb_out"
 #define QDIO_DBF_SLSB_OUT_LEN QDIO_MAX_BUFFERS_PER_Q
-#define QDIO_DBF_SLSB_OUT_INDEX 8
+#define QDIO_DBF_SLSB_OUT_PAGES 256
 #define QDIO_DBF_SLSB_OUT_NR_AREAS 1
 #define QDIO_DBF_SLSB_OUT_LEVEL 6
 
 #define QDIO_DBF_SLSB_IN_NAME "qdio_slsb_in"
 #define QDIO_DBF_SLSB_IN_LEN QDIO_MAX_BUFFERS_PER_Q
-#define QDIO_DBF_SLSB_IN_INDEX 8
+#define QDIO_DBF_SLSB_IN_PAGES 256
 #define QDIO_DBF_SLSB_IN_NR_AREAS 1
 #define QDIO_DBF_SLSB_IN_LEVEL 6
 #endif /* CONFIG_QDIO_DEBUG */
diff -urpN linux-2.6/drivers/s390/net/claw.c linux-2.6-patched/drivers/s390/net/claw.c
--- linux-2.6/drivers/s390/net/claw.c	2005-06-23 18:57:45.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/claw.c	2005-06-23 18:57:55.000000000 +0200
@@ -146,8 +146,8 @@ claw_unregister_debug_facility(void)
 static int
 claw_register_debug_facility(void)
 {
-	claw_dbf_setup = debug_register("claw_setup", 1, 1, 8);
-	claw_dbf_trace = debug_register("claw_trace", 1, 2, 8);
+	claw_dbf_setup = debug_register("claw_setup", 2, 1, 8);
+	claw_dbf_trace = debug_register("claw_trace", 2, 2, 8);
 	if (claw_dbf_setup == NULL || claw_dbf_trace == NULL) {
 		printk(KERN_WARNING "Not enough memory for debug facility.\n");
 		claw_unregister_debug_facility();
diff -urpN linux-2.6/drivers/s390/net/ctcdbug.c linux-2.6-patched/drivers/s390/net/ctcdbug.c
--- linux-2.6/drivers/s390/net/ctcdbug.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctcdbug.c	2005-06-23 18:57:55.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.4 $)
+ * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.6 $)
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,7 +9,7 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.4 $	 $Date: 2004/08/04 10:11:59 $
+ *    $Revision: 1.6 $	 $Date: 2005/05/11 08:10:17 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -51,15 +51,15 @@ int
 ctc_register_dbf_views(void)
 {
 	ctc_dbf_setup = debug_register(CTC_DBF_SETUP_NAME,
-					CTC_DBF_SETUP_INDEX,
+					CTC_DBF_SETUP_PAGES,
 					CTC_DBF_SETUP_NR_AREAS,
 					CTC_DBF_SETUP_LEN);
 	ctc_dbf_data = debug_register(CTC_DBF_DATA_NAME,
-				       CTC_DBF_DATA_INDEX,
+				       CTC_DBF_DATA_PAGES,
 				       CTC_DBF_DATA_NR_AREAS,
 				       CTC_DBF_DATA_LEN);
 	ctc_dbf_trace = debug_register(CTC_DBF_TRACE_NAME,
-					CTC_DBF_TRACE_INDEX,
+					CTC_DBF_TRACE_PAGES,
 					CTC_DBF_TRACE_NR_AREAS,
 					CTC_DBF_TRACE_LEN);
 
diff -urpN linux-2.6/drivers/s390/net/ctcdbug.h linux-2.6-patched/drivers/s390/net/ctcdbug.h
--- linux-2.6/drivers/s390/net/ctcdbug.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctcdbug.h	2005-06-23 18:57:55.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.5 $)
+ * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.6 $)
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,7 +9,7 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.5 $	 $Date: 2005/02/27 19:46:44 $
+ *    $Revision: 1.6 $	 $Date: 2005/05/11 08:10:17 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -35,19 +35,19 @@
  */
 #define CTC_DBF_SETUP_NAME "ctc_setup"
 #define CTC_DBF_SETUP_LEN 16
-#define CTC_DBF_SETUP_INDEX 3
+#define CTC_DBF_SETUP_PAGES 8
 #define CTC_DBF_SETUP_NR_AREAS 1
 #define CTC_DBF_SETUP_LEVEL 3
 
 #define CTC_DBF_DATA_NAME "ctc_data"
 #define CTC_DBF_DATA_LEN 128
-#define CTC_DBF_DATA_INDEX 3
+#define CTC_DBF_DATA_PAGES 8
 #define CTC_DBF_DATA_NR_AREAS 1
 #define CTC_DBF_DATA_LEVEL 3
 
 #define CTC_DBF_TRACE_NAME "ctc_trace"
 #define CTC_DBF_TRACE_LEN 16
-#define CTC_DBF_TRACE_INDEX 2
+#define CTC_DBF_TRACE_PAGES 4
 #define CTC_DBF_TRACE_NR_AREAS 2
 #define CTC_DBF_TRACE_LEVEL 3
 
diff -urpN linux-2.6/drivers/s390/net/iucv.h linux-2.6-patched/drivers/s390/net/iucv.h
--- linux-2.6/drivers/s390/net/iucv.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/iucv.h	2005-06-23 18:57:55.000000000 +0200
@@ -37,19 +37,19 @@
  */
 #define IUCV_DBF_SETUP_NAME "iucv_setup"
 #define IUCV_DBF_SETUP_LEN 32
-#define IUCV_DBF_SETUP_INDEX 1
+#define IUCV_DBF_SETUP_PAGES 2
 #define IUCV_DBF_SETUP_NR_AREAS 1
 #define IUCV_DBF_SETUP_LEVEL 3
 
 #define IUCV_DBF_DATA_NAME "iucv_data"
 #define IUCV_DBF_DATA_LEN 128
-#define IUCV_DBF_DATA_INDEX 1
+#define IUCV_DBF_DATA_PAGES 2
 #define IUCV_DBF_DATA_NR_AREAS 1
 #define IUCV_DBF_DATA_LEVEL 2
 
 #define IUCV_DBF_TRACE_NAME "iucv_trace"
 #define IUCV_DBF_TRACE_LEN 16
-#define IUCV_DBF_TRACE_INDEX 2
+#define IUCV_DBF_TRACE_PAGES 4
 #define IUCV_DBF_TRACE_NR_AREAS 1
 #define IUCV_DBF_TRACE_LEVEL 3
 
diff -urpN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2005-06-23 18:57:45.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2005-06-23 18:57:55.000000000 +0200
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.98 $	 $Date: 2005/04/18 13:41:29 $
+ *    $Revision: 1.99 $	 $Date: 2005/05/11 08:10:17 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.98 $"
+#define VERSION_LCS_C  "$Revision: 1.99 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -93,8 +93,8 @@ lcs_unregister_debug_facility(void)
 static int
 lcs_register_debug_facility(void)
 {
-	lcs_dbf_setup = debug_register("lcs_setup", 1, 1, 8);
-	lcs_dbf_trace = debug_register("lcs_trace", 1, 2, 8);
+	lcs_dbf_setup = debug_register("lcs_setup", 2, 1, 8);
+	lcs_dbf_trace = debug_register("lcs_trace", 2, 2, 8);
 	if (lcs_dbf_setup == NULL || lcs_dbf_trace == NULL) {
 		PRINT_ERR("Not enough memory for debug facility.\n");
 		lcs_unregister_debug_facility();
diff -urpN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-patched/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	2005-06-23 18:57:45.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/netiucv.c	2005-06-23 18:57:55.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.63 2004/07/27 13:36:05 mschwide Exp $
+ * $Id: netiucv.c,v 1.66 2005/05/11 08:10:17 holzheu Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.63 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.66 $
  *
  */
 
@@ -391,15 +391,15 @@ static int
 iucv_register_dbf_views(void)
 {
 	iucv_dbf_setup = debug_register(IUCV_DBF_SETUP_NAME,
-					IUCV_DBF_SETUP_INDEX,
+					IUCV_DBF_SETUP_PAGES,
 					IUCV_DBF_SETUP_NR_AREAS,
 					IUCV_DBF_SETUP_LEN);
 	iucv_dbf_data = debug_register(IUCV_DBF_DATA_NAME,
-				       IUCV_DBF_DATA_INDEX,
+				       IUCV_DBF_DATA_PAGES,
 				       IUCV_DBF_DATA_NR_AREAS,
 				       IUCV_DBF_DATA_LEN);
 	iucv_dbf_trace = debug_register(IUCV_DBF_TRACE_NAME,
-					IUCV_DBF_TRACE_INDEX,
+					IUCV_DBF_TRACE_PAGES,
 					IUCV_DBF_TRACE_NR_AREAS,
 					IUCV_DBF_TRACE_LEN);
 
@@ -2076,7 +2076,7 @@ DRIVER_ATTR(remove, 0200, NULL, remove_w
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.63 $";
+	char vbuf[] = "$Revision: 1.66 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urpN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2005-06-23 18:57:55.000000000 +0200
@@ -42,44 +42,44 @@
  */
 #define QETH_DBF_SETUP_NAME "qeth_setup"
 #define QETH_DBF_SETUP_LEN 8
-#define QETH_DBF_SETUP_INDEX 3
+#define QETH_DBF_SETUP_PAGES 8
 #define QETH_DBF_SETUP_NR_AREAS 1
 #define QETH_DBF_SETUP_LEVEL 5
 
 #define QETH_DBF_MISC_NAME "qeth_misc"
 #define QETH_DBF_MISC_LEN 128
-#define QETH_DBF_MISC_INDEX 1
+#define QETH_DBF_MISC_PAGES 2
 #define QETH_DBF_MISC_NR_AREAS 1
 #define QETH_DBF_MISC_LEVEL 2
 
 #define QETH_DBF_DATA_NAME "qeth_data"
 #define QETH_DBF_DATA_LEN 96
-#define QETH_DBF_DATA_INDEX 3
+#define QETH_DBF_DATA_PAGES 8
 #define QETH_DBF_DATA_NR_AREAS 1
 #define QETH_DBF_DATA_LEVEL 2
 
 #define QETH_DBF_CONTROL_NAME "qeth_control"
 #define QETH_DBF_CONTROL_LEN 256
-#define QETH_DBF_CONTROL_INDEX 3
+#define QETH_DBF_CONTROL_PAGES 8
 #define QETH_DBF_CONTROL_NR_AREAS 2
 #define QETH_DBF_CONTROL_LEVEL 5
 
 #define QETH_DBF_TRACE_NAME "qeth_trace"
 #define QETH_DBF_TRACE_LEN 8
-#define QETH_DBF_TRACE_INDEX 2
+#define QETH_DBF_TRACE_PAGES 4
 #define QETH_DBF_TRACE_NR_AREAS 2
 #define QETH_DBF_TRACE_LEVEL 3
 extern debug_info_t *qeth_dbf_trace;
 
 #define QETH_DBF_SENSE_NAME "qeth_sense"
 #define QETH_DBF_SENSE_LEN 64
-#define QETH_DBF_SENSE_INDEX 1
+#define QETH_DBF_SENSE_PAGES 2
 #define QETH_DBF_SENSE_NR_AREAS 1
 #define QETH_DBF_SENSE_LEVEL 2
 
 #define QETH_DBF_QERR_NAME "qeth_qerr"
 #define QETH_DBF_QERR_LEN 8
-#define QETH_DBF_QERR_INDEX 1
+#define QETH_DBF_QERR_PAGES 2
 #define QETH_DBF_QERR_NR_AREAS 2
 #define QETH_DBF_QERR_LEVEL 2
 
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-06-23 18:57:55.000000000 +0200
@@ -7639,31 +7639,31 @@ static int
 qeth_register_dbf_views(void)
 {
 	qeth_dbf_setup = debug_register(QETH_DBF_SETUP_NAME,
-					QETH_DBF_SETUP_INDEX,
+					QETH_DBF_SETUP_PAGES,
 					QETH_DBF_SETUP_NR_AREAS,
 					QETH_DBF_SETUP_LEN);
 	qeth_dbf_misc = debug_register(QETH_DBF_MISC_NAME,
-				       QETH_DBF_MISC_INDEX,
+				       QETH_DBF_MISC_PAGES,
 				       QETH_DBF_MISC_NR_AREAS,
 				       QETH_DBF_MISC_LEN);
 	qeth_dbf_data = debug_register(QETH_DBF_DATA_NAME,
-				       QETH_DBF_DATA_INDEX,
+				       QETH_DBF_DATA_PAGES,
 				       QETH_DBF_DATA_NR_AREAS,
 				       QETH_DBF_DATA_LEN);
 	qeth_dbf_control = debug_register(QETH_DBF_CONTROL_NAME,
-					  QETH_DBF_CONTROL_INDEX,
+					  QETH_DBF_CONTROL_PAGES,
 					  QETH_DBF_CONTROL_NR_AREAS,
 					  QETH_DBF_CONTROL_LEN);
 	qeth_dbf_sense = debug_register(QETH_DBF_SENSE_NAME,
-					QETH_DBF_SENSE_INDEX,
+					QETH_DBF_SENSE_PAGES,
 					QETH_DBF_SENSE_NR_AREAS,
 					QETH_DBF_SENSE_LEN);
 	qeth_dbf_qerr = debug_register(QETH_DBF_QERR_NAME,
-				       QETH_DBF_QERR_INDEX,
+				       QETH_DBF_QERR_PAGES,
 				       QETH_DBF_QERR_NR_AREAS,
 				       QETH_DBF_QERR_LEN);
 	qeth_dbf_trace = debug_register(QETH_DBF_TRACE_NAME,
-					QETH_DBF_TRACE_INDEX,
+					QETH_DBF_TRACE_PAGES,
 					QETH_DBF_TRACE_NR_AREAS,
 					QETH_DBF_TRACE_LEN);
 
diff -urpN linux-2.6/include/asm-s390/debug.h linux-2.6-patched/include/asm-s390/debug.h
--- linux-2.6/include/asm-s390/debug.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/debug.h	2005-06-23 18:57:55.000000000 +0200
@@ -9,6 +9,8 @@
 #ifndef DEBUG_H
 #define DEBUG_H
 
+#include <linux/config.h>
+#include <linux/fs.h>
 #include <linux/string.h>
 
 /* Note:
@@ -31,19 +33,18 @@ struct __debug_entry{
 } __attribute__((packed));
 
 
-#define __DEBUG_FEATURE_VERSION      1  /* version of debug feature */
+#define __DEBUG_FEATURE_VERSION      2  /* version of debug feature */
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
-#include <linux/proc_fs.h>
 
 #define DEBUG_MAX_LEVEL            6  /* debug levels range from 0 to 6 */
 #define DEBUG_OFF_LEVEL            -1 /* level where debug is switched off */
 #define DEBUG_FLUSH_ALL            -1 /* parameter to flush all areas */
 #define DEBUG_MAX_VIEWS            10 /* max number of views in proc fs */
-#define DEBUG_MAX_PROCF_LEN        64 /* max length for a proc file name */
+#define DEBUG_MAX_NAME_LEN         64 /* max length for a debugfs file name */
 #define DEBUG_DEFAULT_LEVEL        3  /* initial debug level */
 
 #define DEBUG_DIR_ROOT "s390dbf" /* name of debug root directory in proc fs */
@@ -64,16 +65,17 @@ typedef struct debug_info {	
 	spinlock_t lock;			
 	int level;
 	int nr_areas;
-	int page_order;
+	int pages_per_area;
 	int buf_size;
 	int entry_size;	
-	debug_entry_t** areas;
+	debug_entry_t*** areas;
 	int active_area;
-	int *active_entry;
-	struct proc_dir_entry* proc_root_entry;
-	struct proc_dir_entry* proc_entries[DEBUG_MAX_VIEWS];
+	int *active_pages;
+	int *active_entries;
+	struct dentry* debugfs_root_entry;
+	struct dentry* debugfs_entries[DEBUG_MAX_VIEWS];
 	struct debug_view* views[DEBUG_MAX_VIEWS];	
-	char name[DEBUG_MAX_PROCF_LEN];
+	char name[DEBUG_MAX_NAME_LEN];
 } debug_info_t;
 
 typedef int (debug_header_proc_t) (debug_info_t* id,
@@ -98,7 +100,7 @@ int debug_dflt_header_fn(debug_info_t* i
 		         int area, debug_entry_t* entry, char* out_buf);						
 				
 struct debug_view {
-	char name[DEBUG_MAX_PROCF_LEN];
+	char name[DEBUG_MAX_NAME_LEN];
 	debug_prolog_proc_t* prolog_proc;
 	debug_header_proc_t* header_proc;
 	debug_format_proc_t* format_proc;
@@ -120,7 +122,7 @@ debug_entry_t* debug_exception_common(de
 
 /* Debug Feature API: */
 
-debug_info_t* debug_register(char* name, int pages_index, int nr_areas,
+debug_info_t* debug_register(char* name, int pages, int nr_areas,
                              int buf_size);
 
 void debug_unregister(debug_info_t* id);
@@ -132,7 +134,8 @@ void debug_stop_all(void);
 extern inline debug_entry_t* 
 debug_event(debug_info_t* id, int level, void* data, int length)
 {
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_event_common(id,level,data,length);
 }
 
@@ -140,7 +143,8 @@ extern inline debug_entry_t* 
 debug_int_event(debug_info_t* id, int level, unsigned int tag)
 {
         unsigned int t=tag;
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_event_common(id,level,&t,sizeof(unsigned int));
 }
 
@@ -148,14 +152,16 @@ extern inline debug_entry_t *
 debug_long_event (debug_info_t* id, int level, unsigned long tag)
 {
         unsigned long t=tag;
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_event_common(id,level,&t,sizeof(unsigned long));
 }
 
 extern inline debug_entry_t* 
 debug_text_event(debug_info_t* id, int level, const char* txt)
 {
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_event_common(id,level,txt,strlen(txt));
 }
 
@@ -167,7 +173,8 @@ debug_sprintf_event(debug_info_t* id,int
 extern inline debug_entry_t* 
 debug_exception(debug_info_t* id, int level, void* data, int length)
 {
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_exception_common(id,level,data,length);
 }
 
@@ -175,7 +182,8 @@ extern inline debug_entry_t* 
 debug_int_exception(debug_info_t* id, int level, unsigned int tag)
 {
         unsigned int t=tag;
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_exception_common(id,level,&t,sizeof(unsigned int));
 }
 
@@ -183,14 +191,16 @@ extern inline debug_entry_t * 
 debug_long_exception (debug_info_t* id, int level, unsigned long tag)
 {
         unsigned long t=tag;
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_exception_common(id,level,&t,sizeof(unsigned long));
 }
 
 extern inline debug_entry_t* 
 debug_text_exception(debug_info_t* id, int level, const char* txt)
 {
-	if ((!id) || (level > id->level)) return NULL;
+	if ((!id) || (level > id->level) || (id->pages_per_area == 0))
+		return NULL;
         return debug_exception_common(id,level,txt,strlen(txt));
 }
 
