Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRIRMxc>; Tue, 18 Sep 2001 08:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRIRMxX>; Tue, 18 Sep 2001 08:53:23 -0400
Received: from colorfullife.com ([216.156.138.34]:37385 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S270795AbRIRMxL>;
	Tue, 18 Sep 2001 08:53:11 -0400
Message-ID: <3BA743C5.90B11CF5@colorfullife.com>
Date: Tue, 18 Sep 2001 14:53:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        dhowells@redhat.com, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
In-Reply-To: <001701c13fc2$cda19a90$010411ac@local> <200109172339.f8HNd5W13244@penguin.transmeta.com> <20010918020139.B698@athlon.random> <000901c14014$494f9380$010411ac@local> <20010918095549.T698@athlon.random>
Content-Type: multipart/mixed;
 boundary="------------BAC91C8E3D397D69B580E6EF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BAC91C8E3D397D69B580E6EF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a rewritten proc_pid_read_maps. Patch against 2.4.9-ac9, but
should apply against 2.4.9 as well.

As a side-effect, it's more efficient since it tries to return multiple
lines in each call, without the volatile_task hack.

Code that's older than 2.4.3 can't cause recursions - that was before
the rw-mmap_sem change.

* ptrace doesn't cause any recursions, it always copies into temporary
kernel buffers.

* the multithreaded coredump patch added down_read() around
binfmt->core_dump(). I'll think about the simplest way to fix that.

--
	Manfred
--------------BAC91C8E3D397D69B580E6EF
Content-Type: text/plain; charset=us-ascii;
 name="patch-array"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-array"

--- 2.4/fs/proc/array.c	Thu Sep  6 20:51:37 2001
+++ build-2.4/fs/proc/array.c	Tue Sep 18 14:25:17 2001
@@ -537,136 +537,142 @@
 #define MAPS_LINE_FORMAT8	  "%016lx-%016lx %s %016lx %s %lu"
 #define MAPS_LINE_MAX8	73 /* sum of 16  1  16  1 4 1 16 1 5 1 10 1 */
 
-#define MAPS_LINE_MAX	MAPS_LINE_MAX8
+#define MAPS_LINE_FORMAT	(sizeof(void*) == 4 ? MAPS_LINE_FORMAT4 : MAPS_LINE_FORMAT8)
+#define MAPS_LINE_MAX	(sizeof(void*) == 4 ?  MAPS_LINE_MAX4 :  MAPS_LINE_MAX8)
 
+int proc_pid_maps_get_line (char *buf, struct vm_area_struct *map)
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
 	struct vm_area_struct * map, * next;
-	char * destptr = buf, * buffer;
-	loff_t lineno;
-	ssize_t column, i;
-	int volatile_task;
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
-
-	/* decode f_pos */
-	lineno = *ppos >> MAPS_LINE_SHIFT;
-	column = *ppos & (MAPS_LINE_LENGTH-1);
+		goto out_free2;
 
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
+		if (off > MAPS_LINE_LENGTH) {
+			off -= MAPS_LINE_LENGTH;
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
+	}
+	if (retval > count) BUG();
+	if (copy_to_user(buf, kbuf, retval)) {
+		retval = -EFAULT;
+	} else {
+		*ppos = (lineno << MAPS_LINE_SHIFT) + loff;
 	}
 	up_read(&mm->mmap_sem);
-
-	/* encode f_pos */
-	*ppos = (lineno << MAPS_LINE_SHIFT) + column;
 	mmput(mm);
 
-getlen_out:
-	retval = destptr - buf;
-	free_page((unsigned long)buffer);
+out_free2:
+	free_page((unsigned long)tmp);
+out_free1:
+	free_page((unsigned long)kbuf);
 out:
 	return retval;
 }

--------------BAC91C8E3D397D69B580E6EF--

