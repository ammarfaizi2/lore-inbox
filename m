Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSFSC7J>; Tue, 18 Jun 2002 22:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSFSC7I>; Tue, 18 Jun 2002 22:59:08 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:20484
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S317751AbSFSC7H>; Tue, 18 Jun 2002 22:59:07 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: davids@webmaster.com
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020618222449.00ac5738@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 18 Jun 2002 22:52:36 -0400
To: David Schwartz <davids@webmaster.com>, <rml@tech9.net>,
       Chris Friesen <cfriesen@nortelnetworks.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: Question about sched_yield()
Cc: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020619021154.AAA2518@shell.webmaster.com@whenever>
References: <5.1.0.14.2.20020618184424.00ab6418@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:11 PM 6/18/2002 -0700, David Schwartz wrote:
>>By this form of ESP: sched_yield() means "I have nothing better to do right
>>now, give my time to someone who does".
>
>        No, this is not what sched_yield means. What 'sched_yield' means is that 
>you're at a point where it's convenient for another process to run. For 
>example, perhaps you just released a mutex that you held for a long period of 
>time, or perhaps you could function more efficiently if you could acquire a 
>resource another thread holds.

To-may-to, to-mah-to. Okay. I'll try again.

sched_yield() means "It would be convenient (or I would function more efficiently) if another process or thread were to run right now." i.e., "Would you be so kind as to run somebody else? As in, not me.".

 From what I've gathered in this thread, something akin to this happens:

  You are trying to get information out of any of three people. Two of the three people will have better/more reliable information, so you give them a higher priority.

        You choose a person to ask for information -> schedule()
        You ask person #1 for information.
        Person #1 says: "Ask someone else" -> sched_yield()

        You choose a person to ask for information -> schedule()
        You ask person #2 for information.
        Person #2 says: "Ask someone else" -> sched_yield()

        You choose a person to ask for information -> schedule()
Now, any rational human being (who actually wants this information) will certainly proceed as such:

        You ask person #3 for information.
        Person #3 says: "Here is the information you need." 
        You go on your merry way.

However, the Linux scheduler will look at its options, see that Person #1 has a higher priority than Person #3, and that Person #1 is marked ready-to-run, it proceeds:

        You ask person #1 for information.
        Person #1 says: "Ask someone else" -> sched_yield()

        Proceed to thrash between #1 and #2, ignoring #3.

Now, don't get me wrong; I understand your argument.  Like I said, Person #1 is not blocking (sched_yield() does not block), and is a higher priority than #3. All other things being equal, Person #1 should be scheduled after Person #2 yields. 

But things aren't equal. There's a crucial difference here: Person #1 has relinquished his timeslice, and Person #3 hasn't.  And I'm arguing that, if a thread/process/whatever calls sched_yield, then that thread should only be run in that timeslice if:
        * There are no other threads that are ready-to-run on that processor, or
        * Every other thread has called sched_yield().

Yes, the current behavior is technically correct; sched_yield() properly gives up control to another process. But it will sometimes give up the processor to another process that previously did a sched_yield() in the current timeslice. And that's just stupid.


>>If a thread is doing useful work,
>>why would it call sched_yield() ?!?
>
>        Perhaps to allow other threads to make forward progress. Perhaps to give 
>other threads a chance to use a resource it just released. Perhaps in hopes 
>that another thread will release a resource it could benefit from being able 
>to acquire.

Yeah. And if two threads decide to be 'nice' -- to allow a third thread to make forward progress -- neither will. The scheduler with thrash between the two threads, in preference to scheduling the third thread.  This is in accordance with the strictest interpretation of sched_yield()'s definition.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

