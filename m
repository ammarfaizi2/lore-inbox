Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUAOBMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbUAOBMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:12:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:23533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264398AbUAOBMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:12:08 -0500
Date: Wed, 14 Jan 2004 17:12:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, jsun@mvista.com,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BUG] 2.6.1/MIPS - missing cache flushing when user program
 returns pages to kernel
Message-Id: <20040114171252.4d873c51.akpm@osdl.org>
In-Reply-To: <20040114163920.E13471@mvista.com>
References: <20040114163920.E13471@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Sun <jsun@mvista.com> wrote:
>
> I have been chasing a nasty memory corruption bug on my MIPS box with
> 2.6.1 kernel.  In the end it appears the following sequence has
> happened:
> 
> 1. userland gets a page and writes some stuff to it, which dirties
>    data cache.  In my case, it is actually doing a sys_read() into
>    that page.  See my kgdb trace attached in the end.
> 
> 2. userland returns this page to kernel *without* any cache flushing,
>    i.e., the dcache is still dirty.
> 
> 3. kernel calls kmalloc() to get a block from this page.
> 
> 4. the dirty dcache is written back to physical memory some time later,
>    corrupting the kernel data.
> 
> It seems to me the problem is that we should do a cache flush 
> for all the pages returned to kernel during step 2.
> 
> I attached a hack which solves my problem but I am not sure if it is
> most appropriate.  It looks like the affected user region (start, end)
> can span over multiple vma areas.  If so, the fix will only flush the first
> area.
> 
> Also, it is hard to find an appropriate place to do the flushing
> The new 2.6 mm is a confusing maze to me.  I hope someone more
> knowledgable can come up with a more decent fix for this problem.
> 
> BTW, it appears in 2.4 we are doing this flushing in do_zap_page_range()
> where we call a flush_cache_range(mm, start, end).

That flush_cache_range was removed between 2.5.67 and 2.5.68.  If you put
it back, does it fix the problem?

It seems from Russell's words here, MIPS should be flushing in
tlb_start_vma().

I think that's wrong, really.  We've discussed this before and decided that
these flushing operations should be open-coded in the main .c file rather
than embedded in arch functions which happen to undocumentedly do other
stuff.


# --------------------------------------------
# 03/04/14	rmk@arm.linux.org.uk	1.1017
# [PATCH] flush_cache_mm in zap_page_range
# 
# unmap_vmas() eventually calls tlb_start_vma(), where most architectures
# flush caches as necessary.  The flush here seems to make the
# flush_cache_range() in zap_page_range() redundant, and therefore can be
# removed.
# --------------------------------------------
#
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Wed Jan 14 17:09:07 2004
+++ b/mm/memory.c	Wed Jan 14 17:09:07 2004
@@ -601,7 +601,6 @@
 
 	lru_add_drain();
 	spin_lock(&mm->page_table_lock);
-	flush_cache_range(vma, address, end);
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, address, end, &nr_accounted);
 	tlb_finish_mmu(tlb, address, end);

