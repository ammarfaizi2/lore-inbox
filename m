Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264059AbRFERos>; Tue, 5 Jun 2001 13:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264060AbRFERoi>; Tue, 5 Jun 2001 13:44:38 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:18948 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264059AbRFERoa>; Tue, 5 Jun 2001 13:44:30 -0400
Date: Tue, 5 Jun 2001 21:41:07 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010605214107.A566@jurassic.park.msu.ru>
In-Reply-To: <20010604210835.A2907@jurassic.park.msu.ru> <Pine.GSO.3.96.1010605170310.12987F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010605170310.12987F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jun 05, 2001 at 05:11:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 05:11:01PM +0200, Maciej W. Rozycki wrote:
>  Iterating over memory areas twice is ugly.

Hmm, yes. However, your patch isn't pretty, too. You may check
the same area twice, and won't satisfy requested address > TASK_UNMAPPED_BASE.
What do you think about following? Everything is scanned only once, and
returned address matches specified one as close as possible.

Ivan.

--- linux/mm/mmap.c.orig	Mon Jun  4 14:19:02 2001
+++ linux/mm/mmap.c	Tue Jun  5 21:05:23 2001
@@ -398,22 +398,30 @@ free_vma:
 static inline unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vma;
+	unsigned long addr_limit = TASK_SIZE - len;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
-		vma = find_vma(current->mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vma->vm_start))
-			return addr;
+		if (addr <= TASK_UNMAPPED_BASE)
+			goto scan_low;
+		addr_limit = addr;
+		for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+			if (TASK_SIZE - len < addr)
+				break;
+			if (!vma || addr + len <= vma->vm_start)
+				return addr;
+			addr = vma->vm_end;
+		}
 	}
 	addr = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
+scan_low:
 	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr)
+		if (addr_limit < addr)
 			return -ENOMEM;
 		if (!vma || addr + len <= vma->vm_start)
 			return addr;
