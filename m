Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbRDJWLu>; Tue, 10 Apr 2001 18:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132396AbRDJWLl>; Tue, 10 Apr 2001 18:11:41 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:38890 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132387AbRDJWLh>; Tue, 10 Apr 2001 18:11:37 -0400
Message-ID: <3AD38464.A1F97AC8@mvista.com>
Date: Tue, 10 Apr 2001 15:08:36 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mark salisbury <mbs@mc.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3AD366DC.478E4AF@mc.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mark salisbury wrote:
> 
> george anzinger wrote:
> 
> > f) As noted, the account timers (task user/system times) would be much
> > more accurate with the tick less approach.  The cost is added code in
> > both the system call and the schedule path.
> >
> > Tentative conclusions:
> >
> > Currently we feel that the tick less approach is not acceptable due to
> > (f).  We felt that this added code would NOT be welcome AND would, in a
> > reasonably active system, have much higher overhead than any savings in
> > not having a tick.  Also (d) implies a list organization that will, at
> > the very least, be harder to understand.  (We have some thoughts here,
> > but abandoned the effort because of (f).)  We are, of course, open to
> > discussion on this issue and all others related to the project
> > objectives.
> 
> f does not imply tick-less is not acceptable, it implies that better process time
> accounting is not acceptable.

My thinking is that a timer implementation that forced (f) would have
problems gaining acceptance (even with me :).  I think a tick less
system does force this and this is why we have, at least for the moment,
abandoned it.  In no way does this preclude (f) as it is compatible with
either ticks or tick less time keeping.  On the other hand, the stated
project objectives do not include (f) unless, of course we do a tick
less time system.
> 
> list organization is not complex, it is a sorted absolute time list.  I would
> argue that this is a hell of a lot easier to understand that ticks + offsets.

The complexity comes in when you want to maintain indexes into the list
for quick insertion of new timers.  To get the current insert
performance, for example, you would need pointers to (at least) each of
the next 256 centasecond boundaries in the list.  But the list ages, so
these pointers need to be continually updated.  The thought I had was to
update needed pointers (and only those needed) each time an insert was
done and a needed pointer was found to be missing or stale.  Still it
adds complexity that the static structure used now doesn't have.
> 
> still, better process time accounting should be a compile CONFIG option, not
> ignored and ruled out because some one thinks that is is to expensive in the
> general case.

As I said above, we are not ruling it out, but rather, we are not
requiring it by going tick less.
> 
> the whole point of linux and CONFIG options is to get you the kernel with the
> features you want, not what someone else wants.
> 
> there should be a whole range of config options associated with this issue:
> 
> CONFIG_JIFFIES   == old jiffies implementation
> CONFIG_TICKLESS  == tickless
> CONFIG_HYBRID  == old jiffies plus a tickless high-res timer system on
>                                     the side but not assoc w/ process and global
> timekeeping
> 
> CONFIG_USELESS_PROCESS_TIME_ACCOUNTING = old style, cheap time acctg
> CONFIG_USEFUL_BUT_COSTS_TIME_ACCOUNTING = accurate but expensive time accounting
> 
> this way, users who want tickless and lousy time acctg can have it AND people who
> want jiffies and good time acctg could have it.

As I said, it is not clear how you could get
CONFIG_USELESS_PROCESS_TIME_ACCOUNTING unless you did a tick every
jiffie.  What did you have in mind?
> 
> these features are largely disjoint and easily seperable.  it is also relatively
> trivial to do this in such a way that drivers depending on the jiffie abstraction
> can be supported without modification no matter what the configuration.
> 
For the most part, I agree.  I am not sure that it makes a lot of sense
to mix some of these options, however.  I think it comes down to the
question of benefit vs cost.  If keeping an old version around that is
not any faster or more efficient in any way would seem too costly to
me.  We would like to provide a system that is better in every way and
thus eliminate the need to keep the old one around.  We could leave it
in as a compile option so folks would have a fall back, I suppose.

An Issue no one has raised is that the tick less system would need to
start a timer each time it scheduled a task.  This would lead to either
slow but very precise time slicing or about what we have today with more
schedule overhead.

George


>     Mark Salisbury
