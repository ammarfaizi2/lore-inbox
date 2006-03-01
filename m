Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWCAHcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWCAHcf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWCAHcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:32:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5352 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932601AbWCAHcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:32:35 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>
Subject: [PATCH] proc: task_mmu bug fix.
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
	<20060228201040.34a1e8f5.pj@sgi.com>
	<m1irqypxf5.fsf@ebiederm.dsl.xmission.com>
	<20060228212501.25464659.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Mar 2006 00:26:06 -0700
In-Reply-To: <20060228212501.25464659.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Feb 2006 21:25:01 -0800")
Message-ID: <m1u0aiocc1.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix the big bug that has been crashing kernels when
fuser is called.  At least it is the bug I observed here.  It seems
you need the right access pattern on /proc/<pid>/maps to trigger this.

seq_operations ->stop is only called once per start making it safe to
call put_task_struct there.  However m_next was calling m_stop which
totally messed me up.  

Technically the task_struct needs to be held for the duration, so
split m_stop into two functions such that only vma_stop is called
multiple times per start. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/task_mmu.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

4217fed6dbbf2b5615d8a498b39aad5ee28d3e5f
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 4772543..f299538 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -363,17 +363,13 @@ out:
 	return priv->tail_vma;
 }
 
-static void m_stop(struct seq_file *m, void *v)
+static void vma_stop(struct proc_maps_private *priv, struct vm_area_struct *vma)
 {
-	struct proc_maps_private *priv = m->private;
-	struct vm_area_struct *vma = v;
 	if (vma && vma != priv->tail_vma) {
 		struct mm_struct *mm = vma->vm_mm;
 		up_read(&mm->mmap_sem);
 		mmput(mm);
 	}
-	if (priv->task)
-		put_task_struct(priv->task);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
@@ -385,10 +381,20 @@ static void *m_next(struct seq_file *m, 
 	(*pos)++;
 	if (vma && (vma != tail_vma) && vma->vm_next)
 		return vma->vm_next;
-	m_stop(m, v);
+	vma_stop(priv, vma);
 	return (vma != tail_vma)? tail_vma: NULL;
 }
 
+static void m_stop(struct seq_file *m, void *v)
+{
+	struct proc_maps_private *priv = m->private;
+	struct vm_area_struct *vma = v;
+
+	vma_stop(priv, vma);
+	if (priv->task)
+		put_task_struct(priv->task);
+}
+
 static struct seq_operations proc_pid_maps_op = {
 	.start	= m_start,
 	.next	= m_next,
-- 
1.2.2.g709a-dirty

