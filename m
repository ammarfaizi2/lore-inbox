Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310464AbSCPR0N>; Sat, 16 Mar 2002 12:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310460AbSCPR0E>; Sat, 16 Mar 2002 12:26:04 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:64521 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310459AbSCPR0A>;
	Sat, 16 Mar 2002 12:26:00 -0500
Date: Sat, 16 Mar 2002 14:25:15 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <15507.12988.581489.554212@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44L.0203161407470.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Paul Mackerras wrote:
> Linus Torvalds writes:
>
> > But more importantly than that, the whole point really is that the page
> > table tree as far as Linux is concerned is nothing but an _abstraction_
> > of the VM mapping hardware. It so happens that a tree format is the only
> > sane format to keep full VM information that works well with real loads.
>
> Is that still true when we get to wanting to support a full 64-bit
> address space?  Given that we can already tolerate losing PTEs for
> resident pages from the page tables quite happily (since they can be
> reconstructed from the information in the vm_area_structs and the page
> cache), I don't see that the fact that a hash table will sometimes
> lose PTEs because of a hash bucket filling up is all that much of a
> problem.

Indeed, the VM basically has 2 components in this area:

1) the TLB information and possibly an extended TLB in RAM

2) the information needed to construct (1), which could be
   either page tables or VMAs and page cache metadata

On most architectures there is some overlap between (1) and (2),
but on eg. mmap() we never store the complete info on the file
in the page tables but build that _on the fly_ as we page fault
along.

Having said that, obviously we do need a way to store the info
needed to construct (1) somewhere and anonymous pages don't fit
into the pagecache cleanly because of COW and MAP_PRIVATE semantics.

> IMHO it would be interesting to compare the size and complexity of
> using a hash table for the page tables with a 5-level tree.  For a
> 32-bit address space I think the tree wins hands down but for a full
> 64-bit address space I am not convinced either way at present.

This is a good question, especially considering the fact that for
databases page table overhead is already bogging us down on 32-bit
systems.

Reconstructing hash table entries directly from VMA + page cache
might just be more efficient for PPC in this scenario, what would
be best for other architectures I really don't know.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

