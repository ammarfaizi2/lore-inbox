Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVA3X7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVA3X7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVA3X7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:59:21 -0500
Received: from lakermmtao10.cox.net ([68.230.240.29]:64982 "EHLO
	lakermmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261848AbVA3X7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:59:13 -0500
In-Reply-To: <Pine.OSF.4.05.10501302245420.14749-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10501302245420.14749-100000@da410.phys.au.dk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F0038AE2-731A-11D9-BD84-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Shane Shrybman <shrybman@aei.ca>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, emann@mrv.com,
       Rui Nuno Capela <rncbc@rncbc.org>, Adam Heath <doogie@debian.org>,
       Gunther Persoons <gunther_persoons@spymac.com>,
       Florian Schmidt <mista.tapas@gmx.net>, mark_h_johnson@raytheon.com,
       linux-kernel@vger.kernel.org,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Karsten Wiese <annabellesgarden@yahoo.de>,
       Bill Huey <bhuey@lnxw.com>, Amit Shah <amit.shah@codito.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15)
Date: Sun, 30 Jan 2005 18:59:11 -0500
To: Esben Nielsen <simlo@phys.au.dk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For anybody who wants a good executive summary of RCU, see these:
http://lse.sourceforge.net/locking/rcupdate.html
http://lse.sourceforge.net/locking/rcu/HOWTO/intro.html#WHATIS

On Jan 30, 2005, at 17:03, Esben Nielsen wrote:
> I agree that RCU ought to do the trick in a lot of cases. 
> Unfortunately,
> people haven't used RCU in a lot of code but an rwlock. I also like the
> idea of rwlocks: Many readers or just one writer.

Well, RCU is nice because as long as there are no processes attempting 
to
modify the data, the performance is as though there was no locking at 
all,
which is better than the cacheline-bouncing for rwlock read-acquires,
which must modify the rwlock data every time you acquire.  It's only 
when
you need to modify the data that readers or other writers must repeat
their calculations when they find out that the data's changed.  In the
case of a reader and a writer, the performance reduction is the same as 
a
cmpxchg and the reader redoing their calculations (if necessary).

> You have a shared datastructure, rarely updated with many readers. A 
> low
> priority task is reading it. That is preempted a high priority task 
> which
> finds out it can't read it -> priority inheritance, task switch. The 
> low
> priority task finishes the job -> priority set back, task switch. If it
> was done with a rwlock two task switchs would have been saved.

With RCU the high priority task (unlikely to be preempted) gets to run 
all
the way through with its calculation, and any low priority tasks are the
ones that will probably need to redo their calculations.

> Yes it does. But one could make a compromise: The up_write() should 
> _not_
> be deterministic. In that case it would be very simple to implement.
> up_read() could still be deterministic as it would only involve 
> boosting
> one writer in the rare case such exists. That kind of locking would be
> very usefull in many real-time systems. Ofcourse, RCU can do the job as
> well, but it puts a lot of contrains on the code.

Yeah, unfortunately it's harder to write good reliable RCU code than 
good
reliable rwlock code, because the semantics of RCU WRT memory access are
much more difficult, so more people write rwlock code that needs to be
cleaned up.  It's not like normal locking is easily comprehensible 
either.
:-\

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


