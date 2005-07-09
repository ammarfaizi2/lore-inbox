Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbVGIBzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbVGIBzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbVGIBzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:55:16 -0400
Received: from silver.veritas.com ([143.127.12.111]:4679 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S263065AbVGIBzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:55:14 -0400
Date: Sat, 9 Jul 2005 02:56:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] smaps say vma not map
Message-ID: <Pine.LNX.4.61.0507090253270.15778@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 01:55:13.0141 (UTC) FILETIME=[3EC2DA50:01C58429]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/$pid/smaps show_smap has followed show_map in using variable name
"map" where we would usually say "vma": change them to "vma" throughout.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/proc/task_mmu.c |   98 ++++++++++++++++++++++++++---------------------------
 1 files changed, 49 insertions(+), 49 deletions(-)

--- 2.6.13-rc2-mm1/fs/proc/task_mmu.c	2005-07-07 12:33:19.000000000 +0100
+++ smaps1/fs/proc/task_mmu.c	2005-07-09 02:14:05.000000000 +0100
@@ -93,46 +93,46 @@ static void pad_len_spaces(struct seq_fi
 static int show_map(struct seq_file *m, void *v)
 {
 	struct task_struct *task = m->private;
-	struct vm_area_struct *map = v;
-	struct mm_struct *mm = map->vm_mm;
-	struct file *file = map->vm_file;
-	int flags = map->vm_flags;
+	struct vm_area_struct *vma = v;
+	struct mm_struct *mm = vma->vm_mm;
+	struct file *file = vma->vm_file;
+	int flags = vma->vm_flags;
 	unsigned long ino = 0;
 	dev_t dev = 0;
 	int len;
 
 	if (file) {
-		struct inode *inode = map->vm_file->f_dentry->d_inode;
+		struct inode *inode = vma->vm_file->f_dentry->d_inode;
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
 	}
 
 	seq_printf(m, "%08lx-%08lx %c%c%c%c %08lx %02x:%02x %lu %n",
-			map->vm_start,
-			map->vm_end,
+			vma->vm_start,
+			vma->vm_end,
 			flags & VM_READ ? 'r' : '-',
 			flags & VM_WRITE ? 'w' : '-',
 			flags & VM_EXEC ? 'x' : '-',
 			flags & VM_MAYSHARE ? 's' : 'p',
-			map->vm_pgoff << PAGE_SHIFT,
+			vma->vm_pgoff << PAGE_SHIFT,
 			MAJOR(dev), MINOR(dev), ino, &len);
 
 	/*
 	 * Print the dentry name for named mappings, and a
 	 * special [heap] marker for the heap:
 	 */
-	if (map->vm_file) {
+	if (vma->vm_file) {
 		pad_len_spaces(m, len);
 		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
 	} else {
 		if (mm) {
-			if (map->vm_start <= mm->start_brk &&
-						map->vm_end >= mm->brk) {
+			if (vma->vm_start <= mm->start_brk &&
+						vma->vm_end >= mm->brk) {
 				pad_len_spaces(m, len);
 				seq_puts(m, "[heap]");
 			} else {
-				if (map->vm_start <= mm->start_stack &&
-					map->vm_end >= mm->start_stack) {
+				if (vma->vm_start <= mm->start_stack &&
+					vma->vm_end >= mm->start_stack) {
 
 					pad_len_spaces(m, len);
 					seq_puts(m, "[stack]");
@@ -144,8 +144,8 @@ static int show_map(struct seq_file *m, 
 		}
 	}
 	seq_putc(m, '\n');
-	if (m->count < m->size)  /* map is copied successfully */
-		m->version = (map != get_gate_vma(task))? map->vm_start: 0;
+	if (m->count < m->size)  /* vma is copied successfully */
+		m->version = (vma != get_gate_vma(task))? vma->vm_start: 0;
 	return 0;
 }
 
@@ -276,11 +276,11 @@ static void smaps_pgd_range(pgd_t *pgd,
 
 static int show_smap(struct seq_file *m, void *v)
 {
-	struct vm_area_struct *map = v;
-	struct file *file = map->vm_file;
-	int flags = map->vm_flags;
-	struct mm_struct *mm = map->vm_mm;
-	unsigned long vma_len = (map->vm_end - map->vm_start);
+	struct vm_area_struct *vma = v;
+	struct file *file = vma->vm_file;
+	int flags = vma->vm_flags;
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long vma_len = (vma->vm_end - vma->vm_start);
 	struct mem_size_stats mss;
 
 	memset(&mss, 0, sizeof mss);
@@ -288,20 +288,20 @@ static int show_smap(struct seq_file *m,
 	if (mm) {
 		pgd_t *pgd;
 		spin_lock(&mm->page_table_lock);
-		pgd = pgd_offset(mm, map->vm_start);
-		smaps_pgd_range(pgd, map->vm_start, map->vm_end, &mss);
+		pgd = pgd_offset(mm, vma->vm_start);
+		smaps_pgd_range(pgd, vma->vm_start, vma->vm_end, &mss);
 		spin_unlock(&mm->page_table_lock);
 	}
 
 	seq_printf(m, "%08lx-%08lx %c%c%c%c ",
-		   map->vm_start,
-		   map->vm_end,
+		   vma->vm_start,
+		   vma->vm_end,
 		   flags & VM_READ ? 'r' : '-',
 		   flags & VM_WRITE ? 'w' : '-',
 		   flags & VM_EXEC ? 'x' : '-',
 		   flags & VM_MAYSHARE ? 's' : 'p');
 
-	if (map->vm_file)
+	if (vma->vm_file)
 		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
 
 	seq_printf(m, "\n"
@@ -325,14 +325,14 @@ static void *m_start(struct seq_file *m,
 	struct task_struct *task = m->private;
 	unsigned long last_addr = m->version;
 	struct mm_struct *mm;
-	struct vm_area_struct *map, *tail_map;
+	struct vm_area_struct *vma, *tail_vma;
 	loff_t l = *pos;
 
 	/*
 	 * We remember last_addr rather than next_addr to hit with
 	 * mmap_cache most of the time. We have zero last_addr at
 	 * the begining and also after lseek. We will have -1 last_addr
-	 * after the end of the maps.
+	 * after the end of the vmas.
 	 */
 
 	if (last_addr == -1UL)
@@ -342,47 +342,47 @@ static void *m_start(struct seq_file *m,
 	if (!mm)
 		return NULL;
 
-	tail_map = get_gate_vma(task);
+	tail_vma = get_gate_vma(task);
 	down_read(&mm->mmap_sem);
 
 	/* Start with last addr hint */
-	if (last_addr && (map = find_vma(mm, last_addr))) {
-		map = map->vm_next;
+	if (last_addr && (vma = find_vma(mm, last_addr))) {
+		vma = vma->vm_next;
 		goto out;
 	}
 
 	/*
-	 * Check the map index is within the range and do
+	 * Check the vma index is within the range and do
 	 * sequential scan until m_index.
 	 */
-	map = NULL;
+	vma = NULL;
 	if ((unsigned long)l < mm->map_count) {
-		map = mm->mmap;
-		while (l-- && map)
-			map = map->vm_next;
+		vma = mm->mmap;
+		while (l-- && vma)
+			vma = vma->vm_next;
 		goto out;
 	}
 
 	if (l != mm->map_count)
-		tail_map = NULL; /* After gate map */
+		tail_vma = NULL; /* After gate vma */
 
 out:
-	if (map)
-		return map;
+	if (vma)
+		return vma;
 
-	/* End of maps has reached */
-	m->version = (tail_map != NULL)? 0: -1UL;
+	/* End of vmas has been reached */
+	m->version = (tail_vma != NULL)? 0: -1UL;
 	up_read(&mm->mmap_sem);
 	mmput(mm);
-	return tail_map;
+	return tail_vma;
 }
 
 static void m_stop(struct seq_file *m, void *v)
 {
 	struct task_struct *task = m->private;
-	struct vm_area_struct *map = v;
-	if (map && map != get_gate_vma(task)) {
-		struct mm_struct *mm = map->vm_mm;
+	struct vm_area_struct *vma = v;
+	if (vma && vma != get_gate_vma(task)) {
+		struct mm_struct *mm = vma->vm_mm;
 		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
@@ -391,14 +391,14 @@ static void m_stop(struct seq_file *m, v
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct task_struct *task = m->private;
-	struct vm_area_struct *map = v;
-	struct vm_area_struct *tail_map = get_gate_vma(task);
+	struct vm_area_struct *vma = v;
+	struct vm_area_struct *tail_vma = get_gate_vma(task);
 
 	(*pos)++;
-	if (map && (map != tail_map) && map->vm_next)
-		return map->vm_next;
+	if (vma && (vma != tail_vma) && vma->vm_next)
+		return vma->vm_next;
 	m_stop(m, v);
-	return (map != tail_map)? tail_map: NULL;
+	return (vma != tail_vma)? tail_vma: NULL;
 }
 
 struct seq_operations proc_pid_maps_op = {
