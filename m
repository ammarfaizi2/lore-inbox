Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbSKJJwr>; Sun, 10 Nov 2002 04:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264789AbSKJJwr>; Sun, 10 Nov 2002 04:52:47 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:5761 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S264788AbSKJJwo> convert rfc822-to-8bit; Sun, 10 Nov 2002 04:52:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sun, 10 Nov 2002 20:58:43 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
References: <200211091300.32127.conman@kolivas.net> <20021110024451.GE2544@x30.random>
In-Reply-To: <20021110024451.GE2544@x30.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211102058.46883.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

First some explanation.

Contest (http://contest.kolivas.net) is obviously not a throughput style 
benchmark. The benchmark simply uses userland loads known to slow down the 
machine (like writing large files) and sees how much longer kernel 
compilation takes (make -j4 bzImage on uniprocessor). Thus it never claims to 
be any sort of comprehensive system benchmark; it only serves to give an idea 
of the systems ability to respond in the presence of different loads, in 
terms end users can understand.

>On Sat, Nov 09, 2002 at 01:00:19PM +1100, Con Kolivas wrote:
>> xtar_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.18 [3]              150.8   49      2       8       2.11
>> 2.4.19 [1]              132.4   55      2       9       1.85
>> 2.4.19-ck9 [2]          138.6   58      2       11      1.94
>> 2.4.20-rc1 [3]          180.7   40      3       8       2.53
>> 2.4.20-rc1aa1 [3]       166.6   44      2       7       2.33
>
>these numbers doesn't make sense. Can you describe what xtar_load is
>doing?

Ok xtar_load starts extracting a large tar (a kernel tree) in the background 
then tries to compile a kernel. The time is how long kernel compilation takes 
and cpu% is how much cpu% make -j4 bzImage uses. Loads is how many times it 
successfully extracts the tar and LCPU% is the cpu% returned by the "tar x 
linux.tar" command. Ratio is the ratio of this kernel compilation time to the 
reference (2.4.18 with no load).

>> First noticeable difference. With repeated extracting of tars while
>> compiling kernels 2.4.20-rc1 seems to be slower and aa1 curbs it just a
>> little.

This explanation said simply that kernel compilation with the same tar 
extracting load takes longer in 2.4.20-rc1 compared with 2.4.19, but that the 
aa addons sped it up a bit.

>> io_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.18 [3]              474.1   15      36      10      6.64
>> 2.4.19 [3]              492.6   14      38      10      6.90
>> 2.4.19-ck9 [2]          140.6   49      5       5       1.97
>> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
>> 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
>
>What are you benchmarking, tar or the kernel compile? I think the
>latter. That's the elevator and the size of the I/O queue here. Nothing
>else. hacks like read-latency aren't very nice in particular with
>async-io aware apps. If this improvement in ck9 was achieved decreasing
>the queue size it'll be interesting to see how much the sequential I/O
>is slowed down, it's very possible we've too big queues for some device.
>
>> Well this is interesting. 2.4.20-rc1 seems to have improved it's ability
>> to do IO work. Unfortunately it is now busy starving the scheduler in the
>> mean time, much like the 2.5 kernels did before the deadline scheduler was
>> put in.
>>
>> read_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.18 [3]              102.3   70      6       3       1.43
>> 2.4.19 [2]              134.1   54      14      5       1.88
>> 2.4.19-ck9 [2]          77.4    85      11      9       1.08
>> 2.4.20-rc1 [3]          173.2   43      20      5       2.43
>> 2.4.20-rc1aa1 [3]       150.6   51      16      5       2.11
>
>What is busy starving the scheduler? This sounds like it's again just an
>evelator benchmark. I don't buy your scheduler claims, give more
>explanations or it'll take it as vapourware wording, I very much doubt
>you can find any single problem in the scheduler rc1aa2 or that the
>scheduler in rc1aa1 has a chance to run slower than the one of 2.4.19 in
>a I/O benchmark, ok it still misses the numa algorithm, but that's not a
>bug, just a missing feature and it'll soon be fixed too and it doesn't
>matter for normal smp non-numa machines out there.

Ok I fully retract the statement. I should not pass judgement on what part of 
the kernel has changed the benchmark results, I'll just describe what the 
results say. Note however this comment was centred on the results of io_load 
above. Put simply : if I am writing a large file and then try to compile the 
kernel (make -j4 bzImage) it is 16 times slower.

>> mem_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.18 [3]              103.3   70      32      3       1.45
>> 2.4.19 [3]              100.0   72      33      3       1.40
>> 2.4.19-ck9 [2]          78.3    88      31      8       1.10
>> 2.4.20-rc1 [3]          105.9   69      32      2       1.48
>> 2.4.20-rc1aa1 [1]       106.3   69      33      3       1.49
>
>again ck9 is faster because of elevator hacks ala read-latency.
>
>in short your whole benchmark seems all about interacitivy of reads
>during write flood. That's the read-latency thing or whatever else you
>could do to ll_rw_block.c.
>
>In short if somebody runs fast in something like this:
>
>	cp /dev/zero . & time cp bigfile /dev/null
>
>he will win your whole contest too.
>
>please show the difff between
>2.4.19-ck9/drivers/block/{ll_rw_blk,elevator}.c and
>2.4.19/drivers/block/...

I think Matt addressed this issue. 

>All the difference is there and it will hurt you badly if you do
>async-io benchmarks, and possibly dbench too. So you should always
>accompain your benchmark with async-io simultanous read/write bandwitdth
>and dbench, or I could always win your contest by shipping a very bad
>kernel. Either that or change the name of your project, if somebody wins
>this context that's probably a bad I/O scheduler in many other aspects,
>some of the reason I didn't merge read-latency from Andrew.

The name is meaningless and based on my name. Had my name been John it would 
be johntest.

I regret ever including the -ck (http://kernel.kolivas.net) results. The 
purpose of publishing these results was to compare 2.4.20-rc1/aa1 with 
previous kernels. As some people are interested in the results of the ck 
patchset I threw them in as well. -ck is a patchset with desktop users in 
mind and is simply a merged patch of O(1),preempt,low latency and compressed 
caching. If it sacrifices throughput in certain areas to maintain system 
responsiveness then so be it. I'll look into adding other loads to contest as 
you suggested, but I'm not going to add basic throughput benchmarks. There 
are plenty of tools for this already.

I've done some ordinary dbench-quick benchmarks of ck9 and 2.4.20-rc1aa1 at 
the OSDL http://www.osdl.org/stp

ck10_cc is the sum of patches that make up ck9 so is the same thing.

ck10_cc: http://khack.osdl.org/stp/7005/
2.4.20-rc1-aa1: http://khack.osdl.org/stp/7006/

Summary:
2420rc1aa1:
1 117.5
4 114.002
7 114.643
10 114.818
13 109.478
16 109.817
19 103.692
22 103.678
25 105.478
28 93.1296
31 87.0544
34 84.2668
37 81.0731
40 75.4605
43 77.2198
46 69.0448
49 66.7997
52 61.5987
55 60.2009
58 60.1531
61 58.3121
64 55.7127
67 56.2714
70 53.6214
73 52.2704
76 52.3631
79 49.7146
82 48.2406
85 48.1078
88 42.8405
91 42.4929
94 42.3958
97 43.5729
100 45.8318

ck10_cc:
1 116.239
4 115.075
7 114.414
10 114.166
13 109.129
16 109.403
19 106.601
22 97.7714
25 93.7279
28 95.0076
31 92.5594
34 88.5938
37 89.7026
40 86.9904
43 85.1783
46 82.7975
49 79.7348
52 80.2497
55 79.2346
58 76.6632
61 75.9002
64 75.8677
67 75.7318
70 73.2223
73 73.7652
76 72.9277
79 72.5244
82 71.6753
85 71.3161
88 70.9735
91 69.5539
94 69.602
97 67.2016
100 67.158

Regards,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9zi3UF6dfvkL3i1gRAkWmAJ4zX7gyUjzKH7eCNneyNRWLPGtCeACff9A7
Bn8LHqZw46CrGauuWTldDnQ=
=0WMB
-----END PGP SIGNATURE-----

