Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRJNINj>; Sun, 14 Oct 2001 04:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274756AbRJNINd>; Sun, 14 Oct 2001 04:13:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11844 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274803AbRJNINL>; Sun, 14 Oct 2001 04:13:11 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC] "Text file busy" when overwriting libraries
In-Reply-To: <Pine.LNX.4.33.0110050952510.1540-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2001 02:02:21 -0600
In-Reply-To: <Pine.LNX.4.33.0110050952510.1540-100000@penguin.transmeta.com>
Message-ID: <m1het2r6nm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Linus Torvalds <torvalds@transmeta.com> writes:


> I think it literally was /var/run/[uw]tmp, and using MAP_DENYWRITE to
> disable all logins.
> 
> But it pretty much covers _any_ logfiles that are readable (and thus
> openable) by users.

Thank you for the help understanding the historical pitfalls.


> > Currently checking to see if the file is executable looks good
> > enough.
> 
> [ executable by the user in question, not just anybody ]
> 
> Yes, I suspect it is.

If it isn't we can add an extra check to make certain no one has
write permission to the file.  But that feels icky.

Looking at the problem a little more you can do better than MAP_DENYWRITE.
Instead of dening write access per mapping we can more easily deny
write access from the open of a file.  And add an O_EXEC option to open.

Adding the O_EXEC is possible now because we keep a struct file in the 
vm_area_struct.  Which was not the case when MAP_DENYWRITE was
written.  This allows the mapping code to totally ignore the read only
mapping case.

What follows is my initial patch to implement O_EXEC against 2.4.12.
With this patch I totally delete MAP_DENYWRITE except in the arch
headers so we don't accidently reuse it's value. open_exec becomes
open_filp(O_EXEC | O_RDONLY).  And now we don't have to manually
call allow_write_access whenever we call fput on a mapping.  

My big question is how to correctly define O_EXEC for every
architecture.  But I would like to know if there are objectionable
parts as well.

Eric



--=-=-=
Content-Disposition: attachment; filename=linux-2.4.12.eb2.diff

diff -uNrX linux-ignore-files linux-2.4.12/Documentation/Changes linux-2.4.12.eb2/Documentation/Changes
--- linux-2.4.12/Documentation/Changes	Sat Oct 13 16:19:40 2001
+++ linux-2.4.12.eb2/Documentation/Changes	Sun Oct 14 01:39:38 2001
@@ -126,6 +126,13 @@
 
 32-bit UID support is now in place.  Have fun!
 
+A new flag O_EXEC has been added to the open call.  While a file
+is opened O_EXEC you get ETXTBSY errors if you attempt to write it.
+This allows shared libraries to have the same garanutee against
+changes as normal executables do.  The permissions requirements
+to open a file O_EXEC are (a) no one has it open read/write and
+(b) that the open has execute permissions on the file.
+
 Linux documentation for functions is transitioning to inline
 documentation via specially-formatted comments near their
 definitions in the source.  These comments can be combined with the
diff -uNrX linux-ignore-files linux-2.4.12/arch/alpha/kernel/osf_sys.c linux-2.4.12.eb2/arch/alpha/kernel/osf_sys.c
--- linux-2.4.12/arch/alpha/kernel/osf_sys.c	Sat Oct 13 16:18:56 2001
+++ linux-2.4.12.eb2/arch/alpha/kernel/osf_sys.c	Sat Oct 13 17:15:04 2001
@@ -240,7 +240,7 @@
 		if (!file)
 			goto out;
 	}
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	down_write(&current->mm->mmap_sem);
 	ret = do_mmap(file, addr, len, prot, flags, off);
 	up_write(&current->mm->mmap_sem);
