Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbTHYDPp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTHYDPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:15:45 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:42168
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261430AbTHYDPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:15:37 -0400
From: Con Kolivas <kernel@kolivas.org>
Subject: [RFC] Orthogonal Interactivity Patches
Date: Mon, 25 Aug 2003 13:22:12 +1000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>,
       Daniel Phillips <phillips@arcor.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308251322.12050.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a description of the interactivity patches for 2.5/6 that started with 
O1int. 

Background:
A long discussion for sometime has centred on just what interactivity is. I 
did not set out to define interactivity and then modify the scheduler policy 
to match that definition. Instead what I have concentrated on is improving 
the overall feel of using 2.6 on a desktop (gui or non). The area I 
concentrated on was that of tasks that it would make a noticable difference 
when there was sufficient delay or jitter between the time they wake up and 
the time they are scheduled. This makes a palpable difference in the form of 
audio skips in playback or jerky mouse movement. The effect of increasing 
loads on the system and maintaining fairness must also be addressed when 
tackling these.

Introduction:
How the O(1) scheduler deals with "interactive" tasks. 

The O(1) cpu scheduler designed by Ingo Molnar and merged into early 2.5 
development was adopted for it's substantial improvement in scalability. The 
O(1) nature of the new scheduler meant the overhead of increasing number of 
tasks on increasing numbers of cpus was negligible. 

Briefly, the scheduler maintains a runqueue for each cpu, with this split into 
the active and expired array. How it works is thus: when a task is first 
woken up, it is added to the tail end of the active array to be scheduled 
after all tasks of higher priority on that same array, and any tasks of the 
same priority already on the runqueue. If a task goes to sleep it then is 
removed from the runqueue. If, however, it uses up a full timeslice the 
scheduler has to decide whether to put it on the end of the active array to 
be rescheduled again, or to be put onto the expired array. Tasks on the 
active array round robin from highest priority first come first served to 
lowest priority. Tasks on the expired array are not run unless the active 
array is emptied (all tasks go to sleep or are expired) or some predetermined 
starvation limit is used up.

The interactivity estimator in the 2.5 scheduler is designed to find which 
tasks are interactive versus those that are batch (pure cpu hogs). How it 
works is on the premise that batch tasks never sleep but use up all the cpu 
time offered to them, whereas interactive tasks occasionally sleep. A 
sleep_avg was stored for each task, where every tick of the jiffy (1 
millisecond in 2.5) the task earns a sleep_avg point if it's sleeping, or 
loses a sleep_avg point while it's running. Tasks with high sleep_avg are 
considered interactive and low sleep_avg are cpu hogs. 

The scheduler takes the information from the interactivity estimator and then 
assigns a dynamic priority to the task. The variation from the static 
priority is dependent on the value in PRIORITY_BONUS, set to 25% meaning a 
task's priority can change +/- 5 from it's static. Interactive tasks get a 5 
bonus and cpu hogs get a 5 penalty. 

If a task uses up it's full timeslice, the scheduler can choose to not expire 
if it is still TASK_INTERACTIVE which works out to about a priority bonus of 
3+ for nice 0 tasks.

While this simple and intuitive method works quite well, it does have some 
intrinsic limitations. 

Problems:

1. How much sleep avg needs to be accumulated before a task is interactive 
(MAX_SLEEP_AVG [MSA from here on]). 
Decrease the value and it takes only a short time for a task to accumulate 
enough sleep avg to be considered interactive, and also burn off enough sleep 
avg to be seen as a cpu hog. The problem is that most real world interactive 
applications, while they do sleep frequently, they also use bursts of cpu at 
times. These bursts will rapidly drop the interactive status of a task if the 
MSA is low, and these tasks will suddenly get low priority and be scheduled 
with batch tasks or worse, expire. The best example of this is X which is 
interactive but not infrequently uses large bursts of cpu. A low MSA will 
make dragging a window smooth under no load, but as load increases, dragging 
the window across the screen it will stop, jerk and the mouse will become 
unresponsive due to X expiring. The other problem with low MSAs is that most 
tasks, however interactive they are, start out using a lot of cpu. This means 
that they will be seen as cpu hogs during startup and translates into very 
slow application startup under load. 
Increasing the value of MSA is a way to tackle to rapidly decaying interactive 
status and slow startups but brings a different set of problems with it. In 
2.6.0-test4, the default for MSA is 10 seconds. This means a task needs to 
have slept for ten seconds before it is considered max interactive. Because 
tasks are constantly waking up, burning cpu and then going back to sleep, a 
MSA of 10 seconds means it can take up to a minute before the sleep_avg 
accurately represents the task's interactive status (an exponential 
function). This is seen by audio applications skipping like mad under any 
load until the music has been playing for over a minute, and each time a new 
song loads it starts all over again.

