Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129755AbQLEGzb>; Tue, 5 Dec 2000 01:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQLEGzV>; Tue, 5 Dec 2000 01:55:21 -0500
Received: from stellar.cso.uiuc.edu ([130.126.112.47]:26828 "EHLO
	stellar.cso.uiuc.edu") by vger.kernel.org with ESMTP
	id <S129755AbQLEGzO>; Tue, 5 Dec 2000 01:55:14 -0500
Date: Tue, 5 Dec 2000 00:24:46 -0600 (CST)
From: Andrew Reitz <areitz@uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Assistance requested in demystifying wait queues.
Message-ID: <Pine.SOL.4.30.0012042358270.19766-100000@stellar.cso.uiuc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm absolutely green when it comes to Linux kernel development, and so
working on a school project to port a TCP/IP-based service into the kernel
has been quite challenging (but also intesting)! Currently, I'm absolutely
mystified regarding how the "wait queue" subsystem works. I've been
reading the code, and usually that combined with an example is enough,
but not this time.

I searched the linux-kernel archives, and found a message from Mr. Timur
Tabi (ttabi@interactivesi.com). In October, he asked for an explanation of
'wait_queue_head_t' vs. 'wait_queue_t'. I'm confused on this (as well as
several other points), but unfortunately, I didn't see any response to Mr.
Tabi. So, I thought I'd try fashioning my own message.

The kHTTPd source is in many ways similar to what we are trying to
accomplish. Basically, we are trying to implement select() in the kernel
-- we have a bunch of sockets, and we want to return when one of them has
data. We have code that performs all of the necessary checks, but the
whole "going to sleep until data arrives" aspect is the stumper.

I have managed to draw the following skeleton from the kHTTPd source
(main.c):


	wait_queue_head_t dummyWQ;
	init_waitqueue_head (&dummyWQ);

	DECLARE_WAITQUEUE (local_wait);

	add_wait_queue_exclusive (socket->sk->sleep, &local_wait);
	set_current_state (TASK_INTERRUPTIBLE|TASK_EXCLUSIVE);

	while (we don't need to stop) {
		if nothing on socket
			interruptible_sleep_on_timeout (&dummyWQ, timeout);
		else
			handle socket data
		}

	remove_wait_queue (sock->sk->sleep, &local_wait);


>From the structure of the kHTTPd code, it appears as if the call to
'interruptible_sleep_on_timeout()' will return when either data arrives on
one of the sockets that kHTTPd controls, or if the timeout transpires.
However, I cannot see how this can be so. It appears as if the 'dummyWQ'
and 'local_wait' queue are entirely *separate*. I can see how the socket
is tied to the 'local_wait' (via add_wait_queue_exclusive()), but I do not
comprehend how 'interruptible_sleep_on_timeout() knows anything about any
sockets.

Any assistance that could be provided (explaining the wait_queue function
calls, a pointer to some documentation, etc.) would be *sincerely*
appreciated. Please CC: all responses to me directly, since I am not
subscribed to the list.

TIA,
	--Andy Reitz.

--
Andy Reitz <areitz@uiuc.edu>                                  (217) 244-3862
Research Assistant, CCSO                   http://www.uiuc.edu/ph/www/areitz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
