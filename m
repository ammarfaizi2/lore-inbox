Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264455AbRFIKSZ>; Sat, 9 Jun 2001 06:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264456AbRFIKSP>; Sat, 9 Jun 2001 06:18:15 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1796 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264455AbRFIKSC>; Sat, 9 Jun 2001 06:18:02 -0400
Date: Sat, 9 Jun 2001 14:14:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010609141445.A566@jurassic.park.msu.ru>
In-Reply-To: <20010608181612.A561@jurassic.park.msu.ru> <Pine.GSO.3.96.1010608172843.18837A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010608172843.18837A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jun 08, 2001 at 06:08:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 06:08:46PM +0200, Maciej W. Rozycki wrote:
>  Still it has two loops...

Ok, here is a single loop version.

Ivan.

--- 2.4.5-ac11/mm/mmap.c	Fri Jun  8 15:59:35 2001
+++ linux/mm/mmap.c	Sat Jun  9 12:50:05 2001
@@ -398,27 +398,37 @@ free_vma:
 static inline unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vma;
+	unsigned long addr_limit = TASK_SIZE - len;
+	unsigned long addr1 = 0;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
-		vma = find_vma(current->mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vma->vm_start))
-			return addr;
+		if (addr > TASK_UNMAPPED_BASE)
+			addr1 = addr;
+		goto find_free_area;
 	}
+
+default_area:
 	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
+find_free_area:
 	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
+		if (addr_limit < addr)
+			break;
 		if (!vma || addr + len <= vma->vm_start)
 			return addr;
 		addr = vma->vm_end;
 	}
+	if (addr1) {
+		/* No unmapped areas above addr; try below it */
+		addr_limit = addr1;
+		goto default_area;
+	}
+	return -ENOMEM;
 }
 #else
 extern unsigned long arch_get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
--- 2.4.5-ac11/include/linux/binfmts.h	Mon Jun  4 14:19:00 2001
+++ linux/include/linux/binfmts.h	Mon Jun  4 20:24:50 2001
@@ -32,6 +32,9 @@ struct linux_binprm{
 	unsigned long loader, exec;
 };
 
+/* Forward declaration */
+struct mm_struct;
+
 /*
  * This structure defines the functions that are used to load the binary formats that
  * linux accepts.
