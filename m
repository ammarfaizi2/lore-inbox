Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278108AbRJZKEl>; Fri, 26 Oct 2001 06:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278146AbRJZKEc>; Fri, 26 Oct 2001 06:04:32 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:40438 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S278108AbRJZKE1>; Fri, 26 Oct 2001 06:04:27 -0400
Date: Fri, 26 Oct 2001 12:01:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Richard Henderson <rth@redhat.com>
cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: fix taso osf emulation
In-Reply-To: <20011026013101.A1404@redhat.com>
Message-ID: <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2001, Richard Henderson wrote:

> Required to get a dynamicly linked osf taso application working.
> Like netscape.  Which unfortunately still works better than mozilla
> for many things.

 The following trivial patch reportedly fixes OSF/1 programs using 31-bit
addressing.  It's already present in the -ac tree; I guess it just got
lost during a merge.  It applies fine to 2.4.13. 

> Thoughts on changing all ports such that a mmap with a non-zero,
> non-MAP_FIXED address starts the vma search at that address, 
> rather than looking for that exact address then checking the
> regular unmapped base?

 It used to do so.  It breaks things such as dynamic linking of shared
objects linked at high load address.  It breaks mmap() in principle, as it
shouldn't fail when invoked with a non-zero, non-MAP_FIXED, invalid
address if there is still address space available elsewhere. 

 The following patch approximates the idea with no negative impact.

 I cannot run an Alpha/Linux system anymore thus I can't immediately see
if a patch gets missed, sorry.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-2.4.5-ac8.macro/arch/ia64/kernel/sys_ia64.c linux-2.4.5-ac8/arch/ia64/kernel/sys_ia64.c
--- linux-2.4.5-ac8.macro/arch/ia64/kernel/sys_ia64.c	Tue Jun  5 14:22:10 2001
+++ linux-2.4.5-ac8/arch/ia64/kernel/sys_ia64.c	Tue Jun  5 14:46:14 2001
@@ -39,11 +39,15 @@ arch_get_unmapped_area (struct file *fil
 		    rgn_offset(addr) + len <= RGN_MAP_LIMIT) &&
 		    (!vmm || addr + len <= vmm->vm_start))
 			return addr;
+		if (addr > TASK_UNMAPPED_BASE)
+			addr = 0;
+	}
+	if (!addr) {
+		if (flags & MAP_SHARED)
+			addr = COLOR_ALIGN(TASK_UNMAPPED_BASE);
+		else
+			addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 	}
-	if (flags & MAP_SHARED)
-		addr = COLOR_ALIGN(TASK_UNMAPPED_BASE);
-	else
-		addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
diff -up --recursive --new-file linux-2.4.5-ac8.macro/arch/sparc/kernel/sys_sparc.c linux-2.4.5-ac8/arch/sparc/kernel/sys_sparc.c
--- linux-2.4.5-ac8.macro/arch/sparc/kernel/sys_sparc.c	Tue Jun  5 14:22:10 2001
+++ linux-2.4.5-ac8/arch/sparc/kernel/sys_sparc.c	Tue Jun  5 14:39:49 2001
@@ -69,11 +69,15 @@ unsigned long arch_get_unmapped_area(str
 		if (TASK_SIZE - PAGE_SIZE - len >= addr &&
 		    (!vmm || addr + len <= vmm->vm_start))
 			return addr;
+		if (addr > TASK_UNMAPPED_BASE)
+			addr = 0;
+	}
+	if (!addr) {
+		if (flags & MAP_SHARED)
+			addr = COLOUR_ALIGN(TASK_UNMAPPED_BASE);
+		else
+			addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 	}
-	if (flags & MAP_SHARED)
-		addr = COLOUR_ALIGN(TASK_UNMAPPED_BASE);
-	else
-		addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
diff -up --recursive --new-file linux-2.4.5-ac8.macro/arch/sparc64/kernel/sys_sparc.c linux-2.4.5-ac8/arch/sparc64/kernel/sys_sparc.c
--- linux-2.4.5-ac8.macro/arch/sparc64/kernel/sys_sparc.c	Tue Jun  5 14:22:10 2001
+++ linux-2.4.5-ac8/arch/sparc64/kernel/sys_sparc.c	Tue Jun  5 14:44:19 2001
@@ -76,11 +76,15 @@ unsigned long arch_get_unmapped_area(str
 		if (task_size >= addr &&
 		    (!vmm || addr + len <= vmm->vm_start))
 			return addr;
+		if (addr > TASK_UNMAPPED_BASE)
+			addr = 0;
+	}
+	if (!addr) {
+		if (flags & MAP_SHARED)
+			addr = COLOUR_ALIGN(TASK_UNMAPPED_BASE);
+		else
+			addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 	}
-	if (flags & MAP_SHARED)
-		addr = COLOUR_ALIGN(TASK_UNMAPPED_BASE);
-	else
-		addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
 		/* At this point:  (!vmm || addr < vmm->vm_end). */
diff -up --recursive --new-file linux-2.4.5-ac8.macro/mm/mmap.c linux-2.4.5-ac8/mm/mmap.c
--- linux-2.4.5-ac8.macro/mm/mmap.c	Tue Jun  5 14:22:29 2001
+++ linux-2.4.5-ac8/mm/mmap.c	Tue Jun  5 14:45:57 2001
@@ -408,8 +408,11 @@ static inline unsigned long arch_get_unm
 		if (TASK_SIZE - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
+		if (addr > TASK_UNMAPPED_BASE)
+			addr = 0;
 	}
-	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
+	if (!addr)
+		addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */

