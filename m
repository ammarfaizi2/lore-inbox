Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVBQXz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVBQXz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBQXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:55:29 -0500
Received: from news.suse.de ([195.135.220.2]:444 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261235AbVBQXyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:54:41 -0500
Date: Fri, 18 Feb 2005 00:54:37 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Andi Kleen <ak@muc.de>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview II
Message-ID: <20050217235437.GA31591@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4212C1A9.1050903@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the late answer.]

On Tue, Feb 15, 2005 at 09:44:41PM -0600, Ray Bryant wrote:
> >
> >
> >Sorry, but the only real difference between your API and mbind is that
> >yours has a pid argument. 
> >
> 
> That may be true, but the internals of the implementations have got
> to be pretty different as near as I can tell.  So just beause the

Not necessarily. E.g. Steve's file attribute patch actually
implemented very simple page migration into NUMA API 
because he needed it to solve some problems with allocation.
It was even exposed as a new mbind() flag.

> >Main cases:
> >
> >- Program is NUMA API aware. Fine.  It takes care of its own.
> 
> Yes, we could migrate this program using a migration facility
> embedded in the NUMA API.
> 
> >- Program is not aware, but is started with a process policy from
> >numactl/cpusets/batch scheduler. Already covered too in NUMA API.
> 
> Hmmm.... What about the case where no NUMA API is used and cpusets

First the NUMA API internally doesn't care that much about this 
case. It just considers no policy as "DEFAULT" policy which
just happens to be what you call first-touch.

But there is no fundamental reason you can't change the policy
of an existing program externally. It is already implemented for some
kinds of named objects (shmfs etc.), but it can be extended to
more.

> >- Program is not aware and hasn't been started with a policy
> >(or has and you change your mind) but you want to change it later.

> I'm having a little trouble parsing the "it" in that sentence.
> Does that sentence mean "you want to change the NUMA API later"?

The policy. In this case policy means including the page placement
(this would be MPOL_F_STRICT) 

> What if there never is a NUMA API structure associated with
> the program other than the default (local) policy?

If you have some generic facility to change policy externally
it doesn't matter if there was policy before or not. 

> The fundamental disconnect here is that I think that very few
> programs use the NUMA API, and you think that most programs do.

All programs use NUMA policy (assuming you have a CONFIG_NUMA kernel) 
Internally it's all the same.

Hmm, I see perhaps my distinction of these cases with programs
already using NUMA API and not using it was not very useful
and lead you to a tangent. Perhaps we can just drop it.

I think one problem that you have that you essentially
want to keep DEFAULT policy, but change the nodes.
NUMA API currently doesn't offer a way to do that, 
not even with Steve's patch that does simple page migration.
You only get a migration when you set a BIND or PREFERED
policy, and then it would stay. But I guess you could
force that and then set back DEFAULT. It's a big ugly,
but not too bad.
> 
> Let me expand on that a bit.  What most programs do on Altix is
> to do first-touch to get data allocated locally.  That is, lets
> say you have a big array that your parallel computation is going to
> work on.  The programmer would sit down and say, I want processor 1
> to work on this part of the array, processor 2 on that part, etc.
> Then the programmer writes code that causes each processor to touch
> the portions of the data array that should be allocated locally on
> that processor.  Bingo, storage is now allocated the way the user
> wants it, and no NUMA API call was ever issued.

Sure, but NUMA API goes to great pains to handle such programs.
> 
> Yes, it is clumsy, but that is because these programs were written
> before your NUMA API came into being.  Now we simply can't go back
> to these people (many of them ISV's) and say "Please rewrite your
> code to use the NUMA API."  So we are left with a pile of legacy
> programs that we have to be able to migrate that don't have any
> NUMA api data structures associated with them.  What are we
> supposed to do in this case?


> 
> We can't necessarily construct a NUMA API that will cause storage
> to be allocated as the programmer intended, because we can't fathom
> what the programmer was trying to accomplish based on the state
> of the program when we go to migrate it.  So how would we use
> a migration facility embedded into the NUMA API to migrate this
> program and maintain its old topology?

numactl went to great pains to handle such programs. Take
a look at all the command line options ;-)

If the program is using shm and you applied the patch
to do page migration in mbind() you could handle it right now:

- map the shm segment into the management process. 
- change policy with mbind(), triggering page migration
- set back default policy.

For other objects (files etc.) there are patches in the pipeline.

The only hole that's still there is anonymous memory, but I think
we can fill that much simpler than what you're proposing, with
a "migrate whole process except when policy says otherwise" call.



> >That's the new case we discuss here. 
> >
> >Now how to change policy of objects in an already running process.
> >
> 
> If the running process has a non-trivial mempolicy defined for
> all of its address space, then I think I understand this.  This
> is not where our disconnect lies.  The disconnect is in the above, I
> think.

No, I was discussing even uncooperative processes. See below.

> 
> >First there are already some special cases already handled or
> >with existing patches:
> >- tmpfs/hugetlbfs/sysv shm: numactl can handle this by just mapping
> >the object into a different process and changing the policy there.

numactl is an external program 

I designed it originally mostly to handle databases, although many HPC
people I talked to also be happy with it (it may need more tweaks
to handle this better of course, but I hope it won't end up
as complicated as your Irix command for this ;-)

