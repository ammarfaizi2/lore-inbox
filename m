Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbRESMHo>; Sat, 19 May 2001 08:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbRESMHe>; Sat, 19 May 2001 08:07:34 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:48136 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S261783AbRESMHV>;
	Sat, 19 May 2001 08:07:21 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15110.24906.266675.625534@tango.paulus.ozlabs.org>
Date: Sat, 19 May 2001 22:04:26 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: icache flushing in kernel/ptrace.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to change kernel/ptrace.c to call something else instead
of flush_icache_page in access_one_page in kernel/ptrace.c.  Currently
it calls flush_icache_page on the page after modifying it.  Now of
course on many architectures (including PPC) we need to do some sort
of i-cache flush - my contention is that flush_icache_page is the
wrong interface, we should be calling flush_icache_range or something
like it instead.

The problem with flush_icache_page is that it is also called in
do_no_page and do_swap_page in mm/memory.c.  In the do_no_page case it
is called on a page which we have usually just got from the page
cache.  If the page is clean and has previously had the i-cache
flushed for it then there is no need to do the flush again.  But there
is no way (no reasonable way, anyway) for flush_icache_page to tell
whether it has been called from do_no_page or from access_one_page.

I have been able to get good speedups on PPC by using the PG_arch_1
bit on the page to indicate whether a page is i-cache clean (has had
the flush done), by delaying flushing until necessary (i.e. until a
process maps in the page and has requested execute permission on it),
and by not flushing the page if it has already been flushed.  (Anton
Blanchard has actually done a lot of this work with input from Dave
Miller.)

But to do this I need to make flush_icache_page do nothing, which
breaks ptrace.  For now I have duplicated most of the contents of
kernel/ptrace.c inside arch/ppc/kernel/ptrace.c and changed the
flush_icache_page to flush_icache_range (with appropriate parameters)
to fix this.  But this is not ideal.

AFAICT the architectures that need to maintain i-cache coherency in
software are alpha, ia64, m68k, mips, mips64, parisc, ppc and sparc64.
There seems to be a lot of variation in the assumptions about what
sorts of addresses flush_icache_range will be used on and what it
should do.

Going by the name, flush_icache_range would be the ideal interface for
flushing the range of bytes that have been modified by
access_one_page.  But it looks to me like using it might be suboptimal
on other architectures, e.g. alpha, due to the way that
flush_icache_range has been implemented.

Anyway, here's a proposed patch.  Could the various architecture
maintainers (particularly alpha) comment on what the impact would be
on their architectures?  If flush_icache_range isn't the right
interface either, could we invent one that would be?

Thanks,
Paul.

diff -urN linux/kernel/ptrace.c pmac/kernel/ptrace.c
--- linuxppc_2_4/kernel/ptrace.c	Wed Mar 21 09:39:08 2001
+++ pmac/kernel/ptrace.c	Mon Apr 16 12:00:11 2001
@@ -58,10 +58,11 @@
 	flush_cache_page(vma, addr);
 
 	if (write) {
-		maddr = kmap(page);
-		memcpy(maddr + (addr & ~PAGE_MASK), buf, len);
+		maddr = kmap(page) + (addr & ~PAGE_MASK);
+		memcpy(maddr, buf, len);
 		flush_page_to_ram(page);
-		flush_icache_page(vma, page);
+		flush_icache_range((unsigned long) maddr,
+				   (unsigned long) maddr + len);
 		kunmap(page);
 	} else {
 		maddr = kmap(page);
