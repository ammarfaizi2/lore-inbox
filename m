Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUCAKU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 05:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUCAKTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 05:19:21 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:35292 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261168AbUCAKSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 05:18:30 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Date: Mon, 1 Mar 2004 15:48:15 +0530
User-Agent: KMail/1.5
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <403FC0AA.6040205@mvista.com> <20040227225026.GL1052@smtp.west.cox.net>
In-Reply-To: <20040227225026.GL1052@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011548.15601.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 Feb 2004 4:20 am, Tom Rini wrote:
> On Fri, Feb 27, 2004 at 02:11:54PM -0800, George Anzinger wrote:
> > Tom Rini wrote:
> > >On Thu, Feb 26, 2004 at 05:57:27PM -0800, George Anzinger wrote:
> > >>Tom Rini wrote:
> > >>>On Thu, Feb 26, 2004 at 03:30:08PM -0800, George Anzinger wrote:
> > >>>>Amit S. Kale wrote:
> > >>>>>On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
> > >>>>>>The following patch fixes a number of little issues here and there,
> > >>>>>>and
> > >>>>>>ends up making things more robust.
> > >>>>>>- We don't need kgdb_might_be_resumed or kgdb_killed_or_detached.
> > >>>>>>GDB attaching is GDB attaching, we haven't preserved any of the
> > >>>>>>previous context anyhow.
> > >>>>>
> > >>>>>If gdb is restarted, kgdb has to remove all breakpoints. Present
> > >>>>> kgdb does that in the code this patch removes:
> > >>>>>
> > >>>>>-		if (remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] ==
> > >>>>>'c') {
> > >>>>>-			remove_all_break();
> > >>>>>-			atomic_set(&kgdb_killed_or_detached, 0);
> > >>>>>-			ok_packet(remcom_out_buffer);
> > >>>>>
> > >>>>>If we don't remove breakpoints, they stay in kgdb without gdb not
> > >>>>>knowing it and causes consistency problems.
> > >>>>
> > >>>>I wonder if this is worth the trouble.  Does kgdb need to know about
> > >>>>breakpoints at all?  Is there some other reason it needs to track
> > >>>> them?
> > >>>
> > >>>I don't know if it's strictly needed, but it's not the hard part of
> > >>> this particular issue (as I suggested in another thread,
> > >>> remove_all_break() on a ? packet works).
> > >>>
> > >>>>>>- Don't try and look for a connection in put_packet, after we've
> > >>>>>> tried to put a packet.  Instead, when we receive a packet, GDB has
> > >>>>>> connected.
> > >>>>>
> > >>>>>We have to check for gdb connection in putpacket or else following
> > >>>>>problem occurs.
> > >>>>>
> > >>>>>1. kgdb console messages are to be put.
> > >>>>>2. gdb dies
> > >>>>>3. putpacket writes the packet and waits for a '+'
> > >>>>
> > >>>>Oops!  Tom, this '+' will be sent under interrupt and while kgdb is
> > >>>> not connected.  Looks like it needs to be passed through without
> > >>>> causing a breakpoint.  Possible salvation if we disable interrupts
> > >>>> while waiting for the '+' but I don't think that is a good idea.
> > >>>
> > >>>I don't think this is that hard of a problem anymore.  I haven't
> > >>> enabled console messages, but I've got the following being happy now:
> > >>
> > >>console pass through is the hard one as it is done outside of kgdb
> > >> under interrupt control.  Thus the '+' will come to the interrupt
> > >> handler.
> > >>
> > >>There is a bit of a problem here WRT hiting a breakpoint while waiting
> > >>for this '+'.  Should only happen on SMP systems, but still....
> > >
> > >Here's why I don't think it's a problem (I'll post the new patch
> > >shortly, getting from quilt to a patch against previous is still a
> > >pain).  What happens is:
> > >1. kgdb console tried to send a packet.
> > >2. before ACK'ing the above, gdb dies.
> >
> > What I am describing does not have anything to do with gdb going away. 
> > It is that in "normal" operation the console output is done with the
> > interrupts on (i.e. we are not in kgdb as a result of a breakpoint, but
> > only to do console output).  This means that the interrupt that is
> > generated by the '+' from gdb may well happen and the kgdb interrupt
> > handler will see the '+' and, with the interrupt handler changes,
> > generate a breakpoint.  All we really want to do is to pass the '+'
> > through to putpacket.  In a UP machine, I think the wait for the '+' is
> > done with the interrupt system off, however, in an SMP machine, other
> > cpus may see it and interrupt...  At the very least, the interrupt code
> > needs to be able to determine that no character came in and ignore the
> > interrupt.
>
> Today might not be a "smart day" for me, so perhaps I'm just not doing
> what's need to trigger this, or I'm misreading (but if you can trigger
> it, w/ Amit's patches in CVS and my 1/2 from yesterday and then my 7
> from today, I'd be grateful) but UP and SMP on a UP box both have
> KGDB_CONSOLE behaving correctly.

You may not have seen the race. I too believe that the race pointed out by 
George exists.

-Amit

