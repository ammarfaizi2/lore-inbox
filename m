Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbUKQPcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUKQPcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbUKQPcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:32:39 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:55017 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262344AbUKQPcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:32:09 -0500
Date: Tue, 16 Nov 2004 18:49:44 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: domen@coderock.org
Subject: schedule_timeout() issues / questions
Message-ID: <20041117024944.GB4218@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After some pretty heavy discussion on IRC, I felt that it may be
important / useful to bring the discussion of schedule_timeout() to
LKML. There are two issues being considered:

1) msleep_interruptible()

For reference, here is the code for this function:

/**
 * msleep_interruptible - sleep waiting for waitqueue interruptions
 * @msecs: Time in milliseconds to sleep for
 */
unsigned long msleep_interruptible(unsigned int msecs)
{
	unsigned long timeout = msecs_to_jiffies(msecs);

	while (timeout && !signal_pending(current)) {
		set_current_state(TASK_INTERRUPTIBLE);
		timeout = schedule_timeout(timeout);
	}
	return jiffies_to_msecs(timeout);
}

The first issue deals with whether the while() loop is at all necessary.
>From my understanding (primarily from how the code "should" behave, but
also backed up by code itself), I think the following code:

	set_current_state(TASK_INTERRUPTIBLE);
	timeout = schedule_timeout(timeout);

should be interpreted as:

	a) I wish to sleep for timeout jiffies; however
	b) If a signal occurs before timeout jiffies have gone by, I
	would also like to wake up.
	
With this interpretation, though, the while()-conditional becomes
questionable. I can see two cases (think inclusive OR not exclusive) for
schedule_timeout() returning:

	a) A signal was received and thus signal_pending(current) will
	be true, exiting the loop. In this case, timeout will be
	some non-negative value (0 is a corner case, I believe, where
	both the timer fires and a signal is received in the last jiffy).
	b) The timer in schedule_timeout() has expired and thus it will
	return 0. This indicates the function has delayed the requested
	time (at least) and timeout will be set to 0, again exiting the
	loop.
	
Clearly, then, if my interpretion is correct, schedule_timeout() will
always return to a state in msleep_interruptible() which causes the loop
to only iterate the one time. Does this make sense? Is my interpretation
of schedule_timeout()s functioning somehow flawed? If not, we probably
can go ahead and change the msleep_interruptible() code, yes?

This is closely tied to a separate issue. I have often seen code check
two separate conditions in response to calling schedule_timeout():
whether signals_pending() is true and whether the return value is 0 (in
separate if statements). Depending on the correctness of my interpretation
again, these are sequentially dependent. Meaning the following code should
be a correct and equivalent way to use schedule_timeout():

	set_current_state(TASK_INTERRUPTIBLE);
	timeout = schedule_timeout(timeout);
	if (signals_pending(current))
		/* respond appropriately to signals */
	else
		/* this must mean that timeout == 0, respond accordingly */

I think this should result in smaller, more uniform code and perhaps
more well-structured looping (as most schedule_timeout()s occur in some
loop). Does this if/else make sense? Since it is contingent on the
previous interpretation, maybe you've already thrown it out... But if
not, this may result in a good number of standardizing patches (which I
think is generally a good thing). This also would make it clear to me
how exactly the kernel interprets TASK_INTERRUPTIBLE /
TASK_UNINTERRUPTIBLE. <rant> Obviously, one's intuition that
TASK_UNINTERRUPTIBLE means don't wake up until the time as gone by,
at least, is wrong, or we wouldn't need the similar while-loop in
msleep()...

/**
 * msleep - sleep safely even with waitqueue interruptions
 * @msecs: Time in milliseconds to sleep for
 */
void msleep(unsigned int msecs)
{
	unsigned long timeout = msecs_to_jiffies(msecs);

	while (timeout) {
		set_current_state(TASK_UNINTERRUPTIBLE);
		timeout = schedule_timeout(timeout);
	}
}

</rant>
							   
2)  schedule_timeout(1)

A second issue arises when considering the prevalence in the kernel of
calling

	set_current_state(TASK_{,UN}INTERRUPTIBLE);
	schedule_timeout(1);

The 1 is rather arbitrary (but most common); any small enough number
will do. I think these code segments are now "unintentional" (in the
majority, at least; in certain cases, they may certainly be intended).
The reason I think this, is that when HZ==100 this is a pretty long
delay in human-time (~10ms, assuming no signals...). So maybe code
authors actually intended for that length of a delay, but since msleep()
and family did not exist, just went with schedule_timeout(). Of course,
since 1 jiffy of delay was equivalent to 10ms, it makes the dependency
on HZ very hard to see. This is just a theory, though, and I could be
completely wrong.

The main point, though, is that this code now introduces excessive
overhead. Upon examining the code of schedule_timeout(), one sees the
gist of the function to be:

	a) Set up a timer to go off after a certain number of jiffies
	b) Call schedule()
	c) Upon returning, delete the timer and return the number of
	jiffies left (if positive) or 0

Now, with architectures where HZ==1000 or more, I think the overhead of
setting up the timer and then calling schedule() may result in the timer
going off in the middle of the schedule() call. This, of course, is not
great, because it could mean that another task will start up (for 1
jiffy!), thrash the cache perhaps, and then be preempted by my task
again. It would be better, I think to call schedule() directly in these
cases where the intention is: give up the CPU. It results in similar
behavior (excepting that I won't necessarily be able to run in a jiffy
or close to that time), but unless I misunderstand things, that is the
same situation as with the timer in schedule_timeout() (i.e., I might be
completely wrong, though, if somehow when the timer goes off, my task
gets put to the front of it's priority queue). 

It just seems to me that we are putting in excessive code to just give
up the CPU (the intention of some of the calls, as I see it). I would like
to hear other opinions. If I am close to right, though, this will result
in a good number of (small) patches which will help clean up the kernel
a bit.

Please excuse my lack of brevity. There were a lot of ideas, and I
wanted to make myself pretty clear. Any comments would be greatly
appreciated.

Thanks,
Nish
