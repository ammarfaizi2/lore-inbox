Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSCHXyf>; Fri, 8 Mar 2002 18:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSCHXy0>; Fri, 8 Mar 2002 18:54:26 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17454 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S291484AbSCHXx4>; Fri, 8 Mar 2002 18:53:56 -0500
Date: Fri, 8 Mar 2002 18:53:50 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [bkpatch] do_mmap cleanup
Message-ID: <20020308185350.E12425@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a vm cleanup that can be pulled from bk://bcrlbits.bk.net/vm-2.5 .
The bulk of the patch is moving the down/up_write on mmap_sem into do_mmap 
and removing that from all the callers.  The patch also includes a fix for 
do_mmap which caused mapping of the last page in the address space to fail.
Also, a new mmap flag called MAP_NODESTROY is added which will cause mmap 
to fail if a mapping is discovered, and is used in shm (I've wanted this 
flag for userspace for sometime too).

Since this touches arch and driver code, maintainers should have a look at 
it.  Cheers,

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."

 arch/alpha/kernel/osf_sys.c         |    2 --
 arch/arm/kernel/sys_arm.c           |    2 --
 arch/cris/kernel/sys_cris.c         |    2 --
 arch/i386/kernel/sys_i386.c         |    2 --
 arch/ia64/ia32/sys_ia32.c           |   32 +++++++++-----------------------
 arch/ia64/kernel/sys_ia64.c         |    2 --
 arch/m68k/kernel/sys_m68k.c         |    4 ----
 arch/mips/kernel/irixelf.c          |   10 ----------
 arch/mips/kernel/syscall.c          |    2 --
 arch/mips/kernel/sysirix.c          |    4 ----
 arch/mips64/kernel/linux32.c        |    2 --
 arch/mips64/kernel/syscall.c        |    2 --
 arch/parisc/kernel/sys_parisc.c     |    2 --
 arch/ppc/kernel/syscalls.c          |    2 --
 arch/ppc64/kernel/syscalls.c        |    2 --
 arch/s390/kernel/sys_s390.c         |    2 --
 arch/s390x/kernel/binfmt_elf32.c    |    2 --
 arch/s390x/kernel/linux32.c         |    4 +---
 arch/s390x/kernel/sys_s390.c        |    2 --
 arch/sh/kernel/sys_sh.c             |    2 --
 arch/sparc/kernel/sys_sparc.c       |    2 --
 arch/sparc/kernel/sys_sunos.c       |    2 --
 arch/sparc64/kernel/binfmt_aout32.c |    6 ------
 arch/sparc64/kernel/sys_sparc.c     |    7 +------
 arch/sparc64/kernel/sys_sunos32.c   |    2 --
 arch/sparc64/solaris/misc.c         |    2 --
 arch/x86_64/ia32/ia32_binfmt.c      |    2 --
 arch/x86_64/ia32/sys_ia32.c         |   16 ++++------------
 arch/x86_64/kernel/sys_x86_64.c     |    2 --
 drivers/char/drm/drm_bufs.h         |   20 --------------------
 drivers/char/drm/i810_dma.c         |   27 +--------------------------
 drivers/sgi/char/graphics.c         |    2 --
 drivers/sgi/char/shmiq.c            |    3 ---
 fs/binfmt_aout.c                    |    6 ------
 fs/binfmt_elf.c                     |    6 ------
 include/linux/mm.h                  |   15 +++------------
 include/linux/mman.h                |    2 ++
 ipc/shm.c                           |   10 ++++------
 kernel/ksyms.c                      |    2 ++
 mm/mmap.c                           |   33 +++++++++++++++++++++++++++++++--
 40 files changed, 58 insertions(+), 193 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.384   -> 1.387  
