Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274199AbRISV77>; Wed, 19 Sep 2001 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274200AbRISV7u>; Wed, 19 Sep 2001 17:59:50 -0400
Received: from colorfullife.com ([216.156.138.34]:39698 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S274199AbRISV7k>;
	Wed, 19 Sep 2001 17:59:40 -0400
Date: Wed, 19 Sep 2001 18:03:00 -0400
From: Manfred Spraul <manfred@colorfullife.com>
Message-Id: <200109192203.f8JM30f17574@colorfullife.com>
To: torvalds@transmeta.com
Subject: [PATCH] /proc/pid/maps cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Below is the /proc/pid/maps cleanup I posted a few days ago:

* bugfix for platforms with PAGE_SIZE != 4096.
	Some lines could get lost with long filenames.
* Tries to copy multiple lines with each call.
	volatile_task hack removed, both simpler & faster.
* generation of the printed line separated into a special function.

It's a cleanup, please apply it, even if you choose the recursive
semaphore as the bugfix for the copy_{to,from}_user deadlock.

Tested with 2.4.10-pre12.

--
	Manfred
<<<<<<<<<<<
--- 2.4/fs/proc/array.c	Wed Sep 19 23:53:26 2001
+++ build-2.4/fs/proc/array.c	Wed Sep 19 23:51:09 2001
@@ -522,11 +522,8 @@
 /*
  * For the /proc/<pid>/maps file, we use fixed length records, each containing
  * a single line.
- */
-#define MAPS_LINE_LENGTH	4096
-#define MAPS_LINE_SHIFT		12
-/*
- * f_pos = (number of the vma in the task->mm->mmap list) * MAPS_LINE_LENGTH
+ *
+ * f_pos = (number of the vma in the task->mm->mmap list) * PAGE_SIZE
  *         + (index into the line)
  */
 /* for systems with sizeof(void*) == 4: */
@@ -537,136 +534,142 @@
 #define MAPS_LINE_FORMAT8	  "%016lx-%016lx %s %016lx %s %lu"
 #define MAPS_LINE_MAX8	73 /* sum of 16  1  16  1 4 1 16 1 5 1 10 1 */
 
-#define MAPS_LINE_MAX	MAPS_LINE_MAX8
+#define MAPS_LINE_FORMAT	(sizeof(void*) == 4 ? MAPS_LINE_FORMAT4 : MAPS_LINE_FORMAT8)
+#define MAPS_LINE_MAX	(sizeof(void*) == 4 ?  MAPS_LINE_MAX4 :  MAPS_LINE_MAX8)
 
+static int proc_pid_maps_get_line (char *buf, struct vm_area_struct *map)
+{
+	/* produce the next line */
+	char *line;
+	char str[5];
+	int flags;
+	kdev_t dev;
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
+		dev = map->vm_file->f_dentry->d_inode->i_dev;
+		ino = map->vm_file->f_dentry->d_inode->i_ino;
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
+		      kdevname(dev), ino);
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
 
 ssize_t proc_pid_read_maps (struct task_struct *task, struct file * file, char * buf,
 			  size_t count, loff_t *ppos)
 {
 	struct mm_struct *mm;
-	struct vm_area_struct * map, * next;
-	char * destptr = buf, * buffer;
-	loff_t lineno;
-	ssize_t column, i;
-	int volatile_task;
+	struct vm_area_struct * map;
+	char *tmp, *kbuf;
 	long retval;
+	int off, lineno, loff;
 
+	/* reject calls with out of range parameters immediately */
+	retval = 0;
+	if (*ppos > LONG_MAX)
+		goto out;
+	if (count == 0)
+		goto out;
+	off = (long)*ppos;
 	/*
 	 * We might sleep getting the page, so get it first.
 	 */
 	retval = -ENOMEM;
-	buffer = (char*)__get_free_page(GFP_KERNEL);
-	if (!buffer)
+	kbuf = (char*)__get_free_page(GFP_KERNEL);
+	if (!kbuf)
 		goto out;
 
-	if (count == 0)
-		goto getlen_out;
+	tmp = (char*)__get_free_page(GFP_KERNEL);
+	if (!tmp)
+		goto out_free1;
+
 	task_lock(task);
 	mm = task->mm;
 	if (mm)
 		atomic_inc(&mm->mm_users);
 	task_unlock(task);
+	retval = 0;
 	if (!mm)
-		goto getlen_out;
-
-	/* Check whether the mmaps could change if we sleep */
-	volatile_task = (task != current || atomic_read(&mm->mm_users) > 2);
+		goto out_free2;
 
-	/* decode f_pos */
-	lineno = *ppos >> MAPS_LINE_SHIFT;
-	column = *ppos & (MAPS_LINE_LENGTH-1);
-
-	/* quickly go to line lineno */
 	down_read(&mm->mmap_sem);
-	for (map = mm->mmap, i = 0; map && (i < lineno); map = map->vm_next, i++)
-		continue;
-
-	for ( ; map ; map = next ) {
-		/* produce the next line */
-		char *line;
-		char str[5], *cp = str;
-		int flags;
-		kdev_t dev;
-		unsigned long ino;
-		int maxlen = (sizeof(void*) == 4) ?
-			MAPS_LINE_MAX4 :  MAPS_LINE_MAX8;
+	map = mm->mmap;
+	lineno = 0;
+	loff = 0;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+	while (map) {
 		int len;
-
-		/*
-		 * Get the next vma now (but it won't be used if we sleep).
-		 */
-		next = map->vm_next;
-		flags = map->vm_flags;
-
-		*cp++ = flags & VM_READ ? 'r' : '-';
-		*cp++ = flags & VM_WRITE ? 'w' : '-';
-		*cp++ = flags & VM_EXEC ? 'x' : '-';
-		*cp++ = flags & VM_MAYSHARE ? 's' : 'p';
-		*cp++ = 0;
-
-		dev = 0;
-		ino = 0;
-		if (map->vm_file != NULL) {
-			dev = map->vm_file->f_dentry->d_inode->i_dev;
-			ino = map->vm_file->f_dentry->d_inode->i_ino;
-			line = d_path(map->vm_file->f_dentry,
-				      map->vm_file->f_vfsmnt,
-				      buffer, PAGE_SIZE);
-			buffer[PAGE_SIZE-1] = '\n';
-			line -= maxlen;
-			if(line < buffer)
-				line = buffer;
-		} else
-			line = buffer;
-
-		len = sprintf(line,
-			      sizeof(void*) == 4 ? MAPS_LINE_FORMAT4 : MAPS_LINE_FORMAT8,
-			      map->vm_start, map->vm_end, str, map->vm_pgoff << PAGE_SHIFT,
-			      kdevname(dev), ino);
-
-		if(map->vm_file) {
-			for(i = len; i < maxlen; i++)
-				line[i] = ' ';
-			len = buffer + PAGE_SIZE - line;
-		} else
-			line[len++] = '\n';
-		if (column >= len) {
-			column = 0; /* continue with next line at column 0 */
-			lineno++;
-			continue; /* we haven't slept */
+		if (off > PAGE_SIZE) {
+			off -= PAGE_SIZE;
+			goto next;
 		}
-
-		i = len-column;
-		if (i > count)
-			i = count;
-		copy_to_user(destptr, line+column, i); /* may have slept */
-		destptr += i;
-		count   -= i;
-		column  += i;
-		if (column >= len) {
-			column = 0; /* next time: next line at column 0 */
-			lineno++;
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
 		}
-
-		/* done? */
-		if (count == 0)
-			break;
-
-		/* By writing to user space, we might have slept.
-		 * Stop the loop, to avoid a race condition.
-		 */
-		if (volatile_task)
+		off = 0;
+next:
+		if (!loff)
+			lineno++;
+		if (retval >= count)
 			break;
+		if (loff) BUG();
+		map = map->vm_next;
 	}
 	up_read(&mm->mmap_sem);
-
-	/* encode f_pos */
-	*ppos = (lineno << MAPS_LINE_SHIFT) + column;
 	mmput(mm);
 
-getlen_out:
-	retval = destptr - buf;
-	free_page((unsigned long)buffer);
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
 out:
 	return retval;
 }
