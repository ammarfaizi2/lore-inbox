Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTKVPxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 10:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTKVPxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 10:53:44 -0500
Received: from uirapuru.fua.br ([200.129.163.1]:18586 "EHLO uirapuru.fua.br")
	by vger.kernel.org with ESMTP id S262355AbTKVPxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 10:53:39 -0500
Date: Sat, 22 Nov 2003 11:52:52 -0200 (BRST)
From: Edjard de Souza Mota <edjard@uirapuru.fua.br>
To: Gene Heskett <gene.heskett@verizon.net>
cc: edjard@ufam.edu.br, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       muriciolin@bol.com.br, ajsb@dcc.fua.br
Subject: Re: [PATCH] detailed physical memory info in fs/proc/task_mmu.c   
   [2.6.0-test9]
In-Reply-To: <200311220151.51069.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.53.0311221148480.30391@uirapuru.fua.br>
References: <3028.200.208.224.8.1069467302.squirrel@webmail.ufam.edu.br>
 <200311220151.51069.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again,

Here it goes in plain text from a decent terminal.

--- linux-2.6.0-test9/fs/proc/task_mmu.c        2003-10-25
14:43:00.000000000 -0400
+++ linux/fs/proc/task_mmu.c    2003-11-22 10:26:59.000000000 -0400
@@ -3,44 +3,105 @@
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>

+/**
+* Allan Bezerra (ajsb@dcc.fua.br) &
+* Mauricio Lin  (mauriciolin@bol.com.br) &
+* Edjard Mota   (edjard@ufam.edu.br) :   include a process PID physical
memory size allocation
+*                                        info in the /proc/PID/status
+*/
+void phys_size_10LE(struct mm_struct *mm, unsigned long start_address,
unsigned long end_address, unsigned long *size) {
+  pgd_t *my_pgd;
+  pmd_t *my_pmd;
+  pte_t *my_pte;
+  unsigned long page;
+
+  for (page = start_address; page < end_address; page += PAGE_SIZE) {
+    my_pgd = pgd_offset(mm, page);
+    if (pgd_none(*my_pgd) || pgd_bad(*my_pgd)) continue;
+    my_pmd = pmd_offset(my_pgd, page);
+    if (pmd_none(*my_pmd) || pmd_bad(*my_pmd)) continue;
+    my_pte = pte_offset_map(my_pmd, page);
+    if (pte_present(*my_pte)) {
+      *size += PAGE_SIZE;
+    }
+  }
+}
+
+/* This isn't working properly yet, that's why it in comments.
+void shared_size_10LE(struct vm_area_struct *vma, unsigned long len,
unsigned long *shared) {
+   if (is_vm_hugetlb_page(vma)) {
+      if (!(vma->vm_flags & VM_DONTCOPY))
+       *shared += len;
+    }
+
+    if (vma->vm_flags & VM_SHARED || !list_empty(&vma->shared))
+      *shared += len;
+}
+*/
+
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
-       unsigned long data = 0, stack = 0, exec = 0, lib = 0;
-       struct vm_area_struct *vma;
-
-       down_read(&mm->mmap_sem);
-       for (vma = mm->mmap; vma; vma = vma->vm_next) {
-               unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
-               if (!vma->vm_file) {
-                       data += len;
-                       if (vma->vm_flags & VM_GROWSDOWN)
-                               stack += len;
-                       continue;
-               }
-               if (vma->vm_flags & VM_WRITE)
-                       continue;
-               if (vma->vm_flags & VM_EXEC) {
-                       exec += len;
-                       if (vma->vm_flags & VM_EXECUTABLE)
-                               continue;
-                       lib += len;
-               }
-       }
-       buffer += sprintf(buffer,
-               "VmSize:\t%8lu kB\n"
-               "VmLck:\t%8lu kB\n"
-               "VmRSS:\t%8lu kB\n"
-               "VmData:\t%8lu kB\n"
-               "VmStk:\t%8lu kB\n"
-               "VmExe:\t%8lu kB\n"
-               "VmLib:\t%8lu kB\n",
-               mm->total_vm << (PAGE_SHIFT-10),
-               mm->locked_vm << (PAGE_SHIFT-10),
-               mm->rss << (PAGE_SHIFT-10),
-               data - stack, stack,
-               exec - lib, lib);
-       up_read(&mm->mmap_sem);
-       return buffer;
+  unsigned long data = 0, stack = 0, exec = 0, lib = 0;
+  unsigned long phys_data = 0, phys_stack = 0, phys_exec = 0, phys_lib =
0;
+  unsigned long phys_brk = 0, my_rss=0;
+  struct vm_area_struct *vma;
+  down_read(&mm->mmap_sem);
+  for (vma = mm->mmap; vma; vma = vma->vm_next) {
+    unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
+    phys_size_10LE(mm, vma->vm_start, vma->vm_end, &my_rss);
+    if (!vma->vm_file) {
+      phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_data);
+      if (vma->vm_flags & VM_GROWSDOWN) {
+       stack += len;
+       phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_stack);
+      }
+      else {
+       data += len;
+      }
+      continue;
+    }
+
+    if (vma->vm_flags & VM_WRITE)
+      continue;
+
+    if (vma->vm_flags & VM_EXEC) {
+      exec += len;
+      phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_exec);
+      if (vma->vm_flags & VM_EXECUTABLE) {
+       continue;
+      }
+      lib += len;
+      phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_lib);
+    }
+  }
+  phys_size_10LE(mm, mm->start_brk, mm->brk, &phys_brk);
+  buffer += sprintf(buffer,
+                   "VmSize:\t%8lu kB\n"
+                   "VmLck:\t%8lu kB\n"
+                   "VmRSS:\t%8lu kB\n"
+                   "VmData:\t%8lu kB\n"
+                   "PhysicalData:\t%8lu kB\n"
+                   "VmStk:\t%8lu kB\n"
+                   "PhysicalStk:\t%8lu kB\n"
+                   "VmExe:\t%8lu kB\n"
+                   "PhysicalExe:\t%8lu kB\n"
+                   "VmLib:\t%8lu kB\n"
+                   "PhysicalLib:\t%8lu kB\n"
+                   "VmHeap: \t%8lu KB\n"
+                   "PhysicalHeap: \t%8lu KB\n"
+                   "MyRSS: \t%8lu KB\n",
+                   mm->total_vm << (PAGE_SHIFT-10),
+                   mm->locked_vm << (PAGE_SHIFT-10),
+                   mm->rss << (PAGE_SHIFT-10),
+                   data, (phys_data - phys_stack) >> 10,
+                   stack, phys_stack >> 10,
+                   exec - lib, (phys_exec - phys_lib) >> 10,
+                   lib, phys_lib >> 10,
+                   (mm->brk - mm->start_brk) >> 10,
+                   phys_brk >> 10, my_rss >> 10
+                   );
+  up_read(&mm->mmap_sem);
+  return buffer;
 }

 unsigned long task_vsize(struct mm_struct *mm)
