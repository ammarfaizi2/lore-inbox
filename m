Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132742AbRC2PCw>; Thu, 29 Mar 2001 10:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132745AbRC2PCm>; Thu, 29 Mar 2001 10:02:42 -0500
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:25865 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S132742AbRC2PC2>; Thu, 29 Mar 2001 10:02:28 -0500
Date: Thu, 29 Mar 2001 17:01:40 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Andreas Dilger <adilger@turbolinux.com>,
   Martin Dalecki <dalecki@evision-ventures.com>,
   Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
   Jonathan Morton <chromi@cyberspace.org>,
   Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <Pine.LNX.4.30.0103291410070.13864-100000@fs131-224.f-secure.com>
Message-Id: <Pine.A32.3.95.1010329160740.63156B-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Szabolcs Szakacsits wrote:

> 
> On Thu, 29 Mar 2001, Dr. Michael Weller wrote:
> > On Wed, 28 Mar 2001, Andreas Dilger wrote:
> > > Szaka writes:
> > > > And every time the SIGDANGER comes up, the issue that AIX provides
> > > > *both* early and late allocation mechanism even on per-process basis
> > > > that can be controlled by *both* the programmer and the admin is
> > > > completely ignored. Linux supports none of these...
> > Maybe some details here were helpful.
> 
> http://www.unet.univie.ac.at/aix/aixbman/baseadmn/pag_space_under.htm

I read it, it agress with my memory.

> 
> > > > ...with the current model it's quite possible the handler code is still
> > > > sitting on the disk and no memory will be available to page it in.
> > > Actually, I see SIGDANGER being useful at the time we hit freepages.min
> 
> The point is AIX *can* guarantee [even for an ordinary process] that
> your signal handler will be executed, Linux can *not*. It doesn't matter

No it can't... and the reason is...

> where the different oom watermarks are, there would be always such
> situations when your handler would get the control it's already far too
> late [because between sending SIGDANGER and app getting the control (you
> can't schedule e.g. 1000 apps at the same time) the system run into oom
> and killed just your app (and e.g. the other 999 buggy mem leaking app

 ..just that. The system may run OOM hard before your SIGDANGER handler is
   called,

Of course not if there are 999 apps w/o a sigdanger handler. I doubt the
kernel needs to schedule them to learn SIGDANGER is ignored. These won't
be touched. But if there are 999 leaky apps with a SIGDANGER handler, you
might still be killed.

Note that there are nasty users like me, which provide a no_op function
as SIGDANGER handler. In my first hand AIX experience, this suffices
to get your process killed last (after init, for example). If you want to
honour it only when the process really freed memory, you need to store the
memory used when entering SIGDANGER (which can probably be done).

Just a routine to trigger SIGDANGER in all apps at mem low would probably
not bloat the kernel much.

About killing, from my first hand experience aix just kills random
processes (only distinguishhes SIGDANGER ignored or not). Maybe those
using much memory first. This is by no means better than the OOM killer
ap. It for examples kills your 14 days running large simulation if joe
blow users Netscape goes havoc.

AIX does not 'strictly' guarantee that SIGDANGER reaches you. It can't.
It is only likely since few processes catch SIGDANGER, and those that do
it will probably not allocate much memory while doing so. (but the single
page they might allocate for some local stack variable  in the SIGDANGER
handler can kill it).

Joe blow user can code a SIGDANGER exploiting prog that will kill the
whole concept by allocating memory in SIGDANGER.

Actually, the OOM Killer could probably be coded to send an early warning
too.. That is the idea of the external implementation.. more flexibility.

I personally agree with you though, I don't like external kernel servers
like this one. I also dislike kerneld and modules (except for first time
installation of a distrib). I still always compile monolithic kernels for
my servers. I can't sleep well otherwise, sorry.

> registered a no-op SIGDANGER handler), hope you get the picture even
> the example is highly unrealistic].
> 
> > > (or maybe even freepages.low), rather than actual OOM so that the apps
> > > have a chance to DO something about the memory shortage,
> 
> Primarily *users* should have a chance to control this thing, not

I agree, and like SIGDANGER as an early warning. But it doesn't solve
the issue finally, only helps soothing.

About this early alloction myths: Did you actually read the page?
The fact its controlled by a silly environment variable shows it
is a mere user space issue.

So what does it do? if you do malloc (that is, sbrk or mmap) it checks
if enough paging page is there or not. Then you need to allocate (=dirty)
the pages. Just access every pagesize's (4096) byte in it. If someone else
allocates memory while you do it, you might get killed doing so or get
SIGDANGER (which you should catch so you can return 'failed' in that case
and free the new block). Same for mmaps not covered by a file
(PRIVATE or anonymous map).

How simple. If you are that concerned about this: You can easily do it in
your application. Talk to the glibc people (not kerne) to add it for your
convenience. S.o. could also make a new malloc implementation to be linked
to your app (c.f. electric fence) to overload the standard one.  A simple
user space issue. IMHO, lean syscalls to dirty/alloc many pages and esp.
to learn about memory left (I don't want to parse /proc/meminfo all the
time) would be helpful though (but not strictly required). 

Except when the kernel does lazy erasing of new pages, this allocation
will be slow though (can't be done in a single timeslice). It would be
good if pages could be allocated without really clearing them to zeor
(this would be done on first access). This would speedup this feature. One
would need to see how much this is an RL issue though. Probbly the appl
would dirty the pages shortly after anyway. 

What does AIX about stack overflows? Applications forking and then
dirtying their shared data pages madly? OOps.. nothing.. Why? It cannot be
done!

The real advantage of the AIX implementation is: it covers the easy to
implement cases which are luckily those common people consider. The
difficult cases are not handled, but these concern only the real hackers
which know it can't be done. 

Believe me. Without the early killing bug, you'd now praise how cleverly
OOM killer selects apps to kill compared to aix with no, or only well
behaved, SIGDANGER handlers.

Personally, I'd still prefer the (kernel wise seen) simple AIX
in kernel implementation, at least as an option to the external OOM
killer.

Michael (which uses AIX still about as much as linux).

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

