Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWIUHnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWIUHnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWIUHnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:43:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:37320 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750881AbWIUHnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:43:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Owf3gbRfLZ4xkhifRJVrZYwhRMFAeRWVc3Zm5gYJ5O1Y6E3KnTIfdX690tw9+NupKuBRu/BVJJCOynDj8VWINezsMt/GvCyBQR5uPcBkdTvYuDFUXcn4qRoZJYf06Czg2h1Sw4xBf+HTJJSnwlNN2lGcmatOhn/AHFYZXGvoSOU=
Message-ID: <489ecd0c0609210043i33195c2ds44e7a6bab11f82d1@mail.gmail.com>
Date: Thu, 21 Sep 2006 15:43:22 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Randy. Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 4/4] Blackfin: binfmt patch to enhance stacking checking
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <489ecd0c0609210041t484296e5kf94203ecee13514a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202033l456d66ceq85ef69e7a4a4aa00@mail.gmail.com>
	 <20060920230446.f6b825c6.rdunlap@xenotime.net>
	 <489ecd0c0609210041t484296e5kf94203ecee13514a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Please discuss about the patch first and I'll resend a renewed patch
as attachment.

On 9/21/06, Luke Yang <luke.adi@gmail.com> wrote:
> Hi Randy,
>
>   Thanks. Fixed the issues.
>
>  Signed-off-by: Luke Yang <luke.adi@gmail.com>
>
>  fs/binfmt_elf_fdpic.c       |    7 +-
>  fs/binfmt_flat.c            |  144 ++++++++++++++++++++++++++++----------------
>  include/asm-arm/mmu.h       |    1
>  include/asm-frv/mmu.h       |    1
>  include/asm-h8300/mmu.h     |    1
>  include/asm-m32r/mmu.h      |    1
>  include/asm-m68knommu/mmu.h |    1
>  include/asm-sh/mmu.h        |    1
>  include/asm-v850/mmu.h      |    1
>  include/linux/flat.h        |   13 ++-
>  10 files changed, 112 insertions(+), 59 deletions(-)
>
> diff -urN linux-2.6.18.patch2/fs/binfmt_elf_fdpic.c
> linux-2.6.18.patch3/fs/binfmt_elf_fdpic.c
> --- linux-2.6.18.patch2/fs/binfmt_elf_fdpic.c   2006-09-21
> 09:37:18.000000000 +0800
> +++ linux-2.6.18.patch3/fs/binfmt_elf_fdpic.c   2006-09-21
> 11:17:49.000000000 +0800
> @@ -170,7 +170,7 @@
>  {
>         struct elf_fdpic_params exec_params, interp_params;
>         struct elf_phdr *phdr;
> -       unsigned long stack_size, entryaddr;
> +       unsigned long stack_size, entryaddr, requested_stack_size;
>  #ifndef CONFIG_MMU
>         unsigned long fullsize;
>  #endif
> @@ -361,6 +361,7 @@
>          * - the stack starts at the top and works down
>          */
>         stack_size = (stack_size + PAGE_SIZE - 1) & PAGE_MASK;
> +       requested_stack_size = stack_size;
>         if (stack_size < PAGE_SIZE * 2)
>                 stack_size = PAGE_SIZE * 2;
>
> @@ -388,6 +389,8 @@
>         current->mm->context.end_brk = current->mm->start_brk;
>         current->mm->context.end_brk +=
>                 (stack_size > PAGE_SIZE) ? (stack_size - PAGE_SIZE) : 0;
> +       current->mm->context.stack_start =
> +               current->mm->start_brk + stack_size - requested_stack_size;
>         current->mm->start_stack = current->mm->start_brk + stack_size;
>  #endif
>
> @@ -959,6 +962,8 @@
>  }
>  #endif
>
> +extern void *safe_dma_memcpy(void *, const void *, size_t);
> +
>  /*****************************************************************************/
>  /*
>   * map a binary by direct mmap() of the individual PT_LOAD segments
> diff -urN linux-2.6.18.patch2/fs/binfmt_flat.c
> linux-2.6.18.patch3/fs/binfmt_flat.c
> --- linux-2.6.18.patch2/fs/binfmt_flat.c        2006-09-21 09:37:18.000000000 +0800
> +++ linux-2.6.18.patch3/fs/binfmt_flat.c        2006-09-21 15:32:40.000000000 +0800
> @@ -35,13 +35,13 @@
>  #include <linux/personality.h>
>  #include <linux/init.h>
>  #include <linux/flat.h>
> -#include <linux/syscalls.h>
>
>  #include <asm/byteorder.h>
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
>  #include <asm/unaligned.h>
>  #include <asm/cacheflush.h>
> +#include <asm/mmu_context.h>
>
>  /****************************************************************************/
>
> @@ -77,6 +77,8 @@
>  static int load_flat_binary(struct linux_binprm *, struct pt_regs * regs);
>  static int flat_core_dump(long signr, struct pt_regs * regs, struct
> file *file);
>
> +extern void dump_thread(struct pt_regs *, struct user *);
> +
>  static struct linux_binfmt flat_format = {
>         .module         = THIS_MODULE,
>         .load_binary    = load_flat_binary,
> @@ -413,7 +415,9 @@
>  /****************************************************************************/
>
>  static int load_flat_file(struct linux_binprm * bprm,
> -               struct lib_info *libinfo, int id, unsigned long *extra_stack)
> +                         struct lib_info *libinfo, int id,
> +                         unsigned long *extra_stack,
> +                         unsigned long *stack_base)
>  {
>         struct flat_hdr * hdr;
>         unsigned long textpos = 0, datapos = 0, result;
> @@ -426,7 +430,6 @@
>         int i, rev, relocs = 0;
>         loff_t fpos;
>         unsigned long start_code, end_code;
> -       int ret;
>
>         hdr = ((struct flat_hdr *) bprm->buf);          /* exec-header */
>         inode = bprm->file->f_dentry->d_inode;
> @@ -451,24 +454,26 @@
>                  */
>                 if (strncmp(hdr->magic, "#!", 2))
>                         printk("BINFMT_FLAT: bad header magic\n");
> -               ret = -ENOEXEC;
> +               result = -ENOEXEC;
>                 goto err;
>         }
> -
> +#ifdef DEBUG
> +       flags |= FLAT_FLAG_KTRACE;
> +#endif
>         if (flags & FLAT_FLAG_KTRACE)
>                 printk("BINFMT_FLAT: Loading file: %s\n", bprm->filename);
>
>         if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
>                 printk("BINFMT_FLAT: bad flat file version 0x%x (supported 0x%x and
> 0x%x)\n", rev, FLAT_VERSION, OLD_FLAT_VERSION);
> -               ret = -ENOEXEC;
> +               result = -ENOEXEC;
>                 goto err;
>         }
> -
> +
>         /* Don't allow old format executables to use shared libraries */
>         if (rev == OLD_FLAT_VERSION && id != 0) {
>                 printk("BINFMT_FLAT: shared libraries are not available before rev 0x%x\n",
>                                 (int) FLAT_VERSION);
> -               ret = -ENOEXEC;
> +               result = -ENOEXEC;
>                 goto err;
>         }
>
> @@ -482,7 +487,7 @@
>  #ifndef CONFIG_BINFMT_ZFLAT
>         if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
>                 printk("Support for ZFLAT executables is not enabled.\n");
> -               ret = -ENOEXEC;
> +               result = -ENOEXEC;
>                 goto err;
>         }
>  #endif
> @@ -496,17 +501,28 @@
>         if (rlim >= RLIM_INFINITY)
>                 rlim = ~0;
>         if (data_len + bss_len > rlim) {
> -               ret = -ENOMEM;
> +               result = -ENOMEM;
>                 goto err;
>         }
>
> +       if (flags & FLAT_FLAG_L1STK) {
> +               if (stack_base == 0) {
> +                       result = -ENOEXEC;
> +                       goto err;
> +               }
> +               stack_len = alloc_l1stack(stack_len, stack_base);
> +               if (stack_len == 0) {
> +                       result = -ENOEXEC;
> +                       goto err;
> +               }
> +               *extra_stack = stack_len;
> +       }
> +
>         /* Flush all traces of the currently running executable */
>         if (id == 0) {
>                 result = flush_old_exec(bprm);
> -               if (result) {
> -                       ret = result;
> -                       goto err;
> -               }
> +               if (result)
> +                       goto out_fail;
>
>                 /* OK, This is the point of no return */
>                 set_personality(PER_LINUX_32BIT);
> @@ -536,14 +552,17 @@
>                         if (!textpos)
>                                 textpos = (unsigned long) -ENOMEM;
>                         printk("Unable to mmap process text, errno %d\n", (int)-textpos);
> -                       ret = textpos;
> -                       goto err;
> +                       result = textpos;
> +                       goto out_fail;
>                 }
>
>                 down_write(&current->mm->mmap_sem);
>                 realdatastart = do_mmap(0, 0, data_len + extra +
>                                 MAX_SHARED_LIBS * sizeof(unsigned long),
>                                 PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
> +               do_mremap(realdatastart, data_len + extra +
> +                         MAX_SHARED_LIBS * sizeof(unsigned long),
> +                         ksize((void *)realdatastart), 0, 0);
>                 up_write(&current->mm->mmap_sem);
>
>                 if (realdatastart == 0 || realdatastart >= (unsigned long)-4096) {
> @@ -552,8 +571,8 @@
>                         printk("Unable to allocate RAM for process data, errno %d\n",
>                                         (int)-datapos);
>                         do_munmap(current->mm, textpos, text_len);
> -                       ret = realdatastart;
> -                       goto err;
> +                       result = realdatastart;
> +                       goto out_fail;
>                 }
>                 datapos = realdatastart + MAX_SHARED_LIBS * sizeof(unsigned long);
>
> @@ -575,8 +594,7 @@
>                         printk("Unable to read data+bss, errno %d\n", (int)-result);
>                         do_munmap(current->mm, textpos, text_len);
>                         do_munmap(current->mm, realdatastart, data_len + extra);
> -                       ret = result;
> -                       goto err;
> +                       goto out_fail;
>                 }
>
>                 reloc = (unsigned long *) (datapos+(ntohl(hdr->reloc_start)-text_len));
> @@ -588,15 +606,19 @@
>                 textpos = do_mmap(0, 0, text_len + data_len + extra +
>                                         MAX_SHARED_LIBS * sizeof(unsigned long),
>                                 PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
> -               up_write(&current->mm->mmap_sem);
>                 if (!textpos  || textpos >= (unsigned long) -4096) {
> +                       up_write(&current->mm->mmap_sem);
>                         if (!textpos)
>                                 textpos = (unsigned long) -ENOMEM;
>                         printk("Unable to allocate RAM for process text/data, errno %d\n",
>                                         (int)-textpos);
> -                       ret = textpos;
> -                       goto err;
> +                       result = textpos;
> +                       goto out_fail;
>                 }
> +               do_mremap(textpos, text_len + data_len + extra +
> +                         MAX_SHARED_LIBS * sizeof(unsigned long),
> +                         ksize((void *)textpos), 0, 0);
> +               up_write(&current->mm->mmap_sem);
>
>                 realdatastart = textpos + ntohl(hdr->data_start);
>                 datapos = realdatastart + MAX_SHARED_LIBS * sizeof(unsigned long);
> @@ -640,8 +662,7 @@
>                         printk("Unable to read code+data+bss, errno %d\n",(int)-result);
>                         do_munmap(current->mm, textpos, text_len + data_len + extra +
>                                 MAX_SHARED_LIBS * sizeof(unsigned long));
> -                       ret = result;
> -                       goto err;
> +                       goto out_fail;
>                 }
>         }
>
> @@ -665,6 +686,7 @@
>                 current->mm->start_brk = datapos + data_len + bss_len;
>                 current->mm->brk = (current->mm->start_brk + 3) & ~3;
>                 current->mm->context.end_brk = memp + ksize((void *) memp) - stack_len;
> +               current->mm->context.stack_start = current->mm->context.end_brk;
>         }
>
>         if (flags & FLAT_FLAG_KTRACE)
> @@ -686,7 +708,7 @@
>         libinfo->lib_list[id].loaded = 1;
>         libinfo->lib_list[id].entry = (0x00ffffff & ntohl(hdr->entry)) + textpos;
>         libinfo->lib_list[id].build_date = ntohl(hdr->build_date);
> -
> +
>         /*
>          * We just load the allocations into some temporary memory to
>          * help simplify all this mumbo jumbo
> @@ -705,8 +727,8 @@
>                         if (*rp) {
>                                 addr = calc_reloc(*rp, libinfo, id, 0);
>                                 if (addr == RELOC_FAILED) {
> -                                       ret = -ENOEXEC;
> -                                       goto err;
> +                                       result = -ENOEXEC;
> +                                       goto out_fail;
>                                 }
>                                 *rp = addr;
>                         }
> @@ -725,6 +747,7 @@
>          * __start to address 4 so that is okay).
>          */
>         if (rev > OLD_FLAT_VERSION) {
> +               unsigned long persistent = 0;
>                 for (i=0; i < relocs; i++) {
>                         unsigned long addr, relval;
>
> @@ -732,16 +755,20 @@
>                            relocated (of course, the address has to be
>                            relocated first).  */
>                         relval = ntohl(reloc[i]);
> +                       if (flat_set_persistent (relval, &persistent))
> +                               continue;
>                         addr = flat_get_relocate_addr(relval);
>                         rp = (unsigned long *) calc_reloc(addr, libinfo, id, 1);
>                         if (rp == (unsigned long *)RELOC_FAILED) {
> -                               ret = -ENOEXEC;
> -                               goto err;
> +                               result = -ENOEXEC;
> +                               goto out_fail;
>                         }
>
>                         /* Get the pointer's value.  */
> -                       addr = flat_get_addr_from_rp(rp, relval, flags);
> -                       if (addr != 0) {
> +                       addr = flat_get_addr_from_rp(rp, relval, flags, &persistent);
> +                       if (addr == 0)
> +                               continue;
> +                       if (! flat_addr_absolute (relval)) {
>                                 /*
>                                  * Do the relocation.  PIC relocs in the data section are
>                                  * already in target order
> @@ -750,30 +777,32 @@
>                                         addr = ntohl(addr);
>                                 addr = calc_reloc(addr, libinfo, id, 0);
>                                 if (addr == RELOC_FAILED) {
> -                                       ret = -ENOEXEC;
> -                                       goto err;
> +                                       result = -ENOEXEC;
> +                                       goto out_fail;
>                                 }
> -
> -                               /* Write back the relocated pointer.  */
> -                               flat_put_addr_at_rp(rp, addr, relval);
>                         }
> +                       /* Write back the relocated pointer.  */
> +                       flat_put_addr_at_rp(rp, addr, relval);
>                 }
>         } else {
>                 for (i=0; i < relocs; i++)
>                         old_reloc(ntohl(reloc[i]));
>         }
> -
> +
>         flush_icache_range(start_code, end_code);
>
>         /* zero the BSS,  BRK and stack areas */
> -       memset((void*)(datapos + data_len), 0, bss_len +
> +       memset((void*)(datapos + data_len), 0, bss_len +
>                         (memp + ksize((void *) memp) - stack_len -      /* end brk */
>                         libinfo->lib_list[id].start_brk) +              /* start brk */
>                         stack_len);
>
>         return 0;
> -err:
> -       return ret;
> + out_fail:
> +       if (flags & FLAT_FLAG_L1STK)
> +               free_l1stack();
> + err:
> +       return result;
>  }
>
>
> @@ -804,7 +833,7 @@
>         res = prepare_binprm(&bprm);
>
>         if (res <= (unsigned long)-4096)
> -               res = load_flat_file(&bprm, libs, id, NULL);
> +               res = load_flat_file(&bprm, libs, id, NULL, NULL);
>         if (bprm.file) {
>                 allow_write_access(bprm.file);
>                 fput(bprm.file);
> @@ -827,6 +856,7 @@
>         unsigned long p = bprm->p;
>         unsigned long stack_len;
>         unsigned long start_addr;
> +       unsigned long l1stack_base, ramstack_top;
>         unsigned long *sp;
>         int res;
>         int i, j;
> @@ -844,11 +874,11 @@
>         stack_len += (bprm->argc + 1) * sizeof(char *); /* the argv array */
>         stack_len += (bprm->envc + 1) * sizeof(char *); /* the envp array */
>
> -
> -       res = load_flat_file(bprm, &libinfo, 0, &stack_len);
> +       l1stack_base = 0;
> +       res = load_flat_file(bprm, &libinfo, 0, &stack_len, &l1stack_base);
>         if (res > (unsigned long)-4096)
>                 return res;
> -
> +
>         /* Update data segment pointers for all libraries */
>         for (i=0; i<MAX_SHARED_LIBS; i++)
>                 if (libinfo.lib_list[i].loaded)
> @@ -863,6 +893,7 @@
>         set_binfmt(&flat_format);
>
>         p = ((current->mm->context.end_brk + stack_len + 3) & ~3) - 4;
> +       ramstack_top = p;
>         DBG_FLT("p=%x\n", (int)p);
>
>         /* copy the arg pages onto the stack, this could be more efficient :-) */
> @@ -871,7 +902,7 @@
>                         ((char *) page_address(bprm->page[i/PAGE_SIZE]))[i % PAGE_SIZE];
>
>         sp = (unsigned long *) create_flat_tables(p, bprm);
> -
> +
>         /* Fake some return addresses to ensure the call chain will
>          * initialise library in order for us.  We are required to call
>          * lib 1 first, then 2, ... and finally the main program (id 0).
> @@ -887,15 +918,24 @@
>                 }
>         }
>  #endif
> -
> +
>         /* Stash our initial stack pointer into the mm structure */
>         current->mm->start_stack = (unsigned long )sp;
>
> -
> -       DBG_FLT("start_thread(regs=0x%x, entry=0x%x, start_stack=0x%x)\n",
> -               (int)regs, (int)start_addr, (int)current->mm->start_stack);
> -
> -       start_thread(regs, start_addr, current->mm->start_stack);
> +       if (l1stack_base) {
> +               /* Find L1 stack pointer corresponding to the current bottom
> +                  of the stack in normal RAM.  */
> +               l1stack_base += stack_len - (ramstack_top - (unsigned long)sp);
> +               if (!activate_l1stack(current->mm, ramstack_top - stack_len))
> +                       l1stack_base = 0;
> +       }
> +
> +       DBG_FLT("start_thread(regs=0x%x, entry=0x%x, start_stack=0x%x,
> l1stk=0x%x, len 0x%x)\n",
> +               (int)regs, (int)start_addr, (int)current->mm->start_stack, l1stack_base,
> +               stack_len);
> +
> +       start_thread(regs, start_addr,
> +                    l1stack_base ? l1stack_base : current->mm->start_stack);
>
>         if (current->ptrace & PT_PTRACED)
>                 send_sig(SIGTRAP, current, 0);
> diff -urN linux-2.6.18.patch2/include/asm-arm/mmu.h
> linux-2.6.18.patch3/include/asm-arm/mmu.h
> --- linux-2.6.18.patch2/include/asm-arm/mmu.h   2006-09-21
> 09:37:24.000000000 +0800
> +++ linux-2.6.18.patch3/include/asm-arm/mmu.h   2006-09-21
> 09:52:02.000000000 +0800
> @@ -26,6 +26,7 @@
>  typedef struct {
>         struct vm_list_struct   *vmlist;
>         unsigned long           end_brk;
> +       unsigned long           stack_start;
>  } mm_context_t;
>
>  #endif
> diff -urN linux-2.6.18.patch2/include/asm-frv/mmu.h
> linux-2.6.18.patch3/include/asm-frv/mmu.h
> --- linux-2.6.18.patch2/include/asm-frv/mmu.h   2006-09-21
> 09:37:25.000000000 +0800
> +++ linux-2.6.18.patch3/include/asm-frv/mmu.h   2006-09-21
> 09:52:02.000000000 +0800
> @@ -24,6 +24,7 @@
>  #else
>         struct vm_list_struct   *vmlist;
>         unsigned long           end_brk;
> +       unsigned long           stack_start;
>
>  #endif
>
> diff -urN linux-2.6.18.patch2/include/asm-h8300/mmu.h
> linux-2.6.18.patch3/include/asm-h8300/mmu.h
> --- linux-2.6.18.patch2/include/asm-h8300/mmu.h 2006-09-21
> 09:37:26.000000000 +0800
> +++ linux-2.6.18.patch3/include/asm-h8300/mmu.h 2006-09-21
> 09:52:02.000000000 +0800
> @@ -6,6 +6,7 @@
>  typedef struct {
>         struct vm_list_struct   *vmlist;
>         unsigned long           end_brk;
> +       unsigned long           stack_start;
>  } mm_context_t;
>
>  #endif
> diff -urN linux-2.6.18.patch2/include/asm-m32r/mmu.h
> linux-2.6.18.patch3/include/asm-m32r/mmu.h
> --- linux-2.6.18.patch2/include/asm-m32r/mmu.h  2006-09-21
> 09:37:26.000000000 +0800
> +++ linux-2.6.18.patch3/include/asm-m32r/mmu.h  2006-09-21
> 09:52:02.000000000 +0800
> @@ -6,6 +6,7 @@
>  typedef struct {
>         struct vm_list_struct   *vmlist;
>         unsigned long           end_brk;
> +       unsigned long           stack_start;
>  } mm_context_t;
>  #else
>
> diff -urN linux-2.6.18.patch2/include/asm-m68knommu/mmu.h
> linux-2.6.18.patch3/include/asm-m68knommu/mmu.h
> --- linux-2.6.18.patch2/include/asm-m68knommu/mmu.h     2006-09-21
> 09:37:26.000000000 +0800
> +++ linux-2.6.18.patch3/include/asm-m68knommu/mmu.h     2006-09-21
> 09:52:02.000000000 +0800
> @@ -6,6 +6,7 @@
>  typedef struct {
>         struct vm_list_struct   *vmlist;
>         unsigned long           end_brk;
> +       unsigned long           stack_start;
>  } mm_context_t;
>
>  #endif /* __M68KNOMMU_MMU_H */
> diff -urN linux-2.6.18.patch2/include/asm-sh/mmu.h
> linux-2.6.18.patch3/include/asm-sh/mmu.h
> --- linux-2.6.18.patch2/include/asm-sh/mmu.h    2006-09-21 09:37:26.000000000 +0800
> +++ linux-2.6.18.patch3/include/asm-sh/mmu.h    2006-09-21 09:52:02.000000000 +0800
> @@ -17,6 +17,7 @@
>  typedef struct {
>         struct mm_tblock_struct tblock;
>         unsigned long           end_brk;
> +       unsigned long           stack_start;
>  } mm_context_t;
>
>  #else
> diff -urN linux-2.6.18.patch2/include/asm-v850/mmu.h
> linux-2.6.18.patch3/include/asm-v850/mmu.h
> --- linux-2.6.18.patch2/include/asm-v850/mmu.h  2006-09-21
> 09:37:27.000000000 +0800
> +++ linux-2.6.18.patch3/include/asm-v850/mmu.h  2006-09-21
> 09:52:02.000000000 +0800
> @@ -6,6 +6,7 @@
>  typedef struct {
>         struct vm_list_struct   *vmlist;
>         unsigned long           end_brk;
> +       unsigned long           stack_start;
>  } mm_context_t;
>
>  #endif /* __V850_MMU_H__ */
> diff -urN linux-2.6.18.patch2/include/linux/flat.h
> linux-2.6.18.patch3/include/linux/flat.h
> --- linux-2.6.18.patch2/include/linux/flat.h    2006-09-21 09:37:27.000000000 +0800
> +++ linux-2.6.18.patch3/include/linux/flat.h    2006-09-21 09:52:02.000000000 +0800
> @@ -10,6 +10,13 @@
>  #ifndef _LINUX_FLAT_H
>  #define _LINUX_FLAT_H
>
> +#define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
> +#define FLAT_FLAG_GOTPIC 0x0002 /* program is PIC with GOT */
> +#define FLAT_FLAG_GZIP   0x0004 /* all but the header is compressed */
> +#define FLAT_FLAG_GZDATA 0x0008 /* only data/relocs are compressed (for XIP) */
> +#define FLAT_FLAG_KTRACE 0x0010 /* output useful kernel trace for debugging */
> +#define FLAT_FLAG_L1STK  0x0020 /* use a 4k stack in L1 scratch memory.  */
> +
>  #ifdef __KERNEL__
>  #include <asm/flat.h>
>  #endif
> @@ -50,12 +57,6 @@
>         unsigned long filler[5];    /* Reservered, set to zero */
>  };
>
> -#define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
> -#define FLAT_FLAG_GOTPIC 0x0002 /* program is PIC with GOT */
> -#define FLAT_FLAG_GZIP   0x0004 /* all but the header is compressed */
> -#define FLAT_FLAG_GZDATA 0x0008 /* only data/relocs are compressed (for XIP) */
> -#define FLAT_FLAG_KTRACE 0x0010 /* output useful kernel trace for debugging */
> -
>
>  #ifdef __KERNEL__ /* so systems without linux headers can compile the apps */
>  /*
>
>
> On 9/21/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Thu, 21 Sep 2006 11:33:20 +0800 Luke Yang wrote:
> >
> > > Hi all,
> >
> > Patch is malformed due to format=flowed.
> >
> > >  fs/binfmt_elf_fdpic.c       |    7 +-
> > >  fs/binfmt_flat.c            |  150 ++++++++++++++++++++++++++------------------
> > >  include/asm-arm/mmu.h       |    1
> > >  include/asm-frv/mmu.h       |    1
> > >  include/asm-h8300/mmu.h     |    1
> > >  include/asm-m32r/mmu.h      |    1
> > >  include/asm-m68knommu/mmu.h |    1
> > >  include/asm-sh/mmu.h        |    1
> > >  include/asm-v850/mmu.h      |    1
> > >  include/linux/flat.h        |   13 ++-
> > >  10 files changed, 112 insertions(+), 65 deletions(-)
> >
> > > diff -urN linux-2.6.18.patch2/fs/binfmt_flat.c
> > > linux-2.6.18.patch3/fs/binfmt_flat.c
> > > --- linux-2.6.18.patch2/fs/binfmt_flat.c      2006-09-21 09:37:18.000000000 +0800
> > > +++ linux-2.6.18.patch3/fs/binfmt_flat.c      2006-09-21 09:52:02.000000000 +0800
> > > @@ -16,6 +16,7 @@
> > >   */
> > >
> > >  #include <linux/module.h>
> > > +#include <linux/config.h>
> >
> > Don't add config.h at all.
> >
> > >  #include <linux/kernel.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/mm.h>
> >
> > > @@ -413,7 +416,9 @@
> > >  /****************************************************************************/
> > >
> > >  static int load_flat_file(struct linux_binprm * bprm,
> > > -             struct lib_info *libinfo, int id, unsigned long *extra_stack)
> > > +                       struct lib_info *libinfo, int id,
> > > +                       unsigned long *extra_stack,
> > > +                       unsigned long *stack_base)
> > >  {
> > >       struct flat_hdr * hdr;
> > >       unsigned long textpos = 0, datapos = 0, result;
> > > @@ -426,7 +431,6 @@
> > >       int i, rev, relocs = 0;
> > >       loff_t fpos;
> > >       unsigned long start_code, end_code;
> > > -     int ret;
> > >
> > >       hdr = ((struct flat_hdr *) bprm->buf);          /* exec-header */
> > >       inode = bprm->file->f_dentry->d_inode;
> > > @@ -451,25 +455,24 @@
> > >                */
> > >               if (strncmp(hdr->magic, "#!", 2))
> > >                       printk("BINFMT_FLAT: bad header magic\n");
> > > -             ret = -ENOEXEC;
> > > -             goto err;
> > > +             return -ENOEXEC;
> >
> > Some of us actually prefer to have one exit path per function,
> > not multiple ones.  It can help with debugging...
> >
> > and it would be Good to describe such a change in the
> > patch description too, but I'd prefer not to see that
> > particular change.
> >
> >
> > >       }
> > > -
> > > +#ifdef DEBUG
> > > +     flags |= FLAT_FLAG_KTRACE;
> > > +#endif
> > >       if (flags & FLAT_FLAG_KTRACE)
> > >               printk("BINFMT_FLAT: Loading file: %s\n", bprm->filename);
> > >
> > >       if (rev != FLAT_VERSION && rev != OLD_FLAT_VERSION) {
> > >               printk("BINFMT_FLAT: bad flat file version 0x%x (supported 0x%x and
> > > 0x%x)\n", rev, FLAT_VERSION, OLD_FLAT_VERSION);
> > > -             ret = -ENOEXEC;
> > > -             goto err;
> > > +             return -ENOEXEC;
> > >       }
> > > -
> > > +
> > >       /* Don't allow old format executables to use shared libraries */
> > >       if (rev == OLD_FLAT_VERSION && id != 0) {
> > >               printk("BINFMT_FLAT: shared libraries are not available before rev 0x%x\n",
> > >                               (int) FLAT_VERSION);
> > > -             ret = -ENOEXEC;
> > > -             goto err;
> > > +             return -ENOEXEC;
> > >       }
> > >
> > >       /*
> > > @@ -482,8 +485,7 @@
> > >  #ifndef CONFIG_BINFMT_ZFLAT
> > >       if (flags & (FLAT_FLAG_GZIP|FLAT_FLAG_GZDATA)) {
> > >               printk("Support for ZFLAT executables is not enabled.\n");
> > > -             ret = -ENOEXEC;
> > > -             goto err;
> > > +             return -ENOEXEC;
> > >       }
> > >  #endif
> > >
> > > @@ -495,18 +497,27 @@
> > >       rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
> > >       if (rlim >= RLIM_INFINITY)
> > >               rlim = ~0;
> > > -     if (data_len + bss_len > rlim) {
> > > -             ret = -ENOMEM;
> > > -             goto err;
> > > +     if (data_len + bss_len > rlim)
> > > +             return -ENOMEM;
> > > +
> > > +     if (flags & FLAT_FLAG_L1STK) {
> > > +             if (stack_base == 0) {
> > > +                     printk ("BINFMT_FLAT: requesting L1 stack for shared library\n");
> >
> > No space between printk and '('.
> > Use a printk level, like KERN_DEBUG (or drop this printk call
> > completely :).
> >
> > > +                     return -ENOEXEC;
> > > +             }
> >
> > ---
> > ~Randy
> >
>
>
> --
> Best regards,
> Luke Yang
> luke.adi@gmail.com
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com