#	arch/alpha/kernel/osf_sys.c	1.11    -> 1.12   
#	drivers/sgi/char/graphics.c	1.8     -> 1.9    
#	arch/sparc64/kernel/sys_sparc.c	1.10    -> 1.11   
#	      kernel/ksyms.c	1.67    -> 1.68   
#	arch/cris/kernel/sys_cris.c	1.7     -> 1.8    
#	arch/x86_64/ia32/ia32_binfmt.c	1.2     -> 1.3    
#	  include/linux/mm.h	1.40    -> 1.42   
#	arch/sparc64/kernel/sys_sunos32.c	1.14    -> 1.15   
#	arch/ia64/ia32/sys_ia32.c	1.9     -> 1.10   
#	           mm/mmap.c	1.22    -> 1.23   
#	arch/mips64/kernel/linux32.c	1.7     -> 1.8    
#	include/linux/mman.h	1.1     -> 1.2    
#	arch/ppc64/kernel/syscalls.c	1.1     -> 1.2    
#	arch/m68k/kernel/sys_m68k.c	1.3     -> 1.4    
#	arch/s390x/kernel/linux32.c	1.11    -> 1.12   
#	    fs/binfmt_aout.c	1.9     -> 1.10   
#	arch/arm/kernel/sys_arm.c	1.5     -> 1.6    
#	drivers/sgi/char/shmiq.c	1.6     -> 1.7    
#	drivers/char/drm/drm_bufs.h	1.4     -> 1.5    
#	arch/mips/kernel/syscall.c	1.3     -> 1.4    
#	arch/s390x/kernel/sys_s390.c	1.3     -> 1.4    
#	drivers/char/drm/i810_dma.c	1.8     -> 1.9    
#	arch/sparc/kernel/sys_sparc.c	1.5     -> 1.6    
#	arch/s390/kernel/sys_s390.c	1.3     -> 1.4    
#	arch/sparc64/solaris/misc.c	1.7     -> 1.8    
#	arch/ppc/kernel/syscalls.c	1.5     -> 1.6    
#	arch/sparc/kernel/sys_sunos.c	1.14    -> 1.15   
#	arch/x86_64/ia32/sys_ia32.c	1.1     -> 1.2    
#	arch/i386/kernel/sys_i386.c	1.2     -> 1.3    
#	     fs/binfmt_elf.c	1.18    -> 1.19   
#	arch/s390x/kernel/binfmt_elf32.c	1.3     -> 1.4    
#	arch/sparc64/kernel/binfmt_aout32.c	1.6     -> 1.7    
#	           ipc/shm.c	1.9     -> 1.10   
#	arch/sh/kernel/sys_sh.c	1.4     -> 1.5    
#	arch/mips/kernel/irixelf.c	1.3     -> 1.4    
#	arch/ia64/kernel/sys_ia64.c	1.7     -> 1.8    
#	arch/x86_64/kernel/sys_x86_64.c	1.1     -> 1.2    
#	arch/mips64/kernel/syscall.c	1.3     -> 1.4    
#	arch/parisc/kernel/sys_parisc.c	1.2     -> 1.3    
#	arch/mips/kernel/sysirix.c	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/08	bcrl@toomuch.toronto.redhat.com	1.385
# fix do_mmap to allow mapping the last page of addressable space.
# --------------------------------------------
# 02/03/08	bcrl@toomuch.toronto.redhat.com	1.386
# VM cleanup: move mmap_sem acquisition into do_mmap/do_mmap_pgoff.
# Add MAP_NODESTROY flag for mmap to return an error if a mapping 
# already existed instead of unmapping it.
# --------------------------------------------
# 02/03/08	bcrl@toomuch.toronto.redhat.com	1.387
# Missing bits from previous commit: remove mmap_sem around do_munmap.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
--- a/arch/alpha/kernel/osf_sys.c	Fri Mar  8 18:46:34 2002
+++ b/arch/alpha/kernel/osf_sys.c	Fri Mar  8 18:46:34 2002
@@ -241,9 +241,7 @@
 			goto out;
 	}
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	down_write(&current->mm->mmap_sem);
 	ret = do_mmap(file, addr, len, prot, flags, off);
-	up_write(&current->mm->mmap_sem);
 	if (file)
 		fput(file);
 out:
diff -Nru a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
--- a/arch/arm/kernel/sys_arm.c	Fri Mar  8 18:46:34 2002
+++ b/arch/arm/kernel/sys_arm.c	Fri Mar  8 18:46:34 2002
@@ -74,9 +74,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/cris/kernel/sys_cris.c b/arch/cris/kernel/sys_cris.c
--- a/arch/cris/kernel/sys_cris.c	Fri Mar  8 18:46:34 2002
+++ b/arch/cris/kernel/sys_cris.c	Fri Mar  8 18:46:34 2002
@@ -59,9 +59,7 @@
                         goto out;
         }
 
-        down_write(&current->mm->mmap_sem);
         error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-        up_write(&current->mm->mmap_sem);
 
         if (file)
                 fput(file);
diff -Nru a/arch/i386/kernel/sys_i386.c b/arch/i386/kernel/sys_i386.c
--- a/arch/i386/kernel/sys_i386.c	Fri Mar  8 18:46:34 2002
+++ b/arch/i386/kernel/sys_i386.c	Fri Mar  8 18:46:34 2002
@@ -55,9 +55,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c	Fri Mar  8 18:46:34 2002
+++ b/arch/ia64/ia32/sys_ia32.c	Fri Mar  8 18:46:34 2002
@@ -276,12 +276,8 @@
 	if (old_prot)
 		copy_from_user(page, (void *) PAGE_START(start), PAGE_SIZE);
 
-	down_write(&current->mm->mmap_sem);
-	{
-		ret = do_mmap(0, PAGE_START(start), PAGE_SIZE, prot | PROT_WRITE,
-			      flags | MAP_FIXED | MAP_ANONYMOUS, 0);
-	}
-	up_write(&current->mm->mmap_sem);
+	ret = do_mmap(0, PAGE_START(start), PAGE_SIZE, prot | PROT_WRITE,
+		      flags | MAP_FIXED | MAP_ANONYMOUS, 0);
 
 	if (IS_ERR((void *) ret))
 		goto out;
@@ -376,16 +372,12 @@
 	DBG("mmap_body: mapping [0x%lx-0x%lx) %s with poff 0x%llx\n", pstart, pend,
 	    is_congruent ? "congruent" : "not congruent", poff);
 
