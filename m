Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVANVNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVANVNM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVANVMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:12:20 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:156 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S262169AbVANVJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:09:27 -0500
From: pmeda@akamai.com
Date: Fri, 14 Jan 2005 13:12:57 -0800
Message-Id: <200501142112.NAA08016@allur.sanmateo.akamai.com>
To: jeremy@goop.org
Subject: [patch]: fix loss of records on size > 4096 in proc/<pid>/maps
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


5th: Moved the in-range map's version update logic to m_show from
m_start and m_next.  This fixes the loss of records on the reads of
size > 4096 on boundaries.

Jeremy, can you please verify it now? This is on top of 2.6.10-mm3.


--- a/fs/task_mmu.c	Fri Jan 14 00:21:23 2005
+++ b/fs/task_mmu.c	Fri Jan 14 20:20:10 2005
@@ -79,6 +79,7 @@ out:
 
 static int show_map(struct seq_file *m, void *v)
 {
+	struct task_struct *task = m->private;
 	struct vm_area_struct *map = v;
 	struct file *file = map->vm_file;
 	int flags = map->vm_flags;
@@ -110,6 +111,8 @@ static int show_map(struct seq_file *m, 
 		seq_path(m, file->f_vfsmnt, file->f_dentry, "");
 	}
 	seq_putc(m, '\n');
+	if (m->count < m->size)  /* map is copied successfully */
+		m->version = (map != get_gate_vma(task))? map->vm_start: 0;
 	return 0;
 }
 
@@ -132,10 +135,8 @@ static void *m_start(struct seq_file *m,
 		return NULL;
 
 	mm = get_task_mm(task);
-	if (!mm) {
-		m->version = -1UL;
+	if (!mm)
 		return NULL;
-	}
 
 	tail_map = get_gate_vma(task);
 	down_read(&mm->mmap_sem);
@@ -162,13 +163,11 @@ static void *m_start(struct seq_file *m,
 		tail_map = NULL; /* After gate map */
 
 out:
-	if (map && map != tail_map) {
-		m->version = map->vm_start;
+	if (map)
 		return map;
-	}
 
 	/* End of maps has reached */
-	m->version = -1UL;
+	m->version = (tail_map != NULL)? 0: -1UL;
 	up_read(&mm->mmap_sem);
 	mmput(mm);
 	return tail_map;
@@ -192,12 +191,9 @@ static void *m_next(struct seq_file *m, 
 	struct vm_area_struct *tail_map = get_gate_vma(task);
 
 	(*pos)++;
-	if (map && (map != tail_map) && map->vm_next) {
-		m->version = map->vm_next->vm_start;
+	if (map && (map != tail_map) && map->vm_next)
 		return map->vm_next;
-	}
 	m_stop(m, v);
-	m->version = -1UL;
 	return (map != tail_map)? tail_map: NULL;
 }
 
