Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130243AbRBAXFV>; Thu, 1 Feb 2001 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbRBAXFE>; Thu, 1 Feb 2001 18:05:04 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:16632 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130243AbRBAXE4>; Thu, 1 Feb 2001 18:04:56 -0500
Message-ID: <3A79EB95.8070002@interactivesi.com>
Date: Thu, 01 Feb 2001 17:04:53 -0600
From: duane voth <duanev@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18djv i686; en-US; 0.7) Gecko/20010112
X-Accept-Language: en, es-co
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: obscure bug in vmalloc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been abusing vmalloc() recently and stumbled across a rather obscure
bug.  The code is nearly identical for 2.2 and 2.4 so I suspect it exists
in both trees and has been there for quite some time.

Under a heavy memory load (when __get_free_page(GFP_KERNEL) is occasionally
returning NULL) vmalloc can sometimes return a virtual address that is not
valid in all process contexts.  The resulting address will work in the
immediate context of the vmalloc() but can cause a fault if the address
is used after the scheduler has run (or within arbitrary interrupt contexts).

The problem occurs when vmalloc_area_pages() gets an -ENOMEM back from
alloc_area_pmd() and leaves the current process with a new page global
directory entry which is not replicated through all other process' pgds.
This isn't a problem for the majority of vmallocs (why, I don't quite
understand yet) but it is a problem when the area that was going to be
used spans *two* or more pgd entries.  Should a second vmalloc occur in
the near term and happen to get the same page for pte that was returned
after the error during the first, and use the second pgd slot, the
if (pgd_val(olddir) != pgd_val(*dir)) optimisation in vmalloc_area_pages()
will happily leave all other process pgds empty.

Anyway, it's too hard to see via inspection so I've attached a patch that
can be used to watch for the problem.  The following is a 2.2 patch (2.4
will follow in a few minutes).  If you see "vmalloc error" you might want
to uncomment the look_for_dangling_pgds function to get a better feel for
the pgds that cause the probem.

A brute force fix is to remove the if (pgd_val(olddir) != pgd_val(*dir))
optimisation and always update all pgds for every vmalloc (and swallow
the system wide set_pgdir() for all processors!).  This fix works but is
clearly non-optimal.

discussion?

duane

duanev@io.com
duanev@interactivesi.com


--- mm/vmalloc.c.orig   Sat Jan 27 13:21:53 2001
+++ mm/vmalloc.c        Tue Jan 30 19:00:18 2001
@@ -196,6 +196,53 @@
         printk("Trying to vfree() nonexistent vm area (%p)\n", addr);
  }

+
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
+                               if (pgd_val(*pgd_offset(p->mm, va)) == NULL)
+                                    printk("vfree: pgd %03lx is NULL but %03lx is not (in %s)\n",
+                                                       va >> PGDIR_SHIFT,
+                                                       addr >> PGDIR_SHIFT,
+                                                       p->comm);
+                       }
+               }
+       } while ((p = p->next_task) != &init_task);
+}
+
  void * vmalloc(unsigned long size)
  {
         void * addr;
@@ -210,8 +257,11 @@
         addr = area->addr;
         if (vmalloc_area_pages(VMALLOC_VMADDR(addr), size)) {
                 vfree(addr);
+//             duanev_look_for_dangling_pgds((unsigned long)addr, size);
                 return NULL;
         }
+       if (duanev_ensure_pgds_same((unsigned long)addr, size))
+               printk("   size = 0x%08lx\n", size);
         return addr;
  }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
