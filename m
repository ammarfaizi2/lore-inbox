Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWA0TZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWA0TZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWA0TZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:25:29 -0500
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:46980
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S932479AbWA0TZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:25:28 -0500
Date: Fri, 27 Jan 2006 20:25:03 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Howard Chu <hyc@symas.com>
Cc: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Message-ID: <20060127192503.GA17179@titan.lahn.de>
Mail-Followup-To: Howard Chu <hyc@symas.com>, davids@webmaster.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au> <43D93FEA.3070305@symas.com> <43D941FD.9050705@yahoo.com.au> <43D94595.4030002@symas.com> <43D94C2D.6080401@yahoo.com.au> <43D9D4ED.8050406@symas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D9D4ED.8050406@symas.com>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 27, 2006 at 12:08:13AM -0800, Howard Chu wrote:
> >No, not immediately, I said "for a very long time". As in: A does not
> >need the exclusion provided by the lock for a very long time so it
> >drops it to avoid needless contention, then reaquires it when it finally
> >does need the lock.
> 
> OK. I think this is really a separate situation. Just to recap: A takes 
> lock, does some work, releases lock, a very long time passes, then A 
> takes the lock again. In the "time passes" part, that mutex could be 
> locked and unlocked any number of times by other threads and A won't 
> know or care. Particularly on an SMP machine, other threads that were 
> blocked on that mutex could do useful work in the interim without 
> impacting A's progress at all. So here, when A leaves the mutex unlocked 
> for a long time, it's desirable to give the mutex to one of the waiters 
> ASAP.

When you release a lock, you unblock at most one thread, which is
waiting for that lock and put that released thread in the runnable
state.
Than it's up to the scheduler, what happens next:
- if you have multiple processors, you _can_ run the released thread on
  anther processor, so both thread run.
- if you are single processor or don't want to schedule the released
  thread on a second cpu, you must decide to
  - either _continue running the releasing thread_ and let the released
    thread stay some more time in the runnable queue,
  - or _preempt the releasing thread_ to the runnable queue and make the
    released thread running.
If you have different priorities, your decision is easy: run the most
important thread.
But if you don't have priorities, you base your decision on other
metrics: Since it takes more time to switch a thread (save/restore
state) compared to continue running the same thread, from a throuput
perspective you'll prefer to not change threads.

Similar thinking for yield(): You put the running thread back to the
runnable queue and choose one thread from it as the new running thread.
Note, that you might choose the old thread as the new thread again,
since with SCHED_OTHER this is perfectly fine, if you decided to honor
throuput more than fairness.
Other with SCHED_FIFO/RR, since there you are forced to put the old
thread at the end of your runnable queue and choose the new one from the
front of the queue, so all other threads with the same priority will run
before you yielding thread gets the cpu again.

Summary: yield() only makes sense with a SCHED_FIFO/RR policy, because
with SCHED_OTHER you know too little about the exact policy to make any
use of it.

BYtE
Philipp
-- 
      Dipl.-Inform. Philipp.Hahn@informatik.uni-oldenburg.de
      Abteilung Systemsoftware und verteilte Systeme, Fk. II
Carl von Ossietzky Universitaet Oldenburg, 26111 Oldenburg, Germany
    http://www.svs.informatik.uni-oldenburg.de/contact/pmhahn/
      Telefon: +49 441 798-2866    Telefax: +49 441 798-2756
