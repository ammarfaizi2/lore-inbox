Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWHNL1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWHNL1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWHNL1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:27:55 -0400
Received: from mail.suse.de ([195.135.220.2]:53936 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751994AbWHNL1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:27:33 -0400
From: Andi Kleen <ak@suse.de>
References: <20060814 127.183332000@suse.de>
In-Reply-To: <20060814 127.183332000@suse.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] [3/3] Support piping into commands in /proc/sys/kernel/core_pattern
Message-Id: <20060814112732.684D313BD9@wotan.suse.de>
Date: Mon, 14 Aug 2006 13:27:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using the infrastructure created in previous patches implement support
to pipe core dumps into programs. 

This is done by overloading the existing core_pattern sysctl
with a new syntax:

|program

When the first character of the pattern is a '|' the kernel will
instead threat the rest of the pattern as a command to run. The 
core dump will be written to the standard input of that program
instead of to a file.

This is useful for having automatic core dump analysis without
filling up disks. The program can do some simple analysis and save only 
a summary of the core dump.

The core dump proces will run with the privileges and in the name space
of the process that caused the core dump.

I also increased the core pattern size to 128 bytes so that
longer command lines fit.

Most of the changes comes from allowing core dumps without seeks.
They are fairly straight forward though.

One small incompatibility is that if someone had a core pattern previously that
started with '|' they will get suddenly new behaviour. I think that's
unlikely to be a real problem though.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c
+++ linux/fs/exec.c
@@ -58,7 +58,7 @@
 #endif
 
 int core_uses_pid;
-char core_pattern[65] = "core";
+char core_pattern[128] = "core";
 int suid_dumpable = 0;
 
 EXPORT_SYMBOL(suid_dumpable);
