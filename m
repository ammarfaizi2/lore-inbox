Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288498AbSA2Bme>; Mon, 28 Jan 2002 20:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288422AbSA2Bm3>; Mon, 28 Jan 2002 20:42:29 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:35976 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287303AbSA2Blm>;
	Mon, 28 Jan 2002 20:41:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 02:45:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VNLG-0000En-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 02:29 am, Oliver Xymoron wrote:
> On Mon, 28 Jan 2002, Daniel Phillips wrote:
> 
> >   copy_page_range
> >     Intead of copying the page tables, just increment their use counts
> >
> >   zap_page_range:
> >     If a page table is shared according to its use count, just decrement
> >     the use count and otherwise leave it alone.
> >
> >   handle_mm_fault:
> >     If a page table is shared according to its use count and the faulting
> >     instruction is a write, allocate a new page table and do the work that
> >     would have normally been done by copy_page_range at fork time.
> >     Decrement the use count of the (perhaps formerly) shared page table.
> 
> Somewhere in here, the pages have got to all be marked read-only or
> something.

Yes, that's an essential detail I omitted: when a page table's use count 
transitions from 1 to 2, mark all the CoW pages on the page table RO.

> If they're not, then either parent or child writing to
> non-faulting addresses will be writing to shared memory.

Yes, and after all, the whole point is to generalize CoW of pages to include 
instantiation of page tables.

> I think something more is needed, such as creating a minimal page table
> for the child process with read-only mappings to the current %EIP and %EBP
> pages in it. This gets us past the fork/exec hurdle. Without the exec, we
> copy over chunks when they're accessed as above in handle_mm_fault. But
> you can't actually _share_ the page tables without marking the pages
> themselves readonly.

Oh yes, it's what I intended, thanks.  Um, and I think you just told me what 
one of my bugs is.

-- 
Daniel
