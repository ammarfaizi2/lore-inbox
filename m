Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132502AbRDKAny>; Tue, 10 Apr 2001 20:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDKAnp>; Tue, 10 Apr 2001 20:43:45 -0400
Received: from chmls06.mediaone.net ([24.147.1.144]:5319 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S132502AbRDKAn3>; Tue, 10 Apr 2001 20:43:29 -0400
Message-ID: <002a01c0c221$32703e60$6501a8c0@gonar.com>
From: "Mark Salisbury" <gonar@mediaone.net>
To: "george anzinger" <george@mvista.com>, "mark salisbury" <mbs@mc.com>
Cc: "Jamie Lokier" <lk@tantalophile.demon.co.uk>,
        <high-res-timers-discourse@lists.sourceforge.net>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
        "David Schleef" <ds@schleef.org>, "Jeff Dike" <jdike@karaya.com>,
        <schwidefsky@de.ibm.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3AD366DC.478E4AF@mc.com> <3AD38464.A1F97AC8@mvista.com>
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 20:48:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> mark salisbury wrote:
> >
> > george anzinger wrote:
> >
> > > f) As noted, the account timers (task user/system times) would be much
> > > more accurate with the tick less approach.  The cost is added code in
> > > both the system call and the schedule path.
> > >
> > > Tentative conclusions:
> > >
> > > Currently we feel that the tick less approach is not acceptable due to
> > > (f).  We felt that this added code would NOT be welcome AND would, in
a
> > > reasonably active system, have much higher overhead than any savings
in
> > > not having a tick.  Also (d) implies a list organization that will, at
> > > the very least, be harder to understand.  (We have some thoughts here,
> > > but abandoned the effort because of (f).)  We are, of course, open to
> > > discussion on this issue and all others related to the project
> > > objectives.
> >
> > f does not imply tick-less is not acceptable, it implies that better
process time
> > accounting is not acceptable.
>
> My thinking is that a timer implementation that forced (f) would have
> problems gaining acceptance (even with me :).  I think a tick less
> system does force this and this is why we have, at least for the moment,
> abandoned it.  In no way does this preclude (f) as it is compatible with
> either ticks or tick less time keeping.  On the other hand, the stated
> project objectives do not include (f) unless, of course we do a tick
> less time system.
> >
> > list organization is not complex, it is a sorted absolute time list.  I
would
> > argue that this is a hell of a lot easier to understand that ticks +
offsets.
>
> The complexity comes in when you want to maintain indexes into the list
> for quick insertion of new timers.  To get the current insert
> performance, for example, you would need pointers to (at least) each of
> the next 256 centasecond boundaries in the list.  But the list ages, so
> these pointers need to be continually updated.  The thought I had was to
> update needed pointers (and only those needed) each time an insert was
> done and a needed pointer was found to be missing or stale.  Still it
> adds complexity that the static structure used now doesn't have.

actually, I think a head and tail pointer would be sufficient for most
cases. (most new timers are either going to be a new head of list or a new
tail, i.e. long duration timeouts that will never be serviced or short
duration timers that are going to go off "real soon now (tm)")  the oddball
cases would be mostly coming from user-space, i.e. nanosleep which a longerr
list insertion disapears in the block/wakeup/context switch overhead

> >
> > still, better process time accounting should be a compile CONFIG option,
not
> > ignored and ruled out because some one thinks that is is to expensive in
the
> > general case.
>
> As I said above, we are not ruling it out, but rather, we are not
> requiring it by going tick less.
> As I said, it is not clear how you could get
> CONFIG_USELESS_PROCESS_TIME_ACCOUNTING unless you did a tick every
> jiffie.  What did you have in mind?

time accounting can be limited to the quantum expiration and voluntary
yields in the tickless/useless case.

> For the most part, I agree.  I am not sure that it makes a lot of sense
> to mix some of these options, however.  I think it comes down to the
> question of benefit vs cost.  If keeping an old version around that is
> not any faster or more efficient in any way would seem too costly to
> me.  We would like to provide a system that is better in every way and
> thus eliminate the need to keep the old one around.  We could leave it
> in as a compile option so folks would have a fall back, I suppose.

I agree that some combinations don't make much sense _TO_ME_ but that
doesn't mean they don't meet sombody's needs.

in my case (embedded, medium hard real time, massively parallel
multicomputer)  the only choices that makes sense to my customers is
tickless/useless in deployment and tickless/useful in
development/profiling/optimization.

in other cases ticked/useless makes sense (dumb old slow chips)

I have no idea who would want ticked/useful or hybrid.  i suggested hybrid
as an alternative in case linus might be reluctant to gutting and replacing
the sysclock.

>
> An Issue no one has raised is that the tick less system would need to
> start a timer each time it scheduled a task.  This would lead to either
> slow but very precise time slicing or about what we have today with more
> schedule overhead.

no.  you would re-use the timer with a new expiration time and a re-insert.

also re overhead. the cost of servicing 10 times as many interrupts as
necessary for system function must cost a fair chunk.



