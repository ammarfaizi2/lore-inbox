Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWIUDdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWIUDdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 23:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWIUDdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 23:33:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12434 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751179AbWIUDdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 23:33:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=GE1DKbUyGnqh7EzacUzosNqCRSlbLK9tfqIJcCtEgZn0aAfLx8ZZtzGJQVCLktT7q4r7XHrmzmmMhKYYoxhNcS2Q0DgU6OxRvzLADWvEzfMRvlUHNEDwqkqFWV69qtNw9qqiv3E3m6NLawykqXmjI4B2qxoCvtAKnb+WVsqF34A=
Message-ID: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
Date: Thu, 21 Sep 2006 11:33:20 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 4/4] Blackfin: binfmt patch to enhance stacking checking
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14276_27686507.1158809600324"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14276_27686507.1158809600324
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

  This is a patch to enable stacks in L1 scratchpad memory for flat
binaries. A small area of L1 scratchpad memory is reserved to hold
task-specific information, in particular the stack pointer limit. This
will be used by an upcoming gcc patch to implement stack checking in a
way that's compatible with both flat and ELF. When task switching,
this area is swapped out to the thread_info structure.
  As a future enhancement, we can add code to libpthread and/or the
kernel to update this information for clone()d tasks; then we'll have
stack checking for threaded applications as well.
Another enhancement will be to let the compiler track the maximum
stack usage by using the second field in the L1 info structure.

Signed-off-by:  Luke Yang <luke.adi@gmail.com>

 fs/binfmt_elf_fdpic.c       |    7 +-
 fs/binfmt_flat.c            |  150 ++++++++++++++++++++++++++------------------
 include/asm-arm/mmu.h       |    1
 include/asm-frv/mmu.h       |    1
 include/asm-h8300/mmu.h     |    1
 include/asm-m32r/mmu.h      |    1
 include/asm-m68knommu/mmu.h |    1
 include/asm-sh/mmu.h        |    1
 include/asm-v850/mmu.h      |    1
 include/linux/flat.h        |   13 ++-
 10 files changed, 112 insertions(+), 65 deletions(-)


diff -urN linux-2.6.18.patch2/fs/binfmt_elf_fdpic.c
linux-2.6.18.patch3/fs/binfmt_elf_fdpic.c
--- linux-2.6.18.patch2/fs/binfmt_elf_fdpic.c	2006-09-21
09:37:18.000000000 +0800
+++ linux-2.6.18.patch3/fs/binfmt_elf_fdpic.c	2006-09-21
11:17:49.000000000 +0800
@@ -170,7 +170,7 @@
 {
 	struct elf_fdpic_params exec_params, interp_params;
 	struct elf_phdr *phdr;
-	unsigned long stack_size, entryaddr;
+	unsigned long stack_size, entryaddr, requested_stack_size;
 #ifndef CONFIG_MMU
 	unsigned long fullsize;
 #endif
@@ -361,6 +361,7 @@
 	 * - the stack starts at the top and works down
 	 */
 	stack_size = (stack_size + PAGE_SIZE - 1) & PAGE_MASK;
+	requested_stack_size = stack_size;
 	if (stack_size < PAGE_SIZE * 2)
 		stack_size = PAGE_SIZE * 2;

@@ -388,6 +389,8 @@
 	current->mm->context.end_brk = current->mm->start_brk;
 	current->mm->context.end_brk +=
 		(stack_size > PAGE_SIZE) ? (stack_size - PAGE_SIZE) : 0;
+	current->mm->context.stack_start =
+		current->mm->start_brk + stack_size - requested_stack_size;
 	current->mm->start_stack = current->mm->start_brk + stack_size;
 #endif

@@ -959,6 +962,8 @@
 }
 #endif

+extern void *safe_dma_memcpy(void *, const void *, size_t);
+
 /*****************************************************************************/
 /*
  * map a binary by direct mmap() of the individual PT_LOAD segments
diff -urN linux-2.6.18.patch2/fs/binfmt_flat.c
linux-2.6.18.patch3/fs/binfmt_flat.c
--- linux-2.6.18.patch2/fs/binfmt_flat.c	2006-09-21 09:37:18.000000000 +0800
+++ linux-2.6.18.patch3/fs/binfmt_flat.c	2006-09-21 09:52:02.000000000 +0800
@@ -16,6 +16,7 @@
  */

 #include <linux/module.h>
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -35,13 +36,13 @@
 #include <linux/personality.h>
 #include <linux/init.h>
 #include <linux/flat.h>
-#include <linux/syscalls.h>

 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 #include <asm/cacheflush.h>
+#include <asm/mmu_context.h>

 /****************************************************************************/

@@ -77,6 +78,8 @@
 static int load_flat_binary(struct linux_binprm *, struct pt_regs * regs);
 static int flat_core_dump(long signr, struct pt_regs * regs, struct
file *file);

+extern void dump_thread(struct pt_regs *, struct user *);
+
 static struct linux_binfmt flat_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_flat_binary,
@@ -413,7 +416,9 @@
 /****************************************************************************/

 static int load_flat_file(struct linux_binprm * bprm,
-		struct lib_info *libinfo, int id, unsigned long *extra_stack)
+			  struct lib_info *libinfo, int id,
+			  unsigned long *extra_stack,
+			  unsigned long *stack_base)
 {
 	struct flat_hdr * hdr;
 	unsigned long textpos = 0, datapos = 0, result;
@@ -426,7 +431,6 @@
 	int i, rev, relocs = 0;
 	loff_t fpos;
 	unsigned long start_code, end_code;
-	int ret;

 	hdr = ((struct flat_hdr *) bprm->buf);		/* exec-header */
 	inode = bprm->file->f_dentry->d_inode;
@@ -451,25 +455,24 @@
 		 */
 		if (strncmp(hdr->magic, "#!", 2))
 			printk("BINFMT_FLAT: bad header magic\n");
-		ret = -ENOEXEC;
-		goto err;
+		return -ENOEXEC;
 	}
-
+#ifdef DEBUG
+	flags |= FLAT_FLAG_KTRACE;
+#endif
 	if (flags & FLAT_FLAG_KTRACE)
 		printk("BINFMT_FLAT: Loading file: %s\n", bprm->filename);

 	if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
 		printk("BINFMT_FLAT: bad flat file version 0x%x (supported 0x%x and
0x%x)\n", rev, FLAT_VERSION, OLD_FLAT_VERSION);
-		ret = -ENOEXEC;
-		goto err;
+		return -ENOEXEC;
 	}
-	
+
 	/* Don't allow old format executables to use shared libraries */
 	if (rev == OLD_FLAT_VERSION && id != 0) {
 		printk("BINFMT_FLAT: shared libraries are not available before rev 0x%x\n",
 				(int) FLAT_VERSION);
-		ret = -ENOEXEC;
-		goto err;
+		return -ENOEXEC;
 	}

 	/*
@@ -482,8 +485,7 @@
 #ifndef CONFIG_BINFMT_ZFLAT
 	if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
 		printk("Support for ZFLAT executables is not enabled.\n");
-		ret = -ENOEXEC;
-		goto err;
+		return -ENOEXEC;
 	}
 #endif

@@ -495,18 +497,27 @@
 	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim >= RLIM_INFINITY)
 		rlim = ~0;
-	if (data_len + bss_len > rlim) {
-		ret = -ENOMEM;
-		goto err;
+	if (data_len + bss_len > rlim)
+		return -ENOMEM;
+
+	if (flags & FLAT_FLAG_L1STK) {
+		if (stack_base == 0) {
+			printk ("BINFMT_FLAT: requesting L1 stack for shared library\n");
+			return -ENOEXEC;
+		}
+		stack_len = alloc_l1stack(stack_len, stack_base);
+		if (stack_len == 0) {
+			printk("BINFMT_FLAT: stack size with arguments exceeds scratchpad
memory\n");
+			return -ENOMEM;
+		}
+		*extra_stack = stack_len;
 	}

 	/* Flush all traces of the currently running executable */
 	if (id == 0) {
 		result = flush_old_exec(bprm);
-		if (result) {
-			ret = result;
-			goto err;
-		}
+		if (result)
+			goto out_fail;

 		/* OK, This is the point of no return */
 		set_personality(PER_LINUX_32BIT);
@@ -536,14 +547,17 @@
 			if (!textpos)
 				textpos = (unsigned long) -ENOMEM;
 			printk("Unable to mmap process text, errno %d\n", (int)-textpos);
-			ret = textpos;
-			goto err;
+			result = textpos;
+			goto out_fail;
 		}

 		down_write(&current->mm->mmap_sem);
 		realdatastart = do_mmap(0, 0, data_len + extra +
 				MAX_SHARED_LIBS * sizeof(unsigned long),
 				PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
+		do_mremap(realdatastart, data_len + extra +
+			  MAX_SHARED_LIBS * sizeof(unsigned long),
+			  ksize((void *)realdatastart), 0, 0);
 		up_write(&current->mm->mmap_sem);

 		if (realdatastart == 0 || realdatastart >= (unsigned long)-4096) {
@@ -552,8 +566,8 @@
 			printk("Unable to allocate RAM for process data, errno %d\n",
 					(int)-datapos);
 			do_munmap(current->mm, textpos, text_len);
-			ret = realdatastart;
-			goto err;
+			result = realdatastart;
+			goto out_fail;
 		}
 		datapos = realdatastart + MAX_SHARED_LIBS * sizeof(unsigned long);

@@ -575,8 +589,7 @@
 			printk("Unable to read data+bss, errno %d\n", (int)-result);
 			do_munmap(current->mm, textpos, text_len);
 			do_munmap(current->mm, realdatastart, data_len + extra);
-			ret = result;
-			goto err;
+			goto out_fail;
 		}

 		reloc = (unsigned long *) (datapos+(ntohl(hdr->reloc_start)-text_len));
