Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSANOff>; Mon, 14 Jan 2002 09:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSANOf0>; Mon, 14 Jan 2002 09:35:26 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:11529 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286647AbSANOfQ>;
	Mon, 14 Jan 2002 09:35:16 -0500
Date: Mon, 14 Jan 2002 12:35:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <yodaiken@fsmlabs.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33.0201141330350.29208-100000@serv>
Message-ID: <Pine.LNX.4.33L.0201141216520.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Roman Zippel wrote:

> Any ll approach so far only addresses a single type of latency - the
> time from waking up an important process until it really gets the cpu.
> What is not handled by any patch are i/o latencies, that means the
> average time to get access to a specific resource.

OK, suppose you have three tasks.

A is a SCHED_FIFO task
B is a nice 0 SCHED_OTHER task
C is a nice +19 SCHED_OTHER task

Task B is your standard CPU hog, running all the time, task C has
grabbed  an inode semaphore (no spinlock), task A wakes up, preempts
task C, tries to grab the inode semaphore and goes back to sleep.

Now task A has to wait for task B to give up the CPU before task C
can run again and release the semaphore.

Without preemption task C would not have been preempted and it would
have released the lock much sooner, meaning task A could have gotten
the resource earlier.

Using the low latency patch we'd insert some smart code into the
algorithm so task A also releases the lock before rescheduling.

Before you say this thing never happens in practice, I ran into
this thing in real life with the SCHED_IDLE patch. In fact, this
problem was so severe it convinced me to abandon SCHED_IDLE ;))

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