-	down_write(&current->mm->mmap_sem);
-	{
-		if (!(flags & MAP_ANONYMOUS) && is_congruent)
-			ret = do_mmap(file, pstart, pend - pstart, prot, flags | MAP_FIXED, poff);
-		else
-			ret = do_mmap(0, pstart, pend - pstart,
-				      prot | ((flags & MAP_ANONYMOUS) ? 0 : PROT_WRITE),
-				      flags | MAP_FIXED | MAP_ANONYMOUS, 0);
-	}
-	up_write(&current->mm->mmap_sem);
+	if (!(flags & MAP_ANONYMOUS) && is_congruent)
+		ret = do_mmap(file, pstart, pend - pstart, prot, flags | MAP_FIXED, poff);
+	else
+		ret = do_mmap(0, pstart, pend - pstart,
+			      prot | ((flags & MAP_ANONYMOUS) ? 0 : PROT_WRITE),
+			      flags | MAP_FIXED | MAP_ANONYMOUS, 0);
 
 	if (IS_ERR((void *) ret))
 		return ret;
@@ -449,11 +441,7 @@
 	}
 	up(&ia32_mmap_sem);
 #else
-	down_write(&current->mm->mmap_sem);
-	{
-		addr = do_mmap(file, addr, len, prot, flags, offset);
-	}
-	up_write(&current->mm->mmap_sem);
+	addr = do_mmap(file, addr, len, prot, flags, offset);
 #endif
 	DBG("ia32_do_mmap: returning 0x%lx\n", addr);
 	return addr;
@@ -3197,11 +3185,9 @@
 		return(-EFAULT);
 	}
 
-	down_write(&current->mm->mmap_sem);
 	addr = do_mmap_pgoff(file, IA32_IOBASE,
 			     IOLEN, PROT_READ|PROT_WRITE, MAP_SHARED,
 			     (ia64_iobase & ~PAGE_OFFSET) >> PAGE_SHIFT);
-	up_write(&current->mm->mmap_sem);
 
 	if (addr >= 0) {
 		old = (old & ~0x3000) | (level << 12);
diff -Nru a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
--- a/arch/ia64/kernel/sys_ia64.c	Fri Mar  8 18:46:34 2002
+++ b/arch/ia64/kernel/sys_ia64.c	Fri Mar  8 18:46:34 2002
@@ -214,9 +214,7 @@
 		goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	addr = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 out:	if (file)
 		fput(file);
diff -Nru a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
--- a/arch/m68k/kernel/sys_m68k.c	Fri Mar  8 18:46:34 2002
+++ b/arch/m68k/kernel/sys_m68k.c	Fri Mar  8 18:46:34 2002
@@ -59,9 +59,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
@@ -146,9 +144,7 @@
 	}
 	a.flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 	if (file)
 		fput(file);
 out:
diff -Nru a/arch/mips/kernel/irixelf.c b/arch/mips/kernel/irixelf.c
--- a/arch/mips/kernel/irixelf.c	Fri Mar  8 18:46:34 2002
+++ b/arch/mips/kernel/irixelf.c	Fri Mar  8 18:46:34 2002
@@ -314,12 +314,10 @@
 		   (unsigned long) elf_prot, (unsigned long) elf_type,
 		   (unsigned long) (eppnt->p_offset & 0xfffff000));
 #endif
-	    down_write(&current->mm->mmap_sem);
 	    error = do_mmap(interpreter, vaddr,
 			    eppnt->p_filesz + (eppnt->p_vaddr & 0xfff),
 			    elf_prot, elf_type,
 			    eppnt->p_offset & 0xfffff000);
-	    up_write(&current->mm->mmap_sem);
 
 	    if(error < 0 && error > -1024) {
 		    printk("Aieee IRIX interp mmap error=%d\n", error);
@@ -498,12 +496,10 @@
 		prot  = (epp->p_flags & PF_R) ? PROT_READ : 0;
 		prot |= (epp->p_flags & PF_W) ? PROT_WRITE : 0;
 		prot |= (epp->p_flags & PF_X) ? PROT_EXEC : 0;
-	        down_write(&current->mm->mmap_sem);
 		(void) do_mmap(fp, (epp->p_vaddr & 0xfffff000),
 			       (epp->p_filesz + (epp->p_vaddr & 0xfff)),
 			       prot, EXEC_MAP_FLAGS,
 			       (epp->p_offset & 0xfffff000));
-	        up_write(&current->mm->mmap_sem);
 
 		/* Fixup location tracking vars. */
 		if((epp->p_vaddr & 0xfffff000) < *estack)
@@ -762,10 +758,8 @@
 	 * Since we do not have the power to recompile these, we
 	 * emulate the SVr4 behavior.  Sigh.
 	 */
-	down_write(&current->mm->mmap_sem);
 	(void) do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC,
 		       MAP_FIXED | MAP_PRIVATE, 0);
-	up_write(&current->mm->mmap_sem);
 #endif
 
 	start_thread(regs, elf_entry, bprm->p);
@@ -837,14 +831,12 @@
 	while(elf_phdata->p_type != PT_LOAD) elf_phdata++;
 	
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file,
 			elf_phdata->p_vaddr & 0xfffff000,
 			elf_phdata->p_filesz + (elf_phdata->p_vaddr & 0xfff),
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			elf_phdata->p_offset & 0xfffff000);
-	up_write(&current->mm->mmap_sem);
 
 	k = elf_phdata->p_vaddr + elf_phdata->p_filesz;
 	if (k > elf_bss) elf_bss = k;
