Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVBRIpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVBRIpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 03:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVBRIpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 03:45:32 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62946 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261301AbVBRIpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 03:45:01 -0500
Message-ID: <4215A992.80400@sgi.com>
Date: Fri, 18 Feb 2005 02:38:42 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de>
In-Reply-To: <20050217235437.GA31591@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> [Sorry for the late answer.]
>

No problem, remember, I'm supposed to be on vacation, anyway.  :-)

Let's start off with at least one thing we can agree on.  If xattrs
are already part of XFS, then it seems reasonable to use an extended
attribute to mark certain files as non-migratable.   (Some further
thought is going to be required here -- r/o sections of a
shared library need not be migrated, but r/w sections containing
program or thread private data would need to be migrated.  So
the extended attribute may be a little more complicated than
just "don't migrate".)

The fact that NFS doesn't support this means that we will have to
have some other way to handle files from NFS though.  It is possible
we can live with the notion that files mapped in from NFS are always
migratable.  (I'll need to look into that some more).

> On Tue, Feb 15, 2005 at 09:44:41PM -0600, Ray Bryant wrote:
> 
>>>
>>>Sorry, but the only real difference between your API and mbind is that
>>>yours has a pid argument. 
>>>

OK, so I've "lost the thread" a little bit here.  Specifically what
would you propose the API for page migration be?  As I read through your note,
I see a couple of different possibilities being considered:

(1)  Map each object to be migrated into a management process,
      update the object's memory policy to match the new node locations
      and then unmap the object.  Use the MPOL_F_STRICT argument to mbind() and
      the result is that migration happens as part of the call.

(2)  Something along the lines of:

      page_migrate(pid, old_node, new_node);

      or perhaps

      page_migrate(pid, old_node_mask, new_node_mask);

or

(3)  mbind() with a pid argument?

I'm sorry to be so confused, but could you briefly describe what
your proposed API would be (or choose from the above list if I
have guessed correctly?)  :-)


> 
>>The fundamental disconnect here is that I think that very few
>>programs use the NUMA API, and you think that most programs do.
> 
> 
> All programs use NUMA policy (assuming you have a CONFIG_NUMA kernel) 
> Internally it's all the same.

Well, yes, I guess to be more precise I should have said that
very few programs use any NUMA policy other than the DEFAULT
policy.  And that they instead make page placement decisions implicitly
using first touch.

> 
> Hmm, I see perhaps my distinction of these cases with programs
> already using NUMA API and not using it was not very useful
> and lead you to a tangent. Perhaps we can just drop it.
> 
> I think one problem that you have that you essentially
> want to keep DEFAULT policy, but change the nodes.

Yes, that is correct.  This has been exactly my point from the
beginning.

We have programs that use the DEFAULT policy and do placement
by first touch, and we want to migrate  those programs without
requiring them to create a non-DEFAULT policy of some kind.

> NUMA API currently doesn't offer a way to do that, 
> not even with Steve's patch that does simple page migration.
> You only get a migration when you set a BIND or PREFERED
> policy, and then it would stay. But I guess you could
> force that and then set back DEFAULT. It's a big ugly,
> but not too bad.
> 

Very ugly, I think.  Particularly if you have to do a lot of
vma splitting to get the correct node placement.  (Worst case
is a VMA with nodes interleaved by first touch across a set of
nodes in a way that doesn't match the INTERLEAVE mempolicy.
Then you would have to create a separate VMA for each page
and use the BIND policy.  Then after migration you would
have to go through and set the policy back to DEFAULT,
resulting in a lot of vma merges.)

> 
> 
> Sure, but NUMA API goes to great pains to handle such programs.
>

Yes, it does.  But, how do we handle legacy NUMA codes that people
use today on our Linux 2.4.21 based Altix kernels?  Such programs
don't have access to the NUMA API, so they aren't using it.  They
work fine on 2.6 with the DEFAULT memory policy.  It seems unreasonable
to go back and require these programs to use "numactl" to solve a problem that
they are already solving without it.  And it certainly seems difficult
to require them to use numactl to enable migration of those programs.

(I'm sorry to keep harping on this but I think this is the
heart of the issue we are discussing.  Are you of the opinion that
we sould require every program that runs on ALTIX under Linux 2.6 to use numactl?)
> 
>>So lets go with the idea of dropping the va_start and va_end arguments from
>>the system call I proposed.  Then, we get into the kernel and starting
> 
> 
> That would make the node array infinite, won't it?  What happens when
> you want to migrate a 1TB process? @) I think you have to replace
> that one with a single target node argument too.
> 

I'm sorry, I don't follow that at all.  The node array has nothing to do with
the size of the address range to be migrated.  It is not the case that the
ith entry in the node array says what to do with the ith page.  Instead the
old and new node arrays defining a mapping of pages:  for pages found on
old_node[i], move them to new_node[i].  The count field is the size of those
arrays, not the size of the region being migrated.


> You and Robin mentioned some problems with "double migration"
> with that, but it's still not completely clear to me what
> problem you're solving here. Perhaps that needs to be reexamined.
> 

I think the issue here is basically a scalability issue.  The problem
we have with most of the proposals that suggest passing in just a single
target and destination node, e. g.:

sys_page_migrate(pid, old_node, new_node);

is that this is basically an O(N**2) operation if N is the number of
processes in the job.  How do we get that?  Well, we have to make the
above system call M times for each process, where M is the number of
nodes being migrated.  In our environment, we typically pin each process
to a different processor.  So we have to make M*N system calls.  But
we have two processors per node, so really that is N**2/2 system calls,
hence it is O(N**2).

(To simplify the dicussion, I am making an implicit assumption here
that the majority  of the memory involved here is shared among all
N processes.)

Now once a particular shared object has been migrated, then the migration
code won't do any additional work, but we will still scan over the page
table entries once per each system call, so that is the component that
is done O(N**2) times.  It is likely a much smaller component of the
system call than the migration code, which is O(p) in the number of
pages p, but that N**2 factor is a little scary when you have N=128
and the number of pages large.

So what we mean by the phrase "double migration" is the process
of scanning the page tables a second time to try to migrate an
object that a previous call has already moved the underlying pages
for.

Compare this to the system call:

sys_page_migrate(pid, count, old_node_list, new_node_list);

We are then down to O(N) system calls and O(N) page table scans.

But we can do better than that.  If  we have a system  call
of the form

sys_page_migrate(pid, va_start, va_end, count, old_node_list, new_node_list);

and the majority of the memory is shared, then we only need to make
one system call and one page table scan.  (We just "migrate" the
shared object once.) So the time to do the page table scans disappears
from interest and the only thing that takes the time is the migration code 
itself.  (Remember, I making a big simplifying assumption here that most of
the memory is shared among all of the processes of the job, so there is
basically just one object to migrate, so just one system call.  The obvious
generalization to the real case is left as an exercise for the
reader.  :-)  )

Passing in an old_node/new_node mask solves this part of the
problem as well, but we have some concerns with that approach as well,
but that is a detail for a later email exchange.

-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------

