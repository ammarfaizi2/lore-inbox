Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313239AbSDDQ1C>; Thu, 4 Apr 2002 11:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313243AbSDDQ0x>; Thu, 4 Apr 2002 11:26:53 -0500
Received: from 66-224-32-37.atgi.net ([66.224.32.37]:21253 "EHLO sr71.net")
	by vger.kernel.org with ESMTP id <S313239AbSDDQ0j>;
	Thu, 4 Apr 2002 11:26:39 -0500
Message-ID: <3CAC7E15.203@us.ibm.com>
Date: Thu, 04 Apr 2002 08:23:49 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
 boot time
In-Reply-To: <20020404035910.A281@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:

>	When I attempted to boot linux-2.5.8-pre1, I got a kernel
>BUG() for exit.c line 519.
>
That bug is hit when the schedule() returns.  In the do_exit() case, 
schedule is not supposed to return.  After the current task is scheduled 
out, it is destroyed.  I guess that most of the freeing of the task's 
resources is done in do_exit(), but I don't see where its kernel stack 
is freed.  

> The was a small change to to kernel/exit.c
>in 2.5.8-pre1 which deleted a kernel_lock() call.  Restoring that line
>resulted in a kernel that booted fine.
>
I take it you don't have a copy of the BUG().   I was going to ask if 
preemption was enabled, but I see that it was from another message.  I 
was guessing that preemption contributed to this, but now I know.  The 
lock_kernel() has 2 different effects here.  It locks the kernel_flag, 
AND it disables preemption.  The correct fix here will probably be to 
disable preemption, rather than readd the lock_kernel().  

For the preemption gurus:
Is a preempt_disable() in do_exit() going to hurt anything?  Shold we 
selectively skip the preempt_disable() in schedule() if it was 
schedule() called from do_exit()?
--
Dave Hansen
haveblue@us.ibm.com

