Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVBPELy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVBPELy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 23:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVBPELy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 23:11:54 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:2217 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261980AbVBPEL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 23:11:28 -0500
Message-ID: <4212C1A9.1050903@sgi.com>
Date: Tue, 15 Feb 2005 21:44:41 -0600
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
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de>
In-Reply-To: <20050215214831.GC7345@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>Making memory migration a subset of page migration is not a general
>>solution.  It only works for programs that are using memory policy
>>to control placement.   As I've tried to point out multiple times
>>before, most programs that I am aware of use placement based on
>>first-touch.  When we migrate such programs, we have to respect
>>the placement decisions that the program has implicitly made in
>>this way.
> 
> 
> Sorry, but the only real difference between your API and mbind is that
> yours has a pid argument. 
> 

That may be true, but the internals of the implementations have got
to be pretty different as near as I can tell.  So just beause the
API's are nearly the same doesn't imply that the internals are at
all the same.  And I'm convinced that using node masks is an
insufficiently general approach to specifying page migration.
But let's save that discussion for a later note, ok?

> I think we are talking by each other, here's a more structured
> overview of my thinking on the issue.
> 

I'm sure that is what is going on and we face little other choice
than keep our good humor about this and keep trying until we see
our way clear to a common understanding.  :-)

> Main cases:
> 
> - Program is NUMA API aware. Fine.  It takes care of its own.

Yes, we could migrate this program using a migration facility
embedded in the NUMA API.

> - Program is not aware, but is started with a process policy from
> numactl/cpusets/batch scheduler. Already covered too in NUMA API.

Hmmm.... What about the case where no NUMA API is used and cpusets
are used as containers, and page placement is done by first touch.
Then there no NUMA API whatsoever.  I think this is the category
where most of the programs in a large Altix system would fall.
(See more on this below....)

> - Program is not aware and hasn't been started with a policy
> (or has and you change your mind) but you want to change it later.

I'm having a little trouble parsing the "it" in that sentence.
Does that sentence mean "you want to change the NUMA API later"?
What if there never is a NUMA API structure associated with
the program other than the default (local) policy?

The fundamental disconnect here is that I think that very few
programs use the NUMA API, and you think that most programs do.
Eventually more programs will use the NUMA API, but I don't think
they do at the present time.

Let me expand on that a bit.  What most programs do on Altix is
to do first-touch to get data allocated locally.  That is, lets
say you have a big array that your parallel computation is going to
work on.  The programmer would sit down and say, I want processor 1
to work on this part of the array, processor 2 on that part, etc.
Then the programmer writes code that causes each processor to touch
the portions of the data array that should be allocated locally on
that processor.  Bingo, storage is now allocated the way the user
wants it, and no NUMA API call was ever issued.

