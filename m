Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288512AbSBRWTs>; Mon, 18 Feb 2002 17:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288420AbSBRWTj>; Mon, 18 Feb 2002 17:19:39 -0500
Received: from mail.webmaster.com ([216.152.64.131]:47300 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S288342AbSBRWT2> convert rfc822-to-8bit; Mon, 18 Feb 2002 17:19:28 -0500
From: David Schwartz <davids@webmaster.com>
To: <olaf.dietsche--list.linux-kernel@exmail.de>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Mon, 18 Feb 2002 14:19:24 -0800
In-Reply-To: <87pu3aw1ue.fsf@tigram.bogus.local>
Subject: Re: What is a livelock? (was: [patch] sys_sync livelock fix)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020218221926.AAA3883@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I still don't get it :-(. When there is more work, this more work
>needs to be done. So, how could livelock be considered a bug? It's
>just overload. Or is this about the work, which must be done _after_
>the queue is empty?

	Livelock situations can differ. One common issue is when you tune your 
ability to handle load only at a certain point and the load level is such 
that you never reach that point.

	Consider:

int work_count;
while(1)
{
 work_count=0;
 while(work_is_still_to_be_done())
 {
  do_work();
  work_count++;
 }
 if(work_count>250)
  create_more_threads();
}

	In this case, you may be so busy doing work that you never look at how much 
work you did and realize it was too much, so the additional threads never get 
created, and so you remain overloaded forever.

	There are other livelock scenarios that don't involve load over what the 
system can actually take, just over what the system is currently tuned to 
take. Any scheme that considers tuning a low priority can get into this kind 
of problem.

	Here's another case:

lock(first_lock);
/* some stuff */
 lock(second_lock);
 while(there_is_work())
 {
  unlock(second_lock);
  do_work();
  lock(second_lock);
 }
 unlock(second_lock);
/* more stuff */
unlock(first_lock);

	In this case, so long as work keeps flowing in and keeps this thread 
saturated, the first lock may never be released. This is true even if there 
are other threads capable of doing this work without holding the first lock. 
Since this thread remains perpetually ready, it may remain perpetually 
scheduled. This is probably the most common type of livelock encountered in 
kernel code.

	DS


