Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbULAN6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbULAN6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 08:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbULAN6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 08:58:00 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:7610 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261252AbULAN54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 08:57:56 -0500
Message-Id: <200412011357.iB1DviWR003613@localhost.localdomain>
To: Florian Schmidt <mista.tapas@gmx.net>
cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2 
In-reply-to: Your message of "Tue, 23 Nov 2004 15:41:03 +0100."
             <20041123154103.56c25300@mango.fruits.de> 
Date: Wed, 01 Dec 2004 08:57:44 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.151.23.119] at Wed, 1 Dec 2004 07:57:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 23 Nov 2004 16:21:26 +0100
>Ingo Molnar <mingo@elte.hu> wrote:
>
>> 
>> * Florian Schmidt <mista.tapas@gmx.net> wrote:
>> 
>> > ~$ ps -C jack_test -cmL
>> >   PID   LWP CLS PRI TTY          TIME CMD
>> >   988     - -     - pts/1    00:00:00  jack_test
>> >     -   988 TS   20 -        00:00:00 -
>> >     -   989 FF   99 -        00:00:00 -
>> > 
>> > So when you ctrl-z out of jack_test you cause its process() thread to
>> > be suspended, too, thus jackd cannot finish processing its graph.
>> 
>> so in theory any scheduling delay of PID 988 in the above setup (the
>> SCHED_OTHER task) should not be able to negatively influence jackd,
>> correct? 
>
>correct
>
>> In fact, does in this particular jack_test case PID 988 do
>> anything substantial?
>
>Well, it registers the client with jackd, sets up the ports, registers
>the process() callback and then simply goes to sleep() for the desired
>runtime of the program. All these are non RT ops and should never be
>able to cause any xruns.
>
>All the work is done by the process() callback which is called by
>libjack in a SCHED_FIFO thread. The process() callback is called once
>for each buffer that jackd processes.
>
>I cannot explain the detailed mechanism of how jackd wakes its clients
>and communicates with them myself too well, so i'll leave this to Paul
>Davis (CC'ed). Care to elaborate, Paul?

sorry for the delay on this, it ended up in a mail folder that i don't
check very often.

jackd wakes clients by writing a single byte to a FIFO. the first
client is sleeping on the other side of the FIFO. when that client is
done, it writes a single byte to another FIFO. either another client
is sleeping on the other side of that FIFO, or if there are no other
clients, jackd is waiting for the client there.

the "chain" of wakeup FIFOs is rearranged every time the graph
execution order is modified (e.g. by new connections being established
between clients that requires a different execution order).

the chain is executed every time jackd is woken by its "backend"
client, typically the ALSA client that waits on the fd's corresponding
to an audio interface to be readable and/or writable. in other words,
every interrupt from the audio interface.

we know that writes to FIFOs are not really RT-safe, but they are the
closest thing linux has at this time. i have outlined an idea to ingo
that florian and i cooked up one evening on IRC that would provide
true RT-safe IPC mechanisms, but as i recall, he didn't seem to think
that much of it :)

--p
