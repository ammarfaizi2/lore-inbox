Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQKCOxw>; Fri, 3 Nov 2000 09:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbQKCOxm>; Fri, 3 Nov 2000 09:53:42 -0500
Received: from gatekeeper.trcinc.com ([208.224.120.226]:45992 "HELO gatekeeper")
	by vger.kernel.org with SMTP id <S129129AbQKCOx0>;
	Fri, 3 Nov 2000 09:53:26 -0500
Message-ID: <790BC7A85246D41195770000D11C56F21C848A@trc-tpaexc01.trcinc.com>
From: Jonathan George <Jonathan.George@trcinc.com>
To: "'Christoph Rohland'" <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>
Cc: Jonathan George <Jonathan.George@trcinc.com>,
        "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Thrash reduction & RE: 2.4.0-test10 Sluggish After Load
Date: Fri, 3 Nov 2000 09:51:48 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Christoph Rohland [mailto:cr@sap.com]
Sent: Friday, November 03, 2000 7:54 AM
To: Rik van Riel
Cc: Jonathan George; 'matthew@mattshouse.com';
'linux-kernel@vger.kernel.org'
Subject: Re: 2.4.0-test10 Sluggish After Load


Hi Rik,

>On Wed, 1 Nov 2000, Rik van Riel wrote:
>> The 2.4 VM is basically pretty good when you're not
>> thrashing and has efficient management of the VM until
>> your working set reaches the size of physical memory.
>> 
>> But once you hit the thrashing point, the VM falls
>> flat on its face. This is a nasty surprise to many
>> people and I am working on (trivial) thrashing control,
>> but it's not there yet (and not all that important).
>
>I looked into this argument a little bit further: 
>In my usual stress tests 12 processes select a random memory object
>out of 15 to mmap() or shmat() it and then access it serially. Each
>segment is 666000000 bytes and I have 8GB of memory. So at one time
>there are at most 666000000*12 bytes = 7.45GB memory attached and in
>use. So I do not see that the machine qualifies as thrashing. Of
>course the memory pressure is very high all the time since we have to
>swap out unused segments.
>
>But the current VM does not behave good at all on that load.
>
>Greetings
>		Christoph

I wonder how much of that memory is actually being used by your processes.
My guess is that it's not the whole thing (unless you are running on a 64bit
architecture).

--Jonathan--

P.S. ------------------ THRASH REDUCTION THOUGHTS -----------------

I have given some thought to the issue of thrash recovery, and I have come
up with a simple (conceptually) way to implement a fair thrash reduction
algorithm.  However, since I know a minimal amount about the low level
implementation of the Linux scheduler and VM beyond behavioral
characteristics I would love to have some feedback since it should at least
clear up some of my questions about kernel internals.

My idea:
	If THIS process is paged in for consecutive scheduler slices
	Then
		Allow THIS process to run for XX% of the time
			it took to swap THIS process in.

Where:
	THIS -- is the current runnable process.
		(multiple processes for SMP)
	XX% -- is the thrash recovery bias.
		(from 10-150% is probably reasonable)
	time it took to swap --
		-- combined system swap time from fault.
			(until execution for this scheduler slice)

What do you think?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
