Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbTC1CYn>; Thu, 27 Mar 2003 21:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261928AbTC1CYm>; Thu, 27 Mar 2003 21:24:42 -0500
Received: from mail.casabyte.com ([209.63.254.226]:43019 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP
	id <S261920AbTC1CYj>; Thu, 27 Mar 2003 21:24:39 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "Shaya Potter" <spotter@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: process creation/deletions hooks
Date: Thu, 27 Mar 2003 18:35:40 -0800
Message-ID: <PEEPIDHAKMCGHDBJLHKGMEEOCFAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1048813389.31797.30.camel@zaphod>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard for me to say whether this is a good (I'd tend to say NOT as you
will see below) idea because I am not sure what these hooks are supposed to
let you accomplish.  Particularly, if you are just trying to know "that" a
process structure was allocated and used, you are kind of on the right
track.  If you are interested in knowing "what" was done in that process
then you haven't gotten anywhere near close to a viable target.

If you don't wrapper exec, whole programs can come and go without ever
triggering your module-level awareness.  Consider "gettys" execs "login"
that execs "bash" and the user types "exec startx" which starts xinit which
starts X... not counting the script-children (grep, sort,  etc.) five
programs have run in two processes.  Which were you trying to track?  What
did the module miss?

If you don't actually care about resource consumption (CPU Seconds used,
memory footprint etc) and are instead interested in a "What kind of code has
hit the CPU" then you really probably want to put your hooks into various
loaders.  (That is, if this module is intended as part of a security or
audit facility you need to know a lot more than the fact of process creation
and exit.)  If you want to keep track of what kind of code was on your CPU
and make assertions about it, then you need to splice into the elf and a.out
loaders so that you can catch name overrides and such.

What about fundamental changes of character (e.g. setuid) taking place on
within a process' lifetime?

Presuming that, instead, you have a module (say a specialized caching
file-system driver) that needs to keep track of per-process data for things
using your facilities, and presumably does some sort of garbage collection,
that is better done at open/close time for the files or devices.  Keeping
sideband state after a close "just in case" a subsequent open might come
along is very bad mojo.  Adding a data structure that you process will
maintain for each process existent in the system is extra bad mojo because
your module is now involved in the lifetimes of processes that never touch
your facility.  The is wasteful and involves penalizing some process(es)
somewhere for upkeep costs.

I ask because I can think of several "bad metaphors" that people have asked
me to port from Windows that would involve such notice (and then some).

There is a very slippery slope here, as giving indiscriminant side-band
knowledge of arbitrary process peculiars "to any module writer" is asking
for virus-inducability to come along.  In such an environment a module could
easily be written to coerce every program run on a machine into subservience
to a debugger/probe etc. and such a module could automate (in a portable
way) surveillance, spying, and side-door exploits.  Such a module could then
be hidden as any number of things including "that latest driver from 3com"
or whatever.  At least today, if you want do get this kind of knowledge,
real-time, on a system you have attacked, you would have to port it to each
successive kernel and compile and install that kernel on the compromised
device.

Compromised systems are always compromised, but, for instance, my company's
embedded system box has a kernel flashed into its firmware.  If an attacker
could root this box he can't actually replace the flashed kernel.  In the
presence of this kind of hook the attacker would only need to root the box
and update the (currently runtime rewriteable) file system to add the module
into the system.  Similarly, if you were to boot a "known safe" kernel from
a CDROM such an exploit module could survive a reinstall, or in a CDROM
kernel used to boot against HD root partition scenario an exploit could
easily propagate into that "safe" CD single-user maintenance interval.

Module code is just a hair "less trustworthy" than kernel code because of
its late addition to a system.  A portable interface to hook into *every*
*process* started and stopped on the box that "must exist for modules" just
sounds fishy.

