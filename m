Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135314AbRDZQ3L>; Thu, 26 Apr 2001 12:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135323AbRDZQ2w>; Thu, 26 Apr 2001 12:28:52 -0400
Received: from rumor.cps.intel.com ([192.102.198.242]:3288 "EHLO
	rumor.cps.intel.com") by vger.kernel.org with ESMTP
	id <S135314AbRDZQ2s>; Thu, 26 Apr 2001 12:28:48 -0400
Message-ID: <7B1A3FD0E515D211AC3E00A0C96B7AC907C8D05E@orsmsx34.jf.intel.com>
From: "Moore, Robert" <robert.moore@intel.com>
To: "'Ingo Oeser'" <ingo.oeser@informatik.tu-chemnitz.de>,
        "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: down_timeout
Date: Thu, 26 Apr 2001 09:27:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see this as the kind of function that should be implemented within the
semaphore interface itself.  Very simple - Just wake me up when either 1) I
get the semaphore, or 2) I timed out.

A single implementation saves everyone from attempting to implement this
over and over and over.

Bob


		-----Original Message-----
		From:	Ingo Oeser
[mailto:ingo.oeser@informatik.tu-chemnitz.de]
		Sent:	Wednesday, April 25, 2001 4:49 PM
		To:	Grover, Andrew
		Cc:	'linux-kernel@vger.kernel.org'; Moore, Robert
		Subject:	Re: down_timeout

		On Wed, Apr 25, 2001 at 04:21:22PM -0700, Grover, Andrew
wrote:
		> It seems like we need to implement down_timeout (and
		> down_timeout_interruptible) to fully flesh out the
semaphore implementation.
		> It is difficult and inefficient to emulate this using
wrapper functions, as
		> far as I can see.
		> 
		> Seems like this is a fairly standard interface to have for
OS semaphores. We
		> have a prototype implementation, and could contribute
this, if desired.
		> 
		> Thoughts?

		Sure you can't implement this via waitqueues? semaphores use
them
		internally anyway.

		I use this for interrupt or polling based waiting:


		/* IO polling waits */
		/* Timeout after this amount of jiffies */
		#define IO_POLL_TIMEOUT (HZ) 	
		/* Split timeout while polling into chunks of that many
jiffies */
		#define IO_POLL_SPLIT 	2

		/* generic interrupt based wait with timeouts! */
		#define __wait_event_timeout_int(wq, condition, timeout,
ret) \
			do { \
				struct wait_queue __wait; \
				signed long __expire=timeout; \
				__wait.task=current; \
				add_wait_queue(wq, &__wait); \
				for (;;) { \
					current->state=TASK_UNINTERRUPTIBLE;
\
					mb(); \
					if (condition) break; \
					__expire=schedule_timeout(__expire);
\
					if (__expire == 0) {  \
						ret=-ETIMEDOUT; \
						break; \
					} \
				} \
				current->state = TASK_RUNNING; \
				remove_wait_queue(wq, &__wait); \
			} while (0)

		/* polling wait, if we shouldn't use interrupts for this */
		#define __wait_event_timeout_poll(wq, condition, timeout,
ret) \
			do { \
				unsigned int __tries=0; \
				unsigned int __maxtry=timeout /
IO_POLL_SPLIT; \
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
			__wait_event_timeout_int(wq, condition, timeout,
ret)
		#else /* INTS_ARE_CHEAP */
		#define __wait_event_timeout(wq, condition, timeout, ret) \
			__wait_event_timeout_poll(wq, condition, timeout,
ret)
		#endif /* INTS_ARE_CHEAP */

		#define wait_event_timeout(wq, condition, timeout, ret)	\
			do { \
				if (condition) \
					break; \
				__wait_event_timeout(wq, condition, timeout,
ret); \
			} while (0)


		What about that?

		Use it just as you use wait_event() but check for -ETIMEDOUT
as
		value in ret.

		Regards

		Ingo Oeser
		-- 
		10.+11.03.2001 - 3. Chemnitzer LinuxTag
<http://www.tu-chemnitz.de/linux/tag>
		         <<<<<<<<<<<<     been there and had much fun
>>>>>>>>>>>>