@@ -588,15 +601,19 @@
 		textpos = do_mmap(0, 0, text_len + data_len + extra +
 					MAX_SHARED_LIBS * sizeof(unsigned long),
 				PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
-		up_write(&current->mm->mmap_sem);
 		if (!textpos  || textpos >= (unsigned long) -4096) {
+			up_write(&current->mm->mmap_sem);
 			if (!textpos)
 				textpos = (unsigned long) -ENOMEM;
 			printk("Unable to allocate RAM for process text/data, errno %d\n",
 					(int)-textpos);
-			ret = textpos;
-			goto err;
+			result = textpos;
+			goto out_fail;
 		}
+		do_mremap(textpos, text_len + data_len + extra +
+			  MAX_SHARED_LIBS * sizeof(unsigned long),
+			  ksize((void *)textpos), 0, 0);
+		up_write(&current->mm->mmap_sem);

 		realdatastart = textpos + ntohl(hdr->data_start);
 		datapos = realdatastart + MAX_SHARED_LIBS * sizeof(unsigned long);
@@ -640,8 +657,7 @@
 			printk("Unable to read code+data+bss, errno %d\n",(int)-result);
 			do_munmap(current->mm, textpos, text_len + data_len + extra +
 				MAX_SHARED_LIBS * sizeof(unsigned long));
-			ret = result;
-			goto err;
+			goto out_fail;
 		}
 	}

@@ -665,6 +681,7 @@
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
 		current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
+		current->mm->context.stack_start = current->mm->context.end_brk;
 	}

 	if (flags & FLAT_FLAG_KTRACE)
@@ -686,7 +703,7 @@
 	libinfo->lib_list[id].loaded = 1;
 	libinfo->lib_list[id].entry = (0x00ffffff & ntohl(hdr->entry)) + textpos;
 	libinfo->lib_list[id].build_date = ntohl(hdr->build_date);
-	
+
 	/*
 	 * We just load the allocations into some temporary memory to
 	 * help simplify all this mumbo jumbo
@@ -705,8 +722,8 @@
 			if (*rp) {
 				addr = calc_reloc(*rp, libinfo, id, 0);
 				if (addr == RELOC_FAILED) {
-					ret = -ENOEXEC;
-					goto err;
+					result = -ENOEXEC;
+					goto out_fail;
 				}
 				*rp = addr;
 			}
@@ -725,6 +742,7 @@
 	 * __start to address 4 so that is okay).
 	 */
 	if (rev > OLD_FLAT_VERSION) {
+		unsigned long persistent = 0;
 		for (i=0; i < relocs; i++) {
 			unsigned long addr, relval;

@@ -732,16 +750,20 @@
 			   relocated (of course, the address has to be
 			   relocated first).  */
 			relval = ntohl(reloc[i]);
+			if (flat_set_persistent (relval, &persistent))
+				continue;
 			addr = flat_get_relocate_addr(relval);
 			rp = (unsigned long *) calc_reloc(addr, libinfo, id, 1);
 			if (rp == (unsigned long *)RELOC_FAILED) {
-				ret = -ENOEXEC;
-				goto err;
+				result = -ENOEXEC;
+				goto out_fail;
 			}

 			/* Get the pointer's value.  */
-			addr = flat_get_addr_from_rp(rp, relval, flags);
-			if (addr != 0) {
+			addr = flat_get_addr_from_rp(rp, relval, flags, &persistent);
+			if (addr == 0)
+				continue;
+			if (! flat_addr_absolute (relval)) {
 				/*
 				 * Do the relocation.  PIC relocs in the data section are
 				 * already in target order
@@ -750,30 +772,31 @@
 					addr = ntohl(addr);
 				addr = calc_reloc(addr, libinfo, id, 0);
 				if (addr == RELOC_FAILED) {
-					ret = -ENOEXEC;
-					goto err;
+					result = -ENOEXEC;
+					goto out_fail;
 				}
-
-				/* Write back the relocated pointer.  */
-				flat_put_addr_at_rp(rp, addr, relval);
 			}
+			/* Write back the relocated pointer.  */
+			flat_put_addr_at_rp(rp, addr, relval);
 		}
 	} else {
 		for (i=0; i < relocs; i++)
 			old_reloc(ntohl(reloc[i]));
 	}
-	
+
 	flush_icache_range(start_code, end_code);

 	/* zero the BSS,  BRK and stack areas */
-	memset((void*)(datapos + data_len), 0, bss_len +
+	memset((void*)(datapos + data_len), 0, bss_len +
 			(memp + ksize((void *) memp) - stack_len -	/* end brk */
 			libinfo->lib_list[id].start_brk) +		/* start brk */
 			stack_len);

 	return 0;
-err:
-	return ret;
+ out_fail:
+	if (flags & FLAT_FLAG_L1STK)
+		free_l1stack();
+	return result;
 }


@@ -804,7 +827,7 @@
 	res = prepare_binprm(&bprm);

 	if (res <= (unsigned long)-4096)
-		res = load_flat_file(&bprm, libs, id, NULL);
+		res = load_flat_file(&bprm, libs, id, NULL, NULL);
 	if (bprm.file) {
 		allow_write_access(bprm.file);
 		fput(bprm.file);
@@ -827,6 +850,7 @@
 	unsigned long p = bprm->p;
 	unsigned long stack_len;
 	unsigned long start_addr;
+	unsigned long l1stack_base, ramstack_top;
 	unsigned long *sp;
 	int res;
 	int i, j;
@@ -844,11 +868,11 @@
 	stack_len += (bprm->argc + 1) * sizeof(char *); /* the argv array */
 	stack_len += (bprm->envc + 1) * sizeof(char *); /* the envp array */

-	
-	res = load_flat_file(bprm, &libinfo, 0, &stack_len);
+	l1stack_base = 0;
+	res = load_flat_file(bprm, &libinfo, 0, &stack_len, &l1stack_base);
 	if (res > (unsigned long)-4096)
 		return res;
-	
+
 	/* Update data segment pointers for all libraries */
 	for (i=0; i<MAX_SHARED_LIBS; i++)
 		if (libinfo.lib_list[i].loaded)
@@ -863,6 +887,7 @@
 	set_binfmt(&flat_format);

 	p = ((current->mm->context.end_brk + stack_len + 3) & ~3) - 4;
+	ramstack_top = p;
 	DBG_FLT("p=%x\n", (int)p);

 	/* copy the arg pages onto the stack, this could be more efficient :-) */
@@ -871,7 +896,7 @@
 			((char *) page_address(bprm->page[i/PAGE_SIZE]))[i % PAGE_SIZE];

 	sp = (unsigned long *) create_flat_tables(p, bprm);
-	
+
 	/* Fake some return addresses to ensure the call chain will
 	 * initialise library in order for us.  We are required to call
 	 * lib 1 first, then 2, ... and finally the main program (id 0).
@@ -887,15 +912,24 @@
 		}
 	}
 #endif
-	
+
 	/* Stash our initial stack pointer into the mm structure */
 	current->mm->start_stack = (unsigned long )sp;

-	
-	DBG_FLT("start_thread(regs=0x%x, entry=0x%x, start_stack=0x%x)\n",
-		(int)regs, (int)start_addr, (int)current->mm->start_stack);
-	
-	start_thread(regs, start_addr, current->mm->start_stack);
+	if (l1stack_base) {
+		/* Find L1 stack pointer corresponding to the current bottom
+		   of the stack in normal RAM.  */
+		l1stack_base += stack_len - (ramstack_top - (unsigned long)sp);
+		if (!activate_l1stack(current->mm, ramstack_top - stack_len))
+			l1stack_base = 0;
+	}
+
+	DBG_FLT("start_thread(regs=0x%x, entry=0x%x, start_stack=0x%x,
l1stk=0x%x, len 0x%x)\n",
+		(int)regs, (int)start_addr, (int)current->mm->start_stack, l1stack_base,
+		stack_len);
+
+	start_thread(regs, start_addr,
+		     l1stack_base ? l1stack_base : current->mm->start_stack);

 	if (current->ptrace & PT_PTRACED)
 		send_sig(SIGTRAP, current, 0);
diff -urN linux-2.6.18.patch2/include/asm-arm/mmu.h
linux-2.6.18.patch3/include/asm-arm/mmu.h
--- linux-2.6.18.patch2/include/asm-arm/mmu.h	2006-09-21
09:37:24.000000000 +0800
+++ linux-2.6.18.patch3/include/asm-arm/mmu.h	2006-09-21
09:52:02.000000000 +0800
@@ -26,6 +26,7 @@
 typedef struct {
 	struct vm_list_struct	*vmlist;
 	unsigned long		end_brk;
+	unsigned long		stack_start;
 } mm_context_t;

 #endif
diff -urN linux-2.6.18.patch2/include/asm-frv/mmu.h
linux-2.6.18.patch3/include/asm-frv/mmu.h
--- linux-2.6.18.patch2/include/asm-frv/mmu.h	2006-09-21
09:37:25.000000000 +0800
+++ linux-2.6.18.patch3/include/asm-frv/mmu.h	2006-09-21
09:52:02.000000000 +0800
@@ -24,6 +24,7 @@
 #else
 	struct vm_list_struct	*vmlist;
 	unsigned long		end_brk;
+	unsigned long		stack_start;

 #endif

diff -urN linux-2.6.18.patch2/include/asm-h8300/mmu.h
linux-2.6.18.patch3/include/asm-h8300/mmu.h
--- linux-2.6.18.patch2/include/asm-h8300/mmu.h	2006-09-21
09:37:26.000000000 +0800
+++ linux-2.6.18.patch3/include/asm-h8300/mmu.h	2006-09-21
09:52:02.000000000 +0800
@@ -6,6 +6,7 @@
 typedef struct {
 	struct vm_list_struct	*vmlist;
 	unsigned long		end_brk;
+	unsigned long		stack_start;
 } mm_context_t;

 #endif
diff -urN linux-2.6.18.patch2/include/asm-m32r/mmu.h
linux-2.6.18.patch3/include/asm-m32r/mmu.h
--- linux-2.6.18.patch2/include/asm-m32r/mmu.h	2006-09-21
09:37:26.000000000 +0800
+++ linux-2.6.18.patch3/include/asm-m32r/mmu.h	2006-09-21
09:52:02.000000000 +0800
@@ -6,6 +6,7 @@
 typedef struct {
 	struct vm_list_struct	*vmlist;
 	unsigned long		end_brk;
+	unsigned long		stack_start;
 } mm_context_t;
 #else

diff -urN linux-2.6.18.patch2/include/asm-m68knommu/mmu.h
linux-2.6.18.patch3/include/asm-m68knommu/mmu.h
--- linux-2.6.18.patch2/include/asm-m68knommu/mmu.h	2006-09-21
09:37:26.000000000 +0800
+++ linux-2.6.18.patch3/include/asm-m68knommu/mmu.h	2006-09-21
09:52:02.000000000 +0800
@@ -6,6 +6,7 @@
 typedef struct {
 	struct vm_list_struct	*vmlist;
 	unsigned long		end_brk;
+	unsigned long		stack_start;
 } mm_context_t;

 #endif /* __M68KNOMMU_MMU_H */
diff -urN linux-2.6.18.patch2/include/asm-sh/mmu.h
linux-2.6.18.patch3/include/asm-sh/mmu.h
--- linux-2.6.18.patch2/include/asm-sh/mmu.h	2006-09-21 09:37:26.000000000 +0800
+++ linux-2.6.18.patch3/include/asm-sh/mmu.h	2006-09-21 09:52:02.000000000 +0800
@@ -17,6 +17,7 @@
 typedef struct {
 	struct mm_tblock_struct tblock;
 	unsigned long		end_brk;
+	unsigned long		stack_start;
 } mm_context_t;

 #else
diff -urN linux-2.6.18.patch2/include/asm-v850/mmu.h
linux-2.6.18.patch3/include/asm-v850/mmu.h
--- linux-2.6.18.patch2/include/asm-v850/mmu.h	2006-09-21
09:37:27.000000000 +0800
+++ linux-2.6.18.patch3/include/asm-v850/mmu.h	2006-09-21
09:52:02.000000000 +0800
@@ -6,6 +6,7 @@
 typedef struct {
 	struct vm_list_struct	*vmlist;
 	unsigned long		end_brk;
+	unsigned long		stack_start;
 } mm_context_t;

 #endif /* __V850_MMU_H__ */
diff -urN linux-2.6.18.patch2/include/linux/flat.h
linux-2.6.18.patch3/include/linux/flat.h
--- linux-2.6.18.patch2/include/linux/flat.h	2006-09-21 09:37:27.000000000 +0800
+++ linux-2.6.18.patch3/include/linux/flat.h	2006-09-21 09:52:02.000000000 +0800
@@ -10,6 +10,13 @@
 #ifndef _LINUX_FLAT_H
 #define _LINUX_FLAT_H

+#define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
+#define FLAT_FLAG_GOTPIC 0x0002 /* program is PIC with GOT */
+#define FLAT_FLAG_GZIP   0x0004 /* all but the header is compressed */
+#define FLAT_FLAG_GZDATA 0x0008 /* only data/relocs are compressed (for XIP) */
+#define FLAT_FLAG_KTRACE 0x0010 /* output useful kernel trace for debugging */
+#define FLAT_FLAG_L1STK  0x0020 /* use a 4k stack in L1 scratch memory.  */
+
 #ifdef __KERNEL__
 #include <asm/flat.h>
 #endif
@@ -50,12 +57,6 @@
 	unsigned long filler[5];    /* Reservered, set to zero */
 };

