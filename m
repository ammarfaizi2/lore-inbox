Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSLFL14>; Fri, 6 Dec 2002 06:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSLFL1z>; Fri, 6 Dec 2002 06:27:55 -0500
Received: from smtpout.mac.com ([17.250.248.97]:65225 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261305AbSLFL1y>;
	Fri, 6 Dec 2002 06:27:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Peter Waechtler <pwaechtler@mac.com>
To: golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org
Subject: Re: POSIX message queues, 2.5.50
Date: Fri, 6 Dec 2002 12:32:28 +0100
User-Agent: KMail/1.4.3
Cc: wrona@mat.uni.torun.pl
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212061232.28578.pwaechtler@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> and two most important ones:

>  - our implementation does support priority scheduling which is omitted in
> Peter's version (meaning that if many processes wait e.g. for a message
> _random_ one will get it). It is important because developers could rely
> on this feature - and it is as I think the most difficult part of
> implementation

Well, can you give an realistic and sensible example where an app design
really takes advantage on this?

If I've got a thread pool listening on the queue, I _expect_ non 
predictability on which thread gets which message:

What about:
0) low prio and high prio thread do blocking waits
a) "unimportant" message arrives
b) high prio thread gets it
c) "VIP" message arrives
d) low prio thread gets it, because high prio thread works on older one

If you care who is getting which message: you end up not using
multiple readers.
And what about _all_  the other places where waitqueues do not care
about priority? Think about semaphore, spinlock, read on file or socket
and so on...
And: it's not difficult to implement - if you don't care about speed: 
wake_up_all - the scheduler will do the rest. If you care about speed: take
priowaitqueue with O(1) algorithm (cost is space)

>  - our version was quit well tested - with Peter's patch (at least this
> for 2.5.46) I've had many problems.

I replaced the spin_locks with down/up on the inode->i_sem.
Now it runs fine on SMP. Open issues: race on name lookup, port
to 2.4 does not show mqueues at all if mounted.
But these are details, if there is no demand I don't see a reason to work
on this much more. Also: we can do all this in userspace ;-)

BTW, what about the absolute timeout given in mq_timed{send|receive}()?

a) no recalculation in userspace in case of a loop
b) no too long timeouts when preempted right after calculating but 
	before syscall

static inline long get_timeout( struct timespec *abs)
{
	struct timespec t;

	if (abs->tv_nsec >= 1000000000L || abs->tv_nsec < 0 || abs->tv_sec < 0)
		return -EINVAL;
	t=current_kernel_time();
	if (t.tv_sec > abs->tv_sec || 
	(t.tv_sec == abs->tv_sec && t.tv_nsec > abs->tv_nsec))
		return -ETIMEDOUT;

	t.tv_sec = abs->tv_sec - t.tv_sec;
	t.tv_nsec = abs->tv_nsec - t.tv_nsec;
	if (t.tv_nsec < 0){
		t.tv_sec--;
		t.tv_nsec+= 1000000000;
	}
	return timespec_to_jiffies(&t) + 1;
}

