Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135263AbREHUgL>; Tue, 8 May 2001 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135318AbREHUgB>; Tue, 8 May 2001 16:36:01 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:21708 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135263AbREHUf5>; Tue, 8 May 2001 16:35:57 -0400
Date: Tue, 8 May 2001 22:21:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-kernel@vger.kernel.org
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] 2.4.4: mmap() fails for certain legal requests
Message-ID: <Pine.GSO.3.96.1010508214647.4713B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 The mmap() call fails when addr is specified, MAP_FIXED is cleared in
flags and no address space can be allocated either at addr or above it. 
This is a legal request and it should not fail as long as there is space
available below addr.  Following is a patch that fixes the problem. 

 This is nothing new -- I already submitted a similar patch against
2.4.0-test4 once upon a time.  This patch is clean(er), though, and I
believe it can be safely applied to the upcoming 2.4.5 release. 

 A simple test case to trigger the current mmap() bad behaviour for 32-bit
CPUs is something like: 

fd = open("/dev/zero", O_RDONLY);
p = mmap((void *)0xfffff000, 4096, PROT_READ, MAP_SHARED, fd, 0);

With my patch the code does not fail anymore -- p is set to an available
address lower than 0xfffff000. 

 The bug was discovered when tracking down the reason of dlopen() failures
when called from statically linked binaries on MIPS/Linux.  The patch
fixes them.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -up --recursive --new-file linux-2.4.4.macro/mm/mmap.c linux-2.4.4/mm/mmap.c
--- linux-2.4.4.macro/mm/mmap.c	Tue May  1 17:24:25 2001
+++ linux-2.4.4/mm/mmap.c	Tue May  1 18:23:25 2001
@@ -219,7 +219,7 @@ unsigned long do_mmap_pgoff(struct file 
 	if ((len = PAGE_ALIGN(len)) == 0)
 		return addr;
 
-	if (len > TASK_SIZE || addr > TASK_SIZE-len)
+	if (len > TASK_SIZE)
 		return -EINVAL;
 
 	/* offset overflow? */
@@ -405,9 +405,15 @@ static inline unsigned long arch_get_unm
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
-	if (!addr)
-		addr = TASK_UNMAPPED_BASE;
-	addr = PAGE_ALIGN(addr);
+
+	if (addr) {
+		addr = PAGE_ALIGN(addr);
+		vma = find_vma(current->mm, addr);
+		if (TASK_SIZE - len >= addr &&
+		    (!vma || addr + len <= vma->vm_start))
+			return addr;
+	}
+	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
@@ -425,6 +431,8 @@ extern unsigned long arch_get_unmapped_a
 unsigned long get_unmapped_area(struct file *file, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	if (flags & MAP_FIXED) {
+		if (addr > TASK_SIZE - len)
+			return -EINVAL;
 		if (addr & ~PAGE_MASK)
 			return -EINVAL;
 		return addr;

