Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVEHEAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVEHEAX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 00:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVEHEAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 00:00:23 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:42837 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262809AbVEHEAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 00:00:10 -0400
Message-ID: <427D8EC3.9040409@yahoo.com.au>
Date: Sun, 08 May 2005 14:00:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Yuly Finkelberg <liquidicecube@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler: Spinning until tasks are STOPPED
References: <92df3175050506233110a19a60@mail.gmail.com>	 <427C6A5C.6090900@yahoo.com.au> <92df3175050507103621a88554@mail.gmail.com>
In-Reply-To: <92df3175050507103621a88554@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuly Finkelberg wrote:
> Nick,
> 
> 
>>You're doing this in the *kernel*? It sounds like it should be done
>>in userspace or done a different way (ie. not with 50 tasks).
> 
> 
> These are tasks that are running in the kernel on behalf of a new system call.  
> 

Well it still sounds like the kernel is doing too much. For example,
why don't you just have a syscall (or char device) just to send out
the events, and do everything else (all the queueing and
synchronisation and signalling) in userspace?

> 
>>And using signals and spinning on yield for synchronisation and
>>process control in the kernel like this is fairly crazy.
> 
> 
> The problem appears to be not with the process that is
> spinning/yielding, but rather the one process which gets stuck.  It is
> charged almost all the system time.  I agree that it's not pretty
> though...
> 
> 
>>Can't you use a semaphore or something?
> 
> 
> There is noone to call up() when a process is actually stopped.
> 
> If you have any ideas as to what can be happening or a better way to
> accomplish this (in the kernel), I'd appreciate hearing it.
> 

OK, for a simple example, instead of spinning on yield(), do a
down() on a locked mutex.

Then have maybe an `atomic_t nr_running` which is incremented for
each worker task running. When they are ready to stop, they can
do an atomic_dec_and_test of nr_running, and the last one can up()
the mutex. If you absolutely need to know when the process is
actually stopped, why?

Also, sending one's self a SIGSTOP to stop is not so good.
Generally you shouldn't use signals at all in the kernel if
possible. So why don't those guys just return to usermode and you
can raise a signal or whatever you need from there.

-- 
SUSE Labs, Novell Inc.

