Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTKROL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTKROL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:11:57 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:34183 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263062AbTKROLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:11:52 -0500
Message-ID: <3FBA289D.4090201@softhome.net>
Date: Tue, 18 Nov 2003 15:11:41 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] jiffies overflow & timers.
References: <3FB91527.50007@softhome.net> <Pine.LNX.4.53.0311171347540.24608@chaos> <3FB9373D.6010300@softhome.net> <Pine.LNX.4.53.0311171624100.27657@chaos> <3FB9EC19.80107@softhome.net> <Pine.LNX.4.53.0311180802090.30076@chaos>
In-Reply-To: <Pine.LNX.4.53.0311180802090.30076@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

   [ Very good lection on 2-complement arithmetics snipped. This is I 
beleive feature of C: (type) conversion say to compiler "forget about 
original data type - use this one". So this was misunderstanding on my 
side. And thanks for examples ;-) ]

>>
>>   It is state machine, it is event driven - there is nothing that can
>>yield CPU to someone else, because in first place it does not take CPU ;-)))
>>   Right now it is run from tasklet - so ksoftirqd context.
>>
> 
> 
> If you are looping in a tasklet, waiting for something to happen, you
> are "locked up" until the event which may never happen. If for some
> "bad hardware that they won't fix" reason, you must loop, then you
> need to create a kernel thread. If the hardware is good and you
> decided to write a driver this way, then you need to re-think
> what you are doing.
> 

   As I said this is network layer.
   My hardware is good - we miss nothing ;-) [ After all it is made in 
room next to mine ;-))) ]

   I have situations when layer needs to know that given time had passed 
- so if is there any other way to do it without timers - I will really 
appreciate for any advice.

   The same stuff as in TCP/IP - after some time we need to tell that 
this connection timed-out. and TCP/IP uses timers for this: given 
routine will be called at specified jiffies, so e.g. handshake can be 
invalidated or data retransmission invoked.

   In my case layer service routines will generate specially formated 
input for fsm - so fsm will know that given timer has expired and will 
take actions accordingly. Quite flexible - I enqueueing can be put into 
any context and just need to "tasklet_schedule( &layer_entry );" The 
same way skbs are passed to fsm. Pretty standard telecoms layer.


   So to draw conclusion: ./kernel/timer.c: 
add_timer/del_timer/mod_timer are not protected against jiffies 
overflow. internal_add_timer() implicitely schedules items with expires 
< jiffies into the head, so they will be processed at next timer tick. 
(check 2.4.22 & 2.6.0test7)

   Actually I beleive that here the same trick as for Y2K problem can be 
used:
    if (expires < ULONG_MAX/2 && jiffies >= ULONG_MAX/2
          && (jiffies - expires) > ULONG_MAX/2)
        assume_expires_has_overflown();
   In any way, as you say, if someone sets the timer for time longer 
that ULONG_MAX/2 - this is most likely bug. So as for it makes sens to 
put checks in this routines with given above kind of hack to handle 
jiffies overflow. And add const for longest timer expires period - 
((ULONG_MAX/2)-1)
    For example I need timer at top for about 45 seconds. Not more.
    TCP timers at most about 1.5/2 minutes long.

    I have no clue what those stuff in internal_add_timer() does - so I 
cannot produce any patch to try. I can only guess what there really 
going on. But case of expires overflow is clearly stated there as case 
when ((signed long) idx < 0) - timer "in the past" comment. But whole 
ide of those queueing is pretty obscure. And no external reference for 
algoritms/alike...

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

