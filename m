Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135700AbRD2IsR>; Sun, 29 Apr 2001 04:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135701AbRD2IsI>; Sun, 29 Apr 2001 04:48:08 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:25494 "EHLO
	c0mailgw03.prontomail.com") by vger.kernel.org with ESMTP
	id <S135700AbRD2Iru>; Sun, 29 Apr 2001 04:47:50 -0400
Message-ID: <3AEBD4F7.D5B2517F@mvista.com>
Date: Sun, 29 Apr 2001 01:46:47 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: Nigel Gamble <nigel@nrg.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <Pine.LNX.4.33.0104280646140.430-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Fri, 27 Apr 2001, Nigel Gamble wrote:
> 
> > On Fri, 27 Apr 2001, Mike Galbraith wrote:
> > > On Fri, 27 Apr 2001, Nigel Gamble wrote:
> > > > > What about SCHED_YIELD and allocating during vm stress times?
> > >
> > > snip
> > >
> > > > A well-written GUI should not be using SCHED_YIELD.  If it is
> > >
> > > I was refering to the gui (or other tasks) allocating memory during
> > > vm stress periods, and running into the yield in __alloc_pages()..
> > > not a voluntary yield.
> >
> > Oh, I see.  Well, if this were causing the problem, then running the GUI
> > at a real-time priority would be a better solution than increasing the
> > clock frequency, since SCHED_YIELD has no effect on real-time tasks
> > unless there are other runnable real-time tasks at the same priority.
> > The call to schedule() would just reschedule the real-time GUI task
> > itself immediately.
> >
> > However, in times of vm stress it is more likely that GUI performance
> > problems would be caused by parts of the GUI having been paged out,
> > rather than by anything which could be helped by scheduling differences.
> 
> Agreed.  I wasn't thinking about swapping, only kswapd not quite keeping
> up with laundering, and then user tasks having to pick up some of the
> load.  Anyway, I've been told that for most values of HZ the slice is
> 50ms, so my reasoning wrt HZ/SCHED_YIELD was wrong.  (begs the question
> why do some archs use higher HZ values?)
> 
Well, almost.  Here is the scaling code:

#if HZ < 200
#define TICK_SCALE(x)	((x) >> 2)
#elif HZ < 400
#define TICK_SCALE(x)	((x) >> 1)
#elif HZ < 800
#define TICK_SCALE(x)	(x)
#elif HZ < 1600
#define TICK_SCALE(x)	((x) << 1)
#else
#define TICK_SCALE(x)	((x) << 2)
#endif

#define NICE_TO_TICKS(nice)	(TICK_SCALE(20-(nice))+1)

This, by the way, is new with 2.4.x.  As to why, it has more to do with
timer resolution than anything else.  Timer resolution is 1/HZ so higher
HZ => better resolution.  Of course, you must pay for it.  Nothing is
free :)  Higher HZ means more interrupts => higher overhead.

George
