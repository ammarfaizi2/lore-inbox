Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbQJZQOb>; Thu, 26 Oct 2000 12:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129123AbQJZQOW>; Thu, 26 Oct 2000 12:14:22 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:926 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129067AbQJZQOF>; Thu, 26 Oct 2000 12:14:05 -0400
Date: Thu, 26 Oct 2000 09:20:24 -0700
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Linux's implementation of poll() not scalable?
To: "Eric W. Biederman" <ebiederm@biederman.org>
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Reply-to: dank@alumni.caltech.edu
Message-id: <39F859C7.FC0A726F@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <Pine.LNX.4.10.10010241121340.1704-100000@penguin.transmeta.com>
 <39F61766.FC5D2D81@alumni.caltech.edu> <39F6A412.DE378865@idb.hist.no>
 <39F7054C.72FB3EA8@alumni.caltech.edu> <m1aebs9i74.fsf@frodo.biederman.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Dan Kegel <dank@alumni.caltech.edu> writes:
> > It's harder to write correct programs that use edge-triggered events.
> 
> Huh? The race between when an event is reported, and when you take action
> on it effectively means all events are edge triggered.

Nope.  With any of these interfaces, whether level or edge, the app must
treat all the events as hints, and be prepared for them to be wrong.
That's why code that uses poll() tends to use nonblocking sockets.
No matter what you do, you can't get away from that.  Consider
accepting a connection.  Poll or whatever tells you a listening socket
is ready for you to call accept().  Before you do, the other end sends
an RST.  Consequence: app must be prepared for a readiness event to be wrong.
cf. http://boudicca.tux.org/hypermail/linux-kernel/2000week44/0616.html

This is orthogonal to the question of whether edge or level triggering
is easier to write code for, I think.
 
> So making the interface clearly edge triggered seems to be a win for
> correctness.

With level-triggered interfaces like poll(), your chances
of writing a correctly functioning program are higher because you
can throw events away (on purpose or accidentally) with no consequences; 
the next time around the loop, poll() will happily tell you the current
state of all the fd's.

With edge-triggered interfaces, the programmer must be much more careful
to avoid ever dropping a single event; if he does, he's screwed.
This gives rise to complicated code in apps to remember the current
state of fd's in those cases where the programmer has to drop events.
And there are many cases like that; see 
http://boudicca.tux.org/hypermail/linux-kernel/2000week44/0529.html and
http://boudicca.tux.org/hypermail/linux-kernel/2000week44/0592.html
for examples.

Better to let apps ask the kernel for the current state of each socket if
they want, is what I say.  This reduces the amount of code and effort needed
to write many apps, *and makes migrating legacy apps to high-performance
interfaces easier*.
For new apps that are willing to maintain the state 
themselves, by all means, provide an edge-oriented interface, too.
It's probably better if your code is manly enough to handle it.
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
