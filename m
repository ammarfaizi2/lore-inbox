Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131726AbQLVMTQ>; Fri, 22 Dec 2000 07:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbQLVMTG>; Fri, 22 Dec 2000 07:19:06 -0500
Received: from hermes.mixx.net ([212.84.196.2]:16910 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131726AbQLVMSt>;
	Fri, 22 Dec 2000 07:18:49 -0500
Message-ID: <3A433F14.3F3871A5@innominate.de>
Date: Fri, 22 Dec 2000 12:46:28 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Cassella <pwc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <3A42B353.D0D249C1@innominate.de> <Pine.LNX.4.21.0012212221220.32526-100000@mindy.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cassella wrote:
> >     dmabuf_alloc(...)
> >     {
> >             while (1) {
> >                     spin_lock(&dmabuf_lock);
> >                     attempt to grab a free buffer;
> >                     spin_unlock(&dmabuf_lock);
> >                     if (success)
> >                            return;
> >                     down(&dmabuf_wait);
> >             }
> >     }
> 
> >     dmabuf_free(...)
> >     {
> >             spin_lock(&dmabuf_lock);
> >             free up buffer;
> >             spin_unlock(&dmabuf_lock);
> >             up(&dmabuf_wait);
> >     }
> 
> This does things a little differently than the way the original did it.
> I thought the original implied that dmabuf_free() might free up multiple
> buffers.  There's no indication in the comments that this is the case, but
> the original, by using vall_sema(), wakes up all dmabuf_alloc()'s that had
> gone to sleep.

Granted, it's just an example, but it doesn't make sense to wake up more
dmabuf_alloc waiters than you actually have buffers for.  You do one
up() per freed buffer, and the semaphore's wait queue better be fifo or
have some other way of ensuring a task doesn't languish there.  (I don't
know, does it?)
 
> The example wasn't meant to be an ideal use of sv's, but merely as an
> example of how they could be used to achieve the same behavior as the code
> that was posted.

Yes, and a third example of the 'unlock/wakeup_and_sleep' kind of
primitive - there seems to be a pattern.  I should at least take a look
and see if up_down is easy or hard to implement.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