> >- shared libraries and mmaped files in general: this is a generialization 
> >of
> >the previous point. SteveL's patch is the beginning of handling this, 
> >although
> >it needs some more work (xattrs) to make the policy persistent over
> >memory pressure.

Again uncooperative, just set by the administrator system wide.

> >Only case not covered left is anonymous memory. 
> >
> >You said it would need user space control, but the main reason for
> >wanting that seems to be to handle the non anonymous cases which
> >are already covered above.
> 
> Yes, so long as the rest of the cases were handled in user space, then
> the anonymous memory case has to be handled there as well.

Handling in user space would mean (at least in my worldview...) setting
NUMA policy for them at some point there. The kernel would then provide
facilities to remember that policy and use it when allocating
anything (or even migrating pages if the policy was set late) 

> >
> >My thinking is the simplest way to handle that is to have a call that just 
> >o
> >migrates everything. The main reasons for that is that I don't think 
> >external
> >processes should mess with virtual addresses of another process.
> >It just feels unclean and has many drawbacks (parsing /proc/*/maps
> >needs complicated user code, racy, locking difficult).  
> >
> 
> Yes, but remember, we are coming from an assumption that migrated processes
> are suspended.  This may be myopic, but we CAN make this work with  the
> constraints we have in place.  Now if you are arguing for a more general
> migration facility that doesn't require the processes to be blocked, well
> then I agree with you.  The /proc/*/maps approach doesn't work.

It's not just the races, it seems unclean to do a complicated user 
space library for something that the kernel can do better because
it has direct access to the data structures.

> 
> So lets go with the idea of dropping the va_start and va_end arguments from
> the system call I proposed.  Then, we get into the kernel and starting

That would make the node array infinite, won't it?  What happens when
you want to migrate a 1TB process? @) I think you have to replace
that one with a single target node argument too.

> scanning the pte's and the page cache for anonymous memory and mapped files,
> respectively.  For each VMA we have to make a migrate/don't migrate 
> decision.
> We also have to accept that the set of originating and destination nodes
> have to be distinct.  Otherwise, there is no good way to tell whether or not
> a particular page has been migrated.  So we have to make that restriction.

Hmm. That looks a bit unreliable. Unless you use BIND policy it's 
always possible you get memory on wrong nodes on memory pressure.

I wouldn't like it when the page migration facility doesn't "fix" 
those stray allocations later.

Basically it would be random if a page is migrated then or not
on a busy system. 

You could walk the page tables in user space use get_mempolicy
(I put a hack in there to look up the node of a page - was 
intended for regression testing of libnuma), but it's probably
not worth it. I would just let the kernel migrate everything.

You and Robin mentioned some problems with "double migration"
with that, but it's still not completely clear to me what
problem you're solving here. Perhaps that needs to be reexamined.

> 
> Without xattrs, how do we make the migrate/non-migrate decision?  Where
> do we put the data?  Well, we can have some file in the file system that

One way would be the hack I proposed: mlock one page of the file
in a daemon, then set the policy.  That keeps the inode pinned and the 
address space with the policy tree. Not very nice, but would
work right now.

But I think you underestimate xattrs. The infrastructure
is really already quite widespread. They are quite widely used these
days, most linux FS support it in some form (ext2/3, reiserfs, JFS, XFS, ...)

One hole is NFS right now, afaik it only supports ACLs, but no
genericized xattrs, but the selinux guys are pushing it so
I expect this will be eventually solved too (selinux needs xattrs
for advanced security) 


> has file names in it and read that file into the kernel and convert each
> file to a device and inode pair.  We can then match that against each of
> the VMAs and choose not to migrate any VMA that maps a file on the list.

That's quite ugly.

> Sounds like it is doable, but I have this requirement from my IRIX
> buddies that I support overlapping sets of nodes in the two and from
> node sets.  I guess we have to go back and examine that in more detail.

That and the double migration (it's still not completely clear to me
what exactly you're trying to solve here)

> I'm willing to accept that walking the page table (via follow_page()) or
> the file (via find_get_page()) is not that expensive, at least until it
> is shown otherwise.  We do tent to have big address spaces and lots of
> processors associated with them, but I'm willing to accept that we won't
> migrate a huge process around very often.  (Or at least not often enough
> for it to be interesting.)  However, if this does turn out to be a 
> performance
> problem for us, we will have to come back and re-examine this stuff.

Perhaps you can re-examine  fork() and exit() and exec() too while
you're at that. They do exactly the same ;-)  

[I actually have some work in the pipeline to make it faster.] 

> 
> >
> >The main missing piece for this would be a way to make policies for
> >files persistent. One way would be to use xattrs like selinux, but
> >that may be costly (not sure we want to read xattrs all the time
> >when reading a file). 
> >
> 
> I'm not sure I want to tie implementation of the page migration
> API to getting xattrs into all of the file systems in Linux
> (although I suppose we could live with it if we got them into XFS).

XFS has had xattrs from day one on Irix (I found them in
the earliest design documents on the XFS website). In fact the generic 
xattr code in Linux came from SGI as part of the XFS contribution.

Near all other important 2.6 file systems have them too now


> Instead I would propose a magic file to be read at boot time as discussed
> above -- that file would contain the names of all files not to be
> migrated.  The kicker comes here in that what do we do if that set

Sorry, but I see no way to get such a hack merged.

-Andi
