Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUCPXHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUCPXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:06:53 -0500
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:21217 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261795AbUCPXGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:06:36 -0500
From: Eric <eric@cisu.net>
To: Timothy Miller <miller@techsource.com>
Subject: Re: Scheduler: Process priority fed back to parent?
Date: Tue, 16 Mar 2004 17:05:31 -0600
User-Agent: KMail/1.6.1
References: <40571A62.8050204@techsource.com> <200403161323.26043.eric@cisu.net> <40577325.7090709@techsource.com>
In-Reply-To: <40577325.7090709@techsource.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403161705.31974.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 3:35 pm, you wrote:
> Eric wrote:
> > On Tuesday 16 March 2004 10:46 am, Timothy Miller wrote:

> This isn't what I'm talking about, however.  This caching idea is
> something that applies only to, for instance, loading system services,
> and that would all be in user space.

 Yea. I agree, it sounds more like userspace.

> >>I appreciate the problems, and the cost may be greater than the benefit.
> >>  But if the cache is just a file in the file system, then there are no
> >>file-system dependencies.
> >
> >  True. Read on for my thoughts about cost vs. benifit. The biggest costs
> > would only be incurred the first couple times a process is launched, at
> > least the cost of calculating what the heck the process is doing. After
> > that it would only be using already gathered info.
>
> Yes and no.  We'd probably want to keep a running average or a life-time
> average.  We want to smooth out the bumps in program behavior over the
> long-term, and we don't want unfortunate first-impressions to cause
> grudges.  So, let's say that some program you install uses an inordinate
> amount of CPU for the first few days of its life because it's doing all
> sorts of initialization, but after that point, it behaves more sanely.
> We want the initial impression of the program's behavior to decay over
> time to better match its present behavior.

> So, while the existing process scheduler estimates interactivity over
> the lifetime of a process, which could be mere seconds, the
> interactivity cache could estimate interactivity over a period of hours
> or more.

> >>But in this case, it IS extra memory.  Would there be a process-launch
> >>penalty?  Definately.  But it might be worth it for the user experience.
> >>  Furthermore, the priority setting could be asynchronous, where the
> >>initial priority is a guess, and isn't set until the priority info has
> >>been fetched.
> >
> > Well on systems with alot of memory this kind of activity might be a good
> > trade off. I would gladly give up 1-10MB if it would guarantee
> > faster/more efficient process management. This prefetch activity could be
> > turned on/off from a /proc flag too just in case. It would have to be
> > compiled in anyways too, something like CONFIG_PREFETCH. Servers could
> > turn off prefetch while desktops could leave it on. This kind of thing
> > would only improve interactivity anyways, not affect long-running
> > processes.
>
> Let's not call it "prefetch", because that would be confusing.  Let's
> call it "CONFIG_INTERACTIVITY_HISTORY".
>
> The cache would need to know as little as a number which indicates
> interactivity history (or a short list), and either a filename or an
> inode number.

If you want to track history you will definatly need a short list. A filename 
should be enough to associate a program with its interactivity.

> Indeed, would it be possible to store this number as metadata in the
> file's inode?  That would be filesystem-dependent, but it would also
> have zero cost.  This would only be a problem for read-only file
> systems, and those are common enough that it would warrant a separate
> cache.  Furthermore, in some cases, the cache could exist only for the
> uptime, so if you reboot, you lose all the history, but your compiles
> would only misbehave briefly before the system learned the behavior of cc1.

Why not just sacrifice a MB or two, maybe compile time configurable for a DB 
to store the info. Then you don't even have to write it to the filesystem. 
For those of us with enough memory or a large variety of programs, you can 
set it as high as 2-3MB while low-memory systems can disable it or set it as 
small as a few K. If you only need a small string and an few ints to track 
this sort of information, a few K should be more than enough for hundreds of 
program entries. This eliminates entirely the filesystem dependency and fixes 
it for read-only systems.

> >>The thing is, if a program hasn't been loaded yet, then it has to be
> >>fetched from disk, and one more fetch won't hurt.  Launching processes
> >>involves LOTS of files being opened (shares libs, etc.).  Furthermore,
> >>if the program has ALREADY been run once, the both the program AND its
> >>priority descriptor are probably already in the VM disk cache.
> >
> > 	Your idea seems to deal mostly with process priority, what came to my
> > mind was something like a small struct or DB file describing the first
> > 20-30 files or something that that a program uses when it first starts
> > up. That way the file is already in disk cache or on its way when the
> > program requests it. We all know the slowest piece of a computer is the
> > hard drive, so anything we can do to predict, or even KNOW about its file
> > usage we can get the information ready before the process requests it.
>
> This is a wonderful idea, but it's completely separate.  This is
> something that could be done almost completely in user space.

Yes. Good point. This sounds like a job for some sort of launching daemon.

> A few more things about this... we'd need a new filesystem which
> maintained this cache in a section of the disk where it could keep
> things linear, and secondly, the anticipatory I/O scheduler does a
> wonderful job of reordering reads in a VERY efficient order.

Why not just put it in memory? What kind of space usage do you see? I see it 
only requiring a few hundred K to be noticiably efficient and a few MB to 
completely utilize. Although with this approach you would have a set limit to 
the # of programs you could store information about and would need to write 
some sort of replacement policy for it, but this would eliminate the 
filesystem dependency. However with the file/inode approach you are able to 
write information about each and every program. However it will require you 
to make support for each filesystem and it might break in the future, whereas 
a filesystem independent approach will be a lot less work to write and 
maintain.

	If the AS is as good as you say it is then my idea is pretty much moot while 
yours is a good addition to it.

> For what I've been talking about, we'd want to hide it as much as
> possible, except from the scheduler and the daemon that maintains the
> history.

Thats why I suggest you keep it filesystem independent by keeping the DB in 
memory and touching the filesystem as little as possible.

> > 	The process launching a thousand times was exactly the worst case
> > scenario I was thinking of.
> >
> > Quoting a later message:
> >>In FACT, that I think I may be on to something here... Hmmm.  So far,
> >>process schedulers have been trying to BOOST priority of interactive
> >>processes.  That's great.  But maybe an even BIGGER problem is that
> >>every time gcc (and cc1) is launched during a kernel compile, it's given
> >>too high of a priority, and by the time the priority is corrected, the
> >>compile has finished for that .c file.
> >
> > True. I believe both your ideas about priority management and my idea
> > about disk prefetching would greatly improve the performance hit in this
> > scenario.

Erm... I just remembered that the libraries should already be in the disk 
cache if you have enough memory... My idea is pretty much made moot by the  
excellent AS and disk cache handler. Doh...

> As I say, most of the time, this sort of caching is done only as a way
> to passify users who want the OS to boot faster.  On boot, so many
> things are being loaded at the same time that it can really be helpful.
>   But when loading a single app, caching won't help much.

	Yea, I never intended it to be for boot though. There are too many 
implementations that overcome inherit problems with the sysV init system. So 
if someone is *really* interested in speeding up boot times they should be 
using a different scheme anyways.

> The first time gcc is started during a compile, it has to be loaded from
> disk, which is always going to be time-consuming.  But while that disk
> access is going on, other processes run, so interactivity isn't
> affected.  Caching of the executable would only save a few milliseconds.
>   Subsequent launches of gcc would all come from memory cache.  Only
> THEN does gcc start to affect interactivity, and this is all about
> process scheduling.

Ok. I hear where you are coming from. Thanks for the information. This 
discussion has been enlightening.
 
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