@@ -916,12 +908,10 @@
 		prot  = (hp->p_flags & PF_R) ? PROT_READ : 0;
 		prot |= (hp->p_flags & PF_W) ? PROT_WRITE : 0;
 		prot |= (hp->p_flags & PF_X) ? PROT_EXEC : 0;
-		down_write(&current->mm->mmap_sem);
 		retval = do_mmap(filp, (hp->p_vaddr & 0xfffff000),
 				 (hp->p_filesz + (hp->p_vaddr & 0xfff)),
 				 prot, (MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE),
 				 (hp->p_offset & 0xfffff000));
-		up_write(&current->mm->mmap_sem);
 
 		if(retval != (hp->p_vaddr & 0xfffff000)) {
 			printk("irix_mapelf: do_mmap fails with %d!\n", retval);
diff -Nru a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
--- a/arch/mips/kernel/syscall.c	Fri Mar  8 18:46:34 2002
+++ b/arch/mips/kernel/syscall.c	Fri Mar  8 18:46:34 2002
@@ -69,9 +69,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/mips/kernel/sysirix.c b/arch/mips/kernel/sysirix.c
--- a/arch/mips/kernel/sysirix.c	Fri Mar  8 18:46:34 2002
+++ b/arch/mips/kernel/sysirix.c	Fri Mar  8 18:46:34 2002
@@ -1082,9 +1082,7 @@
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file, addr, len, prot, flags, offset);
-	up_write(&current->mm->mmap_sem);
 	if (file)
 		fput(file);
 
@@ -1581,9 +1579,7 @@
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/mips64/kernel/linux32.c b/arch/mips64/kernel/linux32.c
--- a/arch/mips64/kernel/linux32.c	Fri Mar  8 18:46:34 2002
+++ b/arch/mips64/kernel/linux32.c	Fri Mar  8 18:46:34 2002
@@ -377,10 +377,8 @@
 	 *  `execve' frees all current memory we only have to do an
 	 *  `munmap' if the `execve' failes.
 	 */
-	down_write(&current->mm->mmap_sem);
 	av = (char **) do_mmap_pgoff(0, 0, len, PROT_READ | PROT_WRITE,
 				     MAP_PRIVATE | MAP_ANONYMOUS, 0);
-	up_write(&current->mm->mmap_sem);
 
 	if (IS_ERR(av))
 		return (long) av;
diff -Nru a/arch/mips64/kernel/syscall.c b/arch/mips64/kernel/syscall.c
--- a/arch/mips64/kernel/syscall.c	Fri Mar  8 18:46:34 2002
+++ b/arch/mips64/kernel/syscall.c	Fri Mar  8 18:46:34 2002
@@ -65,9 +65,7 @@
 	}
         flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
         error = do_mmap(file, addr, len, prot, flags, offset);
-	up_write(&current->mm->mmap_sem);
         if (file)
                 fput(file);
 out:
diff -Nru a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
--- a/arch/parisc/kernel/sys_parisc.c	Fri Mar  8 18:46:34 2002
+++ b/arch/parisc/kernel/sys_parisc.c	Fri Mar  8 18:46:34 2002
@@ -51,7 +51,6 @@
 	struct file * file = NULL;
 	int error;
 
-	down_write(&current->mm->mmap_sem);
 	lock_kernel();
 	if (!(flags & MAP_ANONYMOUS)) {
 		error = -EBADF;
@@ -65,7 +64,6 @@
 		fput(file);
 out:
 	unlock_kernel();
-	up_write(&current->mm->mmap_sem);
 	return error;
 }
 
diff -Nru a/arch/ppc/kernel/syscalls.c b/arch/ppc/kernel/syscalls.c
--- a/arch/ppc/kernel/syscalls.c	Fri Mar  8 18:46:34 2002
+++ b/arch/ppc/kernel/syscalls.c	Fri Mar  8 18:46:34 2002
@@ -202,9 +202,7 @@
 			goto out;
 	}
 	
-	down_write(&current->mm->mmap_sem);
 	ret = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 	if (file)
 		fput(file);
 out:
diff -Nru a/arch/ppc64/kernel/syscalls.c b/arch/ppc64/kernel/syscalls.c
--- a/arch/ppc64/kernel/syscalls.c	Fri Mar  8 18:46:34 2002
+++ b/arch/ppc64/kernel/syscalls.c	Fri Mar  8 18:46:34 2002
@@ -214,9 +214,7 @@
 	}
 	
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	down_write(&current->mm->mmap_sem);
 	ret = do_mmap(file, addr, len, prot, flags, offset);
-	up_write(&current->mm->mmap_sem);
 	if (file)
 		fput(file);
 
diff -Nru a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
--- a/arch/s390/kernel/sys_s390.c	Fri Mar  8 18:46:34 2002
+++ b/arch/s390/kernel/sys_s390.c	Fri Mar  8 18:46:34 2002
@@ -61,9 +61,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/s390x/kernel/binfmt_elf32.c b/arch/s390x/kernel/binfmt_elf32.c
--- a/arch/s390x/kernel/binfmt_elf32.c	Fri Mar  8 18:46:34 2002
+++ b/arch/s390x/kernel/binfmt_elf32.c	Fri Mar  8 18:46:34 2002
@@ -194,11 +194,9 @@
 	if(!addr)
 		addr = 0x40000000;
 
