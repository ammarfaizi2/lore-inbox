Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTAAW5I>; Wed, 1 Jan 2003 17:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTAAW5I>; Wed, 1 Jan 2003 17:57:08 -0500
Received: from verein.lst.de ([212.34.181.86]:33805 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S265168AbTAAW46>;
	Wed, 1 Jan 2003 17:56:58 -0500
Date: Thu, 2 Jan 2003 00:05:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more procfs bits for !CONFIG_MMU
Message-ID: <20030102000522.A6137@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some file in /proc/<pid>/ need to be generated very differently for
CONFIG_MMU set or not.

To avoid ifdef hell I extented the task_foo() abstraction already
present in array.c a bit and the actual implementations now live
in task_mmu.c and task_nommu.c.


--- 1.4/fs/proc/Makefile	Sat Dec 14 07:38:56 2002
+++ edited/fs/proc/Makefile	Wed Jan  1 13:45:28 2003
@@ -9,6 +9,12 @@
 proc-objs    := inode.o root.o base.o generic.o array.o \
 		kmsg.o proc_tty.o proc_misc.o kcore.o
 
+ifeq ($(CONFIG_MMU),y)
+proc-objs    += task_mmu.o
+else
+proc-objs    += task_nommu.o
+endif
+
 ifeq ($(CONFIG_PROC_DEVICETREE),y)
 proc-objs    += proc_devtree.o
 endif
--- 1.36/fs/proc/array.c	Tue Dec 17 18:07:37 2002
+++ edited/fs/proc/array.c	Wed Jan  1 13:46:00 2003
@@ -179,47 +179,6 @@
 	return buffer;
 }
 
-static inline char * task_mem(struct mm_struct *mm, char *buffer)
-{
-	struct vm_area_struct * vma;
-	unsigned long data = 0, stack = 0;
-	unsigned long exec = 0, lib = 0;
-
-	down_read(&mm->mmap_sem);
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
-		if (!vma->vm_file) {
-			data += len;
-			if (vma->vm_flags & VM_GROWSDOWN)
-				stack += len;
-			continue;
-		}
-		if (vma->vm_flags & VM_WRITE)
-			continue;
-		if (vma->vm_flags & VM_EXEC) {
-			exec += len;
-			if (vma->vm_flags & VM_EXECUTABLE)
-				continue;
-			lib += len;
-		}
-	}
-	buffer += sprintf(buffer,
-		"VmSize:\t%8lu kB\n"
-		"VmLck:\t%8lu kB\n"
-		"VmRSS:\t%8lu kB\n"
-		"VmData:\t%8lu kB\n"
-		"VmStk:\t%8lu kB\n"
-		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
-		mm->total_vm << (PAGE_SHIFT-10),
-		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
-		data - stack, stack,
-		exec - lib, lib);
-	up_read(&mm->mmap_sem);
-	return buffer;
-}
-
 static void collect_sigign_sigcatch(struct task_struct *p, sigset_t *ign,
 				    sigset_t *catch)
 {
@@ -276,7 +235,7 @@
 			    cap_t(p->cap_effective));
 }
 
-
+extern char *task_mem(struct mm_struct *, char *);
 int proc_pid_status(struct task_struct *task, char * buffer)
 {
 	char * orig = buffer;
@@ -297,6 +256,7 @@
 	return buffer - orig;
 }
 
+extern unsigned long task_vsize(struct mm_struct *);
 int proc_pid_stat(struct task_struct *task, char * buffer)
 {
 	unsigned long vsize, eip, esp, wchan;
@@ -320,13 +280,8 @@
 	}
 	task_unlock(task);
 	if (mm) {
-		struct vm_area_struct *vma;
 		down_read(&mm->mmap_sem);
-		vma = mm->mmap;
-		while (vma) {
-			vsize += vma->vm_end - vma->vm_start;
-			vma = vma->vm_next;
-		}
+		vsize = task_vsize(mm);
 		eip = KSTK_EIP(task);
 		esp = KSTK_ESP(task);
 		up_read(&mm->mmap_sem);
@@ -396,206 +351,21 @@
 		mmput(mm);
 	return res;
 }
