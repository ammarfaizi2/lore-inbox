Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWDVTZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWDVTZy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWDVTZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:25:54 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45243 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751055AbWDVTZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:25:53 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:to:subject:cc:message-id:from:date;
	b=RvIg9SOInHwvYbfRxMN8JUoPPxGonNtftmZkxwHhORddFUhYHMwQ9ELp6zAYiVDUO
	ssghV+r+54093xEoMlQNg==
To: akpm@osdl.org
Subject: [PATCH] task_mmu small fixes
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Message-Id: <E1FXIlO-0004cm-Hc@blr-eng3.blr.corp.google.com>
From: Prasanna Meda <mlp@google.com>
Date: Sat, 22 Apr 2006 19:37:06 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



These are the small fixes done in recent Eric W Biederman's patches.
1. Now seqfile private is separate private struct, not task struct.
2. priv->tail_vma should not be reset based on current file position,
   since once it become NULL, reseeking will not output gate vma;
   so use separate return variable tail_vma.

Signed-Off-by: Prasanna Meda



--- a/fs/proc/task_mmu.c	2006-04-21 19:09:56.000000000 +0530
+++ b/fs/proc/task_mmu.c	2006-04-21 19:22:19.000000000 +0530
@@ -124,7 +124,8 @@ struct mem_size_stats
 
 static int show_map_internal(struct seq_file *m, void *v, struct mem_size_stats *mss)
 {
-	struct task_struct *task = m->private;
+	struct proc_maps_private *priv = m->private;
+	struct task_struct *task = priv->task;
 	struct vm_area_struct *vma = v;
 	struct mm_struct *mm = vma->vm_mm;
 	struct file *file = vma->vm_file;
@@ -302,7 +303,7 @@ static void *m_start(struct seq_file *m,
 	struct proc_maps_private *priv = m->private;
 	unsigned long last_addr = m->version;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *tail_vma = NULL;
 	loff_t l = *pos;
 
 	/* Clear the per syscall fields in priv */
@@ -327,7 +328,7 @@ static void *m_start(struct seq_file *m,
 	if (!mm)
 		return NULL;
 
-	priv->tail_vma = get_gate_vma(priv->task);
+	priv->tail_vma = tail_vma = get_gate_vma(priv->task);
 	down_read(&mm->mmap_sem);
 
 	/* Start with last addr hint */
@@ -349,17 +350,17 @@ static void *m_start(struct seq_file *m,
 	}
 
 	if (l != mm->map_count)
-		priv->tail_vma = NULL; /* After gate vma */
+		tail_vma = NULL; /* After gate vma */
 
 out:
 	if (vma)
 		return vma;
 
 	/* End of vmas has been reached */
-	m->version = (priv->tail_vma != NULL)? 0: -1UL;
+	m->version = (tail_vma != NULL)? 0: -1UL;
 	up_read(&mm->mmap_sem);
 	mmput(mm);
-	return priv->tail_vma;
+	return tail_vma;
 }
 
 static void vma_stop(struct proc_maps_private *priv, struct vm_area_struct *vma)
