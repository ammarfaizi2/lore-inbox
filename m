Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263702AbUECSCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUECSCd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUECSCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:02:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:36054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263702AbUECR6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 13:58:18 -0400
Date: Mon, 3 May 2004 10:57:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Reiser <jreiser@BitWagon.com>
Cc: pj@sgi.com, mike@navi.cx, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: arch/ia64/ia32/binfmt_elf32.c: elf32_map() broken ia64 build
 _and_ boot
Message-Id: <20040503105748.0acbb216.akpm@osdl.org>
In-Reply-To: <4096526C.4060503@BitWagon.com>
References: <20040426185633.7969ca0d.pj@sgi.com>
	<20040501013304.32a750d3.pj@sgi.com>
	<4096526C.4060503@BitWagon.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Reiser <jreiser@BitWagon.com> wrote:
>
> >   /sbin/init: ELF 64-bit LSB executable, IA-64, version 1 (SYSV),
>  >   for GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped
> 
>  This indicates a problem with the very first execve() and/or its shared
>  libraries.  It is likely that printk() of the arguments and results
>  to elf_map() and load_elf_interp(), both in fs/binfmt_elf.c,
>  will aid in finding the problem.  This I would do, if I had hardware.
> 
>  Are there any reports, either success or failure, for any other 64-bit
>  architecture?

It worked OK on ppc64 but I also was having ia64 problems so I dropped the
patch.  The final version is below.

It could do with a rethink.  Is there not some simpler way of doing this?




From: John Reiser <jreiser@BitWagon.com>

The problem:

Mike Hearn <mike@navi.cx> reports:

Ihere is a problem in fs/binfmt_elf.c, around line 700.

When mapping a nobits PT_LOAD segment with a memsize > filesize, the kernel
calls set_brk (which in turns calls do_brk) to map and clear the area, but
this discards access permissons on the mapping leading to rwx protection. 
This causes a load failure on systems where the VM cannot reserve swap space
for the segment, unless overcommit is active (on many systems it's not on by
default).

It seems that this discarding of access permissions on the unlikely codepath
is incorrect.

The ability to define a new (large) ELF section which isn't backed by swap
space nor disk space and that will be mapped to a specific VMA range is needed
by Wine to reserve the PE load area.  

Currently the fact that the section is always mapped rwx despite being marked
read-only in the binary prevents us from using this as a solution to the
problems caused by exec-shield/prelink, meaning the only solution is to
bootstrap the ELF interpreter ourselves from a statically linked binary. 
Clearly we'd rather not do that.

Thanks to pageexec@freemail.hu for bringing the matter to my attention.

[1] http://bugzilla.kernel.org/show_bug.cgi?id=2255


The patch:

- do_brk(): new parameter vm_inhibit turns off permissions from
  VM_DATA_DEFAULT_FLAGS; default to 0.  defined in mm/mmap.c, mm/nommu.c;
  header include/linux/mm.h; used in fs/binfmt_aout.c, fs/binfmt_elf.c. 
  Propagate through set_brk() in fs/binfmt_aout.c and fs/binfmt_elf.c.

- total_mapping_size(): new routine computes length of minimal single
  interval that covers all the PT_LOAD, for ease and safety in placement when
  there are holes between PT_LOAD.  Defined in fs/binfmt_elf.c; used there and
  arch/x86_64/ia32/ia32_binfmt.c, arch/s390/kernel/binfmt_elf32.c.  Copied or
  derived from Fedora Core 2 kernel-2.6.5-1.308.src.rpm and later, whose
  license is GPLv2 or later.

- do_bss_pages(): do not set current->mm->brk, to allow for use by multiple
  .bss (local to each PT_LOAD), and by both main ELF program and ELF program
  interpreter; in fs/binfmt_elf.c.

- padzero(): return number of bytes that were written; in fs/binfmt_elf.c.

- calc_bss_inhibit(): new routine computes VM_* bits for .bss; fs/binfmt_elf.c.

- elf_map(): new parameter total_size allows for holes between PT_LOAD; in
  fs/binfmt_elf.c, arch/x86_64/ia32/ia32_binfmt.c, arch/s390/kernel/
  binfmt_elf32.c.

- load_elf_binary(): create a local .bss for each PT_LOAD when .p_memsz >
  .p_filesz, and honor the protection in .p_flags, using new parameter to
  do_brk().  Set current->mm->brk.  In fs/binfmt_elf.c.

- load_elf_interp(): handle local .bss similar to load_elf_binary().  In
  fs/binfmt_elf.c.