2.The idle task that turns into a cpu hog. 
Tasks that idle a lot (shells etc) can suddently turn into cpu hogs very 
easily (fire off "while true ; do a=1 ; done"). Idle tasks basically are 
sleeping all the time so they get maximum interactivity, and if you have a 
combination of a high MSA and an idle task becomes a cpu hog it can preempt 
almost everything till it gets flagged as non interactive (takes 3 seconds at 
an MSA of 10 seconds) and gets expired.

3. The cpu hog that sleeps while waiting on disk i/o.
Batch tasks (like compilers) never sleep on their own. However they often are 
forced to wait on disk i/o and this registers as sleep. This artifically 
raises their interactive status, and the more of these tasks there are 
waiting on i/o that are hogs, the worse the scenario gets (witness the make 
-j $largenumber). These tasks then swamp the cpu time.

4. Interactive tasks forking off cpu hogs.
A forked process inherits the sleep_avg of it's parent penalised by the 
tunable CHILD_PENALTY. The default is 95 meaning it inherits 95% of the sleep 
avg of it's parent. This is meant to stifle the ability of maximum 
interactive tasks from forking other maximum interactive tasks. The problem 
arises when an interactive task forks off a cpu hog, the cpu hog should not 
really start at a high interactive level even if it drops later. Furthermore, 
the parent usually sleeps after it forks off a cpu hog, elevating it's own 
priority again. This makes for a parent that can repeatedly fire off almost 
fully interactive children (make -j $largenumber). Decreasing the child 
penalty helps, but incurs a fork startup slowdown. Applying a PARENT_PENALTY 
helps, but this hurts the case where the parent is firing off lots of 
interactive tasks (eg web server).

5. Intra jiffy wakeups.
The sleep avg of a task is incremented by the amount of time spent sleeping in 
"jiffies" since it last went to sleep, and is decremented each tick of the 
interrupt (1ms on i386). As hardware gets faster many tasks may wake up, use 
cpu time and go to sleep before a single jiffy has passed. If they wake often 
enough or sleep for short enough periods the resolution of the sleep avg will 
completely misjudge them.

6. Scheduling latency.
Two problems exist in this area. 
First is that the time spent on the runqueue is not credited as sleep time, 
and if the runqueue is busy this can be a not-insignificant duration. This 
makes for worsening elevation of priority under load.
Second, nice 0 tasks get 102ms of task_timeslice. If a task wakes up while 
this first task is running and is not higher priority than it, it will wait 
for the previous task to finish it's timeslice. Most audio apps wakeup around 
every 50ms to do their work, which is often over in less than 2ms but if they 
wait for long enough for other same priority tasks to finish eventually it 
will lead to audio dropouts. Also some tasks need to run very frequently to 
minimise the perceptible jitter (moving the mouse in X).

7. Priority inversion
An interactive task that wakes up a cpu hog to get it to do work normally 
sleeps while waiting for the cpu hog to respond. A poorly written application 
can continually keep looking for a response from the cpu hog, and if it is 
higher priority than the cpu hog, it will preempt it. A spiral of the 
interactive task waking up looking for info, preempting the cpu hog and not 
allowing the cpu hog to get any cpu time can ensue. Eventually the 
interactive task is seen to be wasting cpu, loses it's priority bonus to a 
point where it is equal priority with the cpu hog and finally the cpu hog 
gets scheduled. Wine/wineserver cpu intensive games seem to exhibit this, as 
does v2.28 of blender, and kmail reading a pgp signed email.

While this is by no means an exhaustive list, it does describe some of the 
more common issues.


Current work:

Mike Galbraith did a lot of the excellent earlier work on tackling the issue 
of sleep avg resolution by using high resolution timers and nanosecond 
resolution instead of milliseconds. Initially my efforts at interactivity 
improvement did not use this work, but Ingo Molnar wrote some nice 
infrastructure he considered essential that I then worked with. 

Ingo's patch tackled the sleep_avg resolution problem, and added the on 
runqueue bonus calculation. He went further to discriminate between on 
runqueue tasks being woken up by interrupts or other tasks to give more bonus 
to the interrupt tasks and weight down the other on runqueue tasks. Tasks 
woken in interrupts tend to be interactive ones. The other major addon was 
the introduction of TIMESLICE_GRANULARITY[TG from here on]. This would 
prevent a task from using up it's full timeslice if there were other tasks of 
the same priority on the active array. Basically after TG passed (initally 
set to 50ms and later changed to 25ms) the task would be rescheduled with 
it's remaining timeslice at the end of the queue of tasks at the same 
priority. Thus a lot of nos. 5 and 6 above were already accounted for.


Approach:

What I set out to do was use the current infrastructure and not change any of 
the basic workings so as to not change the overall performance of the 
scheduler. Instead I focused on using the information presented to the 
interactivity estimator to choose dynamic priority more carefully. Originally 
the patches were meant to be the O(1)interactivity patches, abbreviated to 
O1int, which were jokingly referred to as the orthogonal patches and the name 
stuck. I'll concentrate on the latest evolution (O18.1) and bypass discussion 
of bugs and failed approaches.


