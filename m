Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSA1Vde>; Mon, 28 Jan 2002 16:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbSA1Vd0>; Mon, 28 Jan 2002 16:33:26 -0500
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:32780 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S285828AbSA1VdV>; Mon, 28 Jan 2002 16:33:21 -0500
Message-ID: <3C55C39A.8040203@vitalstream.com>
Date: Mon, 28 Jan 2002 13:33:14 -0800
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <E16VHy5-0000Bz-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
[snip]

> I've been a little slow to 'publish' this on lkml because I wanted a working 
> prototype first, as proof of concept.  My efforts to dragoon one or more of 
> the notably capable kernelnewbies crowd into coding it haven't been 
> particularly successful, perhaps due to the opacity of the code in question 
> (pgtable.h et al).  So I've begun coding it myself, and it's rather slow 
> going, again because of the opacity of the code.  Oh, and the difficult 
> nature of the problem itself, since it requires understanding pretty much all 
> of Unix memory management semantics first, including the bizarre (and useful) 
> properties of process forking.
> 
> The good news is, the code changes required do fit very cleanly into the 
> current design.  Changes are required in three places I've identified so far:
> 
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


Perhaps I'm missing this, but I read that as the child gets a reference
to the parent's memory.  If the child attempts a write, then new memory
is allocated, data copied and the write occurs to this new memory.  As
I read this, it's only invoked on a child write.

Would this not leave a hole where the parent could write and, since the
child shares that memory, the new data would be read by the child?  Sort
of a hidden shm segment?  If so, I think we've got problems brewing.
Now, if a parent write causes the same behaviour as a child write, then
my point is moot.

Could you clarify this for me?  I'm probably way off base here.

----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-           grep me no patterns and I'll tell you no lines           -
----------------------------------------------------------------------