diff -uNrX linux-ignore-files linux-2.4.12/arch/arm/kernel/sys_arm.c linux-2.4.12.eb2/arch/arm/kernel/sys_arm.c
--- linux-2.4.12/arch/arm/kernel/sys_arm.c	Wed Jul 25 03:08:24 2001
+++ linux-2.4.12.eb2/arch/arm/kernel/sys_arm.c	Sat Oct 13 17:07:57 2001
@@ -58,7 +58,7 @@
 	int error = -EINVAL;
 	struct file * file = NULL;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 
 	/*
 	 * If we are doing a fixed mapping, and address < PAGE_SIZE,
diff -uNrX linux-ignore-files linux-2.4.12/arch/cris/kernel/sys_cris.c linux-2.4.12.eb2/arch/cris/kernel/sys_cris.c
--- linux-2.4.12/arch/cris/kernel/sys_cris.c	Sat Aug 11 09:50:04 2001
+++ linux-2.4.12.eb2/arch/cris/kernel/sys_cris.c	Sat Oct 13 17:14:06 2001
@@ -52,7 +52,7 @@
         int error = -EBADF;
         struct file * file = NULL;
 
-        flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+        flags &= ~(MAP_EXECUTABLE);
         if (!(flags & MAP_ANONYMOUS)) {
                 file = fget(fd);
                 if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/i386/kernel/sys_i386.c linux-2.4.12.eb2/arch/i386/kernel/sys_i386.c
--- linux-2.4.12/arch/i386/kernel/sys_i386.c	Sat Apr 14 13:36:44 2001
+++ linux-2.4.12.eb2/arch/i386/kernel/sys_i386.c	Sat Oct 13 17:08:07 2001
@@ -48,7 +48,7 @@
 	int error = -EBADF;
 	struct file * file = NULL;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/ia64/ia32/sys_ia32.c linux-2.4.12.eb2/arch/ia64/ia32/sys_ia32.c
--- linux-2.4.12/arch/ia64/ia32/sys_ia32.c	Sat Oct 13 16:18:57 2001
+++ linux-2.4.12.eb2/arch/ia64/ia32/sys_ia32.c	Sat Oct 13 17:15:34 2001
@@ -282,7 +282,7 @@
 	long error = -EFAULT;
 	unsigned int poff;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	prot |= PROT_EXEC;
 
 	if ((flags & MAP_FIXED) && ((addr & ~PAGE_MASK) || (offset & ~PAGE_MASK)))
diff -uNrX linux-ignore-files linux-2.4.12/arch/ia64/kernel/sys_ia64.c linux-2.4.12.eb2/arch/ia64/kernel/sys_ia64.c
--- linux-2.4.12/arch/ia64/kernel/sys_ia64.c	Sat Aug 11 09:50:05 2001
+++ linux-2.4.12.eb2/arch/ia64/kernel/sys_ia64.c	Sat Oct 13 17:10:39 2001
@@ -178,7 +178,7 @@
 	unsigned long roff;
 	struct file *file = 0;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/m68k/kernel/sys_m68k.c linux-2.4.12.eb2/arch/m68k/kernel/sys_m68k.c
--- linux-2.4.12/arch/m68k/kernel/sys_m68k.c	Wed Jul 25 03:07:49 2001
+++ linux-2.4.12.eb2/arch/m68k/kernel/sys_m68k.c	Sat Oct 13 17:11:13 2001
@@ -52,7 +52,7 @@
 	int error = -EBADF;
 	struct file * file = NULL;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
@@ -104,7 +104,7 @@
 	if (a.offset & ~PAGE_MASK)
 		goto out;
 
-	a.flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	a.flags &= ~(MAP_EXECUTABLE);
 
 	error = do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
 out:
@@ -144,7 +144,7 @@
 		if (!file)
 			goto out;
 	}
-	a.flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	a.flags &= ~(MAP_EXECUTABLE);
 
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, pgoff);
diff -uNrX linux-ignore-files linux-2.4.12/arch/mips/kernel/irixelf.c linux-2.4.12.eb2/arch/mips/kernel/irixelf.c
--- linux-2.4.12/arch/mips/kernel/irixelf.c	Sat Apr 14 13:36:44 2001
+++ linux-2.4.12.eb2/arch/mips/kernel/irixelf.c	Sun Oct 14 00:35:14 2001
@@ -298,7 +298,7 @@
 	eppnt = elf_phdata;
 	for(i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
 	  if(eppnt->p_type == PT_LOAD) {
-	    int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
+	    int elf_type = MAP_PRIVATE;
 	    int elf_prot = 0;
 	    unsigned long vaddr = 0;
 	    if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
@@ -479,7 +479,7 @@
 	return 0;
 }
 
-#define EXEC_MAP_FLAGS (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE)
+#define EXEC_MAP_FLAGS (MAP_FIXED | MAP_PRIVATE | MAP_EXECUTABLE)
 
 static inline void map_executable(struct file *fp, struct elf_phdr *epp, int pnum,
 				  unsigned int *estack, unsigned int *laddr,
@@ -776,7 +776,6 @@
 	return retval;
 
 out_free_dentry:
-	allow_write_access(interpreter);
 	fput(interpreter);
 out_free_interp:
 	if (elf_interpreter)
@@ -842,7 +841,7 @@
 			elf_phdata->p_vaddr & 0xfffff000,
 			elf_phdata->p_filesz + (elf_phdata->p_vaddr & 0xfff),
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
+			MAP_FIXED | MAP_PRIVATE,
 			elf_phdata->p_offset & 0xfffff000);
 	up_write(&current->mm->mmap_sem);
 
@@ -919,7 +918,7 @@
 		down_write(&current->mm->mmap_sem);
 		retval = do_mmap(filp, (hp->p_vaddr & 0xfffff000),
 				 (hp->p_filesz + (hp->p_vaddr & 0xfff)),
-				 prot, (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE),
+				 prot, (MAP_FIXED | MAP_PRIVATE),
 				 (hp->p_offset & 0xfffff000));
 		up_write(&current->mm->mmap_sem);
 
diff -uNrX linux-ignore-files linux-2.4.12/arch/mips/kernel/syscall.c linux-2.4.12.eb2/arch/mips/kernel/syscall.c
--- linux-2.4.12/arch/mips/kernel/syscall.c	Wed Jul 25 03:07:50 2001
+++ linux-2.4.12.eb2/arch/mips/kernel/syscall.c	Sat Oct 13 17:11:32 2001
@@ -62,7 +62,7 @@
 	int error = -EBADF;
 	struct file * file = NULL;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/mips/kernel/sysirix.c linux-2.4.12.eb2/arch/mips/kernel/sysirix.c
--- linux-2.4.12/arch/mips/kernel/sysirix.c	Sat Oct 13 16:18:57 2001
+++ linux-2.4.12.eb2/arch/mips/kernel/sysirix.c	Sat Oct 13 17:16:16 2001
@@ -1080,7 +1080,7 @@
 		}
 	}
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file, addr, len, prot, flags, offset);
@@ -1640,7 +1640,7 @@
 		}
 	}
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
diff -uNrX linux-ignore-files linux-2.4.12/arch/mips64/kernel/syscall.c linux-2.4.12.eb2/arch/mips64/kernel/syscall.c
--- linux-2.4.12/arch/mips64/kernel/syscall.c	Sat Oct 13 16:19:43 2001
+++ linux-2.4.12.eb2/arch/mips64/kernel/syscall.c	Sat Oct 13 17:11:45 2001
@@ -63,7 +63,7 @@
 		if (!file)
 			goto out;
 	}
-        flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+        flags &= ~(MAP_EXECUTABLE);
 
 	down_write(&current->mm->mmap_sem);
         error = do_mmap(file, addr, len, prot, flags, offset);
diff -uNrX linux-ignore-files linux-2.4.12/arch/parisc/kernel/sys_parisc.c linux-2.4.12.eb2/arch/parisc/kernel/sys_parisc.c
--- linux-2.4.12/arch/parisc/kernel/sys_parisc.c	Sat Apr 14 13:36:45 2001
+++ linux-2.4.12.eb2/arch/parisc/kernel/sys_parisc.c	Sat Oct 13 17:13:55 2001
@@ -59,7 +59,7 @@
 		if (!file)
 			goto out;
 	}
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	error = do_mmap(file, addr, len, prot, flags, offset);
 	if (file != NULL)
 		fput(file);
diff -uNrX linux-ignore-files linux-2.4.12/arch/ppc/kernel/syscalls.c linux-2.4.12.eb2/arch/ppc/kernel/syscalls.c
--- linux-2.4.12/arch/ppc/kernel/syscalls.c	Wed Jul 25 03:07:25 2001
+++ linux-2.4.12.eb2/arch/ppc/kernel/syscalls.c	Sat Oct 13 17:12:01 2001
@@ -196,7 +196,7 @@
 	struct file * file = NULL;
 	int ret = -EBADF;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		if (!(file = fget(fd)))
 			goto out;
diff -uNrX linux-ignore-files linux-2.4.12/arch/s390/kernel/sys_s390.c linux-2.4.12.eb2/arch/s390/kernel/sys_s390.c
--- linux-2.4.12/arch/s390/kernel/sys_s390.c	Sat Apr 14 13:36:45 2001
+++ linux-2.4.12.eb2/arch/s390/kernel/sys_s390.c	Sat Oct 13 17:13:33 2001
@@ -54,7 +54,7 @@
 	int error = -EBADF;
 	struct file * file = NULL;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/s390x/kernel/linux32.c linux-2.4.12.eb2/arch/s390x/kernel/linux32.c
--- linux-2.4.12/arch/s390x/kernel/linux32.c	Sat Oct 13 16:18:57 2001
+++ linux-2.4.12.eb2/arch/s390x/kernel/linux32.c	Sat Oct 13 20:13:59 2001
@@ -2923,12 +2923,10 @@
 	bprm.loader = 0;
 	bprm.exec = 0;
 	if ((bprm.argc = count32(argv)) < 0) {
-		allow_write_access(file);
 		fput(file);
 		return bprm.argc;
 	}
 	if ((bprm.envc = count32(envp)) < 0) {
-		allow_write_access(file);
 		fput(file);
 		return bprm.envc;
 	}
@@ -2957,7 +2955,6 @@
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
 	if (bprm.file)
 		fput(bprm.file);
 
@@ -4179,7 +4176,7 @@
 	struct file * file = NULL;
 	unsigned long error = -EBADF;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/s390x/kernel/sys_s390.c linux-2.4.12.eb2/arch/s390x/kernel/sys_s390.c
--- linux-2.4.12/arch/s390x/kernel/sys_s390.c	Thu May  3 01:46:43 2001
+++ linux-2.4.12.eb2/arch/s390x/kernel/sys_s390.c	Sat Oct 13 17:14:23 2001
@@ -54,7 +54,7 @@
 	long error = -EBADF;
 	struct file * file = NULL;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/sh/kernel/sys_sh.c linux-2.4.12.eb2/arch/sh/kernel/sys_sh.c
--- linux-2.4.12/arch/sh/kernel/sys_sh.c	Sat Oct 13 16:19:45 2001
+++ linux-2.4.12.eb2/arch/sh/kernel/sys_sh.c	Sat Oct 13 17:12:17 2001
@@ -89,7 +89,7 @@
 	int error = -EBADF;
 	struct file *file = NULL;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
 		if (!file)
diff -uNrX linux-ignore-files linux-2.4.12/arch/sparc/kernel/sys_sparc.c linux-2.4.12.eb2/arch/sparc/kernel/sys_sparc.c
--- linux-2.4.12/arch/sparc/kernel/sys_sparc.c	Thu May  3 01:46:43 2001
+++ linux-2.4.12.eb2/arch/sparc/kernel/sys_sparc.c	Sat Oct 13 17:12:40 2001
@@ -240,7 +240,7 @@
 	if (len > TASK_SIZE - PAGE_SIZE || addr + len > TASK_SIZE - PAGE_SIZE)
 		goto out_putf;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
diff -uNrX linux-ignore-files linux-2.4.12/arch/sparc/kernel/sys_sunos.c linux-2.4.12.eb2/arch/sparc/kernel/sys_sunos.c
--- linux-2.4.12/arch/sparc/kernel/sys_sunos.c	Sat Oct 13 16:18:57 2001
+++ linux-2.4.12.eb2/arch/sparc/kernel/sys_sunos.c	Sun Oct 14 00:35:47 2001
@@ -115,7 +115,7 @@
 			goto out_putf;
 	}
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file, addr, len, prot, flags, off);
 	up_write(&current->mm->mmap_sem);
diff -uNrX linux-ignore-files linux-2.4.12/arch/sparc64/kernel/binfmt_aout32.c linux-2.4.12.eb2/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.4.12/arch/sparc64/kernel/binfmt_aout32.c	Wed Jul 25 03:08:26 2001
+++ linux-2.4.12.eb2/arch/sparc64/kernel/binfmt_aout32.c	Sun Oct 14 00:36:22 2001
@@ -280,7 +280,7 @@
 	        down_write(&current->mm->mmap_sem);
 		error = do_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
+			MAP_FIXED | MAP_PRIVATE | MAP_EXECUTABLE,
 			fd_offset);
 	        up_write(&current->mm->mmap_sem);
 
@@ -292,7 +292,7 @@
 	        down_write(&current->mm->mmap_sem);
  		error = do_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
+				MAP_FIXED | MAP_PRIVATE | MAP_EXECUTABLE,
 				fd_offset + ex.a_text);
 	        up_write(&current->mm->mmap_sem);
 		if (error != N_DATADDR(ex)) {
@@ -372,7 +372,7 @@
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
+			MAP_FIXED | MAP_PRIVATE,
 			N_TXTOFF(ex));
 	up_write(&current->mm->mmap_sem);
 	retval = error;
diff -uNrX linux-ignore-files linux-2.4.12/arch/sparc64/kernel/sys_sparc.c linux-2.4.12.eb2/arch/sparc64/kernel/sys_sparc.c
--- linux-2.4.12/arch/sparc64/kernel/sys_sparc.c	Thu May  3 01:46:44 2001
+++ linux-2.4.12.eb2/arch/sparc64/kernel/sys_sparc.c	Sat Oct 13 17:13:19 2001
@@ -277,7 +277,7 @@
 		if (!file)
 			goto out;
 	}
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	len = PAGE_ALIGN(len);
 	retval = -EINVAL;
 
diff -uNrX linux-ignore-files linux-2.4.12/arch/sparc64/kernel/sys_sparc32.c linux-2.4.12.eb2/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.4.12/arch/sparc64/kernel/sys_sparc32.c	Sat Oct 13 16:21:40 2001
+++ linux-2.4.12.eb2/arch/sparc64/kernel/sys_sparc32.c	Sat Oct 13 20:28:49 2001
@@ -2998,12 +2998,10 @@
 	bprm.loader = 0;
 	bprm.exec = 0;
 	if ((bprm.argc = count32(argv, bprm.p / sizeof(u32))) < 0) {
-		allow_write_access(file);
 		fput(file);
 		return bprm.argc;
 	}
 	if ((bprm.envc = count32(envp, bprm.p / sizeof(u32))) < 0) {
-		allow_write_access(file);
 		fput(file);
 		return bprm.envc;
 	}
@@ -3032,7 +3030,6 @@
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
 	if (bprm.file)
 		fput(bprm.file);
 
diff -uNrX linux-ignore-files linux-2.4.12/arch/sparc64/kernel/sys_sunos32.c linux-2.4.12.eb2/arch/sparc64/kernel/sys_sunos32.c
--- linux-2.4.12/arch/sparc64/kernel/sys_sunos32.c	Sat Oct 13 16:18:58 2001
+++ linux-2.4.12.eb2/arch/sparc64/kernel/sys_sunos32.c	Sat Oct 13 17:16:57 2001
@@ -99,7 +99,7 @@
 	ret_type = flags & _MAP_NEW;
 	flags &= ~_MAP_NEW;
 
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file,
 			 (unsigned long) addr, (unsigned long) len,
diff -uNrX linux-ignore-files linux-2.4.12/arch/sparc64/solaris/misc.c linux-2.4.12.eb2/arch/sparc64/solaris/misc.c
--- linux-2.4.12/arch/sparc64/solaris/misc.c	Sat Oct 13 16:19:45 2001
+++ linux-2.4.12.eb2/arch/sparc64/solaris/misc.c	Sat Oct 13 17:17:17 2001
@@ -93,7 +93,7 @@
 	flags &= ~_MAP_NEW;
 
 	down_write(&current->mm->mmap_sem);
-	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
+	flags &= ~(MAP_EXECUTABLE);
 	retval = do_mmap(file,
 			 (unsigned long) addr, (unsigned long) len,
 			 (unsigned long) prot, (unsigned long) flags, off);
Binary files linux-2.4.12/drivers/net/hamradio/soundmodem/gentbl and linux-2.4.12.eb2/drivers/net/hamradio/soundmodem/gentbl differ
diff -uNrX linux-ignore-files linux-2.4.12/fs/binfmt_aout.c linux-2.4.12.eb2/fs/binfmt_aout.c
--- linux-2.4.12/fs/binfmt_aout.c	Sat Oct 13 16:21:50 2001
+++ linux-2.4.12.eb2/fs/binfmt_aout.c	Sun Oct 14 00:59:39 2001
@@ -380,7 +380,7 @@
 		down_write(&current->mm->mmap_sem);
 		error = do_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
+			MAP_FIXED | MAP_PRIVATE | MAP_EXECUTABLE,
 			fd_offset);
 		up_write(&current->mm->mmap_sem);
 
@@ -392,7 +392,7 @@
 		down_write(&current->mm->mmap_sem);
  		error = do_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
+				MAP_FIXED | MAP_PRIVATE | MAP_EXECUTABLE,
 				fd_offset + ex.a_text);
 		up_write(&current->mm->mmap_sem);
 		if (error != N_DATADDR(ex)) {
@@ -479,7 +479,7 @@
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
+			MAP_FIXED | MAP_PRIVATE,
 			N_TXTOFF(ex));
 	up_write(&current->mm->mmap_sem);
 	retval = error;
diff -uNrX linux-ignore-files linux-2.4.12/fs/binfmt_elf.c linux-2.4.12.eb2/fs/binfmt_elf.c
--- linux-2.4.12/fs/binfmt_elf.c	Sat Oct 13 16:21:50 2001
+++ linux-2.4.12.eb2/fs/binfmt_elf.c	Sun Oct 14 00:38:37 2001
@@ -288,7 +288,7 @@
 	eppnt = elf_phdata;
 	for (i=0; i<interp_elf_ex->e_phnum; i++, eppnt++) {
 	  if (eppnt->p_type == PT_LOAD) {
-	    int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
+	    int elf_type = MAP_PRIVATE;
 	    int elf_prot = 0;
 	    unsigned long vaddr = 0;
 	    unsigned long k, map_addr;
@@ -642,7 +642,7 @@
 		if (elf_ppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
 		if (elf_ppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
 
-		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
+		elf_flags = MAP_PRIVATE|MAP_EXECUTABLE;
 
 		vaddr = elf_ppnt->p_vaddr;
 		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
@@ -701,7 +701,6 @@
 						    interpreter,
 						    &interp_load_addr);
 
-		allow_write_access(interpreter);
 		fput(interpreter);
 		kfree(elf_interpreter);
 
@@ -789,7 +788,6 @@
 
 	/* error cleanup */
 out_free_dentry:
