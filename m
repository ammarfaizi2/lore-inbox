Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288283AbSA2Bay>; Mon, 28 Jan 2002 20:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSA2Baj>; Mon, 28 Jan 2002 20:30:39 -0500
Received: from waste.org ([209.173.204.2]:17896 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288274AbSA2BaV>;
	Mon, 28 Jan 2002 20:30:21 -0500
Date: Mon, 28 Jan 2002 19:29:49 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <E16VHy5-0000Bz-00@starship.berlin>
Message-ID: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Daniel Phillips wrote:

>   copy_page_range
>     Intead of copying the page tables, just increment their use counts
>
>   zap_page_range:
>     If a page table is shared according to its use count, just decrement
>     the use count and otherwise leave it alone.
>
>   handle_mm_fault:
>     If a page table is shared according to its use count and the faulting
>     instruction is a write, allocate a new page table and do the work that
>     would have normally been done by copy_page_range at fork time.
>     Decrement the use count of the (perhaps formerly) shared page table.

Somewhere in here, the pages have got to all be marked read-only or
something. If they're not, then either parent or child writing to
non-faulting addresses will be writing to shared memory.

I think something more is needed, such as creating a minimal page table
for the child process with read-only mappings to the current %EIP and %EBP
pages in it. This gets us past the fork/exec hurdle. Without the exec, we
copy over chunks when they're accessed as above in handle_mm_fault. But
you can't actually _share_ the page tables without marking the pages
themselves readonly.


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

