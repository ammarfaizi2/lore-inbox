Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276341AbRJ2QgC>; Mon, 29 Oct 2001 11:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276305AbRJ2Qfw>; Mon, 29 Oct 2001 11:35:52 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:23812 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S276312AbRJ2Qfl>; Mon, 29 Oct 2001 11:35:41 -0500
Date: Mon, 29 Oct 2001 19:35:00 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@redhat.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, torvalds@transmeta.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: fix taso osf emulation
Message-ID: <20011029193500.A771@jurassic.park.msu.ru>
In-Reply-To: <20011026013101.A1404@redhat.com> <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl> <20011026144522.B18880@jurassic.park.msu.ru> <20011026101145.D1663@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011026101145.D1663@redhat.com>; from rth@redhat.com on Fri, Oct 26, 2001 at 10:11:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 10:11:45AM -0700, Richard Henderson wrote:
> Yes there is, since TASO applications need to wrap at 1<<31, 
> not TASK_SIZE.  Note that TASK_SIZE should _not_ be changed
> for TASO applications, since they can explicitly map memory
> above 4G.  An example here is em86, in which the low 4G is
> reserved for the emulated program, and the emulator lives in
> high memory.

I see. I was confused by the fact that netscape did work with
kernels < 2.4.9. Which only means that netscape never calls
mmap() with zero address...

> I think you're working too hard to make this "efficient", and
> in the process making the code hard to read.  A subroutine
> containing a simple search-forward loop is just as effective.

Ok. After converting that from assembly to C I've got your
version of arch_get_unmapped_area :-)  with small changes
(to avoid searching the same areas 2 or 3 times).

Ivan.

--- linux/arch/alpha/kernel/osf_sys.c.rth	Mon Oct 29 17:43:53 2001
+++ linux/arch/alpha/kernel/osf_sys.c	Mon Oct 29 18:14:46 2001
@@ -1342,11 +1342,11 @@ arch_get_unmapped_area_1(unsigned long a
 }
 
 unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
+arch_get_unmapped_area(struct file *filp, unsigned long start,
 		       unsigned long len, unsigned long pgoff,
 		       unsigned long flags)
 {
-	unsigned long limit;
+	unsigned long limit, addr;
 
 	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
 	if (current->personality & ADDR_LIMIT_32BIT)
@@ -1367,10 +1367,12 @@ arch_get_unmapped_area(struct file *filp
 	   merely specific addresses, but regions of memory -- perhaps
 	   this feature should be incorporated into all ports?  */
 
-	if (addr) {
-		addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
+	if (start) {
+		start = PAGE_ALIGN(start);
+		addr = arch_get_unmapped_area_1 (start, len, limit);
 		if (addr != -ENOMEM)
 			return addr;
+		limit = start;
 	}
 
 	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
@@ -1378,6 +1380,8 @@ arch_get_unmapped_area(struct file *filp
 					 len, limit);
 	if (addr != -ENOMEM)
 		return addr;
+
+	limit = PAGE_ALIGN(TASK_UNMAPPED_BASE);
 
 	/* Finally, try allocating in low memory.  */
 	addr = arch_get_unmapped_area_1 (PAGE_SIZE, len, limit);
