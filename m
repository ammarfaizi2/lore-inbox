Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131610AbRBAXIm>; Thu, 1 Feb 2001 18:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbRBAXIf>; Thu, 1 Feb 2001 18:08:35 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:33528 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131610AbRBAXIX>; Thu, 1 Feb 2001 18:08:23 -0500
Message-ID: <3A79EC64.2060502@interactivesi.com>
Date: Thu, 01 Feb 2001 17:08:20 -0600
From: duane voth <duanev@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18djv i686; en-US; 0.7) Gecko/20010112
X-Accept-Language: en, es-co
MIME-Version: 1.0
To: duane voth <duanev@interactivesi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: obscure bug in vmalloc
In-Reply-To: <3A79EB95.8070002@interactivesi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

duane voth wrote:

> ... I've attached a patch that
> can be used to watch for the problem.  The following is a 2.2 patch (2.4
> will follow in a few minutes).  If you see "vmalloc error" you might want
> to uncomment the look_for_dangling_pgds function to get a better feel for
> the pgds that cause the probem.

Here is the 2.4.1 version.

duane

--- mm/vmalloc.c.orig   Thu Feb  1 15:25:19 2001
+++ mm/vmalloc.c        Thu Feb  1 15:40:25 2001
@@ -225,6 +225,52 @@
         printk(KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n", addr);
  }

+int
+duanev_ensure_pgds_same(unsigned long addr, unsigned long size)
+{
+       struct task_struct *    p;
+       unsigned long                   va;
+       int                                             errs = 0;
+
+       for_each_task(p) {
+               for (va = addr; va < addr + size; va = (va + PGDIR_SIZE) & PGDIR_MASK) {
+                       pgd_t kpgd = *pgd_offset_k(va);
+                       if (pgd_val(*pgd_offset(p->mm, va)) != pgd_val(kpgd)) {
+                               printk("vmalloc error: pgd %03lx is %08lx not %08lx in %s\n",
+                                               va >> PGDIR_SHIFT,
+                                               pgd_val(*pgd_offset(p->mm, va)),
+                                               pgd_val(kpgd),
+                                               p->comm);
+                               errs++;
+                       }
+               }
+       }
+
+       return errs;
+}
+
+void
+duanev_look_for_dangling_pgds(unsigned long addr, unsigned long size)
+{
+       struct task_struct *    p;
+       unsigned long                   va;
+
+       /* can't use for_each_task: it skips the swapper! */
+       p = &init_task;
+       do {
+               if (pgd_val(*pgd_offset(p->mm, addr))) {
+                       for (va = (addr + PGDIR_SIZE) & PGDIR_MASK; va < addr + size;
+                                                       va = (va + PGDIR_SIZE) & PGDIR_MASK) {
+                               if (pgd_val(*pgd_offset(p->mm, va)) == 0)
+                                   printk("vfree: pgd %03lx is NULL but %03lx is not (in %s)\n",
+                                                       va >> PGDIR_SHIFT,
+                                                       addr >> PGDIR_SHIFT,
+                                                       p->comm);
+                       }
+               }
+       } while ((p = p->next_task) != &init_task);
+}
+
  void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot)
  {
         void * addr;
@@ -241,8 +287,11 @@
         addr = area->addr;
         if (vmalloc_area_pages(VMALLOC_VMADDR(addr), size, gfp_mask, prot)) {
                 vfree(addr);
+//             duanev_look_for_dangling_pgds((unsigned long)addr, size);
                 return NULL;
         }
+       if (duanev_ensure_pgds_same((unsigned long)addr, size))
+               printk("   vmalloc size = 0x%08lx\n", size);
         return addr;
  }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
