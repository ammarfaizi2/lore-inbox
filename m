Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312718AbSDFTyj>; Sat, 6 Apr 2002 14:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312720AbSDFTye>; Sat, 6 Apr 2002 14:54:34 -0500
Received: from renoir.op.net ([207.29.195.4]:17165 "EHLO renoir.op.net")
	by vger.kernel.org with ESMTP id <S312718AbSDFTyd>;
	Sat, 6 Apr 2002 14:54:33 -0500
Date: Sat, 6 Apr 2002 14:54:50 -0500
Message-Id: <200204061954.g36Jsoe11292@op.net>
From: Paul Davis <pbd@Op.Net>
To: linux-kernel@vger.kernel.org
Subject: delayed interrupt processing caused by cswitching/pipe_writes?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to track down some latency-related issues that we are
having with a low latency audio system (JACK, the Jack Audio
Connection Kit, http://jackit.sf.net/).

Its the usual "soft RT" thing (SCHED_FIFO, mlockall), except that it
involves pipe-driven IPC between two RT threads to get the work
done. Read the website if you want to understand why; its not relevant
here. 

Its clear from a week of instrumented kernels, and hours poring over
trace files, that the presence of "activity" on the machine causes
delays in the handling of interrupts from the audio interface by up to
a millisecond. Given that the interrupt frequency is about 1000Hz,
this is not good :)

I know from trials of older kernels and systems in which all the audio
handling resided in the same thread that we can handle a 1.3msec
interrupt interval without real problems. But now that JACK splits the
handling across two threads in different processes, the thing that
kills us is not the context switch times, not the delay caused by
cache and/or TLB invalidation, or any of that stuff. instead, its that
we start delaying the execution of the audio interface interrupt
handler to the point where our assumptions about handling every
interrupt on time fall apart.

the extra work doesn't involve any increased disk activity - the only
extra work involves more writing to memory (which is all mlocked),
writing to pipes for IPC, and extra context switches.

which of these is most likely to cause us to mask interrupts for up to
a millisecond or more? i know its not the handler for the interrupt in
question - it never takes more than 25 usecs to execute.

--p

