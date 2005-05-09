Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVEIGGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVEIGGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVEIGGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:06:04 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:31584 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263065AbVEIGF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:05:26 -0400
Message-ID: <427EFD9B.7010808@yahoo.com.au>
Date: Mon, 09 May 2005 16:05:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Yuly Finkelberg <liquidicecube@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Spinning until tasks are STOPPED
References: <92df3175050506233110a19a60@mail.gmail.com>	 <427C6A5C.6090900@yahoo.com.au>	 <92df3175050507103621a88554@mail.gmail.com>	 <427D8EC3.9040409@yahoo.com.au> <92df317505050817071d852623@mail.gmail.com>
In-Reply-To: <92df317505050817071d852623@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yuly Finkelberg wrote:
>>Well it still sounds like the kernel is doing too much. For example,
>>why don't you just have a syscall (or char device) just to send out
>>the events, and do everything else (all the queueing and
>>synchronisation and signalling) in userspace?
> 
> 
> True, it does :)
> However, the operation requires that a consistent in-kernel state will
> hold for the tasks.  They all (except for the last one) do some work,
> send a SIGSTOP to themselves, and return to usermode (handling the
> STOP signal).  The last task does not stop itself, but instead
> verifies that all of the others are stopped before it returns.
> 

Well you can do that all from userspace basically.
At least you should be able to do it as well as you can from
kernel (providing you have a syscall/device to retrieve events).

> 
>>OK, for a simple example, instead of spinning on yield(), do a
>>down() on a locked mutex.
>>Then have maybe an `atomic_t nr_running` which is incremented for
>>each worker task running. When they are ready to stop, they can
>>do an atomic_dec_and_test of nr_running, and the last one can up()
>>the mutex. If you absolutely need to know when the process is
>>actually stopped, why?
> 
> 
> I need to ensure that the internal state of the processes will not
> change (unless of course some other signal gets delivered, which will
> not be the case).
> 

They won't change *much*. Nothing that is detectable from userspace
(except for perhaps /proc entries).

> It doesn't look like the problem is with the task that is spinning
> until the others have stopped.  Instead, it looks like one of the
> other tasks is spinning somewhere in between the time that it wakes up
> its successor and the time that it sends it self the STOP signal.  It
> is clearly getting preempted but then makes no progress (sometimes for
> a VERY long time).
> 

Well it is a bit difficult to help further because you haven't posted
the working code or said what you are trying to do.

Stick a few printks around the place or try a kernel debugger to see
if you can't work out what is going wrong. Compiling the kernel with
debug info can allow you to find out what line of code EIP is pointing
to, which can also be helpful.

-- 
SUSE Labs, Novell Inc.

