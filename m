Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTBPCVC>; Sat, 15 Feb 2003 21:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbTBPCVC>; Sat, 15 Feb 2003 21:21:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12560 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265603AbTBPCVB>; Sat, 15 Feb 2003 21:21:01 -0500
Date: Sat, 15 Feb 2003 18:27:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <67320000.1045361394@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302151820200.25000-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Feb 2003, Martin J. Bligh wrote:
> 
> Something like this? Compiles, but not tested yet ...

Close, but you also need

-	buffer = task_sig(task, buffer);
+	if (task->sighand)
+		buffer = task_sig(task, buffer);

to actually check whether signals exist or not. Otherwise you'll just get 
the same oops anyway (well, keeping the task locked may change timings 
enough that it doesn't happen, but the bug will continue to be there.

I would also say that since you explicitly take the task lock, there's no 
real reason to use "get_task_mm()" at all any more, so instead of doing 
that (and then doing the mmput()), just get rid of the mm variable 
entirely, and do

	if (task->mm)
		buffer = task_mem(task->mm, buffer)

too. There's really no downside to just holding on to the task lock over
the whole operation instead of incrementing and decrementing the mm
counts and dropping the lock early.

(There are a few valid reasons for using the "get_task_mm()" function:

 - you need to block and thus drop the task lock

 - the original code just used "task->mm" directly, and using 
   "get_task_mm()" made the original conversion to mm safe handling 
   easier.

Neither reason is really valid any more in this function at least).

			Linus

