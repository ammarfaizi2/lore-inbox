Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSHBSVR>; Fri, 2 Aug 2002 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSHBSVR>; Fri, 2 Aug 2002 14:21:17 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:53306 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316588AbSHBSVO>; Fri, 2 Aug 2002 14:21:14 -0400
Date: Fri, 2 Aug 2002 13:24:44 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208021824.NAA41066@tomcat.admin.navo.hpc.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com>:
>On Fri, 2 Aug 2002, Jamie Lokier wrote:
>>
>> Linus Torvalds wrote:
>> > Sending somebody a SIGKILL (or any signal that kills the process) is
>> > different (in my opinion) from a signal that interrupts a system call in
>> > order to run a signal handler.
>>
>> So it's ok to have truncated log entries (or more realistically,
>> truncated simple database entries) if the logging program is killed?
>
>This is why I said
>
> "Which is what we want in generic_file_read() (and _probably_
>  generic_file_write() as well, but that's slightly more debatable)"
>
>The "slightly more debatable" comes exactly from the thing you mention.
>
>The thing is, "read()" on a file doesn't have any side effects outside the
>process that does it, so if you kill the process, doing a partial read is
>always ok (yeah, you can come up with thread examples etc where you can
>see the state, but I think those are so contrieved as to not really merit
>much worry and certainly have no existing programs issues).
>
>With write(), you have to make a judgement call. Unlike read, a truncated
>write _is_ visible outside the killed process. But exactly like read()
>there _are_ system management reasons why you may really need to kill
>writers. So the debatable point comes from whether you want to consider a
>killing signal to be "exceptional enough" to warrant the partial write.
>
>I can see both sides. I personally think I'd prefer the "if I kill a
>process, I want it dead _now_" approach, but this definitely _is_ up for
>discussion (unlike the signal handler case).

There has been cases (and systems) in the past that have provided BOTH
interpretations:

1. current kill -9 action:

	terminates process as soon as current process returns or is in
	the process of returning to user mode. This is normal, and prevents
	most partial writes. This is applicable to things like data base
	servers, log servers, and journaling processes.

2. Kill, and abort outstanding I/O.

	This casues partial log writes, corrupts databases (usually), and will
	cause any process to terminate.

When is #2 used:
	a. real time systems where the device handling MUST be terminated now.
	b. system shutdown for emergencies (this allows filesystems to
	   finsh flushing, but user processes may be stuck writing to an
	   audio/parallel device... procedure is to use kill -15, wait a
	   second or two, kill -9 wait a second or two, KILL UNCONDITIONALLY,
	   and then shutdown anyway).
	   Other uses:
		b1. fire, flood, power failure (act of god)
		b2. system overtemp (loss of AC cooling...)
		b3. disk drive failures (to stop writing to a drive, abort
		    DMA actions, controller failure detection - no need to
		    propagate errors to a raid...)
		b4. safety related aborts in time critical applications

Item b3 allows a system with some pretty catastrophic hardware
failures to actually do something and shutdown/clean up as much as possible
without just hanging - which will also introduce partial log writes...

I worked on one system that determined the main disk controller was failing,
and proceded to request a power cycle on all disk drives attached to that
particular controller to attempt to clear the failure. All user processes
were killed, a detailed diagnostic was provided, then the system shut itself
off.

In realtime underwater survey systems we used such an abort to cancel
expensive operations that were already in progress (expensive if it
finished - setting off remote explosives via an external controller).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
