Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUL0Pch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUL0Pch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbUL0Pch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:32:37 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:36787 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261904AbUL0PcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:32:20 -0500
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
	-RT-2.6.10-rc2-mm3-V0.7.32-15)
From: Steven Rostedt <rostedt@kihontech.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk>
Content-Type: text/plain
Date: Mon, 27 Dec 2004 10:27:52 -0500
Message-Id: <1104161272.20042.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 15:35 +0100, Esben Nielsen wrote:
> I haven't seen much traffic on real-time preemption lately. Is it due
> to Christmas or lost interest?
> 

I think they are on vacation :-)

> I noticed that you changed rw-locks to behave quite diferently under
> real-time preemption: They basicly works like normal locks now. I.e. there
> can only be one reader task within each region. This can can however lock
> the region recursively. I wanted to start looking at fixing that because
> it ought to hurt scalability quite a bit - and even on UP create a few
> unneeded task-switchs. However, the more I think about it the bigger the 
> problem:
> 
> First, let me describe how I see a read-write lock. It has 3 states:
> a) unlocked
> b) locked by n readers
> c) locked by 1 writer
> There can either be 1 writer within the protected region or n>=0
> readers within the region. When a writer wants to take the lock,
> calling down_write(), it has to wait until the read count is 0. When a
> reader wants to take the lock, calling down_read(), he has only to wait
> until the the writer is done - there is no need to wait for the other
> readers.
> 
> Now in a real-time system down_X() ought to have a deterministic
> blocking time. It should be easy to make down_read() deterministic: If
> there is a writer let it inherit the calling readers priority. 
> However, down_write() is hard to make deterministic. Even if we assume
> that the lock not only keeps track of the number of readers but keeps a
> list of all the reader threads within the region it can traverse the list
> and boost the priority of all those threads. If there is n readers when
> down_write() is called the blocking time would be
>  O(ceil(n/#cpus))
> time - which is unbounded as n is not known!
> 
> Having a rw-lock with deterministic down_read() but non-deterministic
> down_write() would be very usefull in a lot of cases. The characteritic is
> that the data structure being protected is relative static, is going
> to be used by a lot of RT readers and the updates doesn't have to be done
> with any real-time requirements.
> However, there is no way to know in general which locks in the kernel can
> be allowed to work like that and which can't. A good compromise would be
> limit the number of readers in a lock by the number of cpu's on the
> system. That would make the system scale over several CPUs without hitting
> unneeded congestions on read-locks and still have a determnistic
> down_write(). 
> 

Why just limit to the number of CPUs, but make a configurable limit. I
would say the default may be 2*CPUs.  Reason being is that once you
limit the number of readers, you just bound the down_write. Even if
number of readers allowed is 100, the down_write is now bound to
O(ceil(n/#cpus)) as you said, but now n is known. Make a
CONFIG_ALLOWED_READERS or something to that affect, and it would be easy
to see what is a good optimal configuration (assuming you have the
proper tests).

> down_write() shall then do the following: Boost the priority of all the
> active readers to the priority of the caller. This will in turn distribute
> the readers over the cpu's of the system assuming no higher priority RT
> tasks are running. All the reader tasks will then run to up_read() in
> time O(1) as they can all run in parellel - assuming there is no ugly
> nested locking ofcourse!
> down_read() should first check if there is a writer. If there is
> boost it and wait. If there isn't but there isn't room for another reader
> boost one of the readers such it will run to up_read().
> 
> An extra bonus of not having the number of readers bounded: The various
> structures needed for making the list of readers can be allocated once.
> There is no need to call kmalloc() from within down_read() to get a list
> element for the lock's list of readers.
> 
> I don't know wether I have time for coding this soon. Under all
> circumstances I do not have a SMP system so I can't really test it if I
> get time to code it :-(
> 

I have two SMP machines that I can test on, unfortunately, they both
have NVIDIA cards, so I cant use them with X, unless I go back to the
default driver. Which I would do, but I really like the 3d graphics ;-)


-- Steve

> Esben
> 
> 
> 
> On Tue, 14 Dec 2004, Ingo Molnar wrote:
> 
> > 
> > * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> > 
> > > Isn't this tightly related to mkinitrd sometimes hanging while on
> > > mount -o loop, that I've been reporting a couple of times before? It
> > > used to hang on any other time I do a new kernel install, but latetly
> > > it seems to be OK (RT-V0.9.32-19 and -20).
> > 
> > yeah, i've added Thomas Gleixner's earlier semaphore->completion
> > conversion to the loop device, to -19 or -18.
> > 
> > 	Ingo
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Steven Rostedt
Senior Engineer
Kihon Technologies

