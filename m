Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030773AbWI0UbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030773AbWI0UbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbWI0UbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:31:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030773AbWI0UbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:31:04 -0400
Message-ID: <451ADF7A.8070709@redhat.com>
Date: Wed, 27 Sep 2006 15:30:50 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       john stultz <johnstul@us.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Athlon64x2 problem with 2.6.18-rt4 and hrtimers
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo, Thomas, John, et al,

I've been having some problems with hrtimers on a Gateway Athlon64x2
system for some time now, but haven't really had time to play with
parameters. I had some time this morning...

My test machine is an Athlon64x2, running a 32-bit kernel on an FC6t3
user-space. My test is Thomas' cyclictest v0.9 (it's called cyclictest32
since I keep both 32 and 64-bit versions around).

$ uname -a
Linux rt4.farm.hsv.redhat.com 2.6.18-rt4 #4 SMP PREEMPT Wed Sep 27
10:31:06 CDT 2006 i686 athlon i386 GNU/Linux

What I've been seeing were some very long latencies while running
cyclictimer (v0.1 thru v0.9). The test would start up and run with quite
good numbers for a few thousand iterations, then really large latencies
would start to occur (between 5000 and 30000 us). I have not dumped the
stats to a file and done any statistical analysis as to how frequent the
large latencies are, nor whether they're trending up or down.


I had a suspicion that it involved signal delivery because of the following:

$ sudo ./cyclictest32 --prio=1
0.01 0.03 0.01 1/151 3486

T: 0 ( 3484) P: 1 I:    1000 C:    8955 Min:      10 Act:   38011 Avg:
 20919 Max:   38445
$ sudo ./cyclictest32 --prio=1 --nanosleep
0.01 0.03 0.00 1/151 3490

T: 0 ( 3488) P: 1 I:    1000 C:   12995 Min:       6 Act:       7 Avg:
     6 Max:      31

As you can see, the Avg and Max times stay quite low when using
nanosleep; the latencies only happen when using itimers.

I was describing this behavior when DJ Delorie suggested that it might
be affinity based rather than signal delivery. He suggested binding the
test to a particular processor, so I did with the following results:

$ sudo taskset 0x1 ./cyclictest32 --prio=1
0.11 0.07 0.08 1/149 3311

T: 0 ( 3305) P: 1 I:    1000 C:   45709 Min:       8 Act:      11 Avg:
    10 Max:      53
$ sudo taskset 0x2 ./cyclictest32 --prio=1
0.03 0.05 0.08 1/149 3323

T: 0 ( 3313) P: 1 I:    1000 C:   74451 Min:      10 Act:   58011 Avg:
 28976 Max:   58818

So it seems that the latencies only occur on processor 1 (not on
processor 0).  I booted 2.6.18-rt4 with and without idle=poll (as Ingo
suggested) and saw the long latencies in both cases when the test was
bound to processor 1 (never with processor 0).

Hopefully this is useful information. I just wanted to let you guys
know, since you'll probably have a fix available long before I can
comprehend the arch/x86_64 code where this probably occurs.  Let me know
if you want other things, like the .config or something else.

Clark



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFGt96Hyuj/+TTEp0RAogoAJ9KhQE2IoRrqDvOaMwz4c41H95+gACgotaC
KmguTjvCXyj0K4u6E2Y9KEk=
=qsjM
-----END PGP SIGNATURE-----
