Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290607AbSA3VP6>; Wed, 30 Jan 2002 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290606AbSA3VPq>; Wed, 30 Jan 2002 16:15:46 -0500
Received: from mail.epost.de ([64.39.38.76]:62601 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S290611AbSA3VPA>;
	Wed, 30 Jan 2002 16:15:00 -0500
Message-ID: <3C58622D.6B0265ED@epost.de>
Date: Wed, 30 Jan 2002 22:14:21 +0100
From: Martin Wirth <martin.wirth@epost.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is just a general idea I had a few month ago and might be of some
value
for the replacement of BKL or longheld spinlocks in the future 2.5
developement.

While writing some device driver for a real-time data acquisition I had
a 
similar problem. I had to protect some driver data structure that is 
heavily accessed from multiple processes for merely reading a few
variables
consistently. But from time to time there are bigger tasks to be done,
where
holding a spinlock is not appropriate. 

So I used a combination of a spinlock and a semaphore. You can lock this
combilock for short-term issues in a spin-lock mode:

       combi_spin_lock(struct combilock *x)
       combi_spin_unlock(struct combilock *x)

and for longer lasting tasks in a semaphore mode by:

       combi_mutex_lock(struct combilock *x)
       combi_mutex_unlock(struct combilock *x)

If a spin-lock request is blocked by a mutex-lock, the spin-lock
attempt also sleeps i.e. behaves like a semaphore.

This approach is less automatic than a first_spin_then_sleep mutex,
but normally the programmer knows better if he is going to do quick
things, or
maybe maybe unbounded stuff.

Note: For a preemtible kernel this approach could lead to much less
scheduling ping-pong also for UP if a spinlock is replaced by a
combilock 
instead of a semaphore.  


The code is quite simple and borrowed a bit from the completion handler
stuff
in sched.c. (Of course the owner could be a simple flag, but I had some
later 
extension to a priority inheritance scheme in mind).

struct combilock {
       wait_queue_head_t wait;
       task_t            *owner;
};


void combi_spin_lock(struct combilock *x)
{
       spin_lock(&x->wait.lock);
       if (x->owner) {
              DECLARE_WAITQUEUE(wait, current);
              wait.flags |= WQ_FLAG_EXCLUSIVE;
	      __add_wait_queue_tail(&x->wait, &wait);
	      do {
	             __set_current_state(TASK_UNINTERRUPTIBLE);
		     spin_unlock(&x->wait.lock);
		     schedule();
		     spin_lock(&x->wait.lock);
	      } while (x->owner);
	      __remove_wait_queue(&x->wait, &wait);
       }
}


void combi_spin_unlock(struct combilock *x)
{
       spin_unlock(&x->wait.lock);  
}


void combi_mutex_lock(struct combilock *x)
{
       spin_lock(&x->wait.lock);
       if (x->owner) {
              DECLARE_WAITQUEUE(wait, current);
              wait.flags |= WQ_FLAG_EXCLUSIVE;
	      __add_wait_queue_tail(&x->wait, &wait);
	      do {
		     __set_current_state(TASK_UNINTERRUPTIBLE);
		     spin_unlock(&x->wait.lock);
		     schedule();
		     spin_lock(&x->wait.lock);
	      } while (x->owner);
	      __remove_wait_queue(&x->wait, &wait);
       } else 
              x->owner=current;  
       spin_unlock(&x->wait.lock);
}


void combi_mutex_unlock(struct combilock *x)
{
	spin_lock(&x->wait.lock);
	x->owner=NULL;
	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE,
1, 0);
	spin_unlock(&x->wait.lock);
}


Martin Wirth
