Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbTFWXQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbTFWXQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:16:16 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:20100 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265580AbTFWXOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:14:02 -0400
Date: Tue, 24 Jun 2003 00:32:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306232332.h5NNWxbs002721@81-2-122-30.bradfords.org.uk>
To: davidsen@tmr.com, felipe_alfaro@linuxmail.org, john@grabjohn.com
Subject: Re: O(1) scheduler & interactivity improvements
Cc: helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 23 Jun 2003, Felipe Alfaro Solana wrote:
>
>
> > Maybe I have different a different idea of what "interactive" should be.
> > For me, an interactive process should have nearly-realtime response
> > times to user events. For example, if I click on a link in my web
> > browser's window, I want almost an immediate response:I want the process
> > to acknowledge the event, although it could be impossible to perform it
> > due to network latency, etc.
>
> > > The're interactive if the user is staring at / listening to the output.
> > 
> > Or the user is feeding events to it, for example, by dragging a window,
> > clicking the mouse or pressing keys. If a process has received user
> > input in the past, ir's pretty probable that the process is an
> > interactive one.
>
> I think this reflects what "feels good," better than how much or how long
> a process sleeps, or what CPU it uses.

Agreed.

> Consider that an interestion may be
> not only a keypress, but might be a audio buffer going ready for more
> data. Screen update without keypress is not as reliable an indicator IMHO.

Agreed.

> No claim that this is the only factor, but this seems a good way to
> identify processes doing interactive things. I think you have to identify
> things like serial ppp or terminal processes as well.
>
>
> On Mon, 23 Jun 2003, John Bradford wrote:
>
> > > Maybe I have different a different idea of what "interactive" should be.
> > 
> > [snip]
> > 
> > > moving windows around the screen do feel jerky and laggy at best
> > > when the machine is loaded. For a normal desktop usage, I prefer all
> > > my intensive tasks to start releasing more CPU cycles so moving a
> > > window around the desktop feels completely smooth
> > 
> > That's fine for a desktop box, but I wouldn't really want a heavily
> > loaded server to have database queries starved just because somebody
> > is scrolling through a log file, or moving windows about doing admin
> > work.
>
> <bias report, I do stuff on servers a lot> It might be that the total
> interactivity bonus should be set for a system, so that the admin trying
> to use and editor on a config file wouldn't have an unresponsive cursor,
> while a bunch of users doing similar things would get a smaller (perhaps
> tiny) bonus and not impact the server main application.
>
> Question for the VM gods, faced with memory pressure should the VM as well
> as the schedular be aware of interactivity and give a preference to those
> processes when deciding what to page out? The supreme court says it's okay
> to give preference as long as it's not a quota ;-)

Maybe we should give a quota.  When faced with 100% CPU usage,
non-server apps, (however you define that), can't, in total, have more
than 10% CPU, (but see * below).

> > The wordprocessor example is an interesting one - if the user is
> > changing fonts, re-flowing text and generally using it like a DTP
> > application, then I'd agree that it needs to have a more CPU.
> > 
> > If I was simply typing a letter, I wouldn't really care about
> > interactivity.  If I was using a heavily loaded server to do it,
> > (unlikely), I'd rather the wordprocessor was starved, and updated the
> > screen once per second, and gave more time to the server processes,
> > because I don't need the visual feedback to carry on typing.  Screen
> > updates are a waste of CPU in that instance - it might look nice, but
> > all it's doing is starving the CPU even more.
>
> I think what I said about limited preference applies here, OpenOffice on a
> server is (usually) misuse, but vi and tail should be nice to use!

Yeah, I was thinking of an admin doing web-based admin work, scrolling
through and re-sizing browser windows.  That will use up a non-trivial
amount of CPU, even on a fast box.  You _want_ choppy scrolling in that case.

> On 23 Jun 2003, Felipe Alfaro Solana wrote:
>
> > On Mon, 2003-06-23 at 12:50, John Bradford wrote:
>
> > > That's fine for a desktop box, but I wouldn't really want a heavily
> > > loaded server to have database queries starved just because somebody
> > > is scrolling through a log file, or moving windows about doing admin
> > > work.
> > 
> > I agree 100%... So this leads us to having two different set of
> > scheduler policies: for desktop usage, and for server usage. For desktop
> > usage, most of the apps need CPU bursts for a bried period of time. For
> > server usage, we want a more steady scheduling plan.
>
> If the total available boost shared among all interactive processes were
> limited, it might good response to a small user load on a server without
> hurting the server application performance, while allowing a desktop to
> have a large boost limit and let the other processes run on the leavings.

*

Is there any reason why we can't set a 90%/10% server/non-server CPU
limit, but make any application burstable to 100% for no longer than
10% of the time?  I.E. it would work analogously to a burstable
network pipe.

For example:

Let all server apps be called S's, and non-server apps NS's.  The
total number of non-server apps is E(NS).

So, any NS app can use 10% divided by E(NS), at any one time.  All the
time it is using less than that, it is putting time slices in the bit
bucket to draw on later, (up to a maximum).  Then, it can burst to 10%
until it's bit bucket runs out, at which point it has to remain at 10%
divided by E(NS).  Obviously E(NS) may change at any time, and if the
CPU utilisation of all S's is less than 90%, any NS app can use more
than 10%, and the bit buckets are ignored.  The bit buckets are only
relevant when S's are using 90% cpu.  S's don't have bit buckets, but
the sum CPU usage for all S's can always go up to 90%.  Of course you
_could_ schedule S's using bit buckets as well, but that is going
outside the current scope of what we were trying to achieve.

Basically, that would mean that applications:

* Can never starve server processes of CPU
* Are rewarded for being polite with their time slices, (I.E. only
  bursting when necessary).
* Cannot fake being interactive and enjoy excessive CPU for any length
  of time.

Interactive processes tend to be bursty - scrolling and resizing
windows, for example.  Obviously a 3D VR game is interactive and could
easily use 100% CPU, but using the scheduling outlined above, it would
never get excessive CPU, because it's bit bucket would never fill up.

> I am suspicious of any idea of a single knob to solve multiple complex
> problems, feel free to tell me it either won't work for common case
> {whatever}, or that it can't be implemented.
>
>
> On Mon, 23 Jun 2003, John Bradford wrote:
>
>
> > > Nah! I also think it'a waste of time, but Joe-end-user won't think the
> > > same. He'll have a better feeling using more CPU to refresh the screen
> > > at a faster rate, even when that's a waste of CPU cycles.
> > 
> > I totally agree, but it's really tempting to say that that's the
> > distribution's responsibility to renice the X server, and let the
> > kernel default to doing the Right Thing, which is to starve screen
> > refreshes in favour of 'real' work.
>
> Feeding keypress priority back to the user service process is a nasty
> problem.  Ideally it wouldn't take a hack on the X server to let the
> scheduler know what was happening, but if there's a good way to do that,
> as in "doesn't do the wrong thing a lot," I'm sure we wouldn't have this
> thread. 

John.