-	allow_write_access(interpreter);
 	fput(interpreter);
 out_free_interp:
 	if (elf_interpreter)
@@ -853,7 +851,7 @@
 			(elf_phdata->p_filesz +
 			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)),
 			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
+			MAP_FIXED | MAP_PRIVATE,
 			(elf_phdata->p_offset -
 			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)));
 	up_write(&current->mm->mmap_sem);
diff -uNrX linux-ignore-files linux-2.4.12/fs/binfmt_em86.c linux-2.4.12.eb2/fs/binfmt_em86.c
--- linux-2.4.12/fs/binfmt_em86.c	Sat Mar 17 16:28:29 2001
+++ linux-2.4.12.eb2/fs/binfmt_em86.c	Sat Oct 13 20:12:38 2001
@@ -44,7 +44,6 @@
 	}
 
 	bprm->sh_bang++;	/* Well, the bang-shell is implicit... */
-	allow_write_access(bprm->file);
 	fput(bprm->file);
 	bprm->file = NULL;
 
diff -uNrX linux-ignore-files linux-2.4.12/fs/binfmt_misc.c linux-2.4.12.eb2/fs/binfmt_misc.c
--- linux-2.4.12/fs/binfmt_misc.c	Sat Mar 17 16:28:29 2001
+++ linux-2.4.12.eb2/fs/binfmt_misc.c	Sat Oct 13 20:12:46 2001
@@ -201,7 +201,6 @@
 	if (!fmt)
 		goto _ret;
 
