Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWHTCIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWHTCIz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 22:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWHTCIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 22:08:55 -0400
Received: from mother.openwall.net ([195.42.179.200]:29588 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751394AbWHTCIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 22:08:54 -0400
Date: Sun, 20 Aug 2006 06:04:17 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH x7] misc fixes from 2.4.33-ow1
Message-ID: <20060820020417.GA17450@openwall.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Willy and all,

Attached are 7 small changes from 2.4.33-ow1, as separate patches.  I do
not feel that these warrant separate messages.

linux-2.4.33-ow1-BAD_ADDR.diff

This one is a one-liner, in binfmt_elf.c:

-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)

I feel that it is more logical to have BAD_ADDR() defined in this way:
indeed, the first kernel-space address is unusable for userspace.  I
don't think this change affects anything, and we had it in -ow for a
couple of years.

linux-2.4.33-ow1-create_elf_tables.diff
linux-2.4.33-ow1-elf_core_dump.diff

These two are pieces from my more elaborate version of the coredump
vulnerability fix:

	http://www.isec.pl/vulnerabilities/isec-0023-coredump.txt

The first one does for env_end the same thing that the minimal fix did
for arg_end, and the second one makes things more correct for 64-bit
archs.  Neither fixes any known security problem, although I would not
be surprised if there's a yet unexplored attack vector that uses env_end.
This has been in -ow for over a year.

linux-2.4.33-ow1-load_elf_library.diff

This rejects ELF libraries with elf_ex.e_phnum == 0 earlier in the code.
Without this change, such libraries would be rejected anyway - after a
kmalloc() and a kernel_read(), both of zero bytes.  This has been in -ow
for almost two years.

linux-2.4.33-ow1-mremap-arch-sanity.diff

This makes 32-bit emulation mmap/mremap calls on 64-bit archs refuse to
accept/return addresses beyond the 32-bit user address space.  This is
about correctness, not security.  Andrea Arcangeli did not like these,
commenting on them like: "supeflous, reject, must BUG if something", to
which I replied:

I don't see how these architecture-specific checks are superfluous.
The non-arch-specific code has only checked against TASK_SIZE, not
against the lower limit present with 32-bit syscall emulation on
64-bit archs.  Yes, with other checks in the arch-specific code, my
added checks are pretty much limited to just the special case of
addr == end, but such addr's are invalid under 32-bit syscall
emulation and should not be accepted/returned by syscalls.

BUG() would be wrong, it would introduce a DoS.

(That discussion occurred in December, 2003; I kept the changes in -ow
since then.)

linux-2.4.33-ow1-proc_file_read.diff

This is hardening of proc_file_read() similar to what was recently done
in 2.6 in response to the vulnerability discovery.  While 2.4 kernels
were not vulnerable due to differences in the lseek implementation, I
prefer to harden the reads as well.  This change is new with 2.4.33-ow1.

linux-2.4.33-ow1-proc-nosuid-noexec-nodev.diff

This attempts to make procfs MS_NOSUID | MS_NOEXEC | MS_NODEV by
default, in response to another recently discovered 2.6-specific
vulnerability (so for 2.4 this is just proactive hardening).  Most of
the changes in this patch were in -ow patches for years (in order to
enable the uid= and gid= mount options to work).  Only the specific
"s->s_flags |= ..." line is a recent addition, and this one has not yet
been tested to actually make a difference.

Thanks,

Alexander

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-BAD_ADDR.diff"

diff -urpPX nopatch linux-2.4.33/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.4.33/fs/binfmt_elf.c	Sat Aug 12 08:48:39 2006
+++ linux/fs/binfmt_elf.c	Sat Aug 12 08:51:47 2006
@@ -73,5 +76,5 @@
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
 
 static int set_brk(unsigned long start, unsigned long end)

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-create_elf_tables.diff"

diff -urpPX nopatch linux-2.4.33/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.4.33/fs/binfmt_elf.c	Sat Aug 12 08:48:39 2006
+++ linux/fs/binfmt_elf.c	Sat Aug 12 08:51:47 2006
@@ -232,6 +244,7 @@ create_elf_tables(char *p, int argc, int
 	}
 	__put_user(NULL, argv);
 	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
