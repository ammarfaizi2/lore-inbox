Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310513AbSCPSBD>; Sat, 16 Mar 2002 13:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310514AbSCPSAx>; Sat, 16 Mar 2002 13:00:53 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:38663 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310513AbSCPSAo>;
	Sat, 16 Mar 2002 13:00:44 -0500
Date: Sat, 16 Mar 2002 10:57:43 -0700
From: yodaiken@fsmlabs.com
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316105743.A18207@hq.fsmlabs.com>
In-Reply-To: <20020313085217.GA11658@krispykreme> <20020314112725.GA2008@krispykreme> <87wuwfxp25.fsf@fadata.bg> <E16la2m-0000SX-00@starship> <a6te11$si7$1@penguin.transmeta.com> <15507.12988.581489.554212@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <15507.12988.581489.554212@argo.ozlabs.ibm.com>; from paulus@samba.org on Sat, Mar 16, 2002 at 10:55:40PM +1100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 10:55:40PM +1100, Paul Mackerras wrote:
> Is that still true when we get to wanting to support a full 64-bit
> address space?  Given that we can already tolerate losing PTEs for
> resident pages from the page tables quite happily (since they can be
> reconstructed from the information in the vm_area_structs and the page
> cache), I don't see that the fact that a hash table will sometimes
> lose PTEs because of a hash bucket filling up is all that much of a
> problem.  (We would need to find some other way of dealing with swap
> entries of course.)

The basic problem with hash tables is not that they loose data, even though
that is disgusting, the problem is that they delocalize mm data

	reference page n
	reference page n+1
	...
	reference page n+k

With a page table design, referencing page n's PTE on a miss almost
certainly brings PTE n+1 into the cache so that the next TLB miss does
not cause a page miss. the PTE list is a nice chunk of related information
But the hash table design means that consecutive TLB misses scatter over
a hash  table -and the cache is filled with page entries that are not
useful. Even uglier
	TLB miss
	hash table walk where every reference is a cache miss
	and we fill the cache up with crap.
	the pte is not in the hash table, now "reconstruct"

I've yet to see any plausible argument that going to 64 bit can do anything
but make this a whole lot worse. Maybe you've seen one?

In fact, I'm waiting for some hardware engineer to finally realize that
with extent file systems/disks and huge memories, the PDP11 base/limit
architecture is going to have a good chance of outperforming pages.
Pages and hash tables are a solution to the problem of memory fragmentation.
When you have a 4G memory, do you really care so much?


> IMHO it would be interesting to compare the size and complexity of
> using a hash table for the page tables with a 5-level tree.  For a

Why would you need a 5-level tree? Even three levels seems overdoing it
to me. Make the directory pages and target pages bigger. With 4M pages,
each process may waste 12M (if it's using 1byte each on the last page
of stack, code, and data). If that's a problem, you don't need a 64bit
memory space.


> 32-bit address space I think the tree wins hands down but for a full
> 64-bit address space I am not convinced either way at present.


> 
> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

