Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273135AbRIUBUq>; Thu, 20 Sep 2001 21:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274733AbRIUBUg>; Thu, 20 Sep 2001 21:20:36 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:11276 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274731AbRIUBUb>; Thu, 20 Sep 2001 21:20:31 -0400
Message-ID: <3BAA95E0.5BEB8990@zip.com.au>
Date: Thu, 20 Sep 2001 18:20:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Andrea Arcangeli <andrea@suse.de>, Robert Love <rml@tech9.net>,
        "Dieter =?iso-8859-1?Q?N=FCtzel?=" <Dieter.Nuetzel@hamburg.de>,
        Chris Mason <mason@suse.com>, Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy> <200109202112.f8KLCXG16849@zero.tech9.net> <1001024694.6048.246.camel@phantasy> <20010921003742.I729@athlon.random> <1001026597.6048.278.camel@phantasy> <20010921011514.M729@athlon.random> <3BAA8BDA.5EED2879@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> ...
> Actually, I rather think that the problem is lock granularity.  These
> issues are present in the SMP systems as well.  A good solution would be
> one that shortened the spinlock time.  No horrid preempt code, just
> tight fast code.
> 

This may not be practical.

Take, for example, zap_page_range().   It simply has a lot
of work to do, and it does it inside a spinlock.  By doing
it in a tight loop, it's optimal.

There is no way to speed this function up by two or three orders
of magnitude.  (Well, there is: don't take the lock at all if
the mm isn't shared, but this is merely an example.  There are
other instances).

It seems that for a preemptive kernel to be successful, we need
to globally alter the kernel so that it never holds locks for
more than 500 microseconds.  Which is what the conditional_schedule()
(aka cooperative multitasking :)) patches do.

It seems that there are no magic bullets, and low latency will
forever have a global impact on kernel design, unless a way is
found to reschedule with locks held.  I recall that a large
part of the MontaVista patch involved turning spinlocks into
semaphores, yes?  That would seem to be the way to go.
