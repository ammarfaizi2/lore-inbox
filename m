Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTKVEPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 23:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTKVEPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 23:15:24 -0500
Received: from uirapuru.fua.br ([200.129.163.1]:17292 "EHLO uirapuru.fua.br")
	by vger.kernel.org with ESMTP id S261974AbTKVEPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 23:15:18 -0500
Message-ID: <3028.200.208.224.8.1069467302.squirrel@webmail.ufam.edu.br>
Date: Sat, 22 Nov 2003 00:15:02 -0200 (BRST)
Subject: [PATCH] detailed physical memory info in fs/proc/task_mmu.c 
     [2.6.0-test9]
From: edjard@ufam.edu.br
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The piece of code below gives a richer information
at /proc/PID/status for a process PID.

BR,

Edjard
-------------------------------------------------------------------
10LE - Linux Lab at INDT
JOSE - Open Source dEvelopers at ufam.edu.br (site still under construction)

===================================================================
--- linux-2.6.0-test9/fs/proc/task_mmu.c   2003-10-25 14:43:00.000000000
-0400
+++ linux/fs/proc/task_mmu.c               2003-11-21 13:51:42.000000000
-0400 @@
-3,44 +3,87 @@
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>

+
+void phys_size_10LE(struct mm_struct *mm, unsigned long start_address,
unsigned long end_address, unsigned long *size) {
+  pgd_t *my_pgd;
+  pmd_t *my_pmd;
+  pte_t *my_pte;
+  unsigned long page;
+
+  for (page = start_address; page < end_address; page += PAGE_SIZE) { +
 my_pgd = pgd_offset(mm, page);
+    if (pgd_none(*my_pgd) || pgd_bad(*my_pgd)) break;
+    my_pmd = pmd_offset(my_pgd, page);
+    if (pmd_none(*my_pmd) || pmd_bad(*my_pmd)) break;
+    my_pte = pte_offset_map(my_pmd, page);
+    if (pte_present(*my_pte)) {
+      *size += PAGE_SIZE;
+    }
+  }
+}
+
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
-        unsigned long data = 0, stack = 0, exec = 0, lib = 0;
-        struct vm_area_struct *vma;
-
-        down_read(&mm->mmap_sem);
-        for (vma = mm->mmap; vma; vma = vma->vm_next) {
-                unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
-                if (!vma->vm_file) {
-                        data += len;
-                        if (vma->vm_flags & VM_GROWSDOWN)
-                                stack += len;
-                        continue;
-                }
-                if (vma->vm_flags & VM_WRITE)
-                        continue;
-                if (vma->vm_flags & VM_EXEC) {
-                        exec += len;
-                        if (vma->vm_flags & VM_EXECUTABLE)
-                                continue;
-                        lib += len;
-                }
-        }
-        buffer += sprintf(buffer,
-                "VmSize:\t%8lu kB\n"
-                "VmLck:\t%8lu kB\n"
-                "VmRSS:\t%8lu kB\n"
-                "VmData:\t%8lu kB\n"
-                "VmStk:\t%8lu kB\n"
-                "VmExe:\t%8lu kB\n"
-                "VmLib:\t%8lu kB\n",
-                mm->total_vm << (PAGE_SHIFT-10),
-                mm->locked_vm << (PAGE_SHIFT-10),
-                mm->rss << (PAGE_SHIFT-10),
-                data - stack, stack,
-                exec - lib, lib);
-        up_read(&mm->mmap_sem);
-        return buffer;
+  unsigned long data = 0, stack = 0, exec = 0, lib = 0;
+  unsigned long phys_data = 0, phys_stack = 0, phys_exec = 0, phys_lib =
0; +  unsigned long phys_brk = 0;
+  struct vm_area_struct *vma;
+  down_read(&mm->mmap_sem);
+  for (vma = mm->mmap; vma; vma = vma->vm_next) {
+    unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
+
+    if (!vma->vm_file) {
+      phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_data); +
if (vma->vm_flags & VM_GROWSDOWN) {
+        stack += len;
+        phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_stack);
+      }
+      else {
+        data += len;
+      }
+      continue;
+    }
+
+    if (vma->vm_flags & VM_WRITE)
+      continue;
+
+    if (vma->vm_flags & VM_EXEC) {
+      exec += len;
+      phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_exec); +
if (vma->vm_flags & VM_EXECUTABLE) {
+        continue;
+      }
+      lib += len;
+      phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_lib);
+    }
+  }
+  phys_size_10LE(mm, mm->start_brk, mm->brk, &phys_brk);
+  buffer += sprintf(buffer,
+                    "VmSize:\t%8lu kB\n"
+                    "VmLck:\t%8lu kB\n"
+                    "VmRSS:\t%8lu kB\n"
+                    "VmData:\t%8lu kB\n"
+                    "PhysicalData:\t%8lu kB\n"
+                    "VmStk:\t%8lu kB\n"
+                    "PhysicalStk:\t%8lu kB\n"
+                    "VmExe:\t%8lu kB\n"
+                    "PhysicalExe:\t%8lu kB\n"
+                    "VmLib:\t%8lu kB\n"
+                    "PhysicalLib:\t%8lu kB\n"
+                    "VmHeap: \t%8lu KB\n"
+                    "PhysicalHeap: \t%8lu KB\n",
+                    mm->total_vm << (PAGE_SHIFT-10),
+                    mm->locked_vm << (PAGE_SHIFT-10),
+                    mm->rss << (PAGE_SHIFT-10),
+                    data, (phys_data - phys_stack) >> 10,
+                    stack, phys_stack >> 10,
+                    exec - lib, (phys_exec - phys_lib) >> 10,
+                    lib, phys_lib >> 10,
+                    (mm->brk - mm->start_brk) >> 10,
+                    phys_brk >> 10
+                    );
+  up_read(&mm->mmap_sem);
+  return buffer;
 }

 unsigned long task_vsize(struct mm_struct *mm)
