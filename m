Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRJZKpt>; Fri, 26 Oct 2001 06:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278313AbRJZKpk>; Fri, 26 Oct 2001 06:45:40 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:62989 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S278275AbRJZKpb>; Fri, 26 Oct 2001 06:45:31 -0400
Date: Fri, 26 Oct 2001 14:45:22 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Richard Henderson <rth@redhat.com>, torvalds@transmeta.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: fix taso osf emulation
Message-ID: <20011026144522.B18880@jurassic.park.msu.ru>
In-Reply-To: <20011026013101.A1404@redhat.com> <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Oct 26, 2001 at 12:01:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 12:01:10PM +0200, Maciej W. Rozycki wrote:
> On Fri, 26 Oct 2001, Richard Henderson wrote:
> > Thoughts on changing all ports such that a mmap with a non-zero,
> > non-MAP_FIXED address starts the vma search at that address, 
> > rather than looking for that exact address then checking the
> > regular unmapped base?
> 
>  It used to do so.  It breaks things such as dynamic linking of shared
> objects linked at high load address.  It breaks mmap() in principle, as it
> shouldn't fail when invoked with a non-zero, non-MAP_FIXED, invalid
> address if there is still address space available elsewhere. 

Maciej and I discussed all this a while back, and I had a patch
which did exactly that that Richard suggested, plus:
 as far as I can tell, it conforms to any existing mmap(2) documentation;
 is more effective than current implementation, as I call the second
 find_vma() only after VM wraparound, which is extremely rare;
 keeps osf /sbin/loader happy, so no need for alpha-specific routine.
Patch appended, comments?

Ivan.

P.S. Just noticed missing closing brace in the patch from my previous post...
     Sorry.

--- 2.4.13/mm/mmap.c	Sun Sep 30 22:05:40 2001
+++ linux/mm/mmap.c	Fri Oct 26 13:36:47 2001
@@ -590,27 +590,38 @@ free_vma:
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
+		addr1 = 0;
+		goto default_area;
+	}
+	return -ENOMEM;
 }
 #else
 extern unsigned long arch_get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
