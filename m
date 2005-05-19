Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVESTrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVESTrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 15:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVESTrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 15:47:13 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:20466 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261236AbVESTqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 15:46:36 -0400
Message-ID: <428CED0C.9020607@nortel.com>
Date: Thu, 19 May 2005 13:46:20 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
References: <428CD458.6010203@free.fr> <20050519182302.GE23621@csclub.uwaterloo.ca>
In-Reply-To: <20050519182302.GE23621@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Thu, May 19, 2005 at 08:00:56PM +0200, Olivier Croquette wrote:

>>- a system call requiring a PID can have  the same effect if a thread id 
>>of the same process was given.
>>Example: kill(tid,SIGTERM) will kill the entire process the thread
>>belongs to. I think that this is not POSIX compliant. It shall trigger
>>ESRCH!
> 
> 
> How should kill know if you are sending a threadid or processid?

Doesn't matter.  From a userspace point of view there is no process with 
that PID, so kill() should return ESRCH.  In the kernel, I think this 
means that kill() should actually be looking up tgids rather than pids.

>>- is Linux kill() POSIX compliant in this regard?

> Does posix say that a process can't be allocated multiple PIDs?

PID="process ID"

You have one PID per process.

>>- do we want to limit the sched_setaffinity() functionality to
>>correspond to its documentation, or do we want to update the
>>documentation so that its covers all the functionality?

> I believe Linux currently implements threads as seperate processes

No, they are implemented as separately schedulable entities with lots of 
shared state.  "process" and "thread" are POSIX terms that don't really 
mean anything in the kernel.

> Now given linux runs threads as seperate processes, it makes sense that
> thread ids and process ids are the same thing and hence currently
> unique, and that kill would work on any thread's pid within a given
> process.  

Pthreads define signal handling.  Signals are delivered to the process 
as a whole, not to any particular thread.  If you specify a TID that is 
not a valid PID, then the kernel should return an error.

> Doesn't sched_setaffinity do what it says it will?  Since each thread is
> treated as a process then sched_setaffinity should work on it I would
> think since it is a process after all as far as the scheduler is
> concerned.

If the syscall is supposed to operate on processes, it should operate on 
all threads within a process.  It would be nice to have a way to specify 
affinity for threads.  POSIX doesn't define one though.

Chris
