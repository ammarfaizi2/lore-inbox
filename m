Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVALPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVALPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVALPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:53:29 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:62191 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261237AbVALPuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:50:40 -0500
From: pmeda@akamai.com
Date: Wed, 12 Jan 2005 07:54:13 -0800
Message-Id: <200501121554.HAA02083@allur.sanmateo.akamai.com>
To: akpm@osdl.org
Subject: [patch] speedup /proc/<pid>/maps(4th)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fourth version:
Fixed duplicate entries. Thanks to Jeremy Fitzhardinge for reporting, and help in testing
with valgrind and dd.

Third version:
Seek fix: When  last_addr is reset by lseek, we need to depend on f_pos too. This
is fixed and made this code common with starting map.

Second version:
Tested it more, and fixed bug in last_addr vs. next_addr handling, and  added
comments. Also got rid of assumption that zero adress is not part of address space.

First version:
This patch uses find_vma() to improve the read response of /proc/pid/maps.
It attempts to make the linear scan instead of quadratic walk and utilise
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
--- a/fs/seq_file.c	Thu Jan  6 00:19:43 2005
+++ b/fs/seq_file.c	Thu Jan  6 01:17:22 2005
@@ -36,6 +36,13 @@
 	p->op = op;
 	file->private_data = p;
 
+	/* 
+	 * Wrappers around seq_open(e.g. swaps_open) need to be
+	 * aware of this. If they set f_version themselves, they
+	 * should call seq_open first and then set f_version.
+	 */
+	file->f_version = 0;  
+
 	/* SEQ files support lseek, but not pread/pwrite */
 	file->f_mode &= ~(FMODE_PREAD | FMODE_PWRITE);
 	return 0;
@@ -58,6 +65,18 @@
 	int err = 0;
 
 	down(&m->sem);
+	/*
+	 * seq_file->op->..m_start/m_stop/m_next may do special actions
+	 * or optimisations based on the file->f_version, so we want to
+	 * pass the file->f_version to those methods.
+	 *
+	 * seq_file->version is just copy of f_version, and seq_file 
+	 * methods can treat it simply as file version.
+	 * It is copied in first and copied out after all operations.
+	 * It is convenient to have it as  part of structure to avoid the
+	 * need of passing another argument to all the seq_file methods.
+	 */
+	m->version = file->f_version;
 	/* grab buffer if we didn't have one */
 	if (!m->buf) {
 		m->buf = kmalloc(m->size = PAGE_SIZE, GFP_KERNEL);
@@ -136,6 +155,7 @@
 		copied = err;
 	else
 		*ppos += copied;
+	file->f_version = m->version;
 	up(&m->sem);
 	return copied;
 Enomem:
--- a/fs/proc/task_mmu.c	Sun Jan  9 02:05:19 2005
+++ b/fs/proc/task_mmu.c	Sun Jan  9 02:05:34 2005
@@ -84,24 +84,62 @@ static int show_map(struct seq_file *m, 
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
+	/* 
+	 * We remember last_addr rather than next_addr to hit with
+	 * mmap_cache most of the time. We have zero last_addr at
+	 * the begining and also after lseek. We will have -1 last_addr
+	 * after the end of the maps.
+	 */
+
+	if (last_addr == -1UL) 
+		return NULL;
+
+	mm = get_task_mm(task);
+	if (!mm) {
+		m->version = -1UL;
 		return NULL;
+	}
 
+	tail_map = get_gate_vma(task);
 	down_read(&mm->mmap_sem);
-	map = mm->mmap;
-	while (l-- && map)
+
+	/* Start with last addr hint */
+	if (last_addr && (map = find_vma(mm, last_addr))) {
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
+	/* 
+	 * Check the map index is within the range and do
+	 * sequential scan until m_index.
+	 */
+	map = NULL;
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
@@ -119,13 +157,16 @@ static void *m_next(struct seq_file *m, 
 {
 	struct task_struct *task = m->private;
 	struct vm_area_struct *map = v;
+	struct vm_area_struct *tail_map = get_gate_vma(task);
+
 	(*pos)++;
-	if (map->vm_next)
+	if (map && (map != tail_map) && map->vm_next) {
+		m->version = map->vm_next->vm_start;
 		return map->vm_next;
+	}
 	m_stop(m, v);
-	if (map != get_gate_vma(task))
-		return get_gate_vma(task);
-	return NULL;
+	m->version = -1UL;
+	return (map != tail_map)? tail_map: NULL;
 }
 
 struct seq_operations proc_pid_maps_op = {
