Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310469AbSCSIgn>; Tue, 19 Mar 2002 03:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310474AbSCSIg0>; Tue, 19 Mar 2002 03:36:26 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:7906 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S310469AbSCSIfu>;
	Tue, 19 Mar 2002 03:35:50 -0500
Message-ID: <3C96F81F.1020608@dlr.de>
Date: Tue, 19 Mar 2002 09:34:39 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.4) Gecko/20011206 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ulrich Drepper <drepper@redhat.com>, pwaechtler@loewe-komp.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16m1oK-0006oy-00@wagner.rustcorp.com.au>	<3C932B2E.90709@dlr.de>	<20020317175009.4f4954a0.rusty@rustcorp.com.au>	<1016412720.2194.16.camel@myware.mynet> <20020319142842.0d9291c2.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:


> 1) Where this is flawed,


I. There is a race in __pthread_cond_wait between timeout and a 
cond_signal or broadcast. If the signal comes in

} while (ret < 0 && errno == EINTR);
 >>>>> we leave with errno==ETIMEDOUT and get signal or broadcast called 
here
	if (atomic_dec_and_test(cond->num_waiting))

then you up cond->wait one time to often, leaving it in an invalid state.

II. Your implementation relies on the fact that the signal or broadcast
caller owns the mutex used in cond_wait. According to the POSIX spec 
this need not be the case. The only thing that may happen is that you
miss a wakeup. But it is not allowed to screw up the internal state of
of the condition variable, which might well happen in your 
implementation. (Note: Calling cond_signal without holding the mutex is 
not necessarily flawed software. Think of a periodically occurring 
new_data or data_changed flag where it is not really important to sleep 
race free)

III. Minor nit: You should also clear cond->ack.count
in cond_signal otherwise it may wrap around soon (at least for a
24-bit atomic variable) if you mostly use cond_signal.


> 2) Where this is suboptimal,


As said in a previous e-mail, you need an futex_up(..,n) that
really wakes_up n thread at once.




> 3) What kernel primitive would help to resolve these?

Your exported waitqueues or my suggestion for a second waitqueue 
associated with a futex.


Martin

