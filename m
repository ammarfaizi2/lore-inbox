Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155358AbQELHtC>; Fri, 12 May 2000 03:49:02 -0400
Received: by vger.rutgers.edu id <S155159AbQELHsk>; Fri, 12 May 2000 03:48:40 -0400
Received: from eyrie.demon.co.uk ([158.152.9.91]:3569 "HELO eyrie.demon.co.uk") by vger.rutgers.edu with SMTP id <S155427AbQELHsN>; Fri, 12 May 2000 03:48:13 -0400
Date: Fri, 12 May 2000 08:59:39 +0100
From: Derek Fawcus <df@eyrie.demon.co.uk>
To: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Cc: linux-kernel@vger.rutgers.edu, torvalds@transmeta.com
Subject: Re: Proposal for task_queue() WorkToDo Optimization for Network File Systems
Message-ID: <20000512085939.A22345@eyrie.demon.co.uk>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.com>, linux-kernel@vger.rutgers.edu, torvalds@transmeta.com
References: <391B77F6.14E6F9DA@timpanogas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <391B77F6.14E6F9DA@timpanogas.com>; from jmerkey@timpanogas.com on Thu, May 11, 2000 at 09:17:53PM -0600
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, May 11, 2000 at 09:17:53PM -0600, Jeff V. Merkey wrote:
> 

  [ snip of description ]

This idea has cropped up at least twice over the years,  usually in
comparison to a similar mechanism that exists in VMS.  I know because
I've written a similar followup to the following comparing to the
equivalent model in FlexOS[1] which I've had experience with.

I'd therefore guess to have any chance of seeing this in the kernel,
you'd have to provide working code,  and show that it actually gains
something.  Although this mechanism does have it's nice points,  I'm
not entirely sure that it's a gain over the mechanisms currently
employed in Linux.

In FlexOS the equivalent mechanism was called an Asynchronous Service
Routine (ASR).  There is a global priority ordered list of ASR's which
are run by the scheduler before any task.   The scheduler will only
choose to run a task when the ASR queue is empty.  An ASR has to run
to completion[2] since if it blocked it would halt the scheduler.

The ASR queue is a list of the following:

struct _asr {
    struct _asr *link;
    void (*fn)(ULONG p1, ULONG p2);
    ULONG p1, p2;
    struct _evb *evb; /* If event triggered */
    BYTE *stack;
    WORD stack_len;
    BYTE flags;
    BYTE priority;
};
    
These ASR's are triggered by device driver ISR's,  device driver process
context code,  and filesystem code.  They perform almost all of the I/O
action under FlexOS.

The dispatcher happens to have a task context selected when it is running
(for a task with no user level context - i.e. kernel only),  and the ASR's
can use this to gain access to any process memory.  They can ask to share
the process context of an arbitrary process,  thus allowing I/O direct
from the proces memory.  There is also support for wiring down the process
memory,  but given that there is no swapping implemented,  this is not
used.

The equivalent of the pre-emptive I/O is that ISR's return a true/false
value.  This can be used to force an immediate reschedule in case they
have queued an ASR.  Without this the ASR queue would only get run at
the next time slice or process block.

> The question is how many pieces of this are already in Linux.  I haven't
> seen quite this optimization, but would propose that it be implemented
> with a special atomic task_queue with a very lightweight thread_object. 
> Microsoft uses fibre's which coincidently, appeared in NT three months
> after WorkToDo's were disclosed at a Novell Brainshare Conference in
> front of several of their engineers who were in attendance, though the
> implementation they came up with was not exact (because they really
> didn't know how they worked in NetWare but for some odd reason, had to
> have something like them at the time).  

That's probably a bit disingenious,  given that Cutler worked on VMS.
I'd guess he simply took the idea directly from VMS.

[1] A Real time OS that came out of the Digital Research stable.  Ran for
    a while under the Novell Banner and was then flogged of to ISI who
    sent off to the knackers yard.  I guess WRS now own the shoe leather.

[2] Actually ASR's can arrange to schedule another ASR either immediatly
    or upon the completion of some event (struct _evb) so working around
    blocking issues and allowing the work load to be split up.  There is
    also a 'hack' involving saving the ASR stack that allows an ASR to
    actually block.

DF

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