-#define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
-#define FLAT_FLAG_GOTPIC 0x0002 /* program is PIC with GOT */
-#define FLAT_FLAG_GZIP   0x0004 /* all but the header is compressed */
-#define FLAT_FLAG_GZDATA 0x0008 /* only data/relocs are compressed (for XIP) */
-#define FLAT_FLAG_KTRACE 0x0010 /* output useful kernel trace for debugging */
-

 #ifdef __KERNEL__ /* so systems without linux headers can compile the apps */
 /*

-- 
Best regards,
Luke Yang
luke.adi@gmail.com

------=_Part_14276_27686507.1158809600324
Content-Type: text/x-patch; name=blackfin_binfmt_2.6.18.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esckzxl4
Content-Disposition: attachment; filename="blackfin_binfmt_2.6.18.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDIvZnMvYmluZm10X2VsZl9mZHBpYy5jIGxpbnV4
LTIuNi4xOC5wYXRjaDMvZnMvYmluZm10X2VsZl9mZHBpYy5jCi0tLSBsaW51eC0yLjYuMTgucGF0
Y2gyL2ZzL2JpbmZtdF9lbGZfZmRwaWMuYwkyMDA2LTA5LTIxIDA5OjM3OjE4LjAwMDAwMDAwMCAr
MDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMy9mcy9iaW5mbXRfZWxmX2ZkcGljLmMJMjAwNi0w
OS0yMSAxMToxNzo0OS4wMDAwMDAwMDAgKzA4MDAKQEAgLTE3MCw3ICsxNzAsNyBAQAogewogCXN0
cnVjdCBlbGZfZmRwaWNfcGFyYW1zIGV4ZWNfcGFyYW1zLCBpbnRlcnBfcGFyYW1zOwogCXN0cnVj
dCBlbGZfcGhkciAqcGhkcjsKLQl1bnNpZ25lZCBsb25nIHN0YWNrX3NpemUsIGVudHJ5YWRkcjsK
Kwl1bnNpZ25lZCBsb25nIHN0YWNrX3NpemUsIGVudHJ5YWRkciwgcmVxdWVzdGVkX3N0YWNrX3Np
emU7CiAjaWZuZGVmIENPTkZJR19NTVUKIAl1bnNpZ25lZCBsb25nIGZ1bGxzaXplOwogI2VuZGlm
CkBAIC0zNjEsNiArMzYxLDcgQEAKIAkgKiAtIHRoZSBzdGFjayBzdGFydHMgYXQgdGhlIHRvcCBh
bmQgd29ya3MgZG93bgogCSAqLwogCXN0YWNrX3NpemUgPSAoc3RhY2tfc2l6ZSArIFBBR0VfU0la
RSAtIDEpICYgUEFHRV9NQVNLOworCXJlcXVlc3RlZF9zdGFja19zaXplID0gc3RhY2tfc2l6ZTsK
IAlpZiAoc3RhY2tfc2l6ZSA8IFBBR0VfU0laRSAqIDIpCiAJCXN0YWNrX3NpemUgPSBQQUdFX1NJ
WkUgKiAyOwogCkBAIC0zODgsNiArMzg5LDggQEAKIAljdXJyZW50LT5tbS0+Y29udGV4dC5lbmRf
YnJrID0gY3VycmVudC0+bW0tPnN0YXJ0X2JyazsKIAljdXJyZW50LT5tbS0+Y29udGV4dC5lbmRf
YnJrICs9CiAJCShzdGFja19zaXplID4gUEFHRV9TSVpFKSA/IChzdGFja19zaXplIC0gUEFHRV9T
SVpFKSA6IDA7CisJY3VycmVudC0+bW0tPmNvbnRleHQuc3RhY2tfc3RhcnQgPQorCQljdXJyZW50
LT5tbS0+c3RhcnRfYnJrICsgc3RhY2tfc2l6ZSAtIHJlcXVlc3RlZF9zdGFja19zaXplOwogCWN1
cnJlbnQtPm1tLT5zdGFydF9zdGFjayA9IGN1cnJlbnQtPm1tLT5zdGFydF9icmsgKyBzdGFja19z
aXplOwogI2VuZGlmCiAKQEAgLTk1OSw2ICs5NjIsOCBAQAogfQogI2VuZGlmCiAKK2V4dGVybiB2
b2lkICpzYWZlX2RtYV9tZW1jcHkodm9pZCAqLCBjb25zdCB2b2lkICosIHNpemVfdCk7CisKIC8q
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi8KIC8qCiAgKiBtYXAgYSBiaW5hcnkgYnkgZGlyZWN0IG1tYXAo
KSBvZiB0aGUgaW5kaXZpZHVhbCBQVF9MT0FEIHNlZ21lbnRzCmRpZmYgLXVyTiBsaW51eC0yLjYu
MTgucGF0Y2gyL2ZzL2JpbmZtdF9mbGF0LmMgbGludXgtMi42LjE4LnBhdGNoMy9mcy9iaW5mbXRf
ZmxhdC5jCi0tLSBsaW51eC0yLjYuMTgucGF0Y2gyL2ZzL2JpbmZtdF9mbGF0LmMJMjAwNi0wOS0y
MSAwOTozNzoxOC4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOC5wYXRjaDMvZnMvYmlu
Zm10X2ZsYXQuYwkyMDA2LTA5LTIxIDA5OjUyOjAyLjAwMDAwMDAwMCArMDgwMApAQCAtMTYsNiAr
MTYsNyBAQAogICovCiAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51
eC9jb25maWcuaD4KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KICNpbmNsdWRlIDxsaW51eC9z
Y2hlZC5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CkBAIC0zNSwxMyArMzYsMTMgQEAKICNpbmNs
dWRlIDxsaW51eC9wZXJzb25hbGl0eS5oPgogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KICNpbmNs
dWRlIDxsaW51eC9mbGF0Lmg+Ci0jaW5jbHVkZSA8bGludXgvc3lzY2FsbHMuaD4KIAogI2luY2x1
ZGUgPGFzbS9ieXRlb3JkZXIuaD4KICNpbmNsdWRlIDxhc20vc3lzdGVtLmg+CiAjaW5jbHVkZSA8
YXNtL3VhY2Nlc3MuaD4KICNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+CiAjaW5jbHVkZSA8YXNt
L2NhY2hlZmx1c2guaD4KKyNpbmNsdWRlIDxhc20vbW11X2NvbnRleHQuaD4KIAogLyoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKiovCiAKQEAgLTc3LDYgKzc4LDggQEAKIHN0YXRpYyBpbnQgbG9hZF9mbGF0X2Jp
bmFyeShzdHJ1Y3QgbGludXhfYmlucHJtICosIHN0cnVjdCBwdF9yZWdzICogcmVncyk7CiBzdGF0
aWMgaW50IGZsYXRfY29yZV9kdW1wKGxvbmcgc2lnbnIsIHN0cnVjdCBwdF9yZWdzICogcmVncywg
c3RydWN0IGZpbGUgKmZpbGUpOwogCitleHRlcm4gdm9pZCBkdW1wX3RocmVhZChzdHJ1Y3QgcHRf
cmVncyAqLCBzdHJ1Y3QgdXNlciAqKTsKKwogc3RhdGljIHN0cnVjdCBsaW51eF9iaW5mbXQgZmxh
dF9mb3JtYXQgPSB7CiAJLm1vZHVsZQkJPSBUSElTX01PRFVMRSwKIAkubG9hZF9iaW5hcnkJPSBs
b2FkX2ZsYXRfYmluYXJ5LApAQCAtNDEzLDcgKzQxNiw5IEBACiAvKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Ki8KIAogc3RhdGljIGludCBsb2FkX2ZsYXRfZmlsZShzdHJ1Y3QgbGludXhfYmlucHJtICogYnBy
bSwKLQkJc3RydWN0IGxpYl9pbmZvICpsaWJpbmZvLCBpbnQgaWQsIHVuc2lnbmVkIGxvbmcgKmV4
dHJhX3N0YWNrKQorCQkJICBzdHJ1Y3QgbGliX2luZm8gKmxpYmluZm8sIGludCBpZCwKKwkJCSAg
dW5zaWduZWQgbG9uZyAqZXh0cmFfc3RhY2ssCisJCQkgIHVuc2lnbmVkIGxvbmcgKnN0YWNrX2Jh
c2UpCiB7CiAJc3RydWN0IGZsYXRfaGRyICogaGRyOwogCXVuc2lnbmVkIGxvbmcgdGV4dHBvcyA9
IDAsIGRhdGFwb3MgPSAwLCByZXN1bHQ7CkBAIC00MjYsNyArNDMxLDYgQEAKIAlpbnQgaSwgcmV2
LCByZWxvY3MgPSAwOwogCWxvZmZfdCBmcG9zOwogCXVuc2lnbmVkIGxvbmcgc3RhcnRfY29kZSwg
ZW5kX2NvZGU7Ci0JaW50IHJldDsKIAogCWhkciA9ICgoc3RydWN0IGZsYXRfaGRyICopIGJwcm0t
PmJ1Zik7CQkvKiBleGVjLWhlYWRlciAqLwogCWlub2RlID0gYnBybS0+ZmlsZS0+Zl9kZW50cnkt
PmRfaW5vZGU7CkBAIC00NTEsMjUgKzQ1NSwyNCBAQAogCQkgKi8KIAkJaWYgKHN0cm5jbXAoaGRy
LT5tYWdpYywgIiMhIiwgMikpCiAJCQlwcmludGsoIkJJTkZNVF9GTEFUOiBiYWQgaGVhZGVyIG1h
Z2ljXG4iKTsKLQkJcmV0ID0gLUVOT0VYRUM7Ci0JCWdvdG8gZXJyOworCQlyZXR1cm4gLUVOT0VY
RUM7CiAJfQotCisjaWZkZWYgREVCVUcKKwlmbGFncyB8PSBGTEFUX0ZMQUdfS1RSQUNFOworI2Vu
ZGlmCiAJaWYgKGZsYWdzICYgRkxBVF9GTEFHX0tUUkFDRSkKIAkJcHJpbnRrKCJCSU5GTVRfRkxB
VDogTG9hZGluZyBmaWxlOiAlc1xuIiwgYnBybS0+ZmlsZW5hbWUpOwogCiAJaWYgKHJldiAhPSBG
TEFUX1ZFUlNJT04gJiYgcmV2ICE9IE9MRF9GTEFUX1ZFUlNJT04pIHsKIAkJcHJpbnRrKCJCSU5G
TVRfRkxBVDogYmFkIGZsYXQgZmlsZSB2ZXJzaW9uIDB4JXggKHN1cHBvcnRlZCAweCV4IGFuZCAw
eCV4KVxuIiwgcmV2LCBGTEFUX1ZFUlNJT04sIE9MRF9GTEFUX1ZFUlNJT04pOwotCQlyZXQgPSAt
RU5PRVhFQzsKLQkJZ290byBlcnI7CisJCXJldHVybiAtRU5PRVhFQzsKIAl9Ci0JCisKIAkvKiBE
b24ndCBhbGxvdyBvbGQgZm9ybWF0IGV4ZWN1dGFibGVzIHRvIHVzZSBzaGFyZWQgbGlicmFyaWVz
ICovCiAJaWYgKHJldiA9PSBPTERfRkxBVF9WRVJTSU9OICYmIGlkICE9IDApIHsKIAkJcHJpbnRr
KCJCSU5GTVRfRkxBVDogc2hhcmVkIGxpYnJhcmllcyBhcmUgbm90IGF2YWlsYWJsZSBiZWZvcmUg
cmV2IDB4JXhcbiIsCiAJCQkJKGludCkgRkxBVF9WRVJTSU9OKTsKLQkJcmV0ID0gLUVOT0VYRUM7
Ci0JCWdvdG8gZXJyOworCQlyZXR1cm4gLUVOT0VYRUM7CiAJfQogCiAJLyoKQEAgLTQ4Miw4ICs0
ODUsNyBAQAogI2lmbmRlZiBDT05GSUdfQklORk1UX1pGTEFUCiAJaWYgKGZsYWdzICYgKEZMQVRf
RkxBR19HWklQfEZMQVRfRkxBR19HWkRBVEEpKSB7CiAJCXByaW50aygiU3VwcG9ydCBmb3IgWkZM
QVQgZXhlY3V0YWJsZXMgaXMgbm90IGVuYWJsZWQuXG4iKTsKLQkJcmV0ID0gLUVOT0VYRUM7Ci0J
CWdvdG8gZXJyOworCQlyZXR1cm4gLUVOT0VYRUM7CiAJfQogI2VuZGlmCiAKQEAgLTQ5NSwxOCAr
NDk3LDI3IEBACiAJcmxpbSA9IGN1cnJlbnQtPnNpZ25hbC0+cmxpbVtSTElNSVRfREFUQV0ucmxp
bV9jdXI7CiAJaWYgKHJsaW0gPj0gUkxJTV9JTkZJTklUWSkKIAkJcmxpbSA9IH4wOwotCWlmIChk
YXRhX2xlbiArIGJzc19sZW4gPiBybGltKSB7Ci0JCXJldCA9IC1FTk9NRU07Ci0JCWdvdG8gZXJy
OworCWlmIChkYXRhX2xlbiArIGJzc19sZW4gPiBybGltKQorCQlyZXR1cm4gLUVOT01FTTsKKwor
CWlmIChmbGFncyAmIEZMQVRfRkxBR19MMVNUSykgeworCQlpZiAoc3RhY2tfYmFzZSA9PSAwKSB7
CisJCQlwcmludGsgKCJCSU5GTVRfRkxBVDogcmVxdWVzdGluZyBMMSBzdGFjayBmb3Igc2hhcmVk
IGxpYnJhcnlcbiIpOworCQkJcmV0dXJuIC1FTk9FWEVDOworCQl9CisJCXN0YWNrX2xlbiA9IGFs
bG9jX2wxc3RhY2soc3RhY2tfbGVuLCBzdGFja19iYXNlKTsKKwkJaWYgKHN0YWNrX2xlbiA9PSAw
KSB7CisJCQlwcmludGsoIkJJTkZNVF9GTEFUOiBzdGFjayBzaXplIHdpdGggYXJndW1lbnRzIGV4
Y2VlZHMgc2NyYXRjaHBhZCBtZW1vcnlcbiIpOworCQkJcmV0dXJuIC1FTk9NRU07CisJCX0KKwkJ
KmV4dHJhX3N0YWNrID0gc3RhY2tfbGVuOwogCX0KIAogCS8qIEZsdXNoIGFsbCB0cmFjZXMgb2Yg
dGhlIGN1cnJlbnRseSBydW5uaW5nIGV4ZWN1dGFibGUgKi8KIAlpZiAoaWQgPT0gMCkgewogCQly
ZXN1bHQgPSBmbHVzaF9vbGRfZXhlYyhicHJtKTsKLQkJaWYgKHJlc3VsdCkgewotCQkJcmV0ID0g
cmVzdWx0OwotCQkJZ290byBlcnI7Ci0JCX0KKwkJaWYgKHJlc3VsdCkKKwkJCWdvdG8gb3V0X2Zh
aWw7CiAKIAkJLyogT0ssIFRoaXMgaXMgdGhlIHBvaW50IG9mIG5vIHJldHVybiAqLwogCQlzZXRf
cGVyc29uYWxpdHkoUEVSX0xJTlVYXzMyQklUKTsKQEAgLTUzNiwxNCArNTQ3LDE3IEBACiAJCQlp
ZiAoIXRleHRwb3MpCiAJCQkJdGV4dHBvcyA9ICh1bnNpZ25lZCBsb25nKSAtRU5PTUVNOwogCQkJ
cHJpbnRrKCJVbmFibGUgdG8gbW1hcCBwcm9jZXNzIHRleHQsIGVycm5vICVkXG4iLCAoaW50KS10
ZXh0cG9zKTsKLQkJCXJldCA9IHRleHRwb3M7Ci0JCQlnb3RvIGVycjsKKwkJCXJlc3VsdCA9IHRl
eHRwb3M7CisJCQlnb3RvIG91dF9mYWlsOwogCQl9CiAKIAkJZG93bl93cml0ZSgmY3VycmVudC0+
bW0tPm1tYXBfc2VtKTsKIAkJcmVhbGRhdGFzdGFydCA9IGRvX21tYXAoMCwgMCwgZGF0YV9sZW4g
KyBleHRyYSArCiAJCQkJTUFYX1NIQVJFRF9MSUJTICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpLAog
CQkJCVBST1RfUkVBRHxQUk9UX1dSSVRFfFBST1RfRVhFQywgTUFQX1BSSVZBVEUsIDApOworCQlk
b19tcmVtYXAocmVhbGRhdGFzdGFydCwgZGF0YV9sZW4gKyBleHRyYSArCisJCQkgIE1BWF9TSEFS
RURfTElCUyAqIHNpemVvZih1bnNpZ25lZCBsb25nKSwKKwkJCSAga3NpemUoKHZvaWQgKilyZWFs
ZGF0YXN0YXJ0KSwgMCwgMCk7CiAJCXVwX3dyaXRlKCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOwog
CiAJCWlmIChyZWFsZGF0YXN0YXJ0ID09IDAgfHwgcmVhbGRhdGFzdGFydCA+PSAodW5zaWduZWQg
bG9uZyktNDA5NikgewpAQCAtNTUyLDggKzU2Niw4IEBACiAJCQlwcmludGsoIlVuYWJsZSB0byBh
bGxvY2F0ZSBSQU0gZm9yIHByb2Nlc3MgZGF0YSwgZXJybm8gJWRcbiIsCiAJCQkJCShpbnQpLWRh
dGFwb3MpOwogCQkJZG9fbXVubWFwKGN1cnJlbnQtPm1tLCB0ZXh0cG9zLCB0ZXh0X2xlbik7Ci0J
CQlyZXQgPSByZWFsZGF0YXN0YXJ0OwotCQkJZ290byBlcnI7CisJCQlyZXN1bHQgPSByZWFsZGF0
YXN0YXJ0OworCQkJZ290byBvdXRfZmFpbDsKIAkJfQogCQlkYXRhcG9zID0gcmVhbGRhdGFzdGFy
dCArIE1BWF9TSEFSRURfTElCUyAqIHNpemVvZih1bnNpZ25lZCBsb25nKTsKIApAQCAtNTc1LDgg
KzU4OSw3IEBACiAJCQlwcmludGsoIlVuYWJsZSB0byByZWFkIGRhdGErYnNzLCBlcnJubyAlZFxu
IiwgKGludCktcmVzdWx0KTsKIAkJCWRvX211bm1hcChjdXJyZW50LT5tbSwgdGV4dHBvcywgdGV4
dF9sZW4pOwogCQkJZG9fbXVubWFwKGN1cnJlbnQtPm1tLCByZWFsZGF0YXN0YXJ0LCBkYXRhX2xl
biArIGV4dHJhKTsKLQkJCXJldCA9IHJlc3VsdDsKLQkJCWdvdG8gZXJyOworCQkJZ290byBvdXRf
ZmFpbDsKIAkJfQogCiAJCXJlbG9jID0gKHVuc2lnbmVkIGxvbmcgKikgKGRhdGFwb3MrKG50b2hs
KGhkci0+cmVsb2Nfc3RhcnQpLXRleHRfbGVuKSk7CkBAIC01ODgsMTUgKzYwMSwxOSBAQAogCQl0
ZXh0cG9zID0gZG9fbW1hcCgwLCAwLCB0ZXh0X2xlbiArIGRhdGFfbGVuICsgZXh0cmEgKwogCQkJ
CQlNQVhfU0hBUkVEX0xJQlMgKiBzaXplb2YodW5zaWduZWQgbG9uZyksCiAJCQkJUFJPVF9SRUFE
IHwgUFJPVF9FWEVDIHwgUFJPVF9XUklURSwgTUFQX1BSSVZBVEUsIDApOwotCQl1cF93cml0ZSgm
Y3VycmVudC0+bW0tPm1tYXBfc2VtKTsKIAkJaWYgKCF0ZXh0cG9zICB8fCB0ZXh0cG9zID49ICh1
bnNpZ25lZCBsb25nKSAtNDA5NikgeworCQkJdXBfd3JpdGUoJmN1cnJlbnQtPm1tLT5tbWFwX3Nl
bSk7CiAJCQlpZiAoIXRleHRwb3MpCiAJCQkJdGV4dHBvcyA9ICh1bnNpZ25lZCBsb25nKSAtRU5P
TUVNOwogCQkJcHJpbnRrKCJVbmFibGUgdG8gYWxsb2NhdGUgUkFNIGZvciBwcm9jZXNzIHRleHQv
ZGF0YSwgZXJybm8gJWRcbiIsCiAJCQkJCShpbnQpLXRleHRwb3MpOwotCQkJcmV0ID0gdGV4dHBv
czsKLQkJCWdvdG8gZXJyOworCQkJcmVzdWx0ID0gdGV4dHBvczsKKwkJCWdvdG8gb3V0X2ZhaWw7
CiAJCX0KKwkJZG9fbXJlbWFwKHRleHRwb3MsIHRleHRfbGVuICsgZGF0YV9sZW4gKyBleHRyYSAr
CisJCQkgIE1BWF9TSEFSRURfTElCUyAqIHNpemVvZih1bnNpZ25lZCBsb25nKSwKKwkJCSAga3Np
emUoKHZvaWQgKil0ZXh0cG9zKSwgMCwgMCk7CisJCXVwX3dyaXRlKCZjdXJyZW50LT5tbS0+bW1h
cF9zZW0pOwogCiAJCXJlYWxkYXRhc3RhcnQgPSB0ZXh0cG9zICsgbnRvaGwoaGRyLT5kYXRhX3N0
YXJ0KTsKIAkJZGF0YXBvcyA9IHJlYWxkYXRhc3RhcnQgKyBNQVhfU0hBUkVEX0xJQlMgKiBzaXpl
b2YodW5zaWduZWQgbG9uZyk7CkBAIC02NDAsOCArNjU3LDcgQEAKIAkJCXByaW50aygiVW5hYmxl
IHRvIHJlYWQgY29kZStkYXRhK2JzcywgZXJybm8gJWRcbiIsKGludCktcmVzdWx0KTsKIAkJCWRv
X211bm1hcChjdXJyZW50LT5tbSwgdGV4dHBvcywgdGV4dF9sZW4gKyBkYXRhX2xlbiArIGV4dHJh
ICsKIAkJCQlNQVhfU0hBUkVEX0xJQlMgKiBzaXplb2YodW5zaWduZWQgbG9uZykpOwotCQkJcmV0
ID0gcmVzdWx0OwotCQkJZ290byBlcnI7CisJCQlnb3RvIG91dF9mYWlsOwogCQl9CiAJfQogCkBA
IC02NjUsNiArNjgxLDcgQEAKIAkJY3VycmVudC0+bW0tPnN0YXJ0X2JyayA9IGRhdGFwb3MgKyBk
YXRhX2xlbiArIGJzc19sZW47CiAJCWN1cnJlbnQtPm1tLT5icmsgPSAoY3VycmVudC0+bW0tPnN0
YXJ0X2JyayArIDMpICYgfjM7CiAJCWN1cnJlbnQtPm1tLT5jb250ZXh0LmVuZF9icmsgPSBtZW1w
ICsga3NpemUoKHZvaWQgKikgbWVtcCkgLSBzdGFja19sZW47CisJCWN1cnJlbnQtPm1tLT5jb250
ZXh0LnN0YWNrX3N0YXJ0ID0gY3VycmVudC0+bW0tPmNvbnRleHQuZW5kX2JyazsKIAl9CiAKIAlp
ZiAoZmxhZ3MgJiBGTEFUX0ZMQUdfS1RSQUNFKQpAQCAtNjg2LDcgKzcwMyw3IEBACiAJbGliaW5m
by0+bGliX2xpc3RbaWRdLmxvYWRlZCA9IDE7CiAJbGliaW5mby0+bGliX2xpc3RbaWRdLmVudHJ5
ID0gKDB4MDBmZmZmZmYgJiBudG9obChoZHItPmVudHJ5KSkgKyB0ZXh0cG9zOwogCWxpYmluZm8t
PmxpYl9saXN0W2lkXS5idWlsZF9kYXRlID0gbnRvaGwoaGRyLT5idWlsZF9kYXRlKTsKLQkKKwog
CS8qCiAJICogV2UganVzdCBsb2FkIHRoZSBhbGxvY2F0aW9ucyBpbnRvIHNvbWUgdGVtcG9yYXJ5
IG1lbW9yeSB0bwogCSAqIGhlbHAgc2ltcGxpZnkgYWxsIHRoaXMgbXVtYm8ganVtYm8KQEAgLTcw
NSw4ICs3MjIsOCBAQAogCQkJaWYgKCpycCkgewogCQkJCWFkZHIgPSBjYWxjX3JlbG9jKCpycCwg
bGliaW5mbywgaWQsIDApOwogCQkJCWlmIChhZGRyID09IFJFTE9DX0ZBSUxFRCkgewotCQkJCQly
ZXQgPSAtRU5PRVhFQzsKLQkJCQkJZ290byBlcnI7CisJCQkJCXJlc3VsdCA9IC1FTk9FWEVDOwor
CQkJCQlnb3RvIG91dF9mYWlsOwogCQkJCX0KIAkJCQkqcnAgPSBhZGRyOwogCQkJfQpAQCAtNzI1
LDYgKzc0Miw3IEBACiAJICogX19zdGFydCB0byBhZGRyZXNzIDQgc28gdGhhdCBpcyBva2F5KS4K
IAkgKi8KIAlpZiAocmV2ID4gT0xEX0ZMQVRfVkVSU0lPTikgeworCQl1bnNpZ25lZCBsb25nIHBl
cnNpc3RlbnQgPSAwOwogCQlmb3IgKGk9MDsgaSA8IHJlbG9jczsgaSsrKSB7CiAJCQl1bnNpZ25l
ZCBsb25nIGFkZHIsIHJlbHZhbDsKIApAQCAtNzMyLDE2ICs3NTAsMjAgQEAKIAkJCSAgIHJlbG9j
YXRlZCAob2YgY291cnNlLCB0aGUgYWRkcmVzcyBoYXMgdG8gYmUKIAkJCSAgIHJlbG9jYXRlZCBm
aXJzdCkuICAqLwogCQkJcmVsdmFsID0gbnRvaGwocmVsb2NbaV0pOworCQkJaWYgKGZsYXRfc2V0
X3BlcnNpc3RlbnQgKHJlbHZhbCwgJnBlcnNpc3RlbnQpKQorCQkJCWNvbnRpbnVlOwogCQkJYWRk
ciA9IGZsYXRfZ2V0X3JlbG9jYXRlX2FkZHIocmVsdmFsKTsKIAkJCXJwID0gKHVuc2lnbmVkIGxv
bmcgKikgY2FsY19yZWxvYyhhZGRyLCBsaWJpbmZvLCBpZCwgMSk7CiAJCQlpZiAocnAgPT0gKHVu
c2lnbmVkIGxvbmcgKilSRUxPQ19GQUlMRUQpIHsKLQkJCQlyZXQgPSAtRU5PRVhFQzsKLQkJCQln
b3RvIGVycjsKKwkJCQlyZXN1bHQgPSAtRU5PRVhFQzsKKwkJCQlnb3RvIG91dF9mYWlsOwogCQkJ
fQogCiAJCQkvKiBHZXQgdGhlIHBvaW50ZXIncyB2YWx1ZS4gICovCi0JCQlhZGRyID0gZmxhdF9n
ZXRfYWRkcl9mcm9tX3JwKHJwLCByZWx2YWwsIGZsYWdzKTsKLQkJCWlmIChhZGRyICE9IDApIHsK
KwkJCWFkZHIgPSBmbGF0X2dldF9hZGRyX2Zyb21fcnAocnAsIHJlbHZhbCwgZmxhZ3MsICZwZXJz
aXN0ZW50KTsKKwkJCWlmIChhZGRyID09IDApCisJCQkJY29udGludWU7CisJCQlpZiAoISBmbGF0
X2FkZHJfYWJzb2x1dGUgKHJlbHZhbCkpIHsKIAkJCQkvKgogCQkJCSAqIERvIHRoZSByZWxvY2F0
aW9uLiAgUElDIHJlbG9jcyBpbiB0aGUgZGF0YSBzZWN0aW9uIGFyZQogCQkJCSAqIGFscmVhZHkg
aW4gdGFyZ2V0IG9yZGVyCkBAIC03NTAsMzAgKzc3MiwzMSBAQAogCQkJCQlhZGRyID0gbnRvaGwo
YWRkcik7CiAJCQkJYWRkciA9IGNhbGNfcmVsb2MoYWRkciwgbGliaW5mbywgaWQsIDApOwogCQkJ
CWlmIChhZGRyID09IFJFTE9DX0ZBSUxFRCkgewotCQkJCQlyZXQgPSAtRU5PRVhFQzsKLQkJCQkJ
Z290byBlcnI7CisJCQkJCXJlc3VsdCA9IC1FTk9FWEVDOworCQkJCQlnb3RvIG91dF9mYWlsOwog
CQkJCX0KLQotCQkJCS8qIFdyaXRlIGJhY2sgdGhlIHJlbG9jYXRlZCBwb2ludGVyLiAgKi8KLQkJ
CQlmbGF0X3B1dF9hZGRyX2F0X3JwKHJwLCBhZGRyLCByZWx2YWwpOwogCQkJfQorCQkJLyogV3Jp
dGUgYmFjayB0aGUgcmVsb2NhdGVkIHBvaW50ZXIuICAqLworCQkJZmxhdF9wdXRfYWRkcl9hdF9y
cChycCwgYWRkciwgcmVsdmFsKTsKIAkJfQogCX0gZWxzZSB7CiAJCWZvciAoaT0wOyBpIDwgcmVs
b2NzOyBpKyspCiAJCQlvbGRfcmVsb2MobnRvaGwocmVsb2NbaV0pKTsKIAl9Ci0JCisKIAlmbHVz
aF9pY2FjaGVfcmFuZ2Uoc3RhcnRfY29kZSwgZW5kX2NvZGUpOwogCiAJLyogemVybyB0aGUgQlNT
LCAgQlJLIGFuZCBzdGFjayBhcmVhcyAqLwotCW1lbXNldCgodm9pZCopKGRhdGFwb3MgKyBkYXRh
X2xlbiksIDAsIGJzc19sZW4gKyAKKwltZW1zZXQoKHZvaWQqKShkYXRhcG9zICsgZGF0YV9sZW4p
LCAwLCBic3NfbGVuICsKIAkJCShtZW1wICsga3NpemUoKHZvaWQgKikgbWVtcCkgLSBzdGFja19s
ZW4gLQkvKiBlbmQgYnJrICovCiAJCQlsaWJpbmZvLT5saWJfbGlzdFtpZF0uc3RhcnRfYnJrKSAr
CQkvKiBzdGFydCBicmsgKi8KIAkJCXN0YWNrX2xlbik7CiAKIAlyZXR1cm4gMDsKLWVycjoKLQly
ZXR1cm4gcmV0OworIG91dF9mYWlsOgorCWlmIChmbGFncyAmIEZMQVRfRkxBR19MMVNUSykKKwkJ
ZnJlZV9sMXN0YWNrKCk7CisJcmV0dXJuIHJlc3VsdDsKIH0KIAogCkBAIC04MDQsNyArODI3LDcg
QEAKIAlyZXMgPSBwcmVwYXJlX2JpbnBybSgmYnBybSk7CiAKIAlpZiAocmVzIDw9ICh1bnNpZ25l
ZCBsb25nKS00MDk2KQotCQlyZXMgPSBsb2FkX2ZsYXRfZmlsZSgmYnBybSwgbGlicywgaWQsIE5V
TEwpOworCQlyZXMgPSBsb2FkX2ZsYXRfZmlsZSgmYnBybSwgbGlicywgaWQsIE5VTEwsIE5VTEwp
OwogCWlmIChicHJtLmZpbGUpIHsKIAkJYWxsb3dfd3JpdGVfYWNjZXNzKGJwcm0uZmlsZSk7CiAJ
CWZwdXQoYnBybS5maWxlKTsKQEAgLTgyNyw2ICs4NTAsNyBAQAogCXVuc2lnbmVkIGxvbmcgcCA9
IGJwcm0tPnA7CiAJdW5zaWduZWQgbG9uZyBzdGFja19sZW47CiAJdW5zaWduZWQgbG9uZyBzdGFy
dF9hZGRyOworCXVuc2lnbmVkIGxvbmcgbDFzdGFja19iYXNlLCByYW1zdGFja190b3A7CiAJdW5z
aWduZWQgbG9uZyAqc3A7CiAJaW50IHJlczsKIAlpbnQgaSwgajsKQEAgLTg0NCwxMSArODY4LDEx
IEBACiAJc3RhY2tfbGVuICs9IChicHJtLT5hcmdjICsgMSkgKiBzaXplb2YoY2hhciAqKTsgLyog
dGhlIGFyZ3YgYXJyYXkgKi8KIAlzdGFja19sZW4gKz0gKGJwcm0tPmVudmMgKyAxKSAqIHNpemVv
ZihjaGFyICopOyAvKiB0aGUgZW52cCBhcnJheSAqLwogCi0JCi0JcmVzID0gbG9hZF9mbGF0X2Zp
bGUoYnBybSwgJmxpYmluZm8sIDAsICZzdGFja19sZW4pOworCWwxc3RhY2tfYmFzZSA9IDA7CisJ
cmVzID0gbG9hZF9mbGF0X2ZpbGUoYnBybSwgJmxpYmluZm8sIDAsICZzdGFja19sZW4sICZsMXN0
YWNrX2Jhc2UpOwogCWlmIChyZXMgPiAodW5zaWduZWQgbG9uZyktNDA5NikKIAkJcmV0dXJuIHJl
czsKLQkKKwogCS8qIFVwZGF0ZSBkYXRhIHNlZ21lbnQgcG9pbnRlcnMgZm9yIGFsbCBsaWJyYXJp
ZXMgKi8KIAlmb3IgKGk9MDsgaTxNQVhfU0hBUkVEX0xJQlM7IGkrKykKIAkJaWYgKGxpYmluZm8u
bGliX2xpc3RbaV0ubG9hZGVkKQpAQCAtODYzLDYgKzg4Nyw3IEBACiAJc2V0X2JpbmZtdCgmZmxh
dF9mb3JtYXQpOwogCiAJcCA9ICgoY3VycmVudC0+bW0tPmNvbnRleHQuZW5kX2JyayArIHN0YWNr
X2xlbiArIDMpICYgfjMpIC0gNDsKKwlyYW1zdGFja190b3AgPSBwOwogCURCR19GTFQoInA9JXhc
biIsIChpbnQpcCk7CiAKIAkvKiBjb3B5IHRoZSBhcmcgcGFnZXMgb250byB0aGUgc3RhY2ssIHRo
aXMgY291bGQgYmUgbW9yZSBlZmZpY2llbnQgOi0pICovCkBAIC04NzEsNyArODk2LDcgQEAKIAkJ
CSgoY2hhciAqKSBwYWdlX2FkZHJlc3MoYnBybS0+cGFnZVtpL1BBR0VfU0laRV0pKVtpICUgUEFH
RV9TSVpFXTsKIAogCXNwID0gKHVuc2lnbmVkIGxvbmcgKikgY3JlYXRlX2ZsYXRfdGFibGVzKHAs
IGJwcm0pOwotCQorCiAJLyogRmFrZSBzb21lIHJldHVybiBhZGRyZXNzZXMgdG8gZW5zdXJlIHRo
ZSBjYWxsIGNoYWluIHdpbGwKIAkgKiBpbml0aWFsaXNlIGxpYnJhcnkgaW4gb3JkZXIgZm9yIHVz
LiAgV2UgYXJlIHJlcXVpcmVkIHRvIGNhbGwKIAkgKiBsaWIgMSBmaXJzdCwgdGhlbiAyLCAuLi4g
YW5kIGZpbmFsbHkgdGhlIG1haW4gcHJvZ3JhbSAoaWQgMCkuCkBAIC04ODcsMTUgKzkxMiwyNCBA
QAogCQl9CiAJfQogI2VuZGlmCi0JCisKIAkvKiBTdGFzaCBvdXIgaW5pdGlhbCBzdGFjayBwb2lu
dGVyIGludG8gdGhlIG1tIHN0cnVjdHVyZSAqLwogCWN1cnJlbnQtPm1tLT5zdGFydF9zdGFjayA9
ICh1bnNpZ25lZCBsb25nIClzcDsKIAotCQotCURCR19GTFQoInN0YXJ0X3RocmVhZChyZWdzPTB4
JXgsIGVudHJ5PTB4JXgsIHN0YXJ0X3N0YWNrPTB4JXgpXG4iLAotCQkoaW50KXJlZ3MsIChpbnQp
c3RhcnRfYWRkciwgKGludCljdXJyZW50LT5tbS0+c3RhcnRfc3RhY2spOwotCQotCXN0YXJ0X3Ro
cmVhZChyZWdzLCBzdGFydF9hZGRyLCBjdXJyZW50LT5tbS0+c3RhcnRfc3RhY2spOworCWlmIChs
MXN0YWNrX2Jhc2UpIHsKKwkJLyogRmluZCBMMSBzdGFjayBwb2ludGVyIGNvcnJlc3BvbmRpbmcg
dG8gdGhlIGN1cnJlbnQgYm90dG9tCisJCSAgIG9mIHRoZSBzdGFjayBpbiBub3JtYWwgUkFNLiAg
Ki8KKwkJbDFzdGFja19iYXNlICs9IHN0YWNrX2xlbiAtIChyYW1zdGFja190b3AgLSAodW5zaWdu
ZWQgbG9uZylzcCk7CisJCWlmICghYWN0aXZhdGVfbDFzdGFjayhjdXJyZW50LT5tbSwgcmFtc3Rh
Y2tfdG9wIC0gc3RhY2tfbGVuKSkKKwkJCWwxc3RhY2tfYmFzZSA9IDA7CisJfQorCisJREJHX0ZM
VCgic3RhcnRfdGhyZWFkKHJlZ3M9MHgleCwgZW50cnk9MHgleCwgc3RhcnRfc3RhY2s9MHgleCwg
bDFzdGs9MHgleCwgbGVuIDB4JXgpXG4iLAorCQkoaW50KXJlZ3MsIChpbnQpc3RhcnRfYWRkciwg
KGludCljdXJyZW50LT5tbS0+c3RhcnRfc3RhY2ssIGwxc3RhY2tfYmFzZSwKKwkJc3RhY2tfbGVu
KTsKKworCXN0YXJ0X3RocmVhZChyZWdzLCBzdGFydF9hZGRyLAorCQkgICAgIGwxc3RhY2tfYmFz
ZSA/IGwxc3RhY2tfYmFzZSA6IGN1cnJlbnQtPm1tLT5zdGFydF9zdGFjayk7CiAKIAlpZiAoY3Vy
cmVudC0+cHRyYWNlICYgUFRfUFRSQUNFRCkKIAkJc2VuZF9zaWcoU0lHVFJBUCwgY3VycmVudCwg
MCk7CmRpZmYgLXVyTiBsaW51eC0yLjYuMTgucGF0Y2gyL2luY2x1ZGUvYXNtLWFybS9tbXUuaCBs
aW51eC0yLjYuMTgucGF0Y2gzL2luY2x1ZGUvYXNtLWFybS9tbXUuaAotLS0gbGludXgtMi42LjE4
LnBhdGNoMi9pbmNsdWRlL2FzbS1hcm0vbW11LmgJMjAwNi0wOS0yMSAwOTozNzoyNC4wMDAwMDAw
MDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOC5wYXRjaDMvaW5jbHVkZS9hc20tYXJtL21tdS5oCTIw
MDYtMDktMjEgMDk6NTI6MDIuMDAwMDAwMDAwICswODAwCkBAIC0yNiw2ICsyNiw3IEBACiB0eXBl
ZGVmIHN0cnVjdCB7CiAJc3RydWN0IHZtX2xpc3Rfc3RydWN0CSp2bWxpc3Q7CiAJdW5zaWduZWQg
bG9uZwkJZW5kX2JyazsKKwl1bnNpZ25lZCBsb25nCQlzdGFja19zdGFydDsKIH0gbW1fY29udGV4
dF90OwogCiAjZW5kaWYKZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9hc20t
ZnJ2L21tdS5oIGxpbnV4LTIuNi4xOC5wYXRjaDMvaW5jbHVkZS9hc20tZnJ2L21tdS5oCi0tLSBs
aW51eC0yLjYuMTgucGF0Y2gyL2luY2x1ZGUvYXNtLWZydi9tbXUuaAkyMDA2LTA5LTIxIDA5OjM3
OjI1LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMy9pbmNsdWRlL2FzbS1m
cnYvbW11LmgJMjAwNi0wOS0yMSAwOTo1MjowMi4wMDAwMDAwMDAgKzA4MDAKQEAgLTI0LDYgKzI0
LDcgQEAKICNlbHNlCiAJc3RydWN0IHZtX2xpc3Rfc3RydWN0CSp2bWxpc3Q7CiAJdW5zaWduZWQg
bG9uZwkJZW5kX2JyazsKKwl1bnNpZ25lZCBsb25nCQlzdGFja19zdGFydDsKIAogI2VuZGlmCiAK
ZGlmZiAtdXJOIGxpbnV4LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9hc20taDgzMDAvbW11LmggbGlu
dXgtMi42LjE4LnBhdGNoMy9pbmNsdWRlL2FzbS1oODMwMC9tbXUuaAotLS0gbGludXgtMi42LjE4
LnBhdGNoMi9pbmNsdWRlL2FzbS1oODMwMC9tbXUuaAkyMDA2LTA5LTIxIDA5OjM3OjI2LjAwMDAw
MDAwMCArMDgwMAorKysgbGludXgtMi42LjE4LnBhdGNoMy9pbmNsdWRlL2FzbS1oODMwMC9tbXUu
aAkyMDA2LTA5LTIxIDA5OjUyOjAyLjAwMDAwMDAwMCArMDgwMApAQCAtNiw2ICs2LDcgQEAKIHR5
cGVkZWYgc3RydWN0IHsKIAlzdHJ1Y3Qgdm1fbGlzdF9zdHJ1Y3QJKnZtbGlzdDsKIAl1bnNpZ25l
ZCBsb25nCQllbmRfYnJrOworCXVuc2lnbmVkIGxvbmcJCXN0YWNrX3N0YXJ0OwogfSBtbV9jb250
ZXh0X3Q7CiAKICNlbmRpZgpkaWZmIC11ck4gbGludXgtMi42LjE4LnBhdGNoMi9pbmNsdWRlL2Fz
bS1tMzJyL21tdS5oIGxpbnV4LTIuNi4xOC5wYXRjaDMvaW5jbHVkZS9hc20tbTMyci9tbXUuaAot
LS0gbGludXgtMi42LjE4LnBhdGNoMi9pbmNsdWRlL2FzbS1tMzJyL21tdS5oCTIwMDYtMDktMjEg
MDk6Mzc6MjYuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTgucGF0Y2gzL2luY2x1ZGUv
YXNtLW0zMnIvbW11LmgJMjAwNi0wOS0yMSAwOTo1MjowMi4wMDAwMDAwMDAgKzA4MDAKQEAgLTYs
NiArNiw3IEBACiB0eXBlZGVmIHN0cnVjdCB7CiAJc3RydWN0IHZtX2xpc3Rfc3RydWN0CSp2bWxp
c3Q7CiAJdW5zaWduZWQgbG9uZwkJZW5kX2JyazsKKwl1bnNpZ25lZCBsb25nCQlzdGFja19zdGFy
dDsKIH0gbW1fY29udGV4dF90OwogI2Vsc2UKIApkaWZmIC11ck4gbGludXgtMi42LjE4LnBhdGNo
Mi9pbmNsdWRlL2FzbS1tNjhrbm9tbXUvbW11LmggbGludXgtMi42LjE4LnBhdGNoMy9pbmNsdWRl
L2FzbS1tNjhrbm9tbXUvbW11LmgKLS0tIGxpbnV4LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9hc20t
bTY4a25vbW11L21tdS5oCTIwMDYtMDktMjEgMDk6Mzc6MjYuMDAwMDAwMDAwICswODAwCisrKyBs
aW51eC0yLjYuMTgucGF0Y2gzL2luY2x1ZGUvYXNtLW02OGtub21tdS9tbXUuaAkyMDA2LTA5LTIx
IDA5OjUyOjAyLjAwMDAwMDAwMCArMDgwMApAQCAtNiw2ICs2LDcgQEAKIHR5cGVkZWYgc3RydWN0
IHsKIAlzdHJ1Y3Qgdm1fbGlzdF9zdHJ1Y3QJKnZtbGlzdDsKIAl1bnNpZ25lZCBsb25nCQllbmRf
YnJrOworCXVuc2lnbmVkIGxvbmcJCXN0YWNrX3N0YXJ0OwogfSBtbV9jb250ZXh0X3Q7CiAKICNl
bmRpZiAvKiBfX002OEtOT01NVV9NTVVfSCAqLwpkaWZmIC11ck4gbGludXgtMi42LjE4LnBhdGNo
Mi9pbmNsdWRlL2FzbS1zaC9tbXUuaCBsaW51eC0yLjYuMTgucGF0Y2gzL2luY2x1ZGUvYXNtLXNo
L21tdS5oCi0tLSBsaW51eC0yLjYuMTgucGF0Y2gyL2luY2x1ZGUvYXNtLXNoL21tdS5oCTIwMDYt
MDktMjEgMDk6Mzc6MjYuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTgucGF0Y2gzL2lu
Y2x1ZGUvYXNtLXNoL21tdS5oCTIwMDYtMDktMjEgMDk6NTI6MDIuMDAwMDAwMDAwICswODAwCkBA
IC0xNyw2ICsxNyw3IEBACiB0eXBlZGVmIHN0cnVjdCB7CiAJc3RydWN0IG1tX3RibG9ja19zdHJ1
Y3QgdGJsb2NrOwogCXVuc2lnbmVkIGxvbmcJCWVuZF9icms7CisJdW5zaWduZWQgbG9uZwkJc3Rh
Y2tfc3RhcnQ7CiB9IG1tX2NvbnRleHRfdDsKIAogI2Vsc2UKZGlmZiAtdXJOIGxpbnV4LTIuNi4x
OC5wYXRjaDIvaW5jbHVkZS9hc20tdjg1MC9tbXUuaCBsaW51eC0yLjYuMTgucGF0Y2gzL2luY2x1
ZGUvYXNtLXY4NTAvbW11LmgKLS0tIGxpbnV4LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9hc20tdjg1
MC9tbXUuaAkyMDA2LTA5LTIxIDA5OjM3OjI3LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42
LjE4LnBhdGNoMy9pbmNsdWRlL2FzbS12ODUwL21tdS5oCTIwMDYtMDktMjEgMDk6NTI6MDIuMDAw
MDAwMDAwICswODAwCkBAIC02LDYgKzYsNyBAQAogdHlwZWRlZiBzdHJ1Y3QgewogCXN0cnVjdCB2
bV9saXN0X3N0cnVjdAkqdm1saXN0OwogCXVuc2lnbmVkIGxvbmcJCWVuZF9icms7CisJdW5zaWdu
ZWQgbG9uZwkJc3RhY2tfc3RhcnQ7CiB9IG1tX2NvbnRleHRfdDsKIAogI2VuZGlmIC8qIF9fVjg1
MF9NTVVfSF9fICovCmRpZmYgLXVyTiBsaW51eC0yLjYuMTgucGF0Y2gyL2luY2x1ZGUvbGludXgv
ZmxhdC5oIGxpbnV4LTIuNi4xOC5wYXRjaDMvaW5jbHVkZS9saW51eC9mbGF0LmgKLS0tIGxpbnV4
LTIuNi4xOC5wYXRjaDIvaW5jbHVkZS9saW51eC9mbGF0LmgJMjAwNi0wOS0yMSAwOTozNzoyNy4w
MDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi4xOC5wYXRjaDMvaW5jbHVkZS9saW51eC9mbGF0
LmgJMjAwNi0wOS0yMSAwOTo1MjowMi4wMDAwMDAwMDAgKzA4MDAKQEAgLTEwLDYgKzEwLDEzIEBA
CiAjaWZuZGVmIF9MSU5VWF9GTEFUX0gKICNkZWZpbmUgX0xJTlVYX0ZMQVRfSAogCisjZGVmaW5l
IEZMQVRfRkxBR19SQU0gICAgMHgwMDAxIC8qIGxvYWQgcHJvZ3JhbSBlbnRpcmVseSBpbnRvIFJB
TSAqLworI2RlZmluZSBGTEFUX0ZMQUdfR09UUElDIDB4MDAwMiAvKiBwcm9ncmFtIGlzIFBJQyB3
aXRoIEdPVCAqLworI2RlZmluZSBGTEFUX0ZMQUdfR1pJUCAgIDB4MDAwNCAvKiBhbGwgYnV0IHRo
ZSBoZWFkZXIgaXMgY29tcHJlc3NlZCAqLworI2RlZmluZSBGTEFUX0ZMQUdfR1pEQVRBIDB4MDAw
OCAvKiBvbmx5IGRhdGEvcmVsb2NzIGFyZSBjb21wcmVzc2VkIChmb3IgWElQKSAqLworI2RlZmlu
ZSBGTEFUX0ZMQUdfS1RSQUNFIDB4MDAxMCAvKiBvdXRwdXQgdXNlZnVsIGtlcm5lbCB0cmFjZSBm
b3IgZGVidWdnaW5nICovCisjZGVmaW5lIEZMQVRfRkxBR19MMVNUSyAgMHgwMDIwIC8qIHVzZSBh
IDRrIHN0YWNrIGluIEwxIHNjcmF0Y2ggbWVtb3J5LiAgKi8KKwogI2lmZGVmIF9fS0VSTkVMX18K
ICNpbmNsdWRlIDxhc20vZmxhdC5oPgogI2VuZGlmCkBAIC01MCwxMiArNTcsNiBAQAogCXVuc2ln
bmVkIGxvbmcgZmlsbGVyWzVdOyAgICAvKiBSZXNlcnZlcmVkLCBzZXQgdG8gemVybyAqLwogfTsK
IAotI2RlZmluZSBGTEFUX0ZMQUdfUkFNICAgIDB4MDAwMSAvKiBsb2FkIHByb2dyYW0gZW50aXJl
bHkgaW50byBSQU0gKi8KLSNkZWZpbmUgRkxBVF9GTEFHX0dPVFBJQyAweDAwMDIgLyogcHJvZ3Jh
bSBpcyBQSUMgd2l0aCBHT1QgKi8KLSNkZWZpbmUgRkxBVF9GTEFHX0daSVAgICAweDAwMDQgLyog
YWxsIGJ1dCB0aGUgaGVhZGVyIGlzIGNvbXByZXNzZWQgKi8KLSNkZWZpbmUgRkxBVF9GTEFHX0da
REFUQSAweDAwMDggLyogb25seSBkYXRhL3JlbG9jcyBhcmUgY29tcHJlc3NlZCAoZm9yIFhJUCkg
Ki8KLSNkZWZpbmUgRkxBVF9GTEFHX0tUUkFDRSAweDAwMTAgLyogb3V0cHV0IHVzZWZ1bCBrZXJu
ZWwgdHJhY2UgZm9yIGRlYnVnZ2luZyAqLwotCiAKICNpZmRlZiBfX0tFUk5FTF9fIC8qIHNvIHN5
c3RlbXMgd2l0aG91dCBsaW51eCBoZWFkZXJzIGNhbiBjb21waWxlIHRoZSBhcHBzICovCiAvKgo=

------=_Part_14276_27686507.1158809600324--
