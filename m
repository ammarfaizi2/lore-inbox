Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272410AbTHEDSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272412AbTHEDSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:18:22 -0400
Received: from dyn-ctb-210-9-244-254.webone.com.au ([210.9.244.254]:6156 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272410AbTHEDSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:18:06 -0400
Message-ID: <3F2F21DF.1050601@cyberone.com.au>
Date: Tue, 05 Aug 2003 13:17:51 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051306.38180.kernel@kolivas.org>
In-Reply-To: <200308051306.38180.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 5 Aug 2003 12:21, Nick Piggin wrote:
>
>>>I've already posted a better solution in O13.1
>>>
>>No, this still special-cases the uninterruptible sleep. Why is this
>>needed? What is being worked around? There is probably a way to
>>attack the cause of the problem.
>>
>
>Sure I'm open to any and all ideas. Cpu hogs occasionally do significant I/O. 
>Up until that time they have been only losing sleep_avg as they have spent no 
>time sleeping; and this is what gives them a lower dynamic priority. During 
>uninterruptible sleep all of a sudden they are seen as sleeping even though 
>they are cpu hogs waiting on I/O. Witness the old standard, a kernel compile. 
>The very first time you launch a make -j something, the higher the something, 
>the longer all the jobs wait on I/O, the better the dynamic priority they 
>get, which they shouldn't. 
>

Well I don't think the scheduler should really care about a process waiting
1 second vs a process waiting 10 seconds. The point of the dynamic priority
here is that 1 you want the process to wake up soon to respond to the IO,
and 2 you want to give it a bit of an advantage vs a non sleeping CPU hog,
right? I think a very rapidly decaying benefit vs sleep time is in order.

>
>No, this is not just a "fix the scheduler so you don't feel -j kernel 
>compiles" as it happens with any cpu hog starving other tasks, and the longer 
>the cpu hogs wait on I/O the worse it is.  This change causes a _massive_ 
>improvement for that test case which usually brings the machine to a 
>standstill the size of which is dependent on the number of cpu hogs and the 
>size of their I/O wait. I don't think the latest incarnation should be a 
>problem. In my limited testing I've not found any difference in throughput 
>but I don't have a major testbed at my disposal, nor time to use one if it 
>was offered which is why I requested more testing. 
>
>Thoughts?
>

Well if it really is the right thing to do, it should be done with _any_
type of sleep, not just uninterruptible. But you may have just answered
your question there: "the longer cpu hogs wait on I/O the worse it is".
Change the dynamic priority boost so this is no longer the case.

I understand this is essentially what you have done, but you did it in a
way that does not allow a task to become "interactive". Try changing the
formula used to derive the priority boost?


