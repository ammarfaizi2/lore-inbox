Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbRAaOFY>; Wed, 31 Jan 2001 09:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRAaOFG>; Wed, 31 Jan 2001 09:05:06 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:37642 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129944AbRAaOEw>; Wed, 31 Jan 2001 09:04:52 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: Ben LaHaise <bcrl@redhat.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Message-ID: <CA2569E5.004D4950.00@d73mta03.au.ibm.com>
Date: Wed, 31 Jan 2001 19:28:01 +0530
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
	/notify + callback chains
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The waitqueue extension below is a minimalist approach for providing
>kernel support for fully asynchronous io.  The basic idea is that a
>function pointer is added to the wait queue structure that is called
>during wake_up on a wait queue head.  (The patch below also includes
>support for exclusive lifo wakeups, which isn't crucial/perfect, but just
>happened to be part of the code.)  No function pointer or other data is
>added to the wait queue structure.  Rather, users are expected to make use
>of it by embedding the wait queue structure within their own data
>structure that contains all needed info for running the state machine.

>I suspect that chaining of events should be built on top of the
>primatives, which should be kept as simple as possible.  Comments?

Do the following modifications to your wait queue extension sound
reasonable ?

1. Change add_wait_queue to add elements to the end of queue (fifo, by
default) and instead have an add_wait_queue_lifo() routine that adds to the
head of the queue ?
  [This will help avoid the problem of waiters getting woken up before LIFO
wakeup functions have run, just because the wait happened to have been
issued after the LIFO callbacks were registered, for example, while an IO
is going on]
   Or is there a reason why add_wait_queue adds elements to the head by
default ?

2. Pass the wait_queue_head pointer as a parameter to the wakeup function
(in addition to wait queue entry pointer).
[This will make it easier for the wakeup function to access the  structure
in which the wait queue is embedded, i.e. the object which the wait queue
is associated with. Without this, we might have to store a pointer to this
object in each element linked in the wait queue. This never was a problem
with sleeping waiters because the a reference to the object being waited
for would have been on the waiter's stack/context, but with wakeup
functions there is no such context]

3. Have  __wake_up_common break out of the loop if the wakeup function
returns 1 (or some other value) ?
[This makes it possible to abort the loop based on conditional logic in the
wakeup function ]


Regards
Suparna


  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