-	down_write(&current->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&current->mm->mmap_sem);
 	return(map_addr);
 }
 
diff -Nru a/arch/s390x/kernel/linux32.c b/arch/s390x/kernel/linux32.c
--- a/arch/s390x/kernel/linux32.c	Fri Mar  8 18:46:34 2002
+++ b/arch/s390x/kernel/linux32.c	Fri Mar  8 18:46:34 2002
@@ -4108,14 +4108,12 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	if (!IS_ERR((void *) error) && error + len >= 0x80000000ULL) {
 		/* Result is out of bounds.  */
-		do_munmap(current->mm, addr, len);
+		sys_munmap(addr, len);
 		error = -ENOMEM;
 	}
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/s390x/kernel/sys_s390.c b/arch/s390x/kernel/sys_s390.c
--- a/arch/s390x/kernel/sys_s390.c	Fri Mar  8 18:46:34 2002
+++ b/arch/s390x/kernel/sys_s390.c	Fri Mar  8 18:46:34 2002
@@ -61,9 +61,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
--- a/arch/sh/kernel/sys_sh.c	Fri Mar  8 18:46:34 2002
+++ b/arch/sh/kernel/sys_sh.c	Fri Mar  8 18:46:34 2002
@@ -100,9 +100,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/sparc/kernel/sys_sparc.c b/arch/sparc/kernel/sys_sparc.c
--- a/arch/sparc/kernel/sys_sparc.c	Fri Mar  8 18:46:34 2002
+++ b/arch/sparc/kernel/sys_sparc.c	Fri Mar  8 18:46:34 2002
@@ -242,9 +242,7 @@
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	down_write(&current->mm->mmap_sem);
 	retval = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 out_putf:
 	if (file)
diff -Nru a/arch/sparc/kernel/sys_sunos.c b/arch/sparc/kernel/sys_sunos.c
--- a/arch/sparc/kernel/sys_sunos.c	Fri Mar  8 18:46:34 2002
+++ b/arch/sparc/kernel/sys_sunos.c	Fri Mar  8 18:46:34 2002
@@ -116,9 +116,7 @@
 	}
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file, addr, len, prot, flags, off);
-	up_write(&current->mm->mmap_sem);
 	if(!ret_type)
 		retval = ((retval < PAGE_OFFSET) ? 0 : retval);
 
diff -Nru a/arch/sparc64/kernel/binfmt_aout32.c b/arch/sparc64/kernel/binfmt_aout32.c
--- a/arch/sparc64/kernel/binfmt_aout32.c	Fri Mar  8 18:46:34 2002
+++ b/arch/sparc64/kernel/binfmt_aout32.c	Fri Mar  8 18:46:34 2002
@@ -277,24 +277,20 @@
 			goto beyond_if;
 		}
 
-	        down_write(&current->mm->mmap_sem);
 		error = do_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 			fd_offset);
-	        up_write(&current->mm->mmap_sem);
 
 		if (error != N_TXTADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
 		}
 
-	        down_write(&current->mm->mmap_sem);
  		error = do_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 				fd_offset + ex.a_text);
-	        up_write(&current->mm->mmap_sem);
 		if (error != N_DATADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -369,12 +365,10 @@
 	start_addr =  ex.a_entry & 0xfffff000;
 
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			N_TXTOFF(ex));
-	up_write(&current->mm->mmap_sem);
 	retval = error;
 	if (error != start_addr)
 		goto out;
diff -Nru a/arch/sparc64/kernel/sys_sparc.c b/arch/sparc64/kernel/sys_sparc.c
--- a/arch/sparc64/kernel/sys_sparc.c	Fri Mar  8 18:46:34 2002
+++ b/arch/sparc64/kernel/sys_sparc.c	Fri Mar  8 18:46:34 2002
@@ -300,9 +300,7 @@
 			goto out_putf;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file, addr, len, prot, flags, off);
-	up_write(&current->mm->mmap_sem);
 
 out_putf:
 	if (file)
@@ -318,10 +316,7 @@
 	if (len > -PAGE_OFFSET ||
 	    (addr < PAGE_OFFSET && addr + len > -PAGE_OFFSET))
 		return -EINVAL;
