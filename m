Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUEQGvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUEQGvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 02:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUEQGvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 02:51:13 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:41138 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264893AbUEQGvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 02:51:05 -0400
Message-ID: <40A8606D.1000700@linuxmail.org>
Date: Mon, 17 May 2004 16:49:17 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Suspend2 merge preparation: Rationale behind the freezer changes.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

In merging suspend2, one of the biggest changes is in the area of 
freezing activity. I'm writing this email in an effort to improve 
understanding of why I've implemented the freezer differently, and 
perhaps get some ideas as to how I could better achieve the desired results.

First of all, let me explain that although swsusp and suspend2 work at a 
very fundamental level in the same way, there are also some important 
differences. Of particular relevance to this conversation is the fact 
that swsusp makes what is as close to an atomic copy of the entire image 
to be saved as we can get and then saves it. In contrast, suspend2 saves 
one portion of the memory (lru pages), makes an atomic copy of the rest 
and then saves the atomic copy of the second part.

In order, then, for suspend2 to get the equivalent of an atomic copy of 
memory, pages must not be added to or removed from the LRU list once we 
start saving the image. (There are other issues and measures taken, but 
they're not relevant here).

One of the problems we face in achieving this goal is the fact that 
timers & timeouts can still fire during this period. These can of course 
be used to start new processes and to cause others (eg sleep) to exit, 
with the result that we can end up with changes to the LRU lists and 
therefore an inconsistent image.

Secondly, we have a more basic problem with the existing freezer 
implementation. A fundamental assumption made by it is that the order in 
which processes are signalled does not matter; that there will be no 
deadlocks caused by freezing one process before another. This simply 
isn't true.

Thirdly, the existing implementation does not allow us to quickly stop 
activity. Under heavy load, particularly heavy I/O (assuming the freezer 
does work), it make take quite a while for processes to respond to the 
pseudo-signal and enter the refrigerator. New processes may also be 
spawned, further complicating matters. The busier the system is, the 
more hit-and-miss freezing becomes.

The implementation of the freezer that I have developed addresses these 
concerns by adding an atomic count of the number of procesess in 
critical paths. The first part of the freezer simply waits for the 
number of processes in critical paths to reach zero.

A critical path is defined as one in which a process takes locks or 
carries out other activities which could deadlock with another process 
or make the process not respond to a freezer signal. When a process 
enters a critical path, the ACTIVITY_START macro causes it to be marked 
PF_FRIDGE_WAIT and the count of processes in critical paths is 
atomically imcremented. When it returns, a matching ACTIVITY_END macro 
reverses these effects. Use of a local variable makes it safe for 
processes to pass through multiple ACTIVITY_START calls; only the 
matching ACTIVITY_END will reverse the initial ACTIVITY_START. It may be 
that in the middle of a critical patch, there is sleeping in which we 
could safely suspend. This can be indicated by surrounding the sleep 
with ACTIVITY_PAUSING and ACTIVITY_RESTARTING calls. The thread is thus 
temporarily marked as safely suspendable.

These four macros play a further role. When we begin to wait for the 
activity counter to reach zero, a flag is set to record this fact. Macro 
calls check this flag, and a process reaching a START or RESTARTING 
activity macro while the flag is set will be refrigerated at that point 
until after the suspend cycle is completed. This helps us quiesce the 
system more quickly.

Some processes receive special treatment during this period.

A process marked PF_NOFREEZE is never refrigerated or counted in 
measuring activity.

A process may instead be marked PF_SYNCTHREAD. It is good for us to sync 
all dirty data to disc prior to suspending, just-in-case something goes 
wrong or the user uses noresume. By doing this, we maximise the 
filesystem integrity as far as is possible. PF_SYNCTHREAD is used for 
processes such as journalling threads that are used in doing this, and 
for processes which begin a filesystem sync. These processes are allowed 
to continue operation during the initial phase, and are frozen later.

The freezing process is thus:

1) Set FREEZE_NEW_ACTIVITY flag and wait for activity count to reach 
zero. New activity is held, existing activity completes critical paths 
or pauses at a safe place and syncing runs to completion.
2) Do our own sys_sync, just in case none were already running.
3) Set FREEZE_UNREFRIGERATED flag. Syncthreads will now enter the 
refrigerator of their own accord or by being signalled.
4) Signal remaining processes to be frozen. Deadlocking is avoided 
because those that would start critical paths are held at the 
ACTIVITY_START/RESTARTING calls, prior to taking the locks that would 
cause the deadlocks.

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable 
events occur
with alarming frequency, order arises from chaos, and no one is given 
credit.
