Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264009AbRFEPKQ>; Tue, 5 Jun 2001 11:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbRFEPKH>; Tue, 5 Jun 2001 11:10:07 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:26051 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264009AbRFEPJp>; Tue, 5 Jun 2001 11:09:45 -0400
Date: Tue, 5 Jun 2001 17:11:01 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
In-Reply-To: <20010604210835.A2907@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1010605170310.12987F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2001, Ivan Kokshaysky wrote:

> Indeed. Netscape is essentially 32 bit application, so probably
> it treats TASK_UNMAPPED_BASE (0x20000000000) as failure.
> A tad more respect of specified address fixes that.

 Iterating over memory areas twice is ugly.  Tom, could you please try the
following patch?  It should make things better with less ugliness.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.5-ac8-mmap-7
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

