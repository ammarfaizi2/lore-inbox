Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLSNo1>; Tue, 19 Dec 2000 08:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130168AbQLSNoR>; Tue, 19 Dec 2000 08:44:17 -0500
Received: from hermes.mixx.net ([212.84.196.2]:61959 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129773AbQLSNoA>;
	Tue, 19 Dec 2000 08:44:00 -0500
Message-ID: <3A3F5E74.3F1988AB@innominate.de>
Date: Tue, 19 Dec 2000 14:11:16 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Wright <timw@splhi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <0012171922570J.00623@gimli> <20001218193405.A24041@scutter.internal.splhi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Wright wrote:
> 
> On Sun, Dec 17, 2000 at 01:06:10PM +0100, Daniel Phillips wrote:
> > This patch illustrates an alternative approach to waking and waiting on
> > daemons using semaphores instead of direct operations on wait queues.
> > The idea of using semaphores to regulate the cycling of a daemon was
> > suggested to me by Arjan Vos.  The basic idea is simple: on each cycle
> > a daemon down's a semaphore, and is reactivated when some other task
> > up's the semaphore.
> [...]
> >
> > OK, there it is.  Is this better, worse, or lateral?
> 
> Well, I have to confess I'm rather fond of this method, but that could have
> something to do with it being how we did it in DYNIX/ptx (Sequent).
> It certainly works, and I find it very clear, but of course I'm biased :-)

I'm curious, is my method of avoiding the deadlock race the same as
yours?  My solution is to keep a count of tasks that 'intend' to take
the down():

        atomic_inc(&bdflush_waiters);
        up(&bdflush_request);
        down(&bdflush_waiter);

so that bdflush will issue the correct number of up's even if the waiter
has not yet gone to sleep.  IOW, is your approach in DYNIX the same only
in spirit, or in detail?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
