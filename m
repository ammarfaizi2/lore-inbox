Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSHDT27>; Sun, 4 Aug 2002 15:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSHDT27>; Sun, 4 Aug 2002 15:28:59 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49062 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318174AbSHDT26>; Sun, 4 Aug 2002 15:28:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Sun, 4 Aug 2002 15:30:24 -0400
User-Agent: KMail/1.4.1
Cc: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208041131380.10314-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208041530.24661.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 02:38 pm, Linus Torvalds wrote:
> On Sun, 4 Aug 2002, Hubertus Franke wrote:
> > As of the page coloring !
> > Can we tweak the buddy allocator to give us this additional
> > functionality?
>
> I would really prefer to avoid this, and get "95% coloring" by just doing
> read-ahead with higher-order allocations instead of the current "loop
> allocation of one block".
>
Yes, if we (correctly) assume that page coloring only buys you significant 
benefits for small associative caches (e.g. <4 or <= 8).

> I bet that you will get _practically_ perfect coloring with just two small
> changes:
>
>  - do_anonymous_page() looks to see if the page tables are empty around
>    the faulting address (and check vma ranges too, of course), and
>    optimistically does a non-blocking order-X allocation.
>
As long as the alignments are observed, which you I guess imply by the range.

>    If the order-X allocation fails, we're likely low on memory (this is
>    _especially_ true since the very fact that we do lots of order-X
>    allocations will probably actually help keep fragementation down
>    normally), and we just allocate one page (with a regular GFP_USER this
>    time).
>
Correct.

>    Map in all pages.
>
>  - do the same for page_cache_readahead() (this, btw, is where radix trees
>    will kick some serious ass - we'd have had a hard time doing the "is
>    this range of order-X pages populated" efficiently with the old hashes.
>

Hey, we use the radix tree to track page cache mappings for large pages
particularly for this reason...

> I bet just those fairly small changes will give you effective coloring,
> _and_ they are also what you want for doing small superpages.
>

Well, in what you described above there is no concept of superpages
the way it is defined for the purpose of <tracking> and <TLB overhead 
reduction>. 
If you don't know about super pages at the VM level, then you need to
deal with them at TLB fault level to actually create the <large TLB> 
entry. That what the INTC patch will do, namely throughing all the 
complexity over the fence for the page fault.
In your case not keeping track of the super pages in the 
VM layer and PT layer requires to discover the large page at soft TLB 
time by scanning PT proximity for contigous pages if we are talking now 
about the read_ahead ....
In our case, we store the same physical address of the super page 
in the PTEs spanning the superpage together with the page order.
At software TLB time we simply extra the single PTE from the PT based
on the faulting address and move it into the TLB. This ofcourse works only
for software TLBs (PwrPC, MIPS, IA64). For HW TLB (x86) the PT structure
by definition overlaps the large page size support.
The HW TLB case can be extended to not store the same PA in all the PTEs,
but conceptually carry the superpage concept for the purpose described above.

We have that concept exactly the way you want it, but the dress code 
seems to be wrong. That can be worked on.
Our goal was in the long run 2.7 to explore the Rice approach to see
whether it yields benefits or whether we getting down the road of 
fragmentation reduction overhead that will kill all the benefits we get
from reduced TLB overhead. Time would tell.

But to go down this route we need the concept of a superpage in the VM,
not just at TLB time or a hack that throws these things over the fence. 


> And no, I do not want separate coloring support in the allocator. I think
> coloring without superpage support is stupid and worthless (and
> complicates the code for no good reason).
>
> 		Linus

That <stupid> seems premature. You are mixing the concept of 
superpage from a TLB miss reduction perspective 
with the concept of superpage for page coloring. 

In a low associative cache (<=4) you have a larger number of colors (~100s)
To be reasonable effective you need to provide these large 
number of colors, that could be quite a waste of memory if you do it 
only through super pages.
On the otherhand, if you simply try to get a page from a targeted class X
you can solve this problem one page at a time. This still makes sense.
Last you can move these two approaches together by providing small
conceptual super pages (nothing or not necessarily anything to do with your 
TLB at this point) and provide a smaller number of classes from where 
superpages will be allocated. I hope you meant the latter one when
referring to <stupid>.
Eitherway, you need the concept of a superpage IMHO in the VM to 
support all this stuff. 

And we got just the right stuff for you :-).
Again the final dress code and capabilities are still up for discussion.

Bill Irwin and I are working on moving Simon's 2.4.18 patch up to 2.5.30.
Clean up some of the stuff and make sure that the integration with the latest
radix tree and writeback functionality is proper.
There aren't that many major changes. We hope to have something for
review soon.

Cheers. 
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
