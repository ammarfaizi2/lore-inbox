Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271295AbTG2HkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271311AbTG2HkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:40:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:33414 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271295AbTG2HkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:40:10 -0400
Message-Id: <5.2.1.1.2.20030729073749.01bc2dd8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 29 Jul 2003 09:44:12 +0200
To: Andre Hedrick <andre@linux-ide.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10307281030180.30891-100000@master.linux-ide
 .org>
References: <5.2.1.1.2.20030728091801.01b83538@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:33 AM 7/28/2003 -0700, Andre Hedrick wrote:

>No, it was an attempt to get you to explain in detail for people to
>understand why jitter responses in X have anything with scheduling.  Now
>the a pipe ipc that makings loading go south is interesting.

I was going to ignore this, but ok, brief explanation follows.  Do me a 
favor though, if you reply to this, please do so in straight forward English...

> > >Don't bother replying cause last thing I want to know is why.
>
>Means, don't tell me about "X becomes extremely jerky", disclose that is
>below creating the observed effects.

... you didn't have to goad me into explaining why I tested the way I did, 
a simple question would have sufficed.

Now, why would I test Ingo's scheduler changes by wiggling a window while 
some other load is running?  Simple.  I saw the MAX_SLEEP_AVG change, and 
knew that this meant that a pure cpu burner, such as X is while you're 
moving a window, will expire in less than half a second.  That's not very 
much time for someone to drag a window or whatever before their decidedly 
important interactive task expires.  Why is expiration time 
important?  Because of the highly variable amount of time it takes to 
return the expired task to the active array...

If there is no other load present, there will be an instantaneous array 
switch, and you won't even notice that X has expired.  If there is a 
non-interactive cpu burner with a full timeslice present in the active 
array at expiration time, you will probably notice that you took a 102ms 
latency hit.  If there are several present, you will very definitely 
notice.  If, as in the first case I reported, and asked other testers to 
verify, there happens to be a couple of cpu hogs present which the 
scheduler is classifying as interactive because they are sleeping slightly 
more than they are running, and feeding each other sleep_avg via wakeups, 
your time to return to the active array becomes STARVATION_LIMIT unless all 
active tasks happen to sleep at the same time, because these tasks will 
never decay in priority, the active array will never become empty, so there 
will never be an array switch until one is forced by the starvation 
timeout.  Not only will it take 1 second for X to return to the active 
array, when it arrives, the cpu hogs will be above X's priority, and X will 
only receive cpu if both hogs happen to sleep at the same time.   X can 
only recover it's interactive priority if it can get enough cpu to 
accomplish the work it was awakened to do, and go back to sleep.  The 
turn-around time/recovery time is what I was testing, knowing full well 
that there is a price to pay for increased fairness, and knowing from 
experience that the cost, especially when achieved via increased array 
switch frequency, can be quite high.  What I reported was two repeatable 
cases where X suffers from starvation due to the mechanics of the 
scheduler, and the increased fairness changes.

"Jitter responses in X" has everything in the world to do with the 
scheduler.  "jitter responses in X" is a direct output of the 
scheduler.  The decidedly bad reaction to the "jitter test" was a direct 
result of the changes I was testing, and therefore reportable.

Clear now?

         -Mike 