-	down_write(&current->mm->mmap_sem);
-	ret = do_munmap(current->mm, addr, len);
-	up_write(&current->mm->mmap_sem);
-	return ret;
+	return sys_munmap(addr, len);
 }
 
 extern unsigned long do_mremap(unsigned long addr,
diff -Nru a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
--- a/arch/sparc64/kernel/sys_sunos32.c	Fri Mar  8 18:46:34 2002
+++ b/arch/sparc64/kernel/sys_sunos32.c	Fri Mar  8 18:46:34 2002
@@ -100,12 +100,10 @@
 	flags &= ~_MAP_NEW;
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-	down_write(&current->mm->mmap_sem);
 	retval = do_mmap(file,
 			 (unsigned long) addr, (unsigned long) len,
 			 (unsigned long) prot, (unsigned long) flags,
 			 (unsigned long) off);
-	up_write(&current->mm->mmap_sem);
 	if (!ret_type)
 		retval = ((retval < 0xf0000000) ? 0 : retval);
 out_putf:
diff -Nru a/arch/sparc64/solaris/misc.c b/arch/sparc64/solaris/misc.c
--- a/arch/sparc64/solaris/misc.c	Fri Mar  8 18:46:34 2002
+++ b/arch/sparc64/solaris/misc.c	Fri Mar  8 18:46:34 2002
@@ -93,12 +93,10 @@
 	ret_type = flags & _MAP_NEW;
 	flags &= ~_MAP_NEW;
 
-	down_write(&current->mm->mmap_sem);
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 	retval = do_mmap(file,
 			 (unsigned long) addr, (unsigned long) len,
 			 (unsigned long) prot, (unsigned long) flags, off);
-	up_write(&current->mm->mmap_sem);
 	if(!ret_type)
 		retval = ((retval < 0xf0000000) ? 0 : retval);
 	                        
diff -Nru a/arch/x86_64/ia32/ia32_binfmt.c b/arch/x86_64/ia32/ia32_binfmt.c
--- a/arch/x86_64/ia32/ia32_binfmt.c	Fri Mar  8 18:46:34 2002
+++ b/arch/x86_64/ia32/ia32_binfmt.c	Fri Mar  8 18:46:34 2002
@@ -177,11 +177,9 @@
 	unsigned long map_addr;
 	struct task_struct *me = current; 
 
-	down_write(&me->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type|MAP_32BIT,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&me->mm->mmap_sem);
 	return(map_addr);
 }
 
diff -Nru a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
--- a/arch/x86_64/ia32/sys_ia32.c	Fri Mar  8 18:46:34 2002
+++ b/arch/x86_64/ia32/sys_ia32.c	Fri Mar  8 18:46:34 2002
@@ -233,7 +233,6 @@
 	struct mmap_arg_struct a;
 	struct file *file = NULL;
 	unsigned long retval;
-	struct mm_struct *mm ;
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
@@ -247,19 +246,14 @@
 			return -EBADF;
 	}
 
-	mm = current->mm; 
-	down_write(&mm->mmap_sem); 
 	retval = do_mmap_pgoff(file, a.addr, a.len, a.prot, a.flags, a.offset>>PAGE_SHIFT);
 	if (file)
 		fput(file);
 
-	if (retval >= 0xFFFFFFFF) { 
-		do_munmap(mm, retval, a.len); 
-		retval = -ENOMEM; 
-	} 
-	up_write(&mm->mmap_sem); 
-
-
+	if (retval >= 0xFFFFFFFF) {
+		sys_munmap(retval, a.len);
+		retval = -ENOMEM;
+	}
 
 	return retval;
 }
@@ -2589,9 +2583,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/arch/x86_64/kernel/sys_x86_64.c b/arch/x86_64/kernel/sys_x86_64.c
--- a/arch/x86_64/kernel/sys_x86_64.c	Fri Mar  8 18:46:34 2002
+++ b/arch/x86_64/kernel/sys_x86_64.c	Fri Mar  8 18:46:34 2002
@@ -54,9 +54,7 @@
 			goto out;
 	}
 
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, off >> PAGE_SHIFT);
-	up_write(&current->mm->mmap_sem);
 
 	if (file)
 		fput(file);
diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Fri Mar  8 18:46:34 2002
+++ b/drivers/char/drm/drm_bufs.h	Fri Mar  8 18:46:34 2002
@@ -1063,34 +1063,14 @@
 				goto done;
 			}
 
-#if LINUX_VERSION_CODE <= 0x020402
-			down( &current->mm->mmap_sem );
-#else
-			down_write( &current->mm->mmap_sem );
-#endif
 			virtual = do_mmap( filp, 0, map->size,
 					   PROT_READ | PROT_WRITE,
 					   MAP_SHARED,
 					   (unsigned long)map->offset );
