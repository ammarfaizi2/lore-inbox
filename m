Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRHQAIu>; Thu, 16 Aug 2001 20:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269186AbRHQAIk>; Thu, 16 Aug 2001 20:08:40 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:22797 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269184AbRHQAI3>; Thu, 16 Aug 2001 20:08:29 -0400
Message-ID: <3B7C607A.58B9E36@zip.com.au>
Date: Thu, 16 Aug 2001 17:08:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduling with io_lock held in 2.4.6
In-Reply-To: <200108162345.f7GNjUw02993@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> I've been plagued for a month by smp lockups in my block driver
> that I eventually deduced were due to somebody else scheduling while
> holding the io_request_lock spinlock.
> 
> There's nothing so impressive as a direct test, so I put a test for
> the spinlock being held at the front of schedule(), and sure enough, it
> fires every 20s or so when I'm doing nothing in particular on the
> machine:
> 
>   Aug 17 01:36:42 xilofon kernel: Scheduling with io lock held in process 0
> 
> doing a dd to /dev/null from the ide disk seems to trigger it, but from
> differnt contexts ...
> 
>   Aug 17 01:40:58 xilofon kernel: Scheduling with io lock held in process 0
>   Aug 17 01:41:00 xilofon last message repeated 150 times
>   Aug 17 01:41:00 xilofon kernel: Scheduling with io lock held in process 1139
>   Aug 17 01:41:00 xilofon kernel: Scheduling with io lock held in process 0
>   Aug 17 01:41:01 xilofon last message repeated 87 times
>   Aug 17 01:41:01 xilofon kernel: Scheduling with io lock held in process 1141
>   Aug 17 01:41:01 xilofon kernel: Scheduling with io lock held in process 0
> 
> Surprise, 1139 and 1141 are klogd and syslogd respectively.
> 
> Any suggestions as to how to track this further?

Replace the printk with a BUG(), feed the result into ksymooops.
Or use show_trace(0).

But if you're running SMP, scheduling with a lock held
is quite legal - it'll be held by another CPU.  In that case
you'll need to record which CPU holds the lock.

Or just run the SMP kernel on a single CPU (boot with `nosmp')
and see if it still happens.
