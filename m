Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270762AbRHNTVd>; Tue, 14 Aug 2001 15:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270753AbRHNTVN>; Tue, 14 Aug 2001 15:21:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25595 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S270757AbRHNTVL>; Tue, 14 Aug 2001 15:21:11 -0400
Message-ID: <3B795863.863780AC@mvista.com>
Date: Tue, 14 Aug 2001 09:57:07 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Pavel Machek <pavel@suse.cz>,
        high-res-timers-discourse@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: No 100 HZ timer !
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu> <20010410202416.A21512@pcep-jamie.cern.ch> <3AD35EFB.40ED7810@mvista.com> <3B675682.3CE51A3D@mvista.com> <20010811115737.B35@toy.ucw.cz> <20010814165951.A4935@thefinal.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Pavel Machek wrote:
> > > The testing I have done seems to indicate a lower overhead on a lightly
> > > loaded system, about the same overhead with some load, and much more
> > > overhead with a heavy load.  To me this seems like the wrong thing to
> > > do.  We would like as nearly a flat overhead to load curve as we can get
> >
> > Why? Higher overhead is a price for better precision timers. If you rounded
> > all times in "tickless" mode, you'd get about same overhead, right?
> 
> What Pavel says is true only if the data structure for holding pending
> timers degrades into good O(1) insertion & deletion time in the tickless case.
> 
> I recall George Anzinger saying something about the current ticked
> scheduler being able to insert timers that never reach expiry very
> efficiently (simply a list insert + delete), whereas the current
> tickless code could not do that.
> 
> Is that right?  Is it the data structure that is taking too long to
> process, when many timers that do not reach expiry are inserted?  There
> would be one such insertion and deletion on every context switch, right?

No.  It is not the data structure.  I did not change it for the
experimental code.  This, of course, could lead to some additional
overhead looking up the next timer to figure when the next interrupt is
needed.  I used the code from the IBM tick less patch which did a brute
force search.  In actual fact this is not too bad as I also force a
timer every second, so at most ten lists need to be examined.  The
instrumentation on this look up hardly shows up, and of course, it is
only needed after an interrupt.

The overhead comes from setting up a timer for the "slice" on every
schedule.  Schedule(), in a busy system, gets called often, and "slices"
do not often expire.  The other issue is additional overhead for the
jiffie (which is a function).  On review of this code, I see that it
needs to protect it self from interrupt, so as written in the
experimental code, it is wrong and could loose track of time (however,
it is faster as written).  Now neither of these operations take very
long, it is just that they are called every schedule, which is called
often enough to make a difference.  Those who optimized the scheduler
with gotos and such knew what they were doing!  It is a function that is
called enough to make the optimization worth while.

For those who would like to try the experimental system it can be found
at:
http://sourceforge.net/projects/high-res-timers
where it is called the "no HZ tick test".  Do read the release notes to
understand what you are getting.

George
