Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSLAPJW>; Sun, 1 Dec 2002 10:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSLAPJV>; Sun, 1 Dec 2002 10:09:21 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:59318 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261857AbSLAPJV>;
	Sun, 1 Dec 2002 10:09:21 -0500
Message-ID: <3DEA27D6.4000501@colorfullife.com>
Date: Sun, 01 Dec 2002 16:16:38 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
CC: linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues, 2.5.50
References: <Pine.GSO.4.40.0212011435000.7409-100000@anna>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:

>wait_event is rather not good as I don't have condition to check - in that
>case I just place process in a queue and wait for wake_up.
>But I agree that it is ugly - I used it only as a quick fix for one bug.
>Now I think I have good solution but I have to test it first.
>  
>
The bad thing is that you use __add_wait_queue() and call the wait queue 
locking functions yourself. This is not needed. The only function that 
was permitted to do that is sleep_on(), and that will die soon. I've 
quoted sleep_on as a reminder to kill that code in kernel/sched.c.
Just use add_wait_queue() instead of the internal functions. Or 
prepare_to_wait/finish_wait, that has a slighly lower locking overhead.

Btw, could you explain how your message priority implementation works?

If I understand it correctly, wq_add maintains a priority sorted linked 
list. wq_sleep() waits until the process becomes the first entry in the 
priority queue.
- You use the pid value as the thread identifier - why? Usually the task 
struct pointer is used within the kernel.
-  Is it correct that wq_wakeup wakes up all processes that sleep in 
wq_send, and then the highest priority process continues? What about 
waking up just the highest priority process? Look at the wakeup code in 
ipc/msg.c - it implement message types that way. The sender looks 
through the list of waiting receivers, and directly sends the message to 
the right receiver [pipelined_send()]

--
    Manfred