-#if LINUX_VERSION_CODE <= 0x020402
-			up( &current->mm->mmap_sem );
-#else
-			up_write( &current->mm->mmap_sem );
-#endif
 		} else {
-#if LINUX_VERSION_CODE <= 0x020402
-			down( &current->mm->mmap_sem );
-#else
-			down_write( &current->mm->mmap_sem );
-#endif
 			virtual = do_mmap( filp, 0, dma->byte_count,
 					   PROT_READ | PROT_WRITE,
 					   MAP_SHARED, 0 );
-#if LINUX_VERSION_CODE <= 0x020402
-			up( &current->mm->mmap_sem );
-#else
-			up_write( &current->mm->mmap_sem );
-#endif
 		}
 		if ( virtual > -1024UL ) {
 			/* Real error */
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Fri Mar  8 18:46:34 2002
+++ b/drivers/char/drm/i810_dma.c	Fri Mar  8 18:46:34 2002
@@ -182,11 +182,6 @@
 	if(buf_priv->currently_mapped == I810_BUF_MAPPED) return -EINVAL;
 
 	if(VM_DONTCOPY != 0) {
-#if LINUX_VERSION_CODE <= 0x020402
-		down( &current->mm->mmap_sem );
-#else
-		down_write( &current->mm->mmap_sem );
-#endif
 		old_fops = filp->f_op;
 		filp->f_op = &i810_buffer_fops;
 		dev_priv->mmap_buffer = buf;
@@ -202,11 +197,6 @@
 			retcode = (signed int)buf_priv->virtual;
 			buf_priv->virtual = 0;
 		}
-#if LINUX_VERSION_CODE <= 0x020402
-		up( &current->mm->mmap_sem );
-#else
-		up_write( &current->mm->mmap_sem );
-#endif
 	} else {
 		buf_priv->virtual = buf_priv->kernel_virtual;
    		buf_priv->currently_mapped = I810_BUF_MAPPED;
@@ -222,24 +212,9 @@
 	if(VM_DONTCOPY != 0) {
 		if(buf_priv->currently_mapped != I810_BUF_MAPPED)
 			return -EINVAL;
-#if LINUX_VERSION_CODE <= 0x020402
-		down( &current->mm->mmap_sem );
-#else
-		down_write( &current->mm->mmap_sem );
-#endif
-#if LINUX_VERSION_CODE < 0x020399
-        	retcode = do_munmap((unsigned long)buf_priv->virtual,
-				    (size_t) buf->total);
-#else
-        	retcode = do_munmap(current->mm,
+        	retcode = sys_munmap(current->mm,
 				    (unsigned long)buf_priv->virtual,
 				    (size_t) buf->total);
-#endif
-#if LINUX_VERSION_CODE <= 0x020402
-		up( &current->mm->mmap_sem );
-#else
-		up_write( &current->mm->mmap_sem );
-#endif
 	}
    	buf_priv->currently_mapped = I810_BUF_UNMAPPED;
    	buf_priv->virtual = 0;
diff -Nru a/drivers/sgi/char/graphics.c b/drivers/sgi/char/graphics.c
--- a/drivers/sgi/char/graphics.c	Fri Mar  8 18:46:34 2002
+++ b/drivers/sgi/char/graphics.c	Fri Mar  8 18:46:34 2002
@@ -152,11 +152,9 @@
 		 * sgi_graphics_mmap
 		 */
 		disable_gconsole ();
-		down_write(&current->mm->mmap_sem);
 		r = do_mmap (file, (unsigned long)vaddr,
 			     cards[board].g_regs_size, PROT_READ|PROT_WRITE,
 			     MAP_FIXED|MAP_PRIVATE, 0);
-		up_write(&current->mm->mmap_sem);
 		if (r)
 			return r;
 	}
diff -Nru a/drivers/sgi/char/shmiq.c b/drivers/sgi/char/shmiq.c
--- a/drivers/sgi/char/shmiq.c	Fri Mar  8 18:46:34 2002
+++ b/drivers/sgi/char/shmiq.c	Fri Mar  8 18:46:34 2002
@@ -287,11 +287,8 @@
 			s = req.arg * sizeof (struct shmqevent) +
 			    sizeof (struct sharedMemoryInputQueue);
 			v = sys_munmap (vaddr, s);
-			down_write(&current->mm->mmap_sem);
-			do_munmap(current->mm, vaddr, s);
 			do_mmap(filp, vaddr, s, PROT_READ | PROT_WRITE,
 			        MAP_PRIVATE|MAP_FIXED, 0);
-			up_write(&current->mm->mmap_sem);
 			shmiqs[minor].events = req.arg;
 			shmiqs[minor].mapped = 1;
 
diff -Nru a/fs/binfmt_aout.c b/fs/binfmt_aout.c
--- a/fs/binfmt_aout.c	Fri Mar  8 18:46:34 2002
+++ b/fs/binfmt_aout.c	Fri Mar  8 18:46:34 2002
@@ -379,24 +379,20 @@
 			goto beyond_if;
 		}
 
-		down_write(&current->mm->mmap_sem);
 		error = do_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 			fd_offset);
-		up_write(&current->mm->mmap_sem);
 
 		if (error != N_TXTADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
 		}
 
-		down_write(&current->mm->mmap_sem);
  		error = do_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
 				fd_offset + ex.a_text);
