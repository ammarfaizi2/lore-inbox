Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSDNXOo>; Sun, 14 Apr 2002 19:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSDNXOn>; Sun, 14 Apr 2002 19:14:43 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11789 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312491AbSDNXOl>; Sun, 14 Apr 2002 19:14:41 -0400
Date: Mon, 15 Apr 2002 01:15:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: -aa VM updates for 2.5
Message-ID: <20020415011501.R31905@dualathlon.random>
In-Reply-To: <20020413233906.GB10807@matchmail.com> <3CB8C55F.ECD143F7@zip.com.au> <20020414001323.GV23513@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 05:13:23PM -0700, Mike Fedyk wrote:
> Note: I'm just taking about the VM-xx patch from -aa, not some of the more
> controversial patches in -aa.
> 
> On Sat, Apr 13, 2002 at 04:55:11PM -0700, Andrew Morton wrote:
> > Mike Fedyk wrote:
> > > 
> > > Why haven't any of the -aa VM updates gone into 2.5?  Especially after Andrew
> > > Morton has split it up this is surprising...
> > 
> > I don't think there's really any point in doing that.
> > 
> > None of the regular VM guys are really working 2.5 at this time.
> > 
> > VM has a close relationship with buffers, so tinkering
> > with the VM while I'm busily driving a truck through the
> > buffer layer and setting up new writeback mechanisms
> > would represent some wasted effort.
> 
> Yep, make sense.  Though, keeping in mind the changes that are in -aa may
> help when making changes to the buffer layer, and possibly less effort if a
> problem is already fixed in -aa but not in 2.5.
> 
> > We don't know yet whether 2.5 will have a reverse-mapping
> > VM.  If it does, then maintenance work against the current
> > one is wasted effort and more patching pain.
> >
> 
> It looks like most of the vm changes can just be dropped into 2.5 over a few
> -pres.  Especially since few (none?) have argued that the -aa vm-patch
> causes regressions.
> 
> > (I'd also like to investigate the option of not throttling
> >  page allocators by making them wait on I/O - make them
> >  wait on pages coming free instead).
> >
> 
> Sounds interesting.
> 
> > So.  My vote would be that unless the VM is actually impeding
> > developers who are working on other parts of the kernel (it
> > is not) then just leave it as-is for the while.
> >
> 
> What about the recent threads on swapping in 2.5?
> 
> Merging the -aa vm-patch into 2.5 will allow people to develop on the best
> known -aa VM to date, and can reduce duplicated effort.  Though, admittedly

personally I think it should definitely go into 2.5 too.  there's
nothing that prevents the rmap design to be put on top of my vm updates,
the rmap _patch_ (not the _design_ logic) does lots more stuff than just
implementing the rmap design, and the reason I disagree with it (the
patch, not the rmap design) is that it also backouts important fixes as
just pointed out in a past email. As for Andrew's pagecache changes if
it won't be Andrew spending time adapting his changes to my vm, it will
be me later porting my vm patch on top of his changes. Since my code
runs right now in production on some of the most important highend boxes
out there, I think it should have precendence, but hey, I don't really
care if I've to be the one to do the porting work as far as they gets
merged eventually. Of course if somebody cameup with a patch fixing
better all the issues that my current vm patch is addressing, and plus
if somebody can design a better vm algorithm that will prove faster
under my current most important VM benchmark with 1.2G of SGA in swap
during simulated real life DB workload, that will be a very great news
and in such case I will be _very_ _very_ glad to cp vm-33.gz /dev/null
and to replace the whole thing with his code.  The fact is that in all
the feedback I got so far I didn't seen anything that surpasses my vm-33
updates, certainly not mainline without them, certainly not the rmap
patch either, and this is why I'm assuming vm-33 is the right thing to
merge at this point in time into both 2.4 and 2.5. Doing that will first
of all place a solid base to allow Rik to extract a strict rmap patch to
benchmark strictly the rmap design without the other
benchmark-wise-pollution of current rmap patch. Same goes for Andrew, if
vm-33 would be just in mainline he would just hack on top of it. The
longer it gets delayed the more wasted resources IMHO.

Also note that from my part I'm finished with the vm in 2.4. Unless I
get a bugreport I will not touch it further (except for cleanups that
doesn't affect functionality, for example I forgot to delete the
show_stack export after the dump_stack is been introduced by Andrew).
the last series of benchmark I run didn't show regression or instability
in the numbers, and they were fast, it's behaving as expected under all
scenarios, no too many magics, all magics sysctl configurable at least.

There's still the issue of the oom killer. Andrew's right about the ways
to fix the possible oom deadlock but they will become quite ugly code,
similar to the feature in 2.2 that sends sigterm to X first (that I'd
like to forward port to 2.[45] too).  But I'm not very happy with the
algorithm either. my highmem machine runs with 800M of swap free and the
SGA used by the DB is 1.7G mapped by a dozen of tasks. Now if after some
day of web browsing I hit a bug in knoqueror from kde head cvs the oom
killer will start killing all the idle DB tasks attached to the SGA
instead of killing konqueror. That's the wrong thing to do in such case,
the probabilistic effort would do much better in such case, and it will
get the other cases right too most of the time.

BTW, (talking about being perfect in such area) the
non-overcommit/beancounter work as well can be developed on top of vm-33
of course, only _then_ it will be safe to loop forever into the memory
balancing without breaking the loop until we succeed in freeing ram (and
even in such case the oom killer will be superflous, because all -ENOMEM
mem failures will happen at the memstats/vma level).

Andrea
