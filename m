Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbSI2DoJ>; Sat, 28 Sep 2002 23:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSI2DoJ>; Sat, 28 Sep 2002 23:44:09 -0400
Received: from bitchcake.off.net ([216.138.242.5]:34726 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262383AbSI2DoI>;
	Sat, 28 Sep 2002 23:44:08 -0400
Date: Sat, 28 Sep 2002 23:49:30 -0400
From: Zach Brown <zab@zabbo.net>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH] vma->shared list_head initializations
Message-ID: <20020928234930.F13817@bitchcake.off.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more list_head debugging carnage.  This time it was proc_pid_statm()
trying to do list_empty() on vma->shared in various bad ways.    First
were head and next containing slab poison.  with that fixed, it was then
dying with a vma->shared pointing to a valid list that it wasn't a
member of.  I guessed that this was because we hadn't cleared it when we
copied it whole-sale from another vma when it was allocated.  sure
enough, the attached patch makes ps run without exploding.

Andrew, am I on to something?  If the attached patch isn't insane, can
you marshall it and the previous list_head init fix on to linus?

There are probably still arch vma allocators that are doing it wrong,
but I didn't look.

in any case, I think I'll submit the list_head debugging patch.  It
seems to do good things, and is prefaced on CONFIG_DEBUG_LIST_HEAD..
and the system appears to run fine with this and the previous fix
applied.

- z 

--- linux-2.5.39/fs/exec.c.fmuta	Sat Sep 28 19:50:20 2002
+++ linux-2.5.39/fs/exec.c	Sat Sep 28 19:51:08 2002
@@ -400,6 +400,7 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
--- linux-2.5.39/kernel/fork.c.fmuta	Sat Sep 28 19:26:32 2002
+++ linux-2.5.39/kernel/fork.c	Sat Sep 28 20:33:56 2002
@@ -246,6 +246,7 @@
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		file = tmp->vm_file;
+		INIT_LIST_HEAD(&tmp->shared);
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);
--- linux-2.5.39/mm/mmap.c.fmuta	Sat Sep 28 19:38:57 2002
+++ linux-2.5.39/mm/mmap.c	Sat Sep 28 20:35:05 2002
@@ -553,6 +553,7 @@
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	vma->vm_raend = 0;
+	INIT_LIST_HEAD(&vma->shared);
 
 	if (file) {
 		error = -EINVAL;
@@ -1052,6 +1053,8 @@
 	/* most fields are the same, copy all, and then fixup */
 	*new = *vma;
 
+	INIT_LIST_HEAD(&new->shared);
+
 	if (new_below) {
 		new->vm_end = addr;
 		vma->vm_start = addr;
@@ -1215,6 +1218,7 @@
 	vma->vm_pgoff = 0;
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
+	INIT_LIST_HEAD(&vma->shared);
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 
--- linux-2.5.39/mm/mremap.c.fmuta	Sat Sep 28 20:35:32 2002
+++ linux-2.5.39/mm/mremap.c	Sat Sep 28 20:35:51 2002
@@ -200,6 +200,7 @@
 	if (!move_page_tables(vma, new_addr, addr, old_len)) {
 		if (allocated_vma) {
 			*new_vma = *vma;
+			INIT_LIST_HEAD(&new_vma->shared);
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
 			new_vma->vm_pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
