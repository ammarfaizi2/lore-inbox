Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSKHF6a>; Fri, 8 Nov 2002 00:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSKHF6a>; Fri, 8 Nov 2002 00:58:30 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3200 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S261641AbSKHF62> convert rfc822-to-8bit; Fri, 8 Nov 2002 00:58:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@digeo.com>,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
Date: Fri, 8 Nov 2002 17:04:13 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200211080953.22903.conman@kolivas.net> <3DCAFE38.16DED3BF@digeo.com> <1036713848.764.2107.camel@phantasy>
In-Reply-To: <1036713848.764.2107.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211081702.32792.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ok well I guess some more data is required to interpret this.

>On Thu, 2002-11-07 at 18:58, Andrew Morton wrote:
>> Robert Love wrote:
>> > On Thu, 2002-11-07 at 17:53, Con Kolivas wrote:
>> > > io_load:
>> > > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> > > 2.5.44-mm6 [3]          284.1   28      20      10      3.98
>> > > 2.5.46 [1]              600.5   13      48      12      8.41
>> > > 2.5.46-mm1 [5]          134.3   58      6       8       1.88
>> > >
>> > > Big change here. IO load is usually the one we feel the most.
>> >
>> > Nice.
>>
>> Mysterious.
>
>Why?  We are preempting during the generic file write/read routines, I
>bet, which can otherwise be long periods of latency.  CPU is up and I
>bet the throughput is down, but his test is getting the attention it
>wants.

Here are the results with 2.5.46-mm1 with and without preempt (2.5.46-mmnp)
only where they _differ_ for clarity:

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          190.6   36      166     63      2.67
2.5.46 [1]              92.9    74      36      29      1.30
2.5.46-mm1 [5]          82.7    82      21      21      1.16
2.5.46-mmnp [3]         93.8    72      37      29      1.31

Note that 2.5.46-mm1 without preempt here is comparable to 2.5.46 vanilla.
Also, this one is prone to the process_load getting stuck endlessly piping
data around and me having to kill the run. These were the 3 successful runs.
Are the changes that fixed this problem in 2.5.44-mm6 backed out in
2.5.46-mm1? Also it seems interesting to me that preempt manages to break out
of this loop and is not prone to that hang.

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44-mm6 [3]          284.1   28      20      10      3.98
2.5.46 [1]              600.5   13      48      12      8.41
2.5.46-mm1 [5]          134.3   58      6       8       1.88
2.5.46-mmnp [4]         357.6   22      27      11      5.01

I guess this is the one we were most interested in and no doubt it takes less
time with preempt enabled

A few more things to clarify that were queried: Only the kernel compilation
time and cpu% are accurate. The "Loads" field takes the total number of
iterations done by the load over the duration of the load running and divides
it by the time the load ran over the kernel compilation time. Thus it is not
reliably accurate enough because the duration the load runs beyond kernel
compilation time is variable :- It takes a variable length of time to kill
the load. The load cpu% (lcpu%) is that spit out by "time load" and as I said
this runs for longer than the kernel compilation so will be an overestimate.
I haven't found a way around this. It seems to be routine that loads done
drops disproportionately when kernel compilation shortens. This seems to be
more a load accounting problem (dont have a fix for that). Furthermore, since
kernel compilation is -j4 and the load is one task all at the same nice level
it would seem to be ideal for kernel compilation time to increase by 5/4 (and
ratio to equal 1.25) , and concomitantly for cpu% to drop to 4/5 (80%) of
noload.

Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9y1PeF6dfvkL3i1gRAkNXAJ47qgYAd9mygNpF7KDnzyuR6xjX3ACeORH7
Eo3HgfvJ7hJe1ykoaPEEQyQ=
=2L0b
-----END PGP SIGNATURE-----