-		
-int proc_pid_statm(task_t *task, char *buffer)
-{
-	int size, resident, shared, text, lib, data, dirty;
-	struct mm_struct *mm = get_task_mm(task);
-	struct vm_area_struct * vma;
-
-	size = resident = shared = text = lib = data = dirty = 0;
-
-	if (!mm)
-		goto out;
 
-	down_read(&mm->mmap_sem);
-	resident = mm->rss;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-
-		size += pages;
-		if (is_vm_hugetlb_page(vma)) {
-			if (!(vma->vm_flags & VM_DONTCOPY))
-				shared += pages;
-			continue;
-		}
-		if (vma->vm_flags & VM_SHARED || !list_empty(&vma->shared))
-			shared += pages;
-		if (vma->vm_flags & VM_EXECUTABLE)
-			text += pages;
-		else
-			data += pages;
-	}
-	up_read(&mm->mmap_sem);
-	mmput(mm);
-out:
-	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
-		       size, resident, shared, text, lib, data, dirty);
-}
-
-/*
- * The way we support synthetic files > 4K
- * - without storing their contents in some buffer and
- * - without walking through the entire synthetic file until we reach the
- *   position of the requested data
- * is to cleverly encode the current position in the file's f_pos field.
- * There is no requirement that a read() call which returns `count' bytes
- * of data increases f_pos by exactly `count'.
- *
- * This idea is Linus' one. Bruno implemented it.
- */
-
-/*
- * For the /proc/<pid>/maps file, we use fixed length records, each containing
- * a single line.
- *
- * f_pos = (number of the vma in the task->mm->mmap list) * PAGE_SIZE
- *         + (index into the line)
- */
-/* for systems with sizeof(void*) == 4: */
-#define MAPS_LINE_FORMAT4	  "%08lx-%08lx %s %08lx %02x:%02x %lu"
-#define MAPS_LINE_MAX4	49 /* sum of 8  1  8  1 4 1 8 1 5 1 10 1 */
-
-/* for systems with sizeof(void*) == 8: */
-#define MAPS_LINE_FORMAT8	  "%016lx-%016lx %s %016lx %02x:%02x %lu"
-#define MAPS_LINE_MAX8	73 /* sum of 16  1  16  1 4 1 16 1 5 1 10 1 */
-
-#define MAPS_LINE_FORMAT	(sizeof(void*) == 4 ? MAPS_LINE_FORMAT4 : MAPS_LINE_FORMAT8)
-#define MAPS_LINE_MAX	(sizeof(void*) == 4 ?  MAPS_LINE_MAX4 :  MAPS_LINE_MAX8)
-
-static int proc_pid_maps_get_line (char *buf, struct vm_area_struct *map)
-{
-	/* produce the next line */
-	char *line;
-	char str[5];
-	int flags;
-	dev_t dev;
-	unsigned long ino;
-	int len;
-
-	flags = map->vm_flags;
-
-	str[0] = flags & VM_READ ? 'r' : '-';
-	str[1] = flags & VM_WRITE ? 'w' : '-';
-	str[2] = flags & VM_EXEC ? 'x' : '-';
-	str[3] = flags & VM_MAYSHARE ? 's' : 'p';
-	str[4] = 0;
-
-	dev = 0;
-	ino = 0;
-	if (map->vm_file != NULL) {
-		struct inode *inode = map->vm_file->f_dentry->d_inode;
-		dev = inode->i_sb->s_dev;
-		ino = inode->i_ino;
-		line = d_path(map->vm_file->f_dentry,
-			      map->vm_file->f_vfsmnt,
-			      buf, PAGE_SIZE);
-		buf[PAGE_SIZE-1] = '\n';
-		line -= MAPS_LINE_MAX;
-		if(line < buf)
-			line = buf;
-	} else
-		line = buf;
-
-	len = sprintf(line,
-		      MAPS_LINE_FORMAT,
-		      map->vm_start, map->vm_end, str, map->vm_pgoff << PAGE_SHIFT,
-		      MAJOR(dev), MINOR(dev), ino);
-
-	if(map->vm_file) {
-		int i;
-		for(i = len; i < MAPS_LINE_MAX; i++)
-			line[i] = ' ';
-		len = buf + PAGE_SIZE - line;
-		memmove(buf, line, len);
-	} else
-		line[len++] = '\n';
-	return len;
-}
-
-#ifdef CONFIG_MMU
-ssize_t proc_pid_read_maps(struct task_struct *task, struct file *file,
-			   char *buf, size_t count, loff_t *ppos)
+extern int task_statm(struct mm_struct *, int *, int *, int *, int *);
+int proc_pid_statm(struct task_struct *task, char *buffer)
 {
-	struct mm_struct *mm;
-	struct vm_area_struct * map;
-	char *tmp, *kbuf;
-	long retval;
-	int off, lineno, loff;
-
-	/* reject calls with out of range parameters immediately */
-	retval = 0;
-	if (*ppos > LONG_MAX)
-		goto out;
-	if (count == 0)
-		goto out;
-	off = (long)*ppos;
-	/*
-	 * We might sleep getting the page, so get it first.
-	 */
-	retval = -ENOMEM;
-	kbuf = (char*)__get_free_page(GFP_KERNEL);
-	if (!kbuf)
-		goto out;
-
-	tmp = (char*)__get_free_page(GFP_KERNEL);
-	if (!tmp)
-		goto out_free1;
+	int size = 0, resident = 0, shared = 0, text = 0, lib = 0, data = 0;
+	struct mm_struct *mm = get_task_mm(task);
+	
+	if (mm) {
+		down_read(&mm->mmap_sem);
+		size = task_statm(mm, &shared, &text, &data, &resident);
+		up_read(&mm->mmap_sem);
 
-	mm = get_task_mm(task);
- 
-	retval = 0;
-	if (!mm)
-		goto out_free2;
-
-	down_read(&mm->mmap_sem);
-	map = mm->mmap;
-	lineno = 0;
-	loff = 0;
-	if (count > PAGE_SIZE)
-		count = PAGE_SIZE;
-	while (map) {
-		int len;
-		if (off > PAGE_SIZE) {
-			off -= PAGE_SIZE;
-			goto next;
-		}
-		len = proc_pid_maps_get_line(tmp, map);
-		len -= off;
-		if (len > 0) {
-			if (retval+len > count) {
-				/* only partial line transfer possible */
-				len = count - retval;
-				/* save the offset where the next read
-				 * must start */
-				loff = len+off;
-			}
-			memcpy(kbuf+retval, tmp+off, len);
-			retval += len;
-		}
-		off = 0;
-next:
-		if (!loff)
-			lineno++;
-		if (retval >= count)
-			break;
-		if (loff) BUG();
-		map = map->vm_next;
+		mmput(mm);
 	}
-	up_read(&mm->mmap_sem);
-	mmput(mm);
 
-	if (retval > count) BUG();
-	if (copy_to_user(buf, kbuf, retval))
-		retval = -EFAULT;
-	else
-		*ppos = (lineno << PAGE_SHIFT) + loff;
-
-out_free2:
-	free_page((unsigned long)tmp);
-out_free1:
-	free_page((unsigned long)kbuf);
-out:
-	return retval;
+	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
+		       size, resident, shared, text, lib, data, 0);
 }