@@ -1475,6 +1475,7 @@ int do_coredump(long signr, int exit_cod
 	int retval = 0;
 	int fsuid = current->fsuid;
 	int flag = 0;
+	int ispipe = 0;
 
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
@@ -1516,22 +1517,34 @@ int do_coredump(long signr, int exit_cod
  	lock_kernel();
 	format_corename(corename, core_pattern, signr);
 	unlock_kernel();
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE | flag, 0600);
+ 	if (corename[0] == '|') {
+		/* SIGPIPE can happen, but it's just never processed */
+ 		if(call_usermodehelper_pipe(corename+1, NULL, NULL, &file)) {
+ 			printk(KERN_INFO "Core dump to %s pipe failed\n",
+			       corename);
+ 			goto fail_unlock;
+ 		}
+		ispipe = 1;
+ 	} else
+ 		file = filp_open(corename,
+				 O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
 	inode = file->f_dentry->d_inode;
 	if (inode->i_nlink > 1)
 		goto close_fail;	/* multiple links - don't dump */
-	if (d_unhashed(file->f_dentry))
+	if (!ispipe && d_unhashed(file->f_dentry))
 		goto close_fail;
 
-	if (!S_ISREG(inode->i_mode))
+	/* AK: actually i see no reason to not allow this for named pipes etc.,
+	   but keep the previous behaviour for now. */
+	if (!ispipe && !S_ISREG(inode->i_mode))
 		goto close_fail;
 	if (!file->f_op)
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (do_truncate(file->f_dentry, 0, 0, file) != 0)
+	if (!ispipe && do_truncate(file->f_dentry, 0, 0, file) != 0)
 		goto close_fail;
 
 	retval = binfmt->core_dump(signr, regs, file);
Index: linux/fs/binfmt_elf.c
===================================================================
--- linux.orig/fs/binfmt_elf.c
+++ linux/fs/binfmt_elf.c
@@ -1153,11 +1153,23 @@ static int dump_write(struct file *file,
 
 static int dump_seek(struct file *file, loff_t off)
 {
-	if (file->f_op->llseek) {
-		if (file->f_op->llseek(file, off, 0) != off)
+	if (file->f_op->llseek && file->f_op->llseek != no_llseek) {
+		if (file->f_op->llseek(file, off, 1) != off)
 			return 0;
-	} else
-		file->f_pos = off;
+	} else {
+		char *buf = (char *)get_zeroed_page(GFP_KERNEL);
+		if (!buf)
+			return 0;
+		while (off > 0) {
+			unsigned long n = off;
+			if (n > PAGE_SIZE)
+				n = PAGE_SIZE;
+			if (!dump_write(file, buf, n))
+				return 0;
+			off -= n;
+		}
+		free_page((unsigned long)buf);
+	}
 	return 1;
 }
 
@@ -1205,30 +1217,32 @@ static int notesize(struct memelfnote *e
 	return sz;
 }
 
-#define DUMP_WRITE(addr, nr)	\
-	do { if (!dump_write(file, (addr), (nr))) return 0; } while(0)
-#define DUMP_SEEK(off)	\
-	do { if (!dump_seek(file, (off))) return 0; } while(0)
+#define DUMP_WRITE(addr, nr, foffset)	\
+	do { if (!dump_write(file, (addr), (nr))) return 0; *foffset += (nr); } while(0)
 
-static int writenote(struct memelfnote *men, struct file *file)
+static int alignfile(struct file *file, unsigned long *foffset)
 {
-	struct elf_note en;
+	char buf[4] = { 0, };
+	DUMP_WRITE(buf, roundup(*foffset, 4) - *foffset, foffset);
+	return 1;
+}
 
+static int writenote(struct memelfnote *men, struct file *file, unsigned long *foffset)
+{
+	struct elf_note en;
 	en.n_namesz = strlen(men->name) + 1;
 	en.n_descsz = men->datasz;
 	en.n_type = men->type;
 
-	DUMP_WRITE(&en, sizeof(en));
-	DUMP_WRITE(men->name, en.n_namesz);
-	/* XXX - cast from long long to long to avoid need for libgcc.a */
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
-	DUMP_WRITE(men->data, men->datasz);
-	DUMP_SEEK(roundup((unsigned long)file->f_pos, 4));	/* XXX */
+	DUMP_WRITE(&en, sizeof(en), foffset);
+	DUMP_WRITE(men->name, en.n_namesz, foffset);
+	if (!alignfile(file, foffset)) return 0;
+	DUMP_WRITE(men->data, men->datasz, foffset);
+	if (!alignfile(file, foffset)) return 0;
 
 	return 1;
 }
 #undef DUMP_WRITE
-#undef DUMP_SEEK
 
 #define DUMP_WRITE(addr, nr)	\
 	if ((size += (nr)) > limit || !dump_write(file, (addr), (nr))) \
@@ -1428,7 +1442,7 @@ static int elf_core_dump(long signr, str
 	int i;
 	struct vm_area_struct *vma;
 	struct elfhdr *elf = NULL;
-	off_t offset = 0, dataoff;
+	off_t offset = 0, dataoff, foffset;
 	unsigned long limit = current->signal->rlim[RLIMIT_CORE].rlim_cur;
 	int numnote;
 	struct memelfnote *notes = NULL;
@@ -1572,7 +1586,8 @@ static int elf_core_dump(long signr, str
 		DUMP_WRITE(&phdr, sizeof(phdr));
 	}
 
-	/* Page-align dumped data */
+	foffset = offset;
+
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
 	/* Write program headers for segments dump */
@@ -1597,6 +1612,7 @@ static int elf_core_dump(long signr, str
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
 		DUMP_WRITE(&phdr, sizeof(phdr));
+		foffset += sizeof(phdr);
 	}
 
 #ifdef ELF_CORE_WRITE_EXTRA_PHDRS
@@ -1605,7 +1621,7 @@ static int elf_core_dump(long signr, str
 
  	/* write out the notes section */
 	for (i = 0; i < numnote; i++)
-		if (!writenote(notes + i, file))
+		if (!writenote(notes + i, file, &foffset))
 			goto end_coredump;
 
 	/* write out the thread status notes section */
@@ -1614,11 +1630,12 @@ static int elf_core_dump(long signr, str
 				list_entry(t, struct elf_thread_status, list);
 
 		for (i = 0; i < tmp->num_notes; i++)
-			if (!writenote(&tmp->notes[i], file))
+			if (!writenote(&tmp->notes[i], file, &foffset))
 				goto end_coredump;
 	}
- 
-	DUMP_SEEK(dataoff);
+
+	/* Align to page */
+	DUMP_SEEK(dataoff - foffset);
 
 	for (vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
 		unsigned long addr;
@@ -1634,10 +1651,10 @@ static int elf_core_dump(long signr, str
 
 			if (get_user_pages(current, current->mm, addr, 1, 0, 1,
 						&page, &vma) <= 0) {
-				DUMP_SEEK(file->f_pos + PAGE_SIZE);
+				DUMP_SEEK(PAGE_SIZE);
 			} else {
 				if (page == ZERO_PAGE(addr)) {
-					DUMP_SEEK(file->f_pos + PAGE_SIZE);
+					DUMP_SEEK(PAGE_SIZE);
 				} else {
 					void *kaddr;
 					flush_cache_page(vma, addr,
@@ -1661,13 +1678,6 @@ static int elf_core_dump(long signr, str
 	ELF_CORE_WRITE_EXTRA_DATA;
 #endif
 
-	if ((off_t)file->f_pos != offset) {
-		/* Sanity check */
-		printk(KERN_WARNING
-		       "elf_core_dump: file->f_pos (%ld) != offset (%ld)\n",
-		       (off_t)file->f_pos, offset);
-	}
-
 end_coredump:
 	set_fs(fs);
 
Index: linux/kernel/sysctl.c
===================================================================
--- linux.orig/kernel/sysctl.c
+++ linux/kernel/sysctl.c
@@ -293,7 +293,7 @@ static ctl_table kern_table[] = {
 		.ctl_name	= KERN_CORE_PATTERN,
 		.procname	= "core_pattern",
 		.data		= core_pattern,
-		.maxlen		= 64,
+		.maxlen		= 128,
 		.mode		= 0644,
 		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string,
