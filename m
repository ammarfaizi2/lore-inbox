Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129677AbRB0RnV>; Tue, 27 Feb 2001 12:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129531AbRB0RnL>; Tue, 27 Feb 2001 12:43:11 -0500
Received: from fdsl76.dnvr.uswest.net ([209.180.253.77]:56841 "EHLO
	willie.n0ano.com") by vger.kernel.org with ESMTP id <S129677AbRB0RnA>;
	Tue, 27 Feb 2001 12:43:00 -0500
Date: Tue, 27 Feb 2001 10:29:54 -0700
From: Don Dugger <ddugger@willie.n0ano.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Core dumps for threads
Message-ID: <20010227102954.A26230@willie.n0ano.com>
In-Reply-To: <20010224134523.O26109@valinux.com> <E14WmhG-0000Yj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
X-Mailer: Mutt 0.95.4us
In-Reply-To: <E14WmhG-0000Yj-00@the-village.bc.nu>; from Alan Cox on Sat, Feb 24, 2001 at 09:57:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii

OK, I followed Alan's suggestion and here is a patch, relative to
the 2.4.1 kernel, that copies the mm and dumps the corefile from
that copy.  Also, whenever there are multiple users of the original
mm it creates the core dump in the file `core.n' where `n' is the
PID of the offending process.

I would contend that this fixes a bug and should be put into the
2.4 but if the concensus is that it's a new 2.5 feature that's fine.

On Sat, Feb 24, 2001 at 09:57:44PM +0000, Alan Cox wrote:
> > Can anyone explain why this test is in routine `do_coredump'
> > in file `fs/exec.c' in the 2.4.0 kernel?
> > 
> >     if (!current->dumpable || atomic_read(&current->mm->mm_users) != 1)
> > 	goto fail;
> > 
> > The only thing the test on `mm_users' seems to be doing is stopping
> > a thread process from dumping core.  What's the rationale for this?
> 
> The I/O to dump the core would race other changes on the mm. The right fix
> is probably to copy the mm (as fork does) then dump the copy.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="p_core-0227.l"

Index: linux-2.4/fs/binfmt_aout.c
===================================================================
RCS file: /trillian/src/cvs_root/linux-2.4/fs/binfmt_aout.c,v
retrieving revision 1.1
diff -u -r1.1 binfmt_aout.c
--- linux-2.4/fs/binfmt_aout.c	2001/02/06 23:40:30	1.1
+++ linux-2.4/fs/binfmt_aout.c	2001/02/27 16:50:43
@@ -31,7 +31,8 @@
 
 static int load_aout_binary(struct linux_binprm *, struct pt_regs * regs);
 static int load_aout_library(struct file*);
-static int aout_core_dump(long signr, struct pt_regs * regs, struct file *file);
+static int aout_core_dump(long signr, struct pt_regs * regs,
+	struct file *file, struct mm_struct * mm);
 
 extern void dump_thread(struct pt_regs *, struct user *);
 
@@ -78,7 +79,8 @@
  * dumping of the process results in another error..
  */
 
-static int aout_core_dump(long signr, struct pt_regs * regs, struct file *file)
+static int aout_core_dump(long signr, struct pt_regs * regs,
+	struct file * file, struct mm_struct * mm)
 {
 	mm_segment_t fs;
 	int has_dumped = 0;
Index: linux-2.4/fs/binfmt_elf.c
===================================================================
RCS file: /trillian/src/cvs_root/linux-2.4/fs/binfmt_elf.c,v
retrieving revision 1.1
diff -u -r1.1 binfmt_elf.c
--- linux-2.4/fs/binfmt_elf.c	2001/02/06 23:40:30	1.1
+++ linux-2.4/fs/binfmt_elf.c	2001/02/27 16:50:43
@@ -56,7 +56,8 @@
  * don't even try.
  */
 #ifdef USE_ELF_CORE_DUMP
-static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file);
+static int elf_core_dump(long signr, struct pt_regs * regs,
+	struct file * file, struct mm_struct * mm);
 #else
 #define elf_core_dump	NULL
 #endif
@@ -981,7 +982,8 @@
  * and then they are actually written out.  If we run out of core limit
  * we just truncate.
  */
-static int elf_core_dump(long signr, struct pt_regs * regs, struct file * file)
+static int elf_core_dump(long signr, struct pt_regs * regs,
+	struct file * file, struct mm_struct * mm)
 {
 	int has_dumped = 0;
 	mm_segment_t fs;
@@ -998,7 +1000,7 @@
 	elf_fpregset_t fpu;		/* NT_PRFPREG */
 	struct elf_prpsinfo psinfo;	/* NT_PRPSINFO */
 
-	segs = current->mm->map_count;
+	segs = mm->map_count;
 
 #ifdef DEBUG
 	printk("elf_core_dump: %d segs %lu limit\n", segs, limit);
@@ -1158,7 +1160,7 @@
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
 	/* Write program headers for segments dump */
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for(vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 		struct elf_phdr phdr;
 		size_t sz;
 
@@ -1187,7 +1189,7 @@
 
 	DUMP_SEEK(dataoff);
 
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for(vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 		unsigned long addr;
 
 		if (!maydump(vma))
Index: linux-2.4/fs/exec.c
===================================================================
RCS file: /trillian/src/cvs_root/linux-2.4/fs/exec.c,v
retrieving revision 1.2
diff -u -r1.2 exec.c
--- linux-2.4/fs/exec.c	2001/02/07 01:17:26	1.2
+++ linux-2.4/fs/exec.c	2001/02/27 16:50:43
@@ -916,16 +916,18 @@
 
 int do_coredump(long signr, struct pt_regs * regs)
 {
+	struct mm_struct *mm;
 	struct linux_binfmt * binfmt;
-	char corename[6+sizeof(current->comm)];
+	char corename[6+sizeof(current->comm)+10];
 	struct file * file;
 	struct inode * inode;
+	int r;
 
 	lock_kernel();
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
-	if (!current->dumpable || atomic_read(&current->mm->mm_users) != 1)
+	if (!current->dumpable)
 		goto fail;
 	current->dumpable = 0;
 	if (current->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
@@ -937,6 +939,8 @@
 #else
 	corename[4] = '\0';
 #endif
+ 	if (atomic_read(&current->mm->mm_users) != 1)
+ 		sprintf(&corename[4], ".%d", current->pid);
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
@@ -954,10 +958,29 @@
 		goto close_fail;
 	if (do_truncate(file->f_dentry, 0) != 0)
 		goto close_fail;
-	if (!binfmt->core_dump(signr, regs, file))
-		goto close_fail;
+	/*
+	 *  Copy the mm structure to avoid potential races with
+	 *    other threads
+	 */
+	if ((mm = kmem_cache_alloc(mm_cachep, SLAB_KERNEL)) == NULL)
+		goto close_fail;
+	memcpy(mm, current->mm, sizeof(*mm));
+	if (!mm_init(mm)) {
+		kmem_cache_free(mm_cachep, mm);
+		goto close_fail;
+	}
+	down(&current->mm->mmap_sem);
+	r = dup_mmap(mm);
+	up(&current->mm->mmap_sem);
+	if (r) {
+		mmput(mm);
+		goto close_fail;
+	}
+	r = binfmt->core_dump(signr, regs, file, mm);
+	mmput(mm);
 	unlock_kernel();
-	filp_close(file, NULL);
+	if (r)
+		filp_close(file, NULL);
 	return 1;
 
 close_fail:
Index: linux-2.4/include/linux/binfmts.h
===================================================================
RCS file: /trillian/src/cvs_root/linux-2.4/include/linux/binfmts.h,v
retrieving revision 1.1
diff -u -r1.1 binfmts.h
--- linux-2.4/include/linux/binfmts.h	2001/02/06 23:41:21	1.1
+++ linux-2.4/include/linux/binfmts.h	2001/02/27 16:50:43
@@ -41,7 +41,8 @@
 	struct module *module;
 	int (*load_binary)(struct linux_binprm *, struct  pt_regs * regs);
 	int (*load_shlib)(struct file *);
-	int (*core_dump)(long signr, struct pt_regs * regs, struct file * file);
+	int (*core_dump)(long signr, struct pt_regs * regs,
+			struct file * file, struct mm_struct *mm);
 	unsigned long min_coredump;	/* minimal dump size */
 };
 
Index: linux-2.4/kernel/fork.c
===================================================================
RCS file: /trillian/src/cvs_root/linux-2.4/kernel/fork.c,v
retrieving revision 1.2
diff -u -r1.2 fork.c
--- linux-2.4/kernel/fork.c	2001/02/07 01:17:29	1.2
+++ linux-2.4/kernel/fork.c	2001/02/27 16:50:43
@@ -122,7 +122,7 @@
 	return last_pid;
 }
 
-static inline int dup_mmap(struct mm_struct * mm)
+int dup_mmap(struct mm_struct * mm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
@@ -197,7 +197,7 @@
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
-static struct mm_struct * mm_init(struct mm_struct * mm)
+struct mm_struct * mm_init(struct mm_struct * mm)
 {
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);

--/04w6evG8XlLl3ft--