-#endif /* CONFIG_MMU */
--- /dev/null	2002-08-30 19:31:37.000000000 -0400
+++ b/fs/proc/task_mmu.c	2003-01-01 13:48:44.000000000 -0500
@@ -0,0 +1,247 @@
+
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <asm/uaccess.h>
+
+char *task_mem(struct mm_struct *mm, char *buffer)
+{
+	unsigned long data = 0, stack = 0, exec = 0, lib = 0;
+	struct vm_area_struct *vma;
+
+	down_read(&mm->mmap_sem);
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
+		if (!vma->vm_file) {
+			data += len;
+			if (vma->vm_flags & VM_GROWSDOWN)
+				stack += len;
+			continue;
+		}
+		if (vma->vm_flags & VM_WRITE)
+			continue;
+		if (vma->vm_flags & VM_EXEC) {
+			exec += len;
+			if (vma->vm_flags & VM_EXECUTABLE)
+				continue;
+			lib += len;
+		}
+	}
+	buffer += sprintf(buffer,
+		"VmSize:\t%8lu kB\n"
+		"VmLck:\t%8lu kB\n"
+		"VmRSS:\t%8lu kB\n"
+		"VmData:\t%8lu kB\n"
+		"VmStk:\t%8lu kB\n"
+		"VmExe:\t%8lu kB\n"
+		"VmLib:\t%8lu kB\n",
+		mm->total_vm << (PAGE_SHIFT-10),
+		mm->locked_vm << (PAGE_SHIFT-10),
+		mm->rss << (PAGE_SHIFT-10),
+		data - stack, stack,
+		exec - lib, lib);
+	up_read(&mm->mmap_sem);
+	return buffer;
+}
+
+unsigned long task_vsize(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	unsigned long vsize = 0;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next)
+		vsize += vma->vm_end - vma->vm_start;
+
+	return vsize;
+}
+
+int task_statm(struct mm_struct *mm, int *shared, int *text,
+	       int *data, int *resident)
+{
+	struct vm_area_struct *vma;
+	int size = 0;
+
+	*resident = mm->rss;
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		int pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+		size += pages;
+		if (is_vm_hugetlb_page(vma)) {
+			if (!(vma->vm_flags & VM_DONTCOPY))
+				*shared += pages;
+			continue;
+		}
+		if (vma->vm_flags & VM_SHARED || !list_empty(&vma->shared))
+			*shared += pages;
+		if (vma->vm_flags & VM_EXECUTABLE)
+			*text += pages;
+		else
+			*data += pages;
+	}
+
+	return size;
+}
+
+/*
+ * The way we support synthetic files > 4K
+ * - without storing their contents in some buffer and
+ * - without walking through the entire synthetic file until we reach the
+ *   position of the requested data
+ * is to cleverly encode the current position in the file's f_pos field.
+ * There is no requirement that a read() call which returns `count' bytes
+ * of data increases f_pos by exactly `count'.
+ *
+ * This idea is Linus' one. Bruno implemented it.
+ */
+
+/*
+ * For the /proc/<pid>/maps file, we use fixed length records, each containing
+ * a single line.
+ *
+ * f_pos = (number of the vma in the task->mm->mmap list) * PAGE_SIZE
+ *         + (index into the line)
+ */
+/* for systems with sizeof(void*) == 4: */
+#define MAPS_LINE_FORMAT4	  "%08lx-%08lx %s %08lx %02x:%02x %lu"
+#define MAPS_LINE_MAX4	49 /* sum of 8  1  8  1 4 1 8 1 5 1 10 1 */
+
+/* for systems with sizeof(void*) == 8: */
+#define MAPS_LINE_FORMAT8	  "%016lx-%016lx %s %016lx %02x:%02x %lu"
+#define MAPS_LINE_MAX8	73 /* sum of 16  1  16  1 4 1 16 1 5 1 10 1 */
+
+#define MAPS_LINE_FORMAT	(sizeof(void*) == 4 ? MAPS_LINE_FORMAT4 : MAPS_LINE_FORMAT8)
+#define MAPS_LINE_MAX	(sizeof(void*) == 4 ?  MAPS_LINE_MAX4 :  MAPS_LINE_MAX8)
+
+static int proc_pid_maps_get_line (char *buf, struct vm_area_struct *map)
+{
+	/* produce the next line */
+	char *line;
+	char str[5];
+	int flags;
+	dev_t dev;
+	unsigned long ino;
+	int len;
+
+	flags = map->vm_flags;
+
+	str[0] = flags & VM_READ ? 'r' : '-';
+	str[1] = flags & VM_WRITE ? 'w' : '-';
+	str[2] = flags & VM_EXEC ? 'x' : '-';
+	str[3] = flags & VM_MAYSHARE ? 's' : 'p';
+	str[4] = 0;
+
+	dev = 0;
+	ino = 0;
+	if (map->vm_file != NULL) {
+		struct inode *inode = map->vm_file->f_dentry->d_inode;
+		dev = inode->i_sb->s_dev;
+		ino = inode->i_ino;
+		line = d_path(map->vm_file->f_dentry,
+			      map->vm_file->f_vfsmnt,
+			      buf, PAGE_SIZE);
+		buf[PAGE_SIZE-1] = '\n';
+		line -= MAPS_LINE_MAX;
+		if(line < buf)
+			line = buf;
+	} else
+		line = buf;
+
+	len = sprintf(line,
+		      MAPS_LINE_FORMAT,
+		      map->vm_start, map->vm_end, str, map->vm_pgoff << PAGE_SHIFT,
+		      MAJOR(dev), MINOR(dev), ino);
+
+	if(map->vm_file) {
+		int i;
+		for(i = len; i < MAPS_LINE_MAX; i++)
+			line[i] = ' ';
+		len = buf + PAGE_SIZE - line;
+		memmove(buf, line, len);
+	} else
+		line[len++] = '\n';
+	return len;
+}
+
+ssize_t proc_pid_read_maps(struct task_struct *task, struct file *file,
+			   char *buf, size_t count, loff_t *ppos)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct * map;
+	char *tmp, *kbuf;
+	long retval;
+	int off, lineno, loff;
+
+	/* reject calls with out of range parameters immediately */
+	retval = 0;
+	if (*ppos > LONG_MAX)
+		goto out;
+	if (count == 0)
+		goto out;
+	off = (long)*ppos;
+	/*
+	 * We might sleep getting the page, so get it first.
+	 */
+	retval = -ENOMEM;
+	kbuf = (char*)__get_free_page(GFP_KERNEL);
+	if (!kbuf)
+		goto out;
+
+	tmp = (char*)__get_free_page(GFP_KERNEL);
+	if (!tmp)
+		goto out_free1;
+
+	mm = get_task_mm(task);
+ 
+	retval = 0;
+	if (!mm)
+		goto out_free2;
+
+	down_read(&mm->mmap_sem);
+	map = mm->mmap;
+	lineno = 0;
+	loff = 0;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+	while (map) {
+		int len;
+		if (off > PAGE_SIZE) {
+			off -= PAGE_SIZE;
+			goto next;
+		}
+		len = proc_pid_maps_get_line(tmp, map);
+		len -= off;
+		if (len > 0) {
+			if (retval+len > count) {
+				/* only partial line transfer possible */
+				len = count - retval;
+				/* save the offset where the next read
+				 * must start */
+				loff = len+off;
+			}
+			memcpy(kbuf+retval, tmp+off, len);
+			retval += len;
+		}
+		off = 0;
+next:
+		if (!loff)
+			lineno++;
+		if (retval >= count)
+			break;
+		if (loff) BUG();
+		map = map->vm_next;
+	}
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+
+	if (retval > count) BUG();
+	if (copy_to_user(buf, kbuf, retval))
+		retval = -EFAULT;
+	else
+		*ppos = (lineno << PAGE_SHIFT) + loff;
+
+out_free2:
+	free_page((unsigned long)tmp);
+out_free1:
+	free_page((unsigned long)kbuf);
+out:
+	return retval;
+}
--- /dev/null	2002-08-30 19:31:37.000000000 -0400
+++ b/fs/proc/task_nommu.c	2003-01-01 13:51:22.000000000 -0500
@@ -0,0 +1,97 @@
+
+#include <linux/mm.h>
+
+/*
+ * Logic: we've got two memory sums for each process, "shared", and
+ * "non-shared". Shared memory may get counted more then once, for
+ * each process that owns it. Non-shared memory is counted
+ * accurately.
+ */
+char *task_mem(struct mm_struct *mm, char *buffer)
+{
+	unsigned long bytes = 0, sbytes = 0, slack = 0;
+	struct mm_tblock_struct *tblock;
+        
+	down_read(&mm->mmap_sem);
+	for (tblock = &mm->context.tblock; tblock; tblock = tblock->next) {
+		if (!tblock->rblock)
+			continue;
+		bytes += kobjsize(tblock);
+		if (atomic_read(&mm->mm_count) > 1 ||
+		    tblock->rblock->refcount > 1) {
+			sbytes += kobjsize(tblock->rblock->kblock);
+			sbytes += kobjsize(tblock->rblock);
+		} else {
+			bytes += kobjsize(tblock->rblock->kblock);
+			bytes += kobjsize(tblock->rblock);
+			slack += kobjsize(tblock->rblock->kblock) -
+					tblock->rblock->size;
+		}
+	}
+
+	if (atomic_read(&mm->mm_count) > 1)
+		sbytes += kobjsize(mm);
+	else
+		bytes += kobjsize(mm);
+	
+	if (current->fs && atomic_read(&current->fs->count) > 1)
+		sbytes += kobjsize(current->fs);
+	else
+		bytes += kobjsize(current->fs);
+
+	if (current->files && atomic_read(&current->files->count) > 1)
+		sbytes += kobjsize(current->files);
+	else
+		bytes += kobjsize(current->files);
+
+	if (current->sig && atomic_read(&current->sig->count) > 1)
+		sbytes += kobjsize(current->sig);
+	else
+		bytes += kobjsize(current->sig);
+
+	bytes += kobjsize(current); /* includes kernel stack */
+
+	buffer += sprintf(buffer,
+		"Mem:\t%8lu bytes\n"
+		"Slack:\t%8lu bytes\n"
+		"Shared:\t%8lu bytes\n",
+		bytes, slack, sbytes);
+
+	up_read(&mm->mmap_sem);
+	return buffer;
+}
+
+unsigned long task_vsize(struct mm_struct *mm)
+{
+	struct mm_tblock_struct *tbp;
+	unsigned long vsize;
+
+	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
+		if (tbp->rblock)
+			vsize += kobjsize(tbp->rblock->kblock);
+	}
+
+	return vsize;
+}
+
+int task_statm(struct mm_struct *mm, int *shared, int *text,
+	       int *data, int *resident)
+{
+	struct mm_tblock_struct *tbp;
+	int size = kobjsize(mm);
+	
+	for (tbp = &mm->context.tblock; tbp; tbp = tbp->next) {
+		if (tbp->next)
+			size += kobjsize(tbp->next);
+		if (tbp->rblock) {
+			size += kobjsize(tbp->rblock);
+			size += kobjsize(tbp->rblock->kblock);
+		}
+	}
+
+	size += (text = mm->end_code - mm->start_code);
+	size += (data = mm->start_stack - mm->start_data);
+
+	*resident = size;
+	return size;
+}
