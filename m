Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282747AbRLBEoE>; Sat, 1 Dec 2001 23:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282726AbRLBEny>; Sat, 1 Dec 2001 23:43:54 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:42257 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282728AbRLBEnp>; Sat, 1 Dec 2001 23:43:45 -0500
Message-ID: <3C09B168.401E61C9@zip.com.au>
Date: Sat, 01 Dec 2001 20:43:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: space-00002@vortex.physik.uni-konstanz.de
CC: linux-kernel@vger.kernel.org
Subject: Re: buffer/memory strangeness in 2.4.16 / 2.4.17pre2
In-Reply-To: <200111291201.fATC1pd04206@lists.us.dell.com> <200111292030.fATKU1s05921@vortex.physik.uni-konstanz.de> <3C075196.613894EA@zip.com.au>,
		<3C075196.613894EA@zip.com.au> <200112012209.fB1M92s12294@vortex.physik.uni-konstanz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

space-00002@vortex.physik.uni-konstanz.de wrote:
> 
> It is still the same in 2.4.17pre2 :-(
> 

Yes, well, it would be.

It seems that what's happening is that all your buffercache memory
is on the active list, and all your anonymous memory is on the
inactive list.   Consequently the logic in shrink_caches() which
is supposed to move pages onto the inactive list doesn't do anything - it
just sits there calling refill_inactive() with a zero argument all
the time.

You'll find that if you push the machine really hard - allocate
1.5x physical memory and touch it all then the VM will, eventually,
with great reluctance and much swapping, relinquish the 30 megabytes
of buffercache memory.  But it's out of whack.

I tested the pre7aa1 patches and it seemed possibly a little better,
but not right.

If we put anon pages on the active list instead, then shrink_caches()
and refill_inactive() start to do something, and they move that stale
old buffercache memory onto the inactive list where it can be freed.

This is just a random hack.  I don't understand what's going on in
the VM, let alone what's *supposed* to be going on.  And given the
state of documentation available to us,  I never will.


--- linux-2.4.17-pre2/mm/memory.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/mm/memory.c	Sat Dec  1 20:14:28 2001
@@ -1174,6 +1174,7 @@ static int do_anonymous_page(struct mm_s
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
 		lru_cache_add(page);
+		activate_page(page);
 	}
 
 	set_pte(page_table, entry);

-
