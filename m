Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbTFWVk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbTFWVk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:40:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43791 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266154AbTFWVkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:40:49 -0400
Date: Mon, 23 Jun 2003 17:48:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       John Bradford <john@grabjohn.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler & interactivity improvements
In-Reply-To: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1030623170606.433A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 2003, Felipe Alfaro Solana wrote:


> Maybe I have different a different idea of what "interactive" should be.
> For me, an interactive process should have nearly-realtime response
> times to user events. For example, if I click on a link in my web
> browser's window, I want almost an immediate response:I want the process
> to acknowledge the event, although it could be impossible to perform it
> due to network latency, etc.

> > The're interactive if the user is staring at / listening to the output.
> 
> Or the user is feeding events to it, for example, by dragging a window,
> clicking the mouse or pressing keys. If a process has received user
> input in the past, ir's pretty probable that the process is an
> interactive one.

I think this reflects what "feels good," better than how much or how long
a process sleeps, or what CPU it uses. Consider that an interestion may be
not only a keypress, but might be a audio buffer going ready for more
data. Screen update without keypress is not as reliable an indicator IMHO.

No claim that this is the only factor, but this seems a good way to
identify processes doing interactive things. I think you have to identify
things like serial ppp or terminal processes as well.


On Mon, 23 Jun 2003, John Bradford wrote:

> > Maybe I have different a different idea of what "interactive" should be.
> 
> [snip]
> 
> > moving windows around the screen do feel jerky and laggy at best
> > when the machine is loaded. For a normal desktop usage, I prefer all
> > my intensive tasks to start releasing more CPU cycles so moving a
> > window around the desktop feels completely smooth
> 
> That's fine for a desktop box, but I wouldn't really want a heavily
> loaded server to have database queries starved just because somebody
> is scrolling through a log file, or moving windows about doing admin
> work.

<bias report, I do stuff on servers a lot> It might be that the total
interactivity bonus should be set for a system, so that the admin trying
to use and editor on a config file wouldn't have an unresponsive cursor,
while a bunch of users doing similar things would get a smaller (perhaps
tiny) bonus and not impact the server main application.

Question for the VM gods, faced with memory pressure should the VM as well
as the schedular be aware of interactivity and give a preference to those
processes when deciding what to page out? The supreme court says it's okay
to give preference as long as it's not a quota ;-)

> 
> The wordprocessor example is an interesting one - if the user is
> changing fonts, re-flowing text and generally using it like a DTP
> application, then I'd agree that it needs to have a more CPU.
> 
> If I was simply typing a letter, I wouldn't really care about
> interactivity.  If I was using a heavily loaded server to do it,
> (unlikely), I'd rather the wordprocessor was starved, and updated the
> screen once per second, and gave more time to the server processes,
> because I don't need the visual feedback to carry on typing.  Screen
> updates are a waste of CPU in that instance - it might look nice, but
> all it's doing is starving the CPU even more.

I think what I said about limited preference applies here, OpenOffice on a
server is (usually) misuse, but vi and tail should be nice to use!


On 23 Jun 2003, Felipe Alfaro Solana wrote:

> On Mon, 2003-06-23 at 12:50, John Bradford wrote:

> > That's fine for a desktop box, but I wouldn't really want a heavily
> > loaded server to have database queries starved just because somebody
> > is scrolling through a log file, or moving windows about doing admin
> > work.
> 
> I agree 100%... So this leads us to having two different set of
> scheduler policies: for desktop usage, and for server usage. For desktop
> usage, most of the apps need CPU bursts for a bried period of time. For
> server usage, we want a more steady scheduling plan.

If the total available boost shared among all interactive processes were
limited, it might good response to a small user load on a server without
hurting the server application performance, while allowing a desktop to
have a large boost limit and let the other processes run on the leavings.

I am suspicious of any idea of a single knob to solve multiple complex
problems, feel free to tell me it either won't work for common case
{whatever}, or that it can't be implemented.


On Mon, 23 Jun 2003, John Bradford wrote:


> > Nah! I also think it'a waste of time, but Joe-end-user won't think the
> > same. He'll have a better feeling using more CPU to refresh the screen
> > at a faster rate, even when that's a waste of CPU cycles.
> 
> I totally agree, but it's really tempting to say that that's the
> distribution's responsibility to renice the X server, and let the
> kernel default to doing the Right Thing, which is to starve screen
> refreshes in favour of 'real' work.

Feeding keypress priority back to the user service process is a nasty
problem.  Ideally it wouldn't take a hack on the X server to let the
scheduler know what was happening, but if there's a good way to do that,
as in "doesn't do the wrong thing a lot," I'm sure we wouldn't have this
thread. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

