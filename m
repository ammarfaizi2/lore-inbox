Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133014AbRDYXtg>; Wed, 25 Apr 2001 19:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133018AbRDYXt0>; Wed, 25 Apr 2001 19:49:26 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:5511 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S133014AbRDYXtQ>; Wed, 25 Apr 2001 19:49:16 -0400
Date: Thu, 26 Apr 2001 01:49:13 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: Re: down_timeout
Message-ID: <20010426014913.B9089@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDD2@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDD2@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Wed, Apr 25, 2001 at 04:21:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 04:21:22PM -0700, Grover, Andrew wrote:
> It seems like we need to implement down_timeout (and
> down_timeout_interruptible) to fully flesh out the semaphore implementation.
> It is difficult and inefficient to emulate this using wrapper functions, as
> far as I can see.
> 
> Seems like this is a fairly standard interface to have for OS semaphores. We
> have a prototype implementation, and could contribute this, if desired.
> 
> Thoughts?

Sure you can't implement this via waitqueues? semaphores use them
internally anyway.

I use this for interrupt or polling based waiting:


/* IO polling waits */
/* Timeout after this amount of jiffies */
#define IO_POLL_TIMEOUT (HZ) 	
/* Split timeout while polling into chunks of that many jiffies */
#define IO_POLL_SPLIT 	2

/* generic interrupt based wait with timeouts! */
#define __wait_event_timeout_int(wq, condition, timeout, ret) \
	do { \
		struct wait_queue __wait; \
		signed long __expire=timeout; \
		__wait.task=current; \
		add_wait_queue(wq, &__wait); \
		for (;;) { \
			current->state=TASK_UNINTERRUPTIBLE; \
			mb(); \
			if (condition) break; \
			__expire=schedule_timeout(__expire); \
			if (__expire == 0) {  \
				ret=-ETIMEDOUT; \
				break; \
			} \
		} \
		current->state = TASK_RUNNING; \
		remove_wait_queue(wq, &__wait); \
	} while (0)

/* polling wait, if we shouldn't use interrupts for this */
#define __wait_event_timeout_poll(wq, condition, timeout, ret) \
	do { \
		unsigned int __tries=0; \
		unsigned int __maxtry=timeout / IO_POLL_SPLIT; \
		do { \
			schedule_timeout(IO_POLL_SPLIT); \
			if (condition) \
				break; \
		} while (++__tries < __maxtry); \
		if (__tries == __maxtry && !condition) \
			ret=-ETIMEDOUT; \
	} while (0)
	
#ifdef INTS_ARE_CHEAP
#define __wait_event_timeout(wq, condition, timeout, ret) \
	__wait_event_timeout_int(wq, condition, timeout, ret)
#else /* INTS_ARE_CHEAP */
#define __wait_event_timeout(wq, condition, timeout, ret) \
	__wait_event_timeout_poll(wq, condition, timeout, ret)
#endif /* INTS_ARE_CHEAP */

#define wait_event_timeout(wq, condition, timeout, ret)	\
	do { \
		if (condition) \
			break; \
		__wait_event_timeout(wq, condition, timeout, ret); \
	} while (0)


What about that?

Use it just as you use wait_event() but check for -ETIMEDOUT as
value in ret.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