-	allow_write_access(bprm->file);
 	fput(bprm->file);
 	bprm->file = NULL;
 
diff -uNrX linux-ignore-files linux-2.4.12/fs/binfmt_script.c linux-2.4.12.eb2/fs/binfmt_script.c
--- linux-2.4.12/fs/binfmt_script.c	Sat Mar 17 16:28:29 2001
+++ linux-2.4.12.eb2/fs/binfmt_script.c	Sat Oct 13 20:12:30 2001
@@ -29,7 +29,6 @@
 	 */
 
 	bprm->sh_bang++;
-	allow_write_access(bprm->file);
 	fput(bprm->file);
 	bprm->file = NULL;
 
diff -uNrX linux-ignore-files linux-2.4.12/fs/exec.c linux-2.4.12.eb2/fs/exec.c
--- linux-2.4.12/fs/exec.c	Sat Oct 13 16:20:02 2001
+++ linux-2.4.12.eb2/fs/exec.c	Sun Oct 14 00:19:53 2001
@@ -337,39 +337,7 @@
 
 struct file *open_exec(const char *name)
 {
-	struct nameidata nd;
-	struct inode *inode;
-	struct file *file;
-	int err = 0;
-
-	if (path_init(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		err = path_walk(name, &nd);
-	file = ERR_PTR(err);
-	if (!err) {
-		inode = nd.dentry->d_inode;
-		file = ERR_PTR(-EACCES);
-		if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
-		    S_ISREG(inode->i_mode)) {
-			int err = permission(inode, MAY_EXEC);
-			if (!err && !(inode->i_mode & 0111))
-				err = -EACCES;
-			file = ERR_PTR(err);
-			if (!err) {
-				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
-				if (!IS_ERR(file)) {
-					err = deny_write_access(file);
-					if (err) {
-						fput(file);
-						file = ERR_PTR(err);
-					}
-				}
-out:
-				return file;
-			}
-		}
-		path_release(&nd);
-	}
-	goto out;
+	return filp_open(name, O_EXEC | O_RDONLY, 0);
 }
 
 int kernel_read(struct file *file, unsigned long offset,
@@ -774,7 +742,6 @@
 		struct file * file;
 		unsigned long loader;
 
-		allow_write_access(bprm->file);
 		fput(bprm->file);
 		bprm->file = NULL;
 
@@ -809,7 +776,6 @@
 			retval = fn(bprm, regs);
 			if (retval >= 0) {
 				put_binfmt(fmt);
-				allow_write_access(bprm->file);
 				if (bprm->file)
 					fput(bprm->file);
 				bprm->file = NULL;
@@ -871,13 +837,11 @@
 	bprm.loader = 0;
 	bprm.exec = 0;
 	if ((bprm.argc = count(argv, bprm.p / sizeof(void *))) < 0) {
-		allow_write_access(file);
 		fput(file);
 		return bprm.argc;
 	}
 
 	if ((bprm.envc = count(envp, bprm.p / sizeof(void *))) < 0) {
-		allow_write_access(file);
 		fput(file);
 		return bprm.envc;
 	}
@@ -906,7 +870,6 @@
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
 	if (bprm.file)
 		fput(bprm.file);
 
diff -uNrX linux-ignore-files linux-2.4.12/fs/file_table.c linux-2.4.12.eb2/fs/file_table.c
--- linux-2.4.12/fs/file_table.c	Sat Oct 13 16:20:02 2001
+++ linux-2.4.12.eb2/fs/file_table.c	Sat Oct 13 20:00:23 2001
@@ -114,6 +114,8 @@
 		fops_put(file->f_op);
 		if (file->f_mode & FMODE_WRITE)
 			put_write_access(inode);
+		if (file->f_mode & FMODE_EXEC)
+			allow_write_access(inode);
 		file_list_lock();
 		file->f_dentry = NULL;
 		file->f_vfsmnt = NULL;
diff -uNrX linux-ignore-files linux-2.4.12/fs/namei.c linux-2.4.12.eb2/fs/namei.c
--- linux-2.4.12/fs/namei.c	Sat Oct 13 16:22:01 2001
+++ linux-2.4.12.eb2/fs/namei.c	Sun Oct 14 00:40:39 2001
@@ -212,10 +212,10 @@
  * put_write_access() releases this write permission.
  * This is used for regular files.
  * We cannot support write (and maybe mmap read-write shared) accesses and
- * MAP_DENYWRITE mmappings simultaneously. The i_writecount field of an inode
- * can have the following values:
- * 0: no writers, no VM_DENYWRITE mappings
- * < 0: (-i_writecount) vm_area_structs with VM_DENYWRITE set exist
+ * O_EXEC mmappings simultaneously. The i_writecount field of an inode can have
+ * the following values: 
+ * 0: no writers, no executers.
+ * < 0: (-i_writecount) users are executing the file.
  * > 0: (i_writecount) users are writing to the file.
  *
  * Normally we operate on that counter with atomic_{inc,dec} and it's safe
@@ -974,6 +974,8 @@
 	int count = 0;
 
 	acc_mode = ACC_MODE(flag);
+	if (flag & O_EXEC)
+		acc_mode |= MAY_EXEC;
 
 	/*
 	 * The simplest case - just a plain lookup.
@@ -1065,10 +1067,22 @@
 	error = -ELOOP;
 	if (S_ISLNK(inode->i_mode))
 		goto exit;
-	
+
 	error = -EISDIR;
 	if (S_ISDIR(inode->i_mode) && (flag & FMODE_WRITE))
 		goto exit;
+
+	error = -EACCES;
+	if (flag & O_EXEC) {
+		if (flag & FMODE_WRITE)
+			goto exit;
+		if (nd.mnt->mnt_flags & MNT_NOEXEC)
+			goto exit;
+		if (!S_ISREG(inode->i_mode))
+			goto exit;
+		if (!(inode->i_mode & S_IXUGO))
+			goto exit;
+	}
 
 	error = permission(inode,acc_mode);
 	if (error)
diff -uNrX linux-ignore-files linux-2.4.12/fs/open.c linux-2.4.12.eb2/fs/open.c
--- linux-2.4.12/fs/open.c	Sat Oct 13 16:21:50 2001
+++ linux-2.4.12.eb2/fs/open.c	Sun Oct 14 00:08:27 2001
@@ -644,6 +644,8 @@
 		goto cleanup_dentry;
 	f->f_flags = flags;
 	f->f_mode = (flags+1) & O_ACCMODE;
+	if (flags & O_EXEC) 
+		f->f_mode |= FMODE_EXEC;
 	inode = dentry->d_inode;
 	if (f->f_mode & FMODE_WRITE) {
 		error = get_write_access(inode);
@@ -673,6 +675,12 @@
 			goto cleanup_all;
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+
+	if (f->f_mode & FMODE_EXEC) {
+		error = deny_write_access(f);
+		if (error)
+			goto cleanup_all;
+	}
 
 	return f;
 
diff -uNrX linux-ignore-files linux-2.4.12/include/asm-i386/fcntl.h linux-2.4.12.eb2/include/asm-i386/fcntl.h
--- linux-2.4.12/include/asm-i386/fcntl.h	Sat Oct 13 16:20:04 2001
+++ linux-2.4.12.eb2/include/asm-i386/fcntl.h	Sun Oct 14 00:08:01 2001
@@ -7,6 +7,7 @@
 #define O_RDONLY	     00
 #define O_WRONLY	     01
 #define O_RDWR		     02
+#define O_EXEC		     04 /* generate ETXTBSY on writes */
 #define O_CREAT		   0100	/* not fcntl */
 #define O_EXCL		   0200	/* not fcntl */
 #define O_NOCTTY	   0400	/* not fcntl */
diff -uNrX linux-ignore-files linux-2.4.12/include/linux/fs.h linux-2.4.12.eb2/include/linux/fs.h
--- linux-2.4.12/include/linux/fs.h	Sat Oct 13 17:26:25 2001
+++ linux-2.4.12.eb2/include/linux/fs.h	Sun Oct 14 00:42:30 2001
@@ -73,6 +73,7 @@
 
 #define FMODE_READ 1
 #define FMODE_WRITE 2
+#define FMODE_EXEC 4
 
 #define READ 0
 #define WRITE 1
diff -uNrX linux-ignore-files linux-2.4.12/kernel/fork.c linux-2.4.12.eb2/kernel/fork.c
--- linux-2.4.12/kernel/fork.c	Sat Oct 13 16:20:09 2001
+++ linux-2.4.12.eb2/kernel/fork.c	Sat Oct 13 20:34:56 2001
@@ -168,8 +168,6 @@
 		if (file) {
 			struct inode *inode = file->f_dentry->d_inode;
 			get_file(file);
-			if (tmp->vm_flags & VM_DENYWRITE)
-				atomic_dec(&inode->i_writecount);
       
 			/* insert tmp into the share list, just after mpnt */
 			spin_lock(&inode->i_mapping->i_shared_lock);
diff -uNrX linux-ignore-files linux-2.4.12/mm/mmap.c linux-2.4.12.eb2/mm/mmap.c
--- linux-2.4.12/mm/mmap.c	Sat Oct 13 16:21:52 2001
+++ linux-2.4.12.eb2/mm/mmap.c	Sun Oct 14 00:50:32 2001
@@ -98,9 +98,6 @@
 	struct file * file = vma->vm_file;
 
 	if (file) {
-		struct inode *inode = file->f_dentry->d_inode;
-		if (vma->vm_flags & VM_DENYWRITE)
-			atomic_inc(&inode->i_writecount);
 		if(vma->vm_next_share)
 			vma->vm_next_share->vm_pprev_share = vma->vm_pprev_share;
 		*vma->vm_pprev_share = vma->vm_next_share;
@@ -205,7 +202,6 @@
 		_trans(prot, PROT_EXEC, VM_EXEC);
 	flag_bits =
 		_trans(flags, MAP_GROWSDOWN, VM_GROWSDOWN) |
-		_trans(flags, MAP_DENYWRITE, VM_DENYWRITE) |
 		_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE);
 	return prot_bits | flag_bits;
 #undef _trans
@@ -310,9 +306,6 @@
 		struct address_space *mapping = inode->i_mapping;
 		struct vm_area_struct **head;
 
-		if (vma->vm_flags & VM_DENYWRITE)
-			atomic_dec(&inode->i_writecount);
-
 		head = &mapping->i_mmap;
 		if (vma->vm_flags & VM_SHARED)
 			head = &mapping->i_mmap_shared;
@@ -395,7 +388,6 @@
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
 	unsigned int vm_flags;
-	int correct_wcount = 0;
 	int error;
 	rb_node_t ** rb_link, * rb_parent;
 
@@ -526,12 +518,6 @@
 		error = -EINVAL;
 		if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 			goto free_vma;
-		if (vm_flags & VM_DENYWRITE) {
-			error = deny_write_access(file);
-			if (error)
-				goto free_vma;
-			correct_wcount = 1;
-		}
 		vma->vm_file = file;
 		get_file(file);
 		error = file->f_op->mmap(file, vma);
@@ -551,8 +537,6 @@
 	addr = vma->vm_start;
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
-	if (correct_wcount)
-		atomic_inc(&file->f_dentry->d_inode->i_writecount);
 
 out:	
 	mm->total_vm += len >> PAGE_SHIFT;
@@ -563,8 +547,6 @@
 	return addr;
 
 unmap_and_free_vma:
-	if (correct_wcount)
-		atomic_inc(&file->f_dentry->d_inode->i_writecount);
 	vma->vm_file = NULL;
 	fput(file);
 
@@ -946,11 +928,9 @@
 	 * so release them, and unmap the page range..
 	 * If the one of the segments is only being partially unmapped,
 	 * it will put new vm_area_struct(s) into the address space.
-	 * In that case we have to be careful with VM_DENYWRITE.
 	 */
 	while ((mpnt = free) != NULL) {
 		unsigned long st, end, size;
-		struct file *file = NULL;
 
 		free = free->vm_next;
 
@@ -959,11 +939,6 @@
 		end = end > mpnt->vm_end ? mpnt->vm_end : end;
 		size = end - st;
 
-		if (mpnt->vm_flags & VM_DENYWRITE &&
-		    (st != mpnt->vm_start || end != mpnt->vm_end) &&
-		    (file = mpnt->vm_file) != NULL) {
-			atomic_dec(&file->f_dentry->d_inode->i_writecount);
-		}
 		remove_shared_vm_struct(mpnt);
 		mm->map_count--;
 
@@ -973,8 +948,6 @@
 		 * Fix the mapping, and free the old area if it wasn't reused.
 		 */
 		extra = unmap_fixup(mm, mpnt, st, size, extra);
-		if (file)
-			atomic_inc(&file->f_dentry->d_inode->i_writecount);
 	}
 	validate_mm(mm);
 

--=-=-=--
