Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275340AbTHSFaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275353AbTHSFaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:30:18 -0400
Received: from anumail2.anu.edu.au ([150.203.2.42]:57509 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S275340AbTHSFaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:30:08 -0400
Message-ID: <3F41B43D.6000706@cyberone.com.au>
Date: Tue, 19 Aug 2003 15:23:09 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
MIME-Version: 1.0
To: Eric St-Laurent <ericstl34@sympatico.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
References: <1061261666.2094.15.camel@orbiter>	 <3F419449.4070104@cyberone.com.au> <1061266033.2900.43.camel@orbiter>
In-Reply-To: <1061266033.2900.43.camel@orbiter>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3.2)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,SPAM_PHRASE_02_03,USER_AGENT,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric St-Laurent wrote:

>>>this is contrary to all process scheduling theory i've read, and also
>>>contrary to my intuition.
>>>
>>Yep.
>>
>
>Yep? What this ack does mean? Books, papers and old unix ways are wrong?
>or beyond this theory, practice shows otherwise?
>

No, it means the nice / timeslice thing _is_ contrary to scheduling theory.
The aspect usually given by books is most definitely correct - a bigger
timeslice means better efficiency, and grows in importance as caches get
bigger and memory gets slower, etc.

>
>>Its done this way because this is really how the priorities are
>>enforced. With some complicated exceptions, every task will be
>>allowed to complete 1 timeslice before any task completes 2
>>(assuming they don't block).
>>
>>So higher priority tasks need bigger timeslices.
>>
>
>Frankly i don't get this part. Maybe i should study the code more, or
>perhaps you have an illuminating explanation?
>

OK, this is an implementation issue, and we _are_ talking about the 2.5
scheduler, right?

Basically what happens is: all runnable processes are assigned a priority
and a timeslice. Processes are run in order of prioritty, and are allowed
to run their full timeslice. When a process finishes its timeslice, it is
put onto an "expired" queue, and the next process with the highest prio
is run. When no processes are left with a timeslice, all those on the
expired queue are given new timeslices.

So, if you give low priority processes bigger timeslices than high prio
ones, the low priority processes will be allowed to consume more CPU than
high. Obviously not the intended result. I agree with your intended result,
but it is a bit difficult to implement in the scheduler at present.

I'm working on it ;)

>
>Anyway i always tought linux default timeslice of 100 ms is way too long
>for desktop uses. Starting with this in mind, i think that a 10 ms
>timeslice should bring back good interactive feel, and by using longer
>timeslices for (lower prio) cpu-bound processes, we can save some costly
>context switches.
>

I agree completely.

>
>Unfortunatly i'm unable to test those ideas right now but i share them,
>maybe it can help other's work.
>
>- (previously mentionned) higher prio tasks should use small timeslices
>and lower prio tasks, longer ones. i think, maybe falsely, that this can
>lower context switch rate for cpu-bound tasks. by using up to 200 ms
>slices instead of 10 ms...
>
>- (previously mentionned) use dynamic priority to calculate timeslice
>length.
>
>- maybe adjust the max timeslice length depending on how many tasks are
>running/ready.
>

I agree with your previous two points. Not this one. I think it is very
easy to get bad feedback loops and difficult to ensure it doesn't break
down under load when doing stuff like this. I might be wrong though.

>
>- timeslices in cycles, instead of ticks, to scale with cpu_khz. maybe
>account for the cpu caches size to decide the larger timeslice length.
>

I don't think you need that much grainularity. Might be a benefit though.

I don't think its a wise idea to get too smart with the hardware properties.
Just keep the defaults good for current PC sort of hardware, and add
tunables for embedded / server hardware. Unless you can show a really big
problem / improvement of course.

>
>- a /proc tunable might be needed to let the user choose the
>interactivity vs efficiency compromise. for example, with 100 background
>tasks, does the user want the most efficiency or prefer wasting some
>cycles to get a smoother progress between jobs?
>
>- nanoseconds, or better, cycle accurate (rdtsc) timeslice accouting, it
>may help heuristics.
>
>- maybe add some instrumentations, like keeping static and dynamic
>priorities, task_struct internal variables and other relevant data for
>all processes with each scheduling decisions, that a userspace program
>can capture and analyse, to better fine-tune the heuristics.
>

yep yep yep

>
>- lastly, it may be usefull to better encapsulate the scheduler to ease
>adding alternative scheduler, much like the i/o schedulers work...
>

I hope not


