Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSIPBJK>; Sun, 15 Sep 2002 21:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318361AbSIPBJK>; Sun, 15 Sep 2002 21:09:10 -0400
Received: from almesberger.net ([63.105.73.239]:10769 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S318358AbSIPBJJ>; Sun, 15 Sep 2002 21:09:09 -0400
Date: Sun, 15 Sep 2002 03:16:33 -0300
From: Werner Almesberger <wa@almesberger.net>
To: ashwani kumar mehra <ashwani_mehra@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CBQ implementation issues on linux
Message-ID: <20020915031633.C3352@almesberger.net>
References: <20020819141916.15289.qmail@webmail27.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020819141916.15289.qmail@webmail27.rediffmail.com>; from ashwani_mehra@rediffmail.com on Mon, Aug 19, 2002 at 02:19:16PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ashwani kumar mehra wrote:
> iii) A late 1999 doc that i found on the web says the  dequeue 
> code is also invoked via qdisc_run_queues (in sch_generic.c), thru 
> a bottom half handler(net_bh). but am unable to locate it in the 
> 2.4.18 code. am i missing something obvious or has the same been 
> reimplemented using tasklets/soft interrupts? maybe a call to 
> qdisc_restart?

This has changed a little. You may want to have a look at the
updated yet unfinished version of that ancient document:

ftp://icaftp.epfl.ch/pub/people/almesber/junk/tc-04FEB2001-0.tar.gz
(file tc/tc.ps)

Be warned that this "updated version" is for 2.4.0, so it's not
all that up to date anymore. But then, the traffic control code
hasn't changed very much in 2.4.

> 1. buffering at driver level: large buffering at driver level may 
> negate the effect of the scheduler by delaying higher priority 
> packets. ALTQ uses a token bucket regulator after the scheduler to 
> counter this problem. however i've been unable to find something 
> similar or any comment on this issue with regards to linux.

You could use something acting as a shaper (i.e. CBQ or HTB)
as the root qdisc, then cram all the other queuing inside it.

> 2. timer granularity issues: a driver will only interrupt after 
> its buffer gets emptied. however the scheduler may be invoked in 
> between by trigerring it on events like packet enqueue, expiry of 
> watchdog timers, etc. In case of timer expiry events, the timer 
> granularity remains 10 ms, so wont this lead to a bursty dequeue 
> on the next timer tick?

Yes, it does :-( Increasing HZ helps a little, and so do the
opportunistic checks (i.e. trying to dequeue whenever we're
handling an interrupt anyway). Unfortunately, the latter don't
improve worst-case burstiness, which is an issue if the next
network element in the path happens to be particularly picky.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