The MSA in my patches is much smaller (10 average timeslices or ~1second), 
allowing tasks to rapidly change interactive status and allow cpu hogs to be 
identified sooner. Other strategies were put into place to blunt the 
disadvantage of this smaller MSA.

Instead of the sleep avg being a simple counter up and down I use the current 
status of a task to determine how much sleep avg to add or subtract in a sort 
of soft feedback loop. This introduces some autoregulation into the cpu 
interactivity estimator. What it does is determines the current bonus based 
on the sleep_avg to date (CURRENT_BONUS) to decide how much to weight the 
sleep_avg credited to a task. As tasks drop priority they get weighted 
proportionately more so as to recover rapidly from a low interactive state, 
and allow new tasks to gain sleep_avg quickly after their initial burn. 

A flag was introduced (interactive_credit) to detect truly interactive tasks 
so that they wouldn't be penalised too much during their bursts of cpu 
activity. If they reached the MSA and were still accumulating sleep_avg, they 
would start getting interactive credits. Once they were beyond a cutoff (also 
the MSA) they were flagged as HIGH_CREDIT, which then affected their 
sleep_avg burn. This was weighted in the reverse direction as the gaining of 
sleep time, so they slid down an ever increasing slope as they behaved more 
like cpu hogs.

more subtle but helpful was minimising the amount of sleep_avg a LOW_CREDIT 
task could obtain with each wakeup to just one priority bonus to prevent 
rapid swings towards interactive once a task was a proven cpu hog.


Idle detection was implemented, where a task slept for a predetermined time it 
would have a ceiling imposed on the amount of sleep avg it got, set to a 
value that corresponded with ensuring it would just be considered as 
interactive so it wouldn't expire easily. Kernel threads were excluded as 
they are often idle, but when they wake up they need cpu time.

I/O wait of cpu hogs was difficult to detect directly (there is not enough 
information in the kernel) but indirectly, most local disk i/o is associated 
with a special kind of sleep (UNINTERRUPTIBLE_SLEEP seen as process in D). 
Tasks flagged as waiting on this kind of sleep that weren't HIGH_CREDIT were 
limited in their sleep_avg rise to just interactive. This prevents cpu hogs 
getting maximum interactive state during disk i/o and prevents them getting 
needlessly expired after disk i/o.


Forking was handled in my patch by keeping the sleep_avg at a level that would 
not make forked children or their parents lose any priority bonus over what 
CHILD_PENALTY and PARENT_PENALTY. However it would round down their sleep_avg 
so it was just the amount necessary to be the same bonus. This meant they 
remained the same priority but could easily drop priority if they then proved 
to be cpu hogs.


Priority inversion is something that proved difficult to tackle. While a bug 
in earlier incarnations of the orthogonal patches intensified the problem, 
the generic solution in my patches now is that tasks that turn into cpu hogs 
become less interactive at an accelerated rate the lower their interactivity 
gets. This significantly reduces the time the inversion exists but doesn't 
cure the problem. Correcting the bugs in software design are needed for that. 
However it is only the dependent task that gets starved during priority 
inversion, as the longest a single nice 0 fully interactive task can hold the 
cpu over another similarly interactive task with my patches is 27ms. 
Preventing inversion from occurring at all would require more infrastructure.


Other generic changes in my patches were added for throughput purposes.
The requeuing of tasks at TIMESLICE_GRANULARITY was limited to user tasks that 
were interactive with at least MIN_TIMESLICE (10ms) remaining. This meant 
that batch tasks (non interactive) are allowed to run out their full 
timeslice before another task of the same priority gets scheduled. Also it 
meant that a task was not rescheduled with such a small timeslice remaining 
that it was inducing cache trashing. The default timeslice of nice 0 tasks is 
102 ms which meant that if they were requeued every 25ms, they would be 
requeued once with only 2ms remaining. Preemption originally was allowed if a 
task was the same priority but had more than twice the remaining timeslice of 
the process currently being scheduled. This is unecessary with TG in action 
and simply added to the number of context switches so was removed.

TG set to 25ms puts us close to the mouse movement of desktop operating 
systems, if X gets rescheduled with that as the largest wait period (it 
usually is less). Most versions of windows update their mouse cursor at 50Hz, 
and earlier MacOS' at 200Hz. I'm not sure about recent versions. 



>From the testing I've done to date it appears this approach works well in most 
settings and is an improvement in almost every palpable way to the default 
scheduler. The remaining issue is that application startup will be slower 
than the vanilla scheduler (your mileage may vary) under load, but I feel not 
unacceptably so as a tradeoff. No further development is planned on these 
patches (apart from perhaps cosmesis) unless other issues arise.


Thanks to the many contributors of ideas and previous patches and the numerous 
testers out there. I hope that even if an alternative approach is used in the 
final 2.6 kernel that my contributions and explanations have been helpful.


Con Kolivas
25 August 2003