---

 25-akpm/arch/ia64/ia32/binfmt_elf32.c       |    3 
 25-akpm/arch/ia64/kernel/sys_ia64.c         |    2 
 25-akpm/arch/mips/kernel/irixelf.c          |    8 -
 25-akpm/arch/mips/kernel/sysirix.c          |    2 
 25-akpm/arch/s390/kernel/binfmt_elf32.c     |   21 ++
 25-akpm/arch/sparc/kernel/sys_sunos.c       |    2 
 25-akpm/arch/sparc64/kernel/binfmt_aout32.c |   14 +
 25-akpm/arch/sparc64/kernel/sys_sunos32.c   |    2 
 25-akpm/arch/x86_64/ia32/ia32_aout.c        |   14 +
 25-akpm/arch/x86_64/ia32/ia32_binfmt.c      |   20 +-
 25-akpm/fs/binfmt_aout.c                    |   23 +-
 25-akpm/fs/binfmt_elf.c                     |  224 +++++++++++++++-------------
 25-akpm/include/linux/mm.h                  |    2 
 25-akpm/mm/mmap.c                           |    7 
 25-akpm/mm/nommu.c                          |    2 
 15 files changed, 201 insertions(+), 145 deletions(-)

diff -puN arch/s390/kernel/binfmt_elf32.c~bssprot arch/s390/kernel/binfmt_elf32.c
--- 25/arch/s390/kernel/binfmt_elf32.c~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/arch/s390/kernel/binfmt_elf32.c	Sun May  2 02:42:19 2004
@@ -189,18 +189,29 @@ jiffies_to_compat_timeval(unsigned long 
 #include "../../../fs/binfmt_elf.c"
 
 static unsigned long
-elf_map32 (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf_map32 (struct file *filep, unsigned long addr, struct elf_phdr const *eppnt, int prot, int type, unsigned long total_size)
 {
 	unsigned long map_addr;
+	unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
+	unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	addr = ELF_PAGESTART(addr);
+	size = ELF_PAGEALIGN(size);
 
 	if (!addr) 
 		addr = TASK_UNMAPPED_BASE;
 
 	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr),
-			   prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+
+	/* total_size allows for holes between PT_LOAD */
+	if (total_size) {
+		total_size = ELF_PAGEALIGN(total_size);
+		map_addr = do_mmap(filep, addr, total_size, prot, type, off);
+		if (!BAD_ADDR(map_addr))
+			do_munmap(current->mm, map_addr+size, total_size-size);
+	} else
+		map_addr = do_mmap(filep, addr, size, prot, type, off);
+
 	up_write(&current->mm->mmap_sem);
 	return(map_addr);
 }
diff -puN arch/x86_64/ia32/ia32_aout.c~bssprot arch/x86_64/ia32/ia32_aout.c
--- 25/arch/x86_64/ia32/ia32_aout.c~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/arch/x86_64/ia32/ia32_aout.c	Sun May  2 02:42:36 2004
@@ -113,7 +113,7 @@ static void set_brk(unsigned long start,
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
-	do_brk(start, end - start);
+	do_brk(start, end - start, VM_DATA_DEFAULT_FLAGS);
 }
 
 #if CORE_DUMP
@@ -322,7 +322,8 @@ static int load_aout_binary(struct linux
 		pos = 32;
 		map_size = ex.a_text+ex.a_data;
 
-		error = do_brk(text_addr & PAGE_MASK, map_size);
+		error = do_brk(text_addr&PAGE_MASK, map_size,
+					VM_DATA_DEFAULT_FLAGS);
 		if (error != (text_addr & PAGE_MASK)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -358,7 +359,8 @@ static int load_aout_binary(struct linux
 
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
 			loff_t pos = fd_offset;
-			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data,
+					VM_DATA_DEFAULT_FLAGS);
 			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
 			flush_icache_range((unsigned long) N_TXTADDR(ex),
@@ -467,7 +469,8 @@ static int load_aout_library(struct file
 		}
 #endif
 
-		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss,
+				VM_DATA_DEFAULT_FLAGS);
 		
 		file->f_op->read(file, (char *)start_addr,
 			ex.a_text + ex.a_data, &pos);
@@ -491,7 +494,8 @@ static int load_aout_library(struct file
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
-		error = do_brk(start_addr + len, bss - len);
+		error = do_brk(start_addr + len, bss - len,
+					VM_DATA_DEFAULT_FLAGS);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -puN arch/x86_64/ia32/ia32_binfmt.c~bssprot arch/x86_64/ia32/ia32_binfmt.c
--- 25/arch/x86_64/ia32/ia32_binfmt.c~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/arch/x86_64/ia32/ia32_binfmt.c	Sun May  2 02:42:19 2004
@@ -385,19 +385,29 @@ int setup_arg_pages(struct linux_binprm 
 }
 
 static unsigned long
-elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf32_map (struct file *filep, unsigned long addr, struct elf_phdr const *eppnt, int prot, int type, unsigned long total_size)
 {
 	unsigned long map_addr;
 	struct task_struct *me = current; 
+	unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
+	unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
 
 	if (prot & PROT_READ) 
 		prot |= vm_force_exec32;
 
+	addr = ELF_PAGESTART(addr);
+	size = ELF_PAGEALIGN(size);
+
 	down_write(&me->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, 
-			   type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+
+	/* total_size allows for holes between PT_LOAD */
+	if (total_size) {
+		total_size = ELF_PAGEALIGN(total_size);
+		map_addr = do_mmap(filep, addr, total_size, prot, type, off);
+		if (!BAD_ADDR(map_addr))
+			do_munmap(me->mm, map_addr+size, total_size-size);
+	} else
+		map_addr = do_mmap(filep, addr, size, prot, type, off);
 	up_write(&me->mm->mmap_sem);
 	return(map_addr);
 }
diff -puN fs/binfmt_aout.c~bssprot fs/binfmt_aout.c
--- 25/fs/binfmt_aout.c~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/fs/binfmt_aout.c	Sun May  2 02:42:36 2004
@@ -43,13 +43,13 @@ static struct linux_binfmt aout_format =
 	.min_coredump	= PAGE_SIZE
 };
 
-static void set_brk(unsigned long start, unsigned long end)
+static void set_brk(unsigned long start, unsigned long end, unsigned flags)
 {
 	start = PAGE_ALIGN(start);
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
-	do_brk(start, end - start);
+	do_brk(start, end - start, flags);
 }
 
 /*
@@ -317,10 +317,10 @@ static int load_aout_binary(struct linux
 		loff_t pos = fd_offset;
 		/* Fuck me plenty... */
 		/* <AOL></AOL> */
-		error = do_brk(N_TXTADDR(ex), ex.a_text);
+		error = do_brk(N_TXTADDR(ex), ex.a_text, VM_DATA_DEFAULT_FLAGS);
 		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
 			  ex.a_text, &pos);
-		error = do_brk(N_DATADDR(ex), ex.a_data);
+		error = do_brk(N_DATADDR(ex), ex.a_data, VM_DATA_DEFAULT_FLAGS);
 		bprm->file->f_op->read(bprm->file, (char *) N_DATADDR(ex),
 			  ex.a_data, &pos);
 		goto beyond_if;
@@ -341,7 +341,8 @@ static int load_aout_binary(struct linux
 		map_size = ex.a_text+ex.a_data;
 #endif
 
-		error = do_brk(text_addr & PAGE_MASK, map_size);
+		error = do_brk(text_addr & PAGE_MASK, map_size,
+					VM_DATA_DEFAULT_FLAGS);
 		if (error != (text_addr & PAGE_MASK)) {
 			send_sig(SIGKILL, current, 0);
 			return error;
@@ -375,7 +376,8 @@ static int load_aout_binary(struct linux
 
 		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
 			loff_t pos = fd_offset;
-			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
+			do_brk(N_TXTADDR(ex), ex.a_text+ex.a_data,
+						VM_DATA_DEFAULT_FLAGS);
 			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
 					ex.a_text+ex.a_data, &pos);
 			flush_icache_range((unsigned long) N_TXTADDR(ex),
@@ -410,7 +412,8 @@ static int load_aout_binary(struct linux
 beyond_if:
 	set_binfmt(&aout_format);
 
-	set_brk(current->mm->start_brk, current->mm->brk);
+	set_brk(current->mm->start_brk, current->mm->brk,
+			VM_DATA_DEFAULT_FLAGS);
 
 	retval = setup_arg_pages(bprm, EXSTACK_DEFAULT);
 	if (retval < 0) { 
@@ -476,7 +479,8 @@ static int load_aout_library(struct file
 			error_time = jiffies;
 		}
 
-		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
+		do_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss,
+				VM_DATA_DEFAULT_FLAGS);
 		
 		file->f_op->read(file, (char *)start_addr,
 			ex.a_text + ex.a_data, &pos);
@@ -500,7 +504,8 @@ static int load_aout_library(struct file
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
-		error = do_brk(start_addr + len, bss - len);
+		error = do_brk(start_addr + len, bss - len,
+				VM_DATA_DEFAULT_FLAGS);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -puN fs/binfmt_elf.c~bssprot fs/binfmt_elf.c
--- 25/fs/binfmt_elf.c~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/fs/binfmt_elf.c	Sun May  2 02:42:36 2004
@@ -45,7 +45,7 @@
 
 static int load_elf_binary(struct linux_binprm * bprm, struct pt_regs * regs);
 static int load_elf_library(struct file*);
-static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
+static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr const *, int, int, unsigned long);
 extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 
 #ifndef elf_addr_t
@@ -82,16 +82,36 @@ static struct linux_binfmt elf_format = 
 
 #define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
 
-static int set_brk(unsigned long start, unsigned long end)
+static inline unsigned long
+total_mapping_size(struct elf_phdr const *cmds, int nr)
+{
+	unsigned long lo = ~0UL, hi = 0UL;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (cmds[i].p_type == PT_LOAD) {
+			if (lo > cmds[i].p_vaddr)
+				lo = cmds[i].p_vaddr;
+			if (hi < (cmds[i].p_vaddr + cmds[i].p_memsz))
+				hi = cmds[i].p_vaddr + cmds[i].p_memsz;
+		}
+	}
+
+	if (hi == 0)
+		return 0;
+
+	return hi - ELF_PAGESTART(lo);
+}
+
+static int do_bss_pages(unsigned long start, unsigned long end, unsigned flags)
 {
 	start = ELF_PAGEALIGN(start);
 	end = ELF_PAGEALIGN(end);
 	if (end > start) {
-		unsigned long addr = do_brk(start, end - start);
+		unsigned long addr = do_brk(start, end - start, flags);
 		if (BAD_ADDR(addr))
 			return addr;
 	}
-	current->mm->start_brk = current->mm->brk = end;
 	return 0;
 }
 
@@ -102,7 +122,7 @@ static int set_brk(unsigned long start, 
    be in memory */
 
 
-static void padzero(unsigned long elf_bss)
+static unsigned long padzero(unsigned long elf_bss)
 {
 	unsigned long nbyte;
 
@@ -111,6 +131,19 @@ static void padzero(unsigned long elf_bs
 		nbyte = ELF_MIN_ALIGN - nbyte;
 		clear_user((void *) elf_bss, nbyte);
 	}
+	return nbyte;
+}
+
+static /*inline*/ unsigned int
+calc_bss_inhibit(struct elf_phdr const *phdr, unsigned elf_prot)
+{
+	unsigned vm_inhib = (VM_READ|VM_WRITE|VM_EXEC) ^ calc_vm_prot_bits(elf_prot);
+  /* Can readonly .data have associated read+write .bss ?
+  //	if (phdr->p_filesz && !(phdr->p_flags & PF_W)) {
+  //		vm_inhib &= ~VM_WRITE;
+  //	}
+  */
+	return vm_inhib;
 }
 
 /* Let's use some macros to make this stack manipulation a litle clearer */
@@ -270,16 +303,36 @@ create_elf_tables(struct linux_binprm *b
 #ifndef elf_map
 
 static unsigned long elf_map(struct file *filep, unsigned long addr,
-			struct elf_phdr *eppnt, int prot, int type)
+			     struct elf_phdr const *eppnt, int prot, int type,
+			     unsigned long total_size)
 {
 	unsigned long map_addr;
+	unsigned long size = eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr);
+	unsigned long off = eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr);
+
+	addr = ELF_PAGESTART(addr);
+	size = ELF_PAGEALIGN(size);
 
 	down_write(&current->mm->mmap_sem);
-	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
-			   eppnt->p_filesz + ELF_PAGEOFFSET(eppnt->p_vaddr), prot, type,
-			   eppnt->p_offset - ELF_PAGEOFFSET(eppnt->p_vaddr));
+
+	/*
+	 * total_size is the size of the ELF (interpreter) image.
+	 * The _first_ mmap needs to know the full size, otherwise
+	 * randomization might put this image into an overlapping
+	 * position with the ELF binary image. (since size < total_size)
+	 * So we first map the 'big' image - and unmap the remainder at
+	 * the end. (which unmap is needed for ELF images with holes.)
+	 */
+	if (total_size) {
+		total_size = ELF_PAGEALIGN(total_size);
+		map_addr = do_mmap(filep, addr, total_size, prot, type, off);
+		if (!BAD_ADDR(map_addr))
+			do_munmap(current->mm, map_addr+size, total_size-size);
+	} else
+		map_addr = do_mmap(filep, addr, size, prot, type, off);
+
 	up_write(&current->mm->mmap_sem);
-	return(map_addr);
+	return map_addr;
 }
 
 #endif /* !elf_map */
@@ -297,7 +350,7 @@ static unsigned long load_elf_interp(str
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
+	unsigned long elf_bss;
 	unsigned long error = ~0UL;
 	int retval, i, size;
 
@@ -338,17 +391,16 @@ static unsigned long load_elf_interp(str
 	  if (eppnt->p_type == PT_LOAD) {
 	    int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
 	    int elf_prot = 0;
-	    unsigned long vaddr = 0;
+	    unsigned long const vaddr = eppnt->p_vaddr;
 	    unsigned long k, map_addr;
 
 	    if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
 	    if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
 	    if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
-	    vaddr = eppnt->p_vaddr;
 	    if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
 	    	elf_type |= MAP_FIXED;
 
-	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type);
+	    map_addr = elf_map(interpreter, load_addr + vaddr, eppnt, elf_prot, elf_type, 0);
 	    error = map_addr;
 	    if (BAD_ADDR(map_addr))
 	    	goto out_close;
@@ -363,47 +415,33 @@ static unsigned long load_elf_interp(str
 	     * allowed task size. Note that p_filesz must always be
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
-	    k = load_addr + eppnt->p_vaddr;
+	    k = load_addr + vaddr;
 	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
 		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
 	        error = -ENOMEM;
 		goto out_close;
 	    }
 
-	    /*
-	     * Find the end of the file mapping for this phdr, and keep
-	     * track of the largest address we see for this.
-	     */
-	    k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-	    if (k > elf_bss)
-		elf_bss = k;
-
-	    /*
-	     * Do the same thing for the memory mapping - between
-	     * elf_bss and last_bss is the bss section.
-	     */
-	    k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
-	    if (k > last_bss)
-		last_bss = k;
+	    elf_bss = vaddr + eppnt->p_filesz;  /* un-biased start of .bss */
+	    k       = vaddr + eppnt->p_memsz;   /* un-biased end of .bss */
+	    if (elf_bss < k) {
+	    	/* .bss: clear the low fragment; map anonymous pages. */
+	    	elf_bss += load_addr;
+
+	    	/* FIXME: !PF_W ==> must PROT_WRITE one page */
+	    	if (eppnt->p_flags & PF_W)
+	    		elf_bss += padzero(elf_bss);
+
+	    	error = do_bss_pages(elf_bss, load_addr + k,
+	    			VM_DATA_DEFAULT_FLAGS &
+					~calc_bss_inhibit(eppnt, elf_prot));
+	    	if (error) {
+	    		goto out_close;
+	    	}
+	    }
 	  }
 	}
 
-	/*
-	 * Now fill out the bss section.  First pad the last page up
-	 * to the page boundary, and then perform a mmap to make sure
-	 * that there are zero-mapped pages up to and including the 
-	 * last bss page.
-	 */
-	padzero(elf_bss);
-	elf_bss = ELF_PAGESTART(elf_bss + ELF_MIN_ALIGN - 1);	/* What we have mapped so far */
-
-	/* Map the last of the bss segment */
-	if (last_bss > elf_bss) {
-		error = do_brk(elf_bss, last_bss - elf_bss);
-		if (BAD_ADDR(error))
-			goto out_close;
-	}
-
 	*interp_load_addr = load_addr;
 	error = ((unsigned long) interp_elf_ex->e_entry) + load_addr;
 
@@ -439,7 +477,7 @@ static unsigned long load_aout_interp(st
 		goto out;
 	}
 
-	do_brk(0, text_data);
+	do_brk(0, text_data, VM_DATA_DEFAULT_FLAGS);
 	if (!interpreter->f_op || !interpreter->f_op->read)
 		goto out;
 	if (interpreter->f_op->read(interpreter, addr, text_data, &offset) < 0)
@@ -447,8 +485,8 @@ static unsigned long load_aout_interp(st
 	flush_icache_range((unsigned long)addr,
 	                   (unsigned long)addr + text_data);
 
-	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1),
-		interp_ex->a_bss);
+	do_brk(ELF_PAGESTART(text_data + ELF_MIN_ALIGN - 1), interp_ex->a_bss,
+				VM_DATA_DEFAULT_FLAGS);
 	elf_entry = interp_ex->a_entry;
 
 out:
@@ -473,9 +511,9 @@ static int load_elf_binary(struct linux_
 	char * elf_interpreter = NULL;
 	unsigned int interpreter_type = INTERPRETER_NONE;
 	unsigned char ibcs2_interpreter = 0;
-	unsigned long error;
-	struct elf_phdr * elf_ppnt, *elf_phdata;
-	unsigned long elf_bss, elf_brk;
+	struct elf_phdr const * elf_ppnt, *elf_phdata;
+	unsigned long elf_brk;
+	unsigned long total_size;
 	int elf_exec_fileno;
 	int retval, i;
 	unsigned int size;
@@ -539,7 +577,6 @@ static int load_elf_binary(struct linux_
 	fd_install(elf_exec_fileno = retval, bprm->file);
 
 	elf_ppnt = elf_phdata;
-	elf_bss = 0;
 	elf_brk = 0;
 
 	start_code = ~0UL;
@@ -709,33 +746,15 @@ static int load_elf_binary(struct linux_
 	   the image should be loaded at fixed address, not at a variable
 	   address. */
 
+	total_size = total_mapping_size(elf_phdata, elf_ex.e_phnum);
 	for(i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
 		int elf_prot = 0, elf_flags;
-		unsigned long k, vaddr;
+		unsigned long const vaddr = elf_ppnt->p_vaddr;
+		unsigned long k, place;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-	            
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk (elf_bss + load_bias,
-					  elf_brk + load_bias);
-			if (retval) {
-				send_sig(SIGKILL, current, 0);
-				goto out_free_dentry;
-			}
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				clear_user((void *) elf_bss + load_bias, nbyte);
-			}
-		}
 
 		if (elf_ppnt->p_flags & PF_R) elf_prot |= PROT_READ;
 		if (elf_ppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
@@ -743,7 +762,6 @@ static int load_elf_binary(struct linux_
 
 		elf_flags = MAP_PRIVATE|MAP_DENYWRITE|MAP_EXECUTABLE;
 
-		vaddr = elf_ppnt->p_vaddr;
 		if (elf_ex.e_type == ET_EXEC || load_addr_set) {
 			elf_flags |= MAP_FIXED;
 		} else if (elf_ex.e_type == ET_DYN) {
@@ -753,21 +771,22 @@ static int load_elf_binary(struct linux_
 			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
 		}
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags);
-		if (BAD_ADDR(error))
+		place = elf_map(bprm->file, load_bias + vaddr, elf_ppnt, elf_prot, elf_flags, total_size);
+		total_size = 0;
+		if (BAD_ADDR(place))
 			continue;
 
 		if (!load_addr_set) {
 			load_addr_set = 1;
-			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
+			load_addr = (vaddr - elf_ppnt->p_offset);
 			if (elf_ex.e_type == ET_DYN) {
-				load_bias += error -
+				load_bias += place -
 				             ELF_PAGESTART(load_bias + vaddr);
 				load_addr += load_bias;
 				reloc_func_desc = load_bias;
 			}
 		}
-		k = elf_ppnt->p_vaddr;
+		k = vaddr;
 		if (k < start_code) start_code = k;
 		if (start_data < k) start_data = k;
 
@@ -784,38 +803,43 @@ static int load_elf_binary(struct linux_
 			goto out_free_dentry;
 		}
 
-		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
-
-		if (k > elf_bss)
-			elf_bss = k;
-		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
+		k = vaddr + elf_ppnt->p_filesz;  /* un-biased start of .bss */
+		place = k;
+		if ((elf_ppnt->p_flags & PF_X) && (end_code < k))
 			end_code = k;
 		if (end_data < k)
 			end_data = k;
-		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
+
+		k = vaddr + elf_ppnt->p_memsz;  /* un-biased end of .bss */
 		if (k > elf_brk)
 			elf_brk = k;
+
+		if (place < k) {
+			/* .bss: clear the low fragment; map anonymous pages. */
+			place += load_bias;
+
+			/* FIXME: !PF_W ==> must PROT_WRITE one page */
+			if (elf_ppnt->p_flags & PF_W)
+				place += padzero(place);
+
+			retval = do_bss_pages(place, load_bias + k,
+				VM_DATA_DEFAULT_FLAGS &
+					~calc_bss_inhibit(elf_ppnt, elf_prot));
+			if (retval) {
+				send_sig(SIGKILL, current, 0);
+				goto out_free_dentry;
+			}
+		}
 	}
 
 	elf_ex.e_entry += load_bias;
-	elf_bss += load_bias;
 	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
 	start_data += load_bias;
 	end_data += load_bias;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk);
-	if (retval) {
-		send_sig(SIGKILL, current, 0);
-		goto out_free_dentry;
-	}
-	padzero(elf_bss);
+	current->mm->start_brk = current->mm->brk = elf_brk;
 
 	if (elf_interpreter) {
 		if (interpreter_type == INTERPRETER_AOUT)
@@ -866,7 +890,7 @@ static int load_elf_binary(struct linux_
 		   Since we do not have the power to recompile these, we
 		   emulate the SVr4 behavior.  Sigh.  */
 		down_write(&current->mm->mmap_sem);
-		error = do_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
+		/*error =*/ do_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
 		up_write(&current->mm->mmap_sem);
 	}
@@ -981,7 +1005,7 @@ static int load_elf_library(struct file 
 	len = ELF_PAGESTART(elf_phdata->p_filesz + elf_phdata->p_vaddr + ELF_MIN_ALIGN - 1);
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
 	if (bss > len)
-		do_brk(len, bss - len);
+		do_brk(len, bss - len, VM_DATA_DEFAULT_FLAGS);
 	error = 0;
 
 out_free_ph:
diff -puN include/linux/mm.h~bssprot include/linux/mm.h
--- 25/include/linux/mm.h~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/include/linux/mm.h	Sun May  2 02:42:19 2004
@@ -599,7 +599,7 @@ out:
 
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
-extern unsigned long do_brk(unsigned long, unsigned long);
+extern unsigned long do_brk(unsigned long, unsigned long, unsigned int);
 
 static inline void
 __vma_unlink(struct mm_struct *mm, struct vm_area_struct *vma,
diff -puN mm/mmap.c~bssprot mm/mmap.c
--- 25/mm/mmap.c~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/mm/mmap.c	Sun May  2 02:42:36 2004
@@ -132,7 +132,7 @@ asmlinkage unsigned long sys_brk(unsigne
 		goto out;
 
 	/* Ok, looks good - let it rip. */
-	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
+	if (do_brk(oldbrk, newbrk-oldbrk, VM_DATA_DEFAULT_FLAGS) != oldbrk)
 		goto out;
 set_brk:
 	mm->brk = brk;
@@ -1378,7 +1378,7 @@ asmlinkage long sys_munmap(unsigned long
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-unsigned long do_brk(unsigned long addr, unsigned long len)
+unsigned long do_brk(unsigned long addr, unsigned long len, unsigned _flags)
 {
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
@@ -1424,7 +1424,7 @@ unsigned long do_brk(unsigned long addr,
 	if (security_vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	flags = _flags | VM_ACCOUNT | mm->def_flags;
 
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len,
@@ -1459,7 +1459,6 @@ out:
 	}
 	return addr;
 }
-
 EXPORT_SYMBOL(do_brk);
 
 /* Release all mmaps. */
diff -puN mm/nommu.c~bssprot mm/nommu.c
--- 25/mm/nommu.c~bssprot	Sun May  2 02:42:19 2004
+++ 25-akpm/mm/nommu.c	Sun May  2 02:42:36 2004
@@ -535,7 +535,7 @@ asmlinkage long sys_munmap(unsigned long
 	return ret;
 }
 
-unsigned long do_brk(unsigned long addr, unsigned long len)
+unsigned long do_brk(unsigned long addr, unsigned long len, unsigned flags)
 {
 	return -ENOMEM;
 }
diff -puN arch/sparc64/kernel/sys_sunos32.c~bssprot arch/sparc64/kernel/sys_sunos32.c
--- 25/arch/sparc64/kernel/sys_sunos32.c~bssprot	Sun May  2 02:42:26 2004
+++ 25-akpm/arch/sparc64/kernel/sys_sunos32.c	Sun May  2 02:42:36 2004
@@ -173,7 +173,7 @@ asmlinkage int sunos_brk(u32 baddr)
 		goto out;
 	/* Ok, we have probably got enough memory - let it rip. */
 	current->mm->brk = brk;
-	do_brk(oldbrk, newbrk-oldbrk);
+	do_brk(oldbrk, newbrk-oldbrk, VM_DATA_DEFAULT_FLAGS);
 	retval = 0;
 out:
 	up_write(&current->mm->mmap_sem);
diff -puN arch/ia64/ia32/binfmt_elf32.c~bssprot arch/ia64/ia32/binfmt_elf32.c
--- 25/arch/ia64/ia32/binfmt_elf32.c~bssprot	Sun May  2 02:42:40 2004
+++ 25-akpm/arch/ia64/ia32/binfmt_elf32.c	Sun May  2 02:42:50 2004
@@ -220,7 +220,8 @@ elf32_set_personality (void)
 }
 
 static unsigned long
-elf32_map (struct file *filep, unsigned long addr, struct elf_phdr *eppnt, int prot, int type)
+elf32_map (struct file *filep, unsigned long addr, struct elf_phdr const *eppnt,
+		int prot, int type, unsigned long total_size)
 {
 	unsigned long pgoff = (eppnt->p_vaddr) & ~IA32_PAGE_MASK;
 
diff -puN arch/ia64/kernel/sys_ia64.c~bssprot arch/ia64/kernel/sys_ia64.c
--- 25/arch/ia64/kernel/sys_ia64.c~bssprot	Sun May  2 02:42:40 2004
+++ 25-akpm/arch/ia64/kernel/sys_ia64.c	Sun May  2 02:42:40 2004
@@ -147,7 +147,7 @@ ia64_brk (unsigned long brk)
 		goto out;
 
 	/* Ok, looks good - let it rip. */
-	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
+	if (do_brk(oldbrk, newbrk-oldbrk, VM_DATA_DEFAULT_FLAGS) != oldbrk)
 		goto out;
 set_brk:
 	mm->brk = brk;
diff -puN arch/mips/kernel/irixelf.c~bssprot arch/mips/kernel/irixelf.c
--- 25/arch/mips/kernel/irixelf.c~bssprot	Sun May  2 02:42:40 2004
+++ 25-akpm/arch/mips/kernel/irixelf.c	Sun May  2 02:42:40 2004
@@ -127,7 +127,7 @@ static void set_brk(unsigned long start,
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
-	do_brk(start, end - start);
+	do_brk(start, end - start, VM_DATA_DEFAULT_FLAGS);
 }
 
 
@@ -376,7 +376,7 @@ static unsigned int load_irix_interp(str
 
 	/* Map the last of the bss segment */
 	if (last_bss > len) {
-		do_brk(len, (last_bss - len));
+		do_brk(len, (last_bss - len), VM_DATA_DEFAULT_FLAGS);
 	}
 	kfree(elf_phdata);
 
@@ -564,7 +564,7 @@ void irix_map_prda_page (void)
 	unsigned long v;
 	struct prda *pp;
 
-	v =  do_brk (PRDA_ADDRESS, PAGE_SIZE);
+	v =  do_brk(PRDA_ADDRESS, PAGE_SIZE, VM_DATA_DEFAULT_FLAGS);
 
 	if (v < 0)
 		return;
@@ -856,7 +856,7 @@ static int load_irix_library(struct file
 	len = (elf_phdata->p_filesz + elf_phdata->p_vaddr+ 0xfff) & 0xfffff000;
 	bss = elf_phdata->p_memsz + elf_phdata->p_vaddr;
 	if (bss > len)
-	  do_brk(len, bss-len);
+		do_brk(len, bss-len, VM_DATA_DEFAULT_FLAGS);
 	kfree(elf_phdata);
 	return 0;
 }
diff -puN arch/mips/kernel/sysirix.c~bssprot arch/mips/kernel/sysirix.c
--- 25/arch/mips/kernel/sysirix.c~bssprot	Sun May  2 02:42:40 2004
+++ 25-akpm/arch/mips/kernel/sysirix.c	Sun May  2 02:42:40 2004
@@ -586,7 +586,7 @@ asmlinkage int irix_brk(unsigned long br
 	 * Ok, looks good - let it rip.
 	 */
 	mm->brk = brk;
-	do_brk(oldbrk, newbrk-oldbrk);
+	do_brk(oldbrk, newbrk-oldbrk, VM_DATA_DEFAULT_FLAGS);
 	ret = 0;
 
 out:
diff -puN arch/sparc64/kernel/binfmt_aout32.c~bssprot arch/sparc64/kernel/binfmt_aout32.c
--- 25/arch/sparc64/kernel/binfmt_aout32.c~bssprot	Sun May  2 02:42:40 2004
+++ 25-akpm/arch/sparc64/kernel/binfmt_aout32.c	Sun May  2 02:42:40 2004
@@ -49,7 +49,7 @@ static void set_brk(unsigned long start,
 	end = PAGE_ALIGN(end);
 	if (end <= start)
 		return;
-	do_brk(start, end - start);
+	do_brk(start, end - start, VM_DATA_DEFAULT_FLAGS);
 }
 
 /*
@@ -246,10 +246,10 @@ static int load_aout32_binary(struct lin
 	if (N_MAGIC(ex) == NMAGIC) {
 		loff_t pos = fd_offset;
 		/* Fuck me plenty... */
-		error = do_brk(N_TXTADDR(ex), ex.a_text);
+		error = do_brk(N_TXTADDR(ex), ex.a_text, VM_DATA_DEFAULT_FLAGS);
 		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
 			  ex.a_text, &pos);
-		error = do_brk(N_DATADDR(ex), ex.a_data);
+		error = do_brk(N_DATADDR(ex), ex.a_data, VM_DATA_DEFAULT_FLAGS);
 		bprm->file->f_op->read(bprm->file, (char *) N_DATADDR(ex),
 			  ex.a_data, &pos);
 		goto beyond_if;
@@ -258,7 +258,8 @@ static int load_aout32_binary(struct lin
 	if (N_MAGIC(ex) == OMAGIC) {
 		loff_t pos = fd_offset;
 		do_brk(N_TXTADDR(ex) & PAGE_MASK,
-			ex.a_text+ex.a_data + PAGE_SIZE - 1);
+			ex.a_text+ex.a_data + PAGE_SIZE - 1,
+			VM_DATA_DEFAULT_FLAGS);
 		bprm->file->f_op->read(bprm->file, (char *) N_TXTADDR(ex),
 			  ex.a_text+ex.a_data, &pos);
 	} else {
@@ -272,7 +273,7 @@ static int load_aout32_binary(struct lin
 
 		if (!bprm->file->f_op->mmap) {
 			loff_t pos = fd_offset;
-			do_brk(0, ex.a_text+ex.a_data);
+			do_brk(0, ex.a_text+ex.a_data, VM_DATA_DEFAULT_FLAGS);
 			bprm->file->f_op->read(bprm->file,(char *)N_TXTADDR(ex),
 				  ex.a_text+ex.a_data, &pos);
 			goto beyond_if;
@@ -388,7 +389,8 @@ static int load_aout32_library(struct fi
 	len = PAGE_ALIGN(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
-		error = do_brk(start_addr + len, bss - len);
+		error = do_brk(start_addr + len, bss - len,
+				VM_DATA_DEFAULT_FLAGS);
 		retval = error;
 		if (error != start_addr + len)
 			goto out;
diff -puN arch/sparc/kernel/sys_sunos.c~bssprot arch/sparc/kernel/sys_sunos.c
--- 25/arch/sparc/kernel/sys_sunos.c~bssprot	Sun May  2 02:42:40 2004
+++ 25-akpm/arch/sparc/kernel/sys_sunos.c	Sun May  2 02:42:40 2004
@@ -207,7 +207,7 @@ asmlinkage int sunos_brk(unsigned long b
 	 * Ok, we have probably got enough memory - let it rip.
 	 */
 	current->mm->brk = brk;
-	do_brk(oldbrk, newbrk-oldbrk);
+	do_brk(oldbrk, newbrk-oldbrk, VM_DATA_DEFAULT_FLAGS);
 	retval = 0;
 out:
 	up_write(&current->mm->mmap_sem);

_