Yes, it is clumsy, but that is because these programs were written
before your NUMA API came into being.  Now we simply can't go back
to these people (many of them ISV's) and say "Please rewrite your
code to use the NUMA API."  So we are left with a pile of legacy
programs that we have to be able to migrate that don't have any
NUMA api data structures associated with them.  What are we
supposed to do in this case?

We can't necessarily construct a NUMA API that will cause storage
to be allocated as the programmer intended, because we can't fathom
what the programmer was trying to accomplish based on the state
of the program when we go to migrate it.  So how would we use
a migration facility embedded into the NUMA API to migrate this
program and maintain its old topology?

That's the fundamental question here.  Can you address that
question specifically for me, please?

> That's the new case we discuss here. 
> 
> Now how to change policy of objects in an already running process.
> 

If the running process has a non-trivial mempolicy defined for
all of its address space, then I think I understand this.  This
is not where our disconnect lies.  The disconnect is in the above, I
think.

> First there are already some special cases already handled or
> with existing patches:
> - tmpfs/hugetlbfs/sysv shm: numactl can handle this by just mapping
> the object into a different process and changing the policy there.
> - shared libraries and mmaped files in general: this is a generialization of
> the previous point. SteveL's patch is the beginning of handling this, although
> it needs some more work (xattrs) to make the policy persistent over
> memory pressure.
> 
> Only case not covered left is anonymous memory. 
> 
> You said it would need user space control, but the main reason for
> wanting that seems to be to handle the non anonymous cases which
> are already covered above.

Yes, so long as the rest of the cases were handled in user space, then
the anonymous memory case has to be handled there as well.

> 
> My thinking is the simplest way to handle that is to have a call that just o
> migrates everything. The main reasons for that is that I don't think external
> processes should mess with virtual addresses of another process.
> It just feels unclean and has many drawbacks (parsing /proc/*/maps
> needs complicated user code, racy, locking difficult).  
> 

Yes, but remember, we are coming from an assumption that migrated processes
are suspended.  This may be myopic, but we CAN make this work with  the
constraints we have in place.  Now if you are arguing for a more general
migration facility that doesn't require the processes to be blocked, well
then I agree with you.  The /proc/*/maps approach doesn't work.

So lets go with the idea of dropping the va_start and va_end arguments from
the system call I proposed.  Then, we get into the kernel and starting
scanning the pte's and the page cache for anonymous memory and mapped files,
respectively.  For each VMA we have to make a migrate/don't migrate decision.
We also have to accept that the set of originating and destination nodes
have to be distinct.  Otherwise, there is no good way to tell whether or not
a particular page has been migrated.  So we have to make that restriction.

Without xattrs, how do we make the migrate/non-migrate decision?  Where
do we put the data?  Well, we can have some file in the file system that
has file names in it and read that file into the kernel and convert each
file to a device and inode pair.  We can then match that against each of
the VMAs and choose not to migrate any VMA that maps a file on the list.
For each anonymous VMA we just migrate the pages.

Sounds like it is doable, but I have this requirement from my IRIX
buddies that I support overlapping sets of nodes in the two and from
node sets.  I guess we have to go back and examine that in more detail.

> In kernel space handling full VMs is much easier and safer due to better 
> locking facilities.
> 
> In user space only the process itself really can handle its own virtual 
> addresses well, and if it does that it can use NUMA API directly anyways.
> 
> You argued that it may be costly to walk everything, but I don't see this
> as a big problem - first walking mempolicies is not very costly and then
> fork() and exit() do exactly this already. 

I'm willing to accept that walking the page table (via follow_page()) or
the file (via find_get_page()) is not that expensive, at least until it
is shown otherwise.  We do tent to have big address spaces and lots of
processors associated with them, but I'm willing to accept that we won't
migrate a huge process around very often.  (Or at least not often enough
for it to be interesting.)  However, if this does turn out to be a performance
problem for us, we will have to come back and re-examine this stuff.

> 
> The main missing piece for this would be a way to make policies for
> files persistent. One way would be to use xattrs like selinux, but
> that may be costly (not sure we want to read xattrs all the time
> when reading a file). 
>

I'm not sure I want to tie implementation of the page migration
API to getting xattrs into all of the file systems in Linux
(although I suppose we could live with it if we got them into XFS).
Is this really the way go to here?  This seems like this would
decrease the likelyhood of getting the page migration code
accepted by a significant amount.  It introduces a new set of
people (the file system maintainers) whom I have to convince to
make changes.  I just don't see that as being a fruitful exercise.

Instead I would propose a magic file to be read at boot time as discussed
above -- that file would contain the names of all files not to be
migrated.  The kicker comes here in that what do we do if that set
needs to be changed during the course of a single boot?  (i. e. somone
adds a new shared library, for example.  I suppose we could have a
sysctl() that would cause that file to be re-read.  This would be
a short term solution until xattrs are accepted and/or until Steve
Longerbeam's patch is accepted.  Would that be an acceptable short
term kludge?

> A hackish way to do this that already 
> works would be to do a mlock on one page of the file to keep
> the inode pinned. E.g. the batch manager could do this. That's 
> not very clean, but would probably work. 
> 
> -Andi
> 


-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------

