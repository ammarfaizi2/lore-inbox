Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTKUTUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTKUTUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:20:19 -0500
Received: from uirapuru.fua.br ([200.129.163.1]:50636 "EHLO uirapuru.fua.br")
	by vger.kernel.org with ESMTP id S264419AbTKUTT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:19:59 -0500
Message-ID: <29020.200.212.156.130.1069438907.squirrel@webmail.ufam.edu.br>
Date: Fri, 21 Nov 2003 16:21:47 -0200 (BRST)
Subject: kernel2.6.0-test9: Adding process physical memory detailed info in 
     /proc/PID/status]
From: edjard@ufam.edu.br
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The kernel we used was the 2.6.0-test9.

BR,

Edjard

--------------------------- Original Message ----------------------------
Subject: Adding process physical memoy detailed info in /proc/PID/status
From:      edjard@ufam.edu.br
Data:    Fri, Novembro 21, 2003 3:47 pm
To:    linux-kernel@vger.kernel.org
CC:      Mauricio.Lin@indt.org.br
         Allan.Bezerra@indt.org.br
--------------------------------------------------------------------------

Hi There,

We needed to add a detailed info about the physical memory space
allocated for a given process PID in the /proc/PID/status, similar to the
pmap of Solaris. Although you may argue the reasons
of doing that, we are building a performance tool analyser which
needs such info.

We think this may be of use to someone else. We're not sure whether the
proper place to do that is in the kernel or via module. Anyway, below is
the patch, followed by an example, of a new output for
/proc/PID/status

Thanks for any comment,

BR,

Edjard
-----------------------------------------------
10LE/INdT - Labaratorio de Linux
JOSE - Jungle Open Source dEvelopers
Manaus, Amazon - Brazil
-----------------------------------------------


--- linux/fs/proc/task_mmu.c	2003-10-25 14:43:00.000000000 -0400
+++ linux/fs/proc/task_mmu.c-10LE	2003-11-21 13:51:42.000000000 -0400 @@
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
-	unsigned long data = 0, stack = 0, exec = 0, lib = 0;
-	struct vm_area_struct *vma;
-
-	down_read(&mm->mmap_sem);
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
-		if (!vma->vm_file) {
-			data += len;
-			if (vma->vm_flags & VM_GROWSDOWN)
-				stack += len;
-			continue;
-		}
-		if (vma->vm_flags & VM_WRITE)
-			continue;
-		if (vma->vm_flags & VM_EXEC) {
-			exec += len;
-			if (vma->vm_flags & VM_EXECUTABLE)
-				continue;
-			lib += len;
-		}
-	}
-	buffer += sprintf(buffer,
-		"VmSize:\t%8lu kB\n"
-		"VmLck:\t%8lu kB\n"
-		"VmRSS:\t%8lu kB\n"
-		"VmData:\t%8lu kB\n"
-		"VmStk:\t%8lu kB\n"
-		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
-		mm->total_vm << (PAGE_SHIFT-10),
-		mm->locked_vm << (PAGE_SHIFT-10),
-		mm->rss << (PAGE_SHIFT-10),
-		data - stack, stack,
-		exec - lib, lib);
-	up_read(&mm->mmap_sem);
-	return buffer;
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
+	stack += len;
+	phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_stack);
+      }
+      else {
+	data += len;
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
+	continue;
+      }
+      lib += len;
+      phys_size_10LE(mm, vma->vm_start, vma->vm_end, &phys_lib);
+    }
+  }
+  phys_size_10LE(mm, mm->start_brk, mm->brk, &phys_brk);
+  buffer += sprintf(buffer,
+		    "VmSize:\t%8lu kB\n"
+		    "VmLck:\t%8lu kB\n"
+		    "VmRSS:\t%8lu kB\n"
+		    "VmData:\t%8lu kB\n"
+		    "PhysicalData:\t%8lu kB\n"
+		    "VmStk:\t%8lu kB\n"
+		    "PhysicalStk:\t%8lu kB\n"
+		    "VmExe:\t%8lu kB\n"
+		    "PhysicalExe:\t%8lu kB\n"
+		    "VmLib:\t%8lu kB\n"
+		    "PhysicalLib:\t%8lu kB\n"
+		    "VmHeap: \t%8lu KB\n"
+		    "PhysicalHeap: \t%8lu KB\n",
+		    mm->total_vm << (PAGE_SHIFT-10),
+		    mm->locked_vm << (PAGE_SHIFT-10),
+		    mm->rss << (PAGE_SHIFT-10),
+		    data, (phys_data - phys_stack) >> 10,
+		    stack, phys_stack >> 10,
+		    exec - lib, (phys_exec - phys_lib) >> 10,
+		    lib, phys_lib >> 10,
+		    (mm->brk - mm->start_brk) >> 10,
+		    phys_brk >> 10
+		    );
+  up_read(&mm->mmap_sem);
+  return buffer;
 }

 unsigned long task_vsize(struct mm_struct *mm)


---------------------  END OF PATCH -----------------------------


Here is an output of a new /proc/PID/stat

Originally the command 'cat /proc/PID/status' does not provide the
information in physical memory of the process with PID. As you can see in
the example below physical memory allocation is detailed.
>
> $ cat /proc/1718/status
> Name:        opera
> State:        S (sleeping)
> SleepAVG:        101%
> Tgid:        1718
> Pid:        1718
> PPid:        1631
> TracerPid:        0
> Uid:        500        500        500        500
> Gid:        501        501        501        501
> FDSize:        256
> Groups:        501
> VmSize:           35792 kB
> VmLck:                kB
> VmRSS:           21156 kB
> VmData:            5920 kB
> PhysicalData:            5556 kB
> VmStk:              68 kB
> PhysicalStk:              40 kB
> VmExe:            5124 kB
> PhysicalExe:            3408 kB
> VmLib:           19244 kB
> PhysicalLib:           10240 kB
> HeapSize:             5184 KB
> PhysicalHeap:             5124 KB
> Threads:        1
> SigPnd:        0000000000000000
> ShdPnd:        0000000000000000
> SigBlk:        0000000100000000
> SigIgn:        8000000010001000
> SigCgt:        0000000080010000
> CapInh:        0000000000000000
> CapPrm:        0000000000000000
> CapEff:        0000000000000000
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html Please
read the FAQ at  http://www.tux.org/lkml/