Such a callback would even expose the creation of kernel threads and
previously well-insulated clones of other modules private state.  That alone
would mean that a P.O.C. module could step out into the world and break
other peoples stuff without ever really implicating itself.  (The messages
would come back "on my system, when init starts running my Foo program I get
an OOPS during fork." and without harvesting their complete list of drivers
you'd just have to say "works for me" and ignore them.  Think of the pain!
8-)

Consider the soft-IRQ processes that run on some boxes.  The kernel boots,
some theoretical ill-behaved module "Boo" is loaded and hooked into the
clone and fork behaviors.  The next module for some product is loaded and
claims the previously unused hardware interrupt vector 15, a "[IRQ 15]"
process must be started.  At this moment, "Boo" has now been given an equity
interest and the chance to screw up the kernel thread that manages IRQ 15
and madness abounds.

The bad cases that come to mind go on and on...

In general, I'd be against something this promiscuous.  It already smacks of
the OnLoad/OnExec style notices in the Windows system message queue and
would become "trojan happy" and "DRM friendly" overnight.

IMHO There would need to be an overridingly compelling reason to expose that
event in that context.

But maybe I'm just paranoid...

Rob.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Shaya Potter
Sent: Thursday, March 27, 2003 5:03 PM
To: linux-kernel@vger.kernel.org
Subject: Re: process creation/deletions hooks


In fleshing out the ideas a little more, I would think the hook would go
right b4 wake_up_process(p) in do_fork() (at least on my 2.4.18 kernel),
so that the process is totally setup, but not yet runnable.  It would
also seem correct to go right b/4 after the BSD process accounting code
in do_exit().

so the pseudo code would be something like (pseudo in the fact that it's
been over a year since I touched the kernel's linked list, so I believe
I got them right)

list_for_each(tmp, &accounting_head)
{
        as = list_entry(tmp, struct account_struct, as_list);
        if (as->remove) //or create
                as->remove(code); //or create(p)
}

It would seem that the BSD proceed accounting could probably be changed
to use this same infrastructure, so an IFDEF would be removed, though
that's not a reason

The only negative I see is that there would have to be some sort of
locking to prevent removal's from the list causing problems.

I'm also making the assumption that the only way a process is removed
from the system is through do_exit().

anyways, comments would be appreciated.

thanks,

shaya

On Thu, 2003-03-27 at 18:56, Shaya Potter wrote:
> Well, the ideas are somewhat similar, but I'm viewing it more from a
> module perspective that lets any module author implement something, so
> it's not specialized, and hopefully has a better chance of getting in
> the kernel (i.e. I think your system could work for this as well).
>
> basically what I envision is something simple, in process creation and
> deletion we do something like
>
> item = some list_head;
> while (item)
> {
> 	item->function(task_struct);
> 	item = item->next;
> }
>
> so it has very little overhead into the actual kernel if it's not being
> used (1 memory load and 1 compare/branch).
>
> the way pagg would work (I think, just did a cursory reading) is that
> instead of storing the data in the task_struct, you'd have a seperate
> struct that deal with it.  Not as pretty in that regards, but also the
> standard way modules that want to extend the linux kernel have to work,
> and therefore hopefully linus would be willing to include it in his
> kernel.
>
> shaya
>
> On Thu, 2003-03-27 at 16:31, Nathan Straz wrote:
> > On Thu, Mar 27, 2003 at 04:08:10PM -0500, Shaya Potter wrote:
> > > We are trying to write a module that does it's own accounting of
> > > processes as they are created and deleted.  We have an extremely ugly
> > > hack of taking care of process creation (wrap fork() and clone() in a
> > > syscall wrapper, as that's the only way processes can be created).
> >
> > You might want to look at the PAGG patch.  SGI did something like this
> > to implement CSA, an accounting package.  Here are some links that might
> > interest you:
> >
> > Linux PAGG home page:
> > http://oss.sgi.com/projects/pagg/
> >
> > Design Doc:
> > http://oss.sgi.com/projects/pagg/pagg-lkd.txt
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

