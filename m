Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264471AbUEaAE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUEaAE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 20:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUEaAE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 20:04:26 -0400
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:19852 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S264471AbUEaAEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 20:04:24 -0400
Message-ID: <40BA7683.2000501@bigpond.net.au>
Date: Mon, 31 May 2004 10:04:19 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired
 with a single array
References: <40B81F24.9080405@bigpond.net.au> <200405292117.56089.kernel@kolivas.org> <40B92874.50009@bigpond.net.au> <200405302256.02703.kernel@kolivas.org>
In-Reply-To: <200405302256.02703.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sun, 30 May 2004 10:19, Peter Williams wrote:
> 
>>Out of interest, what was the reason?  What problem were you addressing?
> 
> 
> The interactive credit?

No.  I was asking about the mechanism in schedule() that, based on the 
value of "activated", allows some tasks to count their time on the run 
queue as sleep time.

> 
> There was a problem with difficulty elevating back to interactive state if an 
> interactive task had used too long a burst of cpu (ie Xfree) which was 
> addressed by making the bonus pseudo-exponentially curved for rapid recovery 
> and slow decay - in fact this is probably the most important part of 
> addressing the interactive tasks and had the best effect.

But this probably answers my question anyway.

> The problem was 
> that giving this to all tasks meant that cpu bound tasks that had, as a 
> property of their behaviour, long waits on say pipes or i/o would also get 
> this rapid recovery to interactive state and as soon as they became fully 
> bound to cpu again they would cause noticable stalls. The standard example is 
> the increasing number of jobs in a make, where each job waits longer for i/o 
> as the job numbers increase. However there were much worse examples at even 
> normal - low loads, such as mpeg or divx encoding where the encoder would 
> buffer say 250 frames sleeping and then do them in a burst. (this is the 
> maximum space between key [I] frame or intervals). The interactive credit 
> prevented those tasks that would have long but only infrequent sleeps from 
> getting the curved bonus/penalty.

In the near future, I'll be proposing another patch that goes on top of 
the single priority array (SPA) patch that has the express purpose of 
reducing the time that all tasks spend on run queues.  I think that one 
of the side effects of this mechanism is that it will alleviate the 
problem you've described above.

I also think that their is a category of task that may be automatically 
detected and that needs special attention and that is tasks that need 
very regular access to small bursts of CPU.  I suspect that the tasks 
doing the mpeg and divx encoding/decoding that you refer to above fall 
into this category.  The key to identifying these tasks would be that 
the variance (or standard deviation) of their sleeps would be close to 
zero and as they probably do much the same amount of work each CPU burst 
the same would be true of the variance of the length of the CPU bursts. 
  Currently, the scheduler relies on the interactive bonus to make sure 
that these tasks get CPU when they need it but I suspect that to make 
this happen the interactive bonus has to be larger than it might 
otherwise need to be.  So if these tasks can be identified and treated 
specially (e.g. reserve the MAX_RT_PRIO slot for them) the interactive 
bonus could be reduced and this would improve overall system throughput.

> 
> Hmm... if this is black magic I guess I'm breaking the magician's cardinal 
> rules and revealing my tricks ;-)
> 

Peter
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

