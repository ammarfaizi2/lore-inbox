Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318051AbSFSWy1>; Wed, 19 Jun 2002 18:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318050AbSFSWy0>; Wed, 19 Jun 2002 18:54:26 -0400
Received: from pc132.utati.net ([216.143.22.132]:27010 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S318047AbSFSWyW>; Wed, 19 Jun 2002 18:54:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: John Alvord <jalvo@mbay.net>
Subject: Re: kernel upgrade on the fly
Date: Wed, 19 Jun 2002 12:56:03 -0400
X-Mailer: KMail [version 1.3.1]
Cc: zaimi@pegasus.rutgers.edu, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0206181703540.26846-100000@pegasus.rutgers.edu> <20020619010945.6725B7D9@merlin.webofficenow.com> <l8f1hu0ptese1cie90tnvathd36jqc41ca@4ax.com>
In-Reply-To: <l8f1hu0ptese1cie90tnvathd36jqc41ca@4ax.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020619222836.078946A2@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 01:22 pm, John Alvord wrote:
> On Tue, 18 Jun 2002 15:37:23 -0400, Rob Landley
>
> <landley@trommello.org> wrote:
> >On Tuesday 18 June 2002 05:21 pm, zaimi@pegasus.rutgers.edu wrote:
> >> Hi all,
> >>
> >>  has anybody worked or thought about a property to upgrade the kernel
> >> while the system is running?  ie. with all processes waiting in their
> >> queues while the resident-older kernel gets replaced by a newer one.
> >
> >Thought about, yes.  At length.  That's why it hasn't been done. :)
>
> IMO the biggest reason it hasn't been done is the existence of
> loadable modules. Most driver-type development work can be tested
> without rebooting.

That's part of it, sure.  (And I'm sure the software suspend work is 
leveraging the ability to unload modules.)

There's a dependency tree: processes need resources like mounted filesystems 
and open file handles to the network stack and such, and you can't unmount 
filesystems and unload devices while they're in use.  Taking a running system 
apart and keeping track of the pieces needed to put it back together again is 
a bit of a challenge.

The software suspend work can't freeze processees individually to seperate 
files (that I know of), but I've heard blue-sky talk about potentially adding 
it.  (Dunno what the actual plans are, pavel machek probably would).  If 
processes could be frozen in a somewhat kernel independent way (so that their 
run-time state was parsed in again in a known format and flung into any 
functioning kernel), then upgrading to a new kernel would just be a question 
of suspending all the processes you care about preserving, doing a two kernel 
monte, and restoring the processes.  Migrating a process from one machine to 
another in a network clsuter would be possible too.

I'm sure it's not as easy as it sounds, but looking at the software suspend 
work would be a necessary first step.  They are, at least, serializing 
processes to disk and bringing them back afterwards.  I'm fairly certain it's 
happening the microsoft word saves *.doc files (block write the run-time 
structures to disk and block read them back in verbatim later, and hope all 
your compiler alignment offsets and such match if there's any version skew).

Then again, the star office people reverse engineered that and made it 
(mostly) work without even having access to the source code... :)

Hmmm, what would be involved in serializing a process to disk?  Obviously you 
start by sending it a suspend signal.  There's the process stuff, of course.  
(Priority, etc.)  That's not too bad.  You'd need to record all the memory 
mappings (not just the contents of the physical and swapped out memory 
mappings (which should be saved to the serializing file), but also the memory 
protection states and memory mapped file ranges and such, so you can map it 
all back in at the appropriate location later).  I'd bug whoever did the 
recent shared page table work (daniel philips?) for information about what 
that really MEANS.

You'd need to record all the open file handles, of course. (For actual files 
this includes position in file, corresponding locks, etc.  For the zillions 
of things that just LOOK like files, pipes and sockets and character and 
block devices, expect special case code).

Pipes bring up a fun point: you can't always serialize just one process.  
Sometimes they clump together, and if you kill one more go down with it.  
Thread groups are easy to spot, as well as parent/child relationships that 
share memory maps and file handles and such, but even just a simple "cat blah 
| less" means there are two processes connected by a pipe which pretty much 
need to be serialized together.  (A common real-world case is that one of 
those processes is going to be the X11 server, this brings up a WORLD of fun. 
 For a 1.00 release it's an obvious "Don't Do That Then", and later on might 
have special case behavior.)

If an actual file handle is open to an otherwise unlinked file, you need to 
either make a link to that file somewhere (not too hard, that info is already 
in proc/###/fs) or maybe cache the contents of the file as part of the 
serialized image...

Which brings up the whole question of how portable a serialized program image 
should be.  Forget swapping kernels, I mean running the system for a while 
before resuming the "frozen" executable.  Rename a couple files and the 
resume is going to get confused.  You kind of have to restore to the exact 
same system you left off at, because if you have an open fiile handle to file 
or device driver that isn't there on the resumed system, you basically have 
some variant of a "broken pipe" scenario.  (Then again, forced unmount of 
filesystems can sort of give you this problem anyway, so infrastructure to 
deal with it is going to have to be faced at some point...)

For rebooting a running system with the same mounted partitions and hopefully 
the same set of device drivers, this isn't really any worse than software 
suspend.  And detecting a missing file and having the resume fail with an 
error would be pretty easy.  But also pretty darn easy to trigger, but that's 
the user's problem...

What other resources attach to a process?  The process infos itself (user ID, 
capabilities), memory mappings, file handles...  Bound sockets...  Signal 
handlers and masks...  I/O port mappings and such if you're running as root...

It's not an unsolvable problem, but it IS a can of worms.  Just plain 
reparenting a process turned out to be complicated enough they made 
reparent_to_init (see kernel/sched.c).

> john

Rob
