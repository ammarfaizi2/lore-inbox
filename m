Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTLOUjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTLOUjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:39:31 -0500
Received: from uirapuru.fua.br ([200.129.163.1]:21433 "EHLO uirapuru.fua.br")
	by vger.kernel.org with ESMTP id S262109AbTLOUjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:39:16 -0500
Message-ID: <33772.200.212.156.130.1071517210.squirrel@webmail.ufam.edu.br>
In-Reply-To: <20031215185701.GC1769@matchmail.com>
References: <20031214014429.GB1769@matchmail.com>
    <Pine.LNX.4.44.0312141915550.26386-100000@chimarrao.boston.redhat.com>
    <20031215185701.GC1769@matchmail.com>
Date: Mon, 15 Dec 2003 17:40:10 -0200 (BRST)
Subject: Re: Re: More questions about 2.6 /proc/meminfo was: (Mem: and 
     Swap: lines in /proc/meminfo)
From: edjard@ufam.edu.br
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "Rik van Riel" <riel@redhat.com>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Dec 14, 2003 at 07:17:05PM -0500, Rik van Riel wrote:
>> On Sat, 13 Dec 2003, Mike Fedyk wrote:
>>
>> > > > Are Dirty: and Writeback: counted in Inactive: or are they
>> seperate?
>> > >
>> > > They're unrelated statistics to active/inactive and will
>> > > overlap with active/inactive.
>> >
>> > Do they count anonymous memory, or are they strictly dirty/writeback
>> > pagecache?
>>
>> Pagecache only, I think.
>>
>
> That makes sence, since dirty anonymous memory should be swapped out, not
> "written back".
>
> Though dirty seems anbiguous, since it could contain dirty anon memory
> too.
> But, I think you are right.  On my idle system (with kde running), there's
> only 40KB "dirty" memory, so it's probably pagecache only.
>
> Thanks.
>
>> > > > Does Mapped: include all files mmap()ed, or only the executable
>> ones?
>> > >
>> > > Mapped: includes all mmap()ed pages, regardless of executable
>> > > status.
>> >
>> > Is mmap() always pagecache backed, or can it be backed with anonymous
>> > memory?  IE, can I subtract mapped from pagecache?
>>
>> Mapped includes all mapped memory, both pagecache and
>> anonymous.
>>
>
> Ok, then I can't subtract it from the pagecache value.  I'll have to graph
> that differently (a line instead of a stack).
>
> Thanks.
>
>> > I'd love to find a more accurate way to get the amount of memory used
>> for
>> > apps, short of reading the output of ps and doing calculations on RSS,
>> > VIRTUAL, and SHARED...
>>
>> That would be great, it would really help with tuning
>> the VM further (if that turns out to be needed for
>> special workloads).
>
> Any suggestions?

Some days ago we sent this patch for 2.6.0-test11, which gives some useful
information regarding these data you are requesting.

We are now changing this patch to provide the data you require. No body
answered so far if this is ok to be done by the kernel. We did not to
try to implement it as a module yet.

BR

Edjard

--- linux-2.6.0-test11/fs/proc/task_mmu.c	2003-11-26 18:43:07.000000000 -0200
+++ linux/fs/proc/task_mmu.c	2003-12-02 13:58:10.000000000 -0200
@@ -3,42 +3,83 @@
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>

+/**
+* Allan Bezerra (ajsb@dcc.fua.br) &
+* Bruna Moreira (brunampm@bol.com.br) &
+* Edjard Mota (edjard@ufam.edu.br) &
+* Mauricio Lin (mauriciolin@bol.com.br) &
+* Include a process PID physical memory size info in the /proc/PID/status
+*/
+
+void resident_mem_size(struct mm_struct *mm, unsigned long start_address,
unsigned long end_address, unsigned long *size)
+{
+	pgd_t *my_pgd;
+	pmd_t *my_pmd;
+	pte_t *my_pte;
+	unsigned long page;
+
+	for (page = start_address; page < end_address; page += PAGE_SIZE) {
+		my_pgd = pgd_offset(mm, page);
+		if (pgd_none(*my_pgd) || pgd_bad(*my_pgd)) continue;
+		my_pmd = pmd_offset(my_pgd, page);
+		if (pmd_none(*my_pmd) || pmd_bad(*my_pmd)) continue;
+		my_pte = pte_offset_map(my_pmd, page);
+		if (pte_present(*my_pte))
+			*size += PAGE_SIZE;
+	}
+}
+
 char *task_mem(struct mm_struct *mm, char *buffer)
 {
 	unsigned long data = 0, stack = 0, exec = 0, lib = 0;
 	struct vm_area_struct *vma;
-
+	unsigned long phys_data = 0, phys_stack = 0, phys_exec = 0, phys_lib =
0, phys_brk = 0;
 	down_read(&mm->mmap_sem);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
 		if (!vma->vm_file) {
 			data += len;
-			if (vma->vm_flags & VM_GROWSDOWN)
+			resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_data);
+			if (vma->vm_flags & VM_GROWSDOWN){
 				stack += len;
+				resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_stack);
+			}
 			continue;
 		}
 		if (vma->vm_flags & VM_WRITE)
 			continue;
 		if (vma->vm_flags & VM_EXEC) {
 			exec += len;
+			resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_exec);
 			if (vma->vm_flags & VM_EXECUTABLE)
 				continue;
 			lib += len;
+			resident_mem_size(mm, vma->vm_start, vma->vm_end, &phys_lib);
 		}
 	}
+	resident_mem_size(mm, mm->start_brk, mm->brk, &phys_brk);
 	buffer += sprintf(buffer,
 		"VmSize:\t%8lu kB\n"
 		"VmLck:\t%8lu kB\n"
 		"VmRSS:\t%8lu kB\n"
 		"VmData:\t%8lu kB\n"
+		"RssData:\t%8lu kB\n"
 		"VmStk:\t%8lu kB\n"
+		"RssStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
-		"VmLib:\t%8lu kB\n",
+		"RssExe:\t%8lu kB\n"
+		"VmLib:\t%8lu kB\n"
+		"RssLib:\t%8lu kB\n"
+		"VmHeap:\t%8lu KB\n"
+		"RssHeap:\t%8lu KB\n",
 		mm->total_vm << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		mm->rss << (PAGE_SHIFT-10),
-		data - stack, stack,
-		exec - lib, lib);
+		data - stack, (phys_data - phys_stack) >> 10,
+		stack, phys_stack >> 10,
+		exec - lib, (phys_exec - phys_lib) >> 10,
+		lib,  phys_lib >> 10,
+		(mm->brk - mm->start_brk) >> 10, phys_brk >> 10);
 	up_read(&mm->mmap_sem);
 	return buffer;
 }



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