-		up_write(&current->mm->mmap_sem);
 		if (error != N_DATADDR(ex)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -478,12 +474,10 @@
 		goto out;
 	}
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file, start_addr, ex.a_text + ex.a_data,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			N_TXTOFF(ex));
-	up_write(&current->mm->mmap_sem);
 	retval = error;
 	if (error != start_addr)
 		goto out;
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	Fri Mar  8 18:46:34 2002
+++ b/fs/binfmt_elf.c	Fri Mar  8 18:46:34 2002
@@ -228,11 +228,9 @@
 {
 	unsigned long map_addr;
 
-	down_write(&current->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
 			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
 			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
-	up_write(&current->mm->mmap_sem);
 	return(map_addr);
 }
 
@@ -741,10 +739,8 @@
 		   Since we do not have the power to recompile these, we
 		   emulate the SVr4 behavior.  Sigh.  */
 		/* N.B. Shouldn't the size here be PAGE_SIZE?? */
-		down_write(&current->mm->mmap_sem);
 		error = do_mmap(NULL, 0, 4096, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
-		up_write(&current->mm->mmap_sem);
 	}
 
 #ifdef ELF_PLAT_INIT
@@ -824,7 +820,6 @@
 	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
 
 	/* Now use mmap to map the library into memory. */
-	down_write(&current->mm->mmap_sem);
 	error = do_mmap(file,
 			ELF_PAGESTART(elf_phdata->p_vaddr),
 			(elf_phdata->p_filesz +
@@ -833,7 +828,6 @@
 			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
 			(elf_phdata->p_offset -
 			 ELF_PAGEOFFSET(elf_phdata->p_vaddr)));
-	up_write(&current->mm->mmap_sem);
 	if (error != ELF_PAGESTART(elf_phdata->p_vaddr))
 		goto out_free_ph;
 
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Fri Mar  8 18:46:34 2002
+++ b/include/linux/mm.h	Fri Mar  8 18:46:34 2002
@@ -492,20 +492,11 @@
 	unsigned long len, unsigned long prot,
 	unsigned long flag, unsigned long pgoff);
 
-static inline unsigned long do_mmap(struct file *file, unsigned long addr,
+extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long offset)
-{
-	unsigned long ret = -EINVAL;
-	if ((offset + PAGE_ALIGN(len)) < offset)
-		goto out;
-	if (!(offset & ~PAGE_MASK))
-		ret = do_mmap_pgoff(file, addr, len, prot, flag, offset >> PAGE_SHIFT);
-out:
-	return ret;
-}
-
+	unsigned long flag, unsigned long offset);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
+extern long sys_munmap(unsigned long, size_t);
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
diff -Nru a/include/linux/mman.h b/include/linux/mman.h
--- a/include/linux/mman.h	Fri Mar  8 18:46:34 2002
+++ b/include/linux/mman.h	Fri Mar  8 18:46:34 2002
@@ -6,4 +6,6 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
 
+#define MAP_NODESTROY	0x8000000UL	/* Don't destroy old mappings. */
+
 #endif /* _LINUX_MMAN_H */
diff -Nru a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	Fri Mar  8 18:46:34 2002
+++ b/ipc/shm.c	Fri Mar  8 18:46:34 2002
@@ -628,11 +628,8 @@
 	shp->shm_nattch++;
 	shm_unlock(shmid);
 
-	down_write(&current->mm->mmap_sem);
 	if (addr && !(shmflg & SHM_REMAP)) {
 		user_addr = ERR_PTR(-EINVAL);
-		if (find_vma_intersection(current->mm, addr, addr + size))
-			goto invalid;
 		/*
 		 * If shm segment goes below stack, make sure there is some
 		 * space left for the stack to grow (at least 4 pages).
@@ -642,10 +639,10 @@
 			goto invalid;
 	}
 		
-	user_addr = (void*) do_mmap (file, addr, size, prot, flags, 0);
+	user_addr = (void*) do_mmap (file, addr, size, prot,
+				     flags | MAP_NODESTROY, 0);
 
 invalid:
-	up_write(&current->mm->mmap_sem);
 
 	down (&shm_ids.sem);
 	if(!(shp = shm_lock(shmid)))
@@ -679,7 +676,8 @@
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr)
-			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
+			do_munmap(mm, shmd->vm_start,
+				    shmd->vm_end - shmd->vm_start);
 	}
 	up_write(&mm->mmap_sem);
 	return 0;
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri Mar  8 18:46:34 2002
+++ b/kernel/ksyms.c	Fri Mar  8 18:46:34 2002
@@ -82,8 +82,10 @@
 EXPORT_SYMBOL(try_inc_mod_count);
 
 /* process memory management */
+EXPORT_SYMBOL(do_mmap);
 EXPORT_SYMBOL(do_mmap_pgoff);
 EXPORT_SYMBOL(do_munmap);
+EXPORT_SYMBOL(sys_munmap);
 EXPORT_SYMBOL(do_brk);
 EXPORT_SYMBOL(exit_mm);
 
diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	Fri Mar  8 18:46:34 2002
+++ b/mm/mmap.c	Fri Mar  8 18:46:34 2002
@@ -381,8 +381,24 @@
 	return 0;
 }
 
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags, unsigned long pgoff)
+extern unsigned long do_mmap(struct file *file, unsigned long addr,
+	unsigned long len, unsigned long prot,
+	unsigned long flag, unsigned long offset)
+{
+	unsigned long ret = -EINVAL;
+	if (unlikely((offset + PAGE_ALIGN(len) - 1) < offset))
+		goto out;
+	if (!(offset & ~PAGE_MASK))
+		ret = do_mmap_pgoff(file, addr, len, prot, flag,
+				    offset >> PAGE_SHIFT);
+out:
+	return ret;
+}
+
+
+static inline unsigned long __do_mmap_pgoff(struct file * file,
+	unsigned long addr, unsigned long len, unsigned long prot,
+	unsigned long flags, unsigned long pgoff)
 {
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
@@ -474,6 +490,8 @@
 munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
+		if (flags & MAP_NODESTROY)
+			return -EINVAL;
 		if (do_munmap(mm, addr, len))
 			return -ENOMEM;
 		goto munmap_back;
@@ -565,6 +583,17 @@
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 	return error;
+}
+
+unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
+	unsigned long len, unsigned long prot, unsigned long flags,
+	unsigned long pgoff)
+{
+	unsigned long ret;
+	down_write(&current->mm->mmap_sem);
+	ret = __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+	up_write(&current->mm->mmap_sem);
+	return ret;
 }
 
 /* Get an address range which is currently unmapped.