+	current->mm->env_end = (unsigned long) p;
 	while (envc-->0) {
 		__put_user((elf_caddr_t)(unsigned long)p,envp++);
 		len = strnlen_user(p, PAGE_SIZE*MAX_ARG_PAGES);

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-elf_core_dump.diff"

diff -urpPX nopatch linux-2.4.33/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.4.33/fs/binfmt_elf.c	Sat Aug 12 08:48:39 2006
+++ linux/fs/binfmt_elf.c	Sat Aug 12 08:51:47 2006
@@ -1166,9 +1206,12 @@ static int elf_core_dump(long signr, str
 	{
 		unsigned int i, len;
 
-		len = current->mm->arg_end - current->mm->arg_start;
-		if (len >= ELF_PRARGSZ)
-			len = ELF_PRARGSZ-1;
+		if (current->mm->arg_end > current->mm->arg_start) {
+			len = current->mm->arg_end - current->mm->arg_start;
+			if (len >= ELF_PRARGSZ)
+				len = ELF_PRARGSZ-1;
+		} else
+			len = 0;
 		copy_from_user(&psinfo.pr_psargs,
 			      (const char *)current->mm->arg_start, len);
 		for(i = 0; i < len; i++)

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-load_elf_library.diff"

diff -urpPX nopatch linux-2.4.33/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.4.33/fs/binfmt_elf.c	Sat Aug 12 08:48:39 2006
+++ linux/fs/binfmt_elf.c	Sat Aug 12 08:51:47 2006
@@ -945,8 +983,9 @@ static int load_elf_library(struct file 
 		goto out;
 
 	/* First of all, some simple consistency checks */
-	if (elf_ex.e_type != ET_EXEC || elf_ex.e_phnum > 2 ||
-	   !elf_check_arch(&elf_ex) || !file->f_op || !file->f_op->mmap)
+	if (elf_ex.e_type != ET_EXEC ||
+	    elf_ex.e_phnum < 1 || elf_ex.e_phnum > 2 ||
+	    !elf_check_arch(&elf_ex) || !file->f_op || !file->f_op->mmap)
 		goto out;
 
 	/* Now read in all of the header information */

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-mremap-arch-sanity.diff"

diff -urpPX nopatch linux-2.4.33/arch/alpha/kernel/osf_sys.c linux/arch/alpha/kernel/osf_sys.c
--- linux-2.4.33/arch/alpha/kernel/osf_sys.c	Fri Jun 13 18:51:29 2003
+++ linux/arch/alpha/kernel/osf_sys.c	Sat Aug 12 08:51:47 2006
@@ -1346,6 +1346,8 @@ arch_get_unmapped_area(struct file *filp
 
 	if (len > limit)
 		return -ENOMEM;
+	if (addr >= limit)
+		return -ENOMEM;
 
 	/* First, see if the given suggestion fits.
 
diff -urpPX nopatch linux-2.4.33/arch/sparc/kernel/sys_sparc.c linux/arch/sparc/kernel/sys_sparc.c
--- linux-2.4.33/arch/sparc/kernel/sys_sparc.c	Mon Aug 25 15:44:40 2003
+++ linux/arch/sparc/kernel/sys_sparc.c	Sat Aug 12 08:51:47 2006
@@ -52,6 +52,8 @@ unsigned long arch_get_unmapped_area(str
 	/* See asm-sparc/uaccess.h */
 	if (len > TASK_SIZE - PAGE_SIZE)
 		return -ENOMEM;
+	if (addr >= TASK_SIZE - PAGE_SIZE)
+		return -ENOMEM;
 	if (ARCH_SUN4C_SUN4 && len > 0x20000000)
 		return -ENOMEM;
 	if (!addr)
diff -urpPX nopatch linux-2.4.33/arch/sparc64/kernel/sys_sparc.c linux/arch/sparc64/kernel/sys_sparc.c
--- linux-2.4.33/arch/sparc64/kernel/sys_sparc.c	Mon Aug 25 15:44:40 2003
+++ linux/arch/sparc64/kernel/sys_sparc.c	Sat Aug 12 08:51:47 2006
@@ -63,6 +63,8 @@ unsigned long arch_get_unmapped_area(str
 		task_size = 0xf0000000UL;
 	if (len > task_size || len > -PAGE_OFFSET)
 		return -ENOMEM;
+	if (addr >= task_size)
+		return -ENOMEM;
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 
diff -urpPX nopatch linux-2.4.33/arch/x86_64/kernel/sys_x86_64.c linux/arch/x86_64/kernel/sys_x86_64.c
--- linux-2.4.33/arch/x86_64/kernel/sys_x86_64.c	Fri Nov 28 21:26:19 2003
+++ linux/arch/x86_64/kernel/sys_x86_64.c	Sat Aug 12 08:51:47 2006
@@ -94,6 +94,8 @@ unsigned long arch_get_unmapped_area(str
 	if (len > end)
 		return -ENOMEM;
 	addr = PAGE_ALIGN(addr);
+	if (addr >= end)
+		return -ENOMEM;
 
 	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-proc_file_read.diff"

diff -urpPX nopatch linux-2.4.33/fs/proc/generic.c linux/fs/proc/generic.c
--- linux-2.4.33/fs/proc/generic.c	Wed Jan 19 17:10:11 2005
+++ linux/fs/proc/generic.c	Sun Aug 13 20:59:16 2006
@@ -62,11 +62,17 @@ proc_file_read(struct file * file, char 
 	if (!(page = (char*) __get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
 
+	if (pos < 0 || pos >= MAX_NON_LFS)
+		eof = 1;
+	else if (nbytes > MAX_NON_LFS - pos)
+		nbytes = MAX_NON_LFS - pos;
+
 	while ((nbytes > 0) && !eof)
 	{
-		count = MIN(PROC_BLOCK_SIZE, nbytes);
-		if ((unsigned)pos > INT_MAX)
+		/* This is redundant, but better safe than sorry */
+		if (pos < 0 || pos >= MAX_NON_LFS)
 			break;
+		count = MIN(PROC_BLOCK_SIZE, nbytes);
 
 		start = NULL;
 		if (dp->get_info) {

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.33-ow1-proc-nosuid-noexec-nodev.diff"

diff -urpPX nopatch linux-2.4.33/fs/proc/generic.c linux/fs/proc/generic.c
--- linux-2.4.33/fs/proc/generic.c	Wed Jan 19 17:10:11 2005
+++ linux/fs/proc/generic.c	Sun Aug 13 20:59:16 2006
@@ -396,7 +402,9 @@ static int proc_register(struct proc_dir
 static void proc_kill_inodes(struct proc_dir_entry *de)
 {
 	struct list_head *p;
-	struct super_block *sb = proc_mnt->mnt_sb;
+	struct super_block *sb = proc_super;
+
+	if (!sb) return;
 
 	/*
 	 * Actually it's a partial revoke().
diff -urpPX nopatch linux-2.4.33/fs/proc/inode.c linux/fs/proc/inode.c
--- linux-2.4.33/fs/proc/inode.c	Fri Nov 28 21:26:21 2003
+++ linux/fs/proc/inode.c	Wed Aug 16 04:54:57 2006
@@ -73,8 +74,6 @@ static void proc_delete_inode(struct ino
 	}
 }
 
-struct vfsmount *proc_mnt;
-
 static void proc_read_inode(struct inode * inode)
 {
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
@@ -176,12 +179,15 @@ out_fail:
 	goto out;
 }			
 
+struct super_block *proc_super = NULL;
+
 struct super_block *proc_read_super(struct super_block *s,void *data, 
 				    int silent)
 {
 	struct inode * root_inode;
 	struct task_struct *p;
 
+	s->s_flags |= MS_NOSUID | MS_NOEXEC | MS_NODEV;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = PROC_SUPER_MAGIC;
@@ -201,6 +207,10 @@ struct super_block *proc_read_super(stru
 	if (!s->s_root)
 		goto out_no_root;
 	parse_options(data, &root_inode->i_uid, &root_inode->i_gid);
+	if (!proc_super) {
+		s->s_count++;
+		proc_super = s;
+	}
 	return s;
 
 out_no_root:
diff -urpPX nopatch linux-2.4.33/fs/proc/root.c linux/fs/proc/root.c
--- linux-2.4.33/fs/proc/root.c	Wed Nov 17 14:54:21 2004
+++ linux/fs/proc/root.c	Sat Aug 12 08:51:47 2006
@@ -30,12 +31,6 @@ void __init proc_root_init(void)
 	int err = register_filesystem(&proc_fs_type);
 	if (err)
 		return;
-	proc_mnt = kern_mount(&proc_fs_type);
-	err = PTR_ERR(proc_mnt);
-	if (IS_ERR(proc_mnt)) {
-		unregister_filesystem(&proc_fs_type);
-		return;
-	}
 	proc_misc_init();
 	proc_net = proc_mkdir("net", 0);
 	proc_net_stat = proc_mkdir("net/stat", NULL);
diff -urpPX nopatch linux-2.4.33/include/linux/proc_fs.h linux/include/linux/proc_fs.h
--- linux-2.4.33/include/linux/proc_fs.h	Sat Aug 12 08:48:39 2006
+++ linux/include/linux/proc_fs.h	Sat Aug 12 08:51:47 2006
@@ -96,7 +96,7 @@ extern struct proc_dir_entry *create_pro
 						struct proc_dir_entry *parent);
 extern void remove_proc_entry(const char *name, struct proc_dir_entry *parent);
 
-extern struct vfsmount *proc_mnt;
+extern struct super_block *proc_super;
 extern struct super_block *proc_read_super(struct super_block *,void *,int);
 extern struct inode * proc_get_inode(struct super_block *, int, struct proc_dir_entry *);
 

--+HP7ph2BbKc20aGI--
