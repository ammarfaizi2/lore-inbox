Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292858AbSCMJNn>; Wed, 13 Mar 2002 04:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292860AbSCMJNd>; Wed, 13 Mar 2002 04:13:33 -0500
Received: from n13.sp.op.dlr.de ([129.247.25.4]:41131 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S292858AbSCMJNO>;
	Wed, 13 Mar 2002 04:13:14 -0500
Message-ID: <3C8F1801.6070107@dlr.de>
Date: Wed, 13 Mar 2002 10:12:33 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.4) Gecko/20011206 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > > On Tue, 12 Mar 2002, Rusty Russell wrote:
 > > > > > > > You've convinced me.
 > > > > > Damn.  Because now I've been playing with a different approach.
 > > > I don't think your current patch is very useful.

 > I agree.  But your "Applied" EMail rushed me into posting it.


The normal way to use multithreading under UNIX is the pthread
library. Here the condition variables are the equivalent to kernel
wait queues. So I think to really implement a fast pthread lib based
on futexes one needs some means to implement condition variables
(with synchronous futex release to implement  pthread_cond_wait(..)!).

This could either be done with the exported waitqueue approach or a bit 
easier (but less general) by associating a second hashed waitqueue with 
each futex (maybe marked by the odd offset+1?). Then we would have two 
additional variants of sys_futex (with parameters FUTEX_WAIT, 
FUTEX_SIGNAL).

The principle implementation is:

FUTEX_WAIT:
    add_to_cond_queue
    current->state=INTERRUPTIBLE
    futex_up
    schedule
    remove_from_cond_queue
    futex_down

FUTEX_SIGNAL
    wake_up_all on cond_queue


Later we may also want FUTEX_SIGNAL_ONE and FUTEX_WAIT_TIMEOUT.

The user space code for pthread_cond_wait then of course needs a 
chaining of the protecting pthread_mutex and the futex used as condition 
variable.


Martin

