Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVAETxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVAETxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVAETxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:53:19 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:35732 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262143AbVAETwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:52:36 -0500
From: pmeda@akamai.com
Date: Wed, 5 Jan 2005 12:55:37 -0800
Message-Id: <200501052055.MAA10940@allur.sanmateo.akamai.com>
To: akpm@osdl.org
Subject: [patch  /proc] Speedup /proc/pid/maps
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch uses find_vma() to improve the read response of /proc/pid/maps.
It attempts to make the liner scan instead of quadratic walk and utilise
rb tree.  Reading the file was doing sequential scan from the begining to
file position all the time, and taking a quite long time.

The improvements came from f_version/m_version and resulting in mmap_cache match. 
Even if mmap_cache does not match, rb tree walk should be faster than sequential
walk.  First attempt was to put the state across read system calls into private
data. Later got inspiration from wli's pid patch using f_version in readdir of /proc.
Other advantage is, f_version will be cleared automatically by lseek.

The test program creates 32K maps and splits them into two(limited by max_map_count
sysctl) using mprotect(0). After the patch, the read time improves from many
seconds to milliseconds, and does not grow superlinearly with number of read calls.

Help taken from Peter Swain in idea and testing.

After the patch:
Reading /proc/self/maps:65528 time: 0 secs and   780728 usecs buf:4096 bytes:3811362
Reading /proc/self/maps:65528 time: 1 secs and   117573 usecs buf:1024 bytes:3866627
Reading /proc/self/maps:65528 time: 0 secs and   473459 usecs buf: 256 bytes:3866627
Reading /proc/self/maps:65528 time: 0 secs and   901288 usecs buf:  64 bytes:3866627
Reading /proc/self/maps:65528 time: 1 secs and   480185 usecs buf:  16 bytes:3866627
Reading /proc/self/maps:65528 time: 1 secs and   636268 usecs buf:   4 bytes:3866627
Reading /proc/self/maps:65528 time: 4 secs and   118327 usecs buf:   1 bytes:3866627

Before the patch:
Reading /proc/self/maps:65528 time: 4 secs and   359556 usecs buf:4096 bytes:3866647
Reading /proc/self/maps:65528 time:16 secs and   218584 usecs buf:1024 bytes:3866688
Reading /proc/self/maps:65528 time:67 secs and   870200 usecs buf: 256 bytes:3866688
Reading /proc/self/maps:65528 time:255 secs and   186934 usecs buf:  64 bytes:3866688
Small reads never completed.

Signed-off-by: Prasanna Meda <pmeda@akamai.com>

--- a/include/linux/seq_file.h	Tue Dec  28 03:54:29 2004
+++ b/include/linux/seq_file.h	Tue Dec  28 03:55:10 2004
@@ -18,6 +18,7 @@
 	size_t from;
 	size_t count;
 	loff_t index;
+	loff_t version;
 	struct semaphore sem;
 	struct seq_operations *op;
 	void *private;
--- a/fs/seq_file.c	Tue Dec  28 03:50:12 2004
+++ b/fs/seq_file.c	Tue Dec  28 21:54:12 2004
@@ -35,6 +35,7 @@
 	sema_init(&p->sem, 1);
 	p->op = op;
 	file->private_data = p;
+	file->f_version = 0;
 
 	/* SEQ files support lseek, but not pread/pwrite */
 	file->f_mode &= ~(FMODE_PREAD | FMODE_PWRITE);
@@ -58,6 +59,7 @@
 	int err = 0;
 
 	down(&m->sem);
+	m->version = file->f_version;
 	/* grab buffer if we didn't have one */
 	if (!m->buf) {
 		m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);
@@ -136,6 +138,7 @@
 		copied = err;
 	else
 		*ppos += copied;
+	file->f_version = m->version;
 	up(&m->sem);
 	return copied;
 Enomem:
--- a/fs/proc/task_mmu.c	Tue Dec  28 02:51:19 2004
+++ b/fs/proc/task_mmu.c	Tue Dec  28 21:34:00 2004
@@ -81,24 +81,52 @@
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct task_struct *task = m->private;
-	struct mm_struct *mm = get_task_mm(task);
-	struct vm_area_struct * map;
+	unsigned long last_addr = m->version;
+	struct mm_struct *mm;
+	struct vm_area_struct *map, *tail_map;
 	loff_t l = *pos;
 
-	if (!mm)
+	if (last_addr == -1UL) 
 		return NULL;
 
+	mm = get_task_mm(task);
+	if (!mm) {
+		m->version = -1UL;
+		return NULL;
+	}
+
+	tail_map = get_gate_vma(task);
 	down_read(&mm->mmap_sem);
-	map = mm->mmap;
-	while (l-- && map)
+
+	/* Start with last addr hint */
+	map = find_vma(mm, last_addr);
+	if (map) {
 		map = map->vm_next;
-	if (!map) {
-		up_read(&mm->mmap_sem);
-		mmput(mm);
-		if (l == -1)
-			map = get_gate_vma(task);
+		goto out;
 	}
-	return map;
+
+	/* Check the map index is within the range */
+	if ((unsigned long)l < mm->map_count) {
+		map = mm->mmap;
+		while (l-- && map)
+			map = map->vm_next;
+		goto out;
+	}
+
+	if (l != mm->map_count)
+		tail_map = NULL; /* After gate map */
+
+out:
+	if (map && map != tail_map) {
+		m->version = map->vm_start;
+		return map;
+	}
+
+	/* End of maps has reached */
+	m->version = -1UL;
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	return tail_map;
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -117,9 +145,12 @@
 	struct task_struct *task = m->private;
 	struct vm_area_struct *map = v;
 	(*pos)++;
-	if (map->vm_next)
+	if (map && map->vm_next) {
+		m->version = map->vm_next->vm_start;
 		return map->vm_next;
+	}
 	m_stop(m, v);
+	m->version = -1UL;
 	if (map != get_gate_vma(task))
 		return get_gate_vma(task);
 	return NULL;
