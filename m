Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRCEAlT>; Sun, 4 Mar 2001 19:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbRCEAlJ>; Sun, 4 Mar 2001 19:41:09 -0500
Received: from linuxcare.com.au ([203.29.91.49]:18959 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130552AbRCEAlC>; Sun, 4 Mar 2001 19:41:02 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 5 Mar 2001 11:38:08 +1100
To: Jonathan Lahr <lahr@sequent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
Message-ID: <20010305113807.A3917@linuxcare.com>
In-Reply-To: <20010215104656.A6856@w-lahr.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010215104656.A6856@w-lahr.des.sequent.com>; from lahr@sequent.com on Thu, Feb 15, 2001 at 10:46:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> To discover possible locking limitations to scalability, I have collected 
> locking statistics on a 2-way, 4-way, and 8-way performing as networked
> database servers.  I patched the [48]-way kernels with Kravetz's multiqueue 
> patch in the hope that mitigating runqueue_lock contention might better 
> reveal other lock contention.

...

>       24.38%  23.93%    15us(   218us)   4.3us(   111us)     744475     566289     178186      0  runqueue_lock
>       23.15%  38.78%    28us(   218us)   6.2us(   108us)     376292     230381     145911      0    schedule+0xe0

Tridge and I tried out the postgresql benchmark you used here and this
contention is due to a bug in postgres. From a quick strace, we found
the threads do a load of select(0, NULL, NULL, NULL, {0,0}). Basically all
threads are pounding on schedule().

Our guess is that the app has some form of userspace synchronisation
(semaphores/spinlocks). I'd argue that the app needs to be fixed not the
kernel, or a more valid test case is put forwards. :)

PS: I just looked at the postgresql source and the spinlocks (s_lock() etc)
are in a tight loop doing select(0, NULL, NULL, NULL, {0,0}). In samba
we have userspace spinlocks, but they cover small amounts of code and
offer an advantage over ipc semaphores. When you have to synchronise
large sections of code ipc semaphores are reasonably fast on linux and
would be a better fit.

Cheers,
Anton
