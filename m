Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319420AbSILDEU>; Wed, 11 Sep 2002 23:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319421AbSILDEU>; Wed, 11 Sep 2002 23:04:20 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:226 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319420AbSILDES>; Wed, 11 Sep 2002 23:04:18 -0400
Date: Wed, 11 Sep 2002 23:11:56 -0400
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance differences in recent kernels
Message-ID: <20020912031156.GA5947@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> AIM7 database workload
>> kernel                   Tasks   Jobs/Min       Real    CPU
>> 2.5.33-mm5               256    763.0           1992.9 1020.8

> I assume that's seconds of CPU for the entire run?

Yes.

>> IRMAN - interactive response measurement.
>>
>>                    FILE_IO Response time measurements (milliseconds)
>>                            Max         Min         Avg       StdDev
>> 2.4.20-pre4-ac1          40.603       0.008       0.009       0.043
>> 2.4.20-pre5              52.405       0.009       0.011       0.080
>> 2.5.33-mm5                2.955       0.008       0.010       0.004

> For many things, 1/latency == throughput.  But the averages are
> the same here.  Be interesting to run it on the 384 megabyte machine.

This is on the 384 mb machine.  It doesn't have the really low
max response time on 2.5.33-mm5.

                      FILE_IO Response time measurements (milliseconds)
                              Max         Min         Avg       StdDev
2.4.19-rmap14              190.061       0.016       0.137       4.017
2.4.20-pre5                180.719       0.016       0.113       3.708
2.4.20-pre5-ac1            552.150       0.011       0.035       3.160
2.4.20-pre5aa1             450.191       0.012       0.030       2.772
2.5.33-mm1                 456.736       0.012       0.033       2.979
2.5.33-mm5                 456.733       0.016       0.047       3.633
2.5.33                     456.061       0.012       0.034       3.077

> It would be interesting to run irman in conjunction with tiobench
> or dbench.  One the same disk and on a different disk.

hm, i'll think about ways to do that and keep the test repeatable.

>> Time to build the kernel 12 times.  Not a lot of difference here.
>>
>> kernel                           seconds
>> 2.5.33                             728.2
>> 2.5.33-mm5                         736.8

> Should have been better than that.  Although the kmap work doesn't
> seem to affect these machines.  Is that a `make -j1', `-j6'???

That's make -j1 executed simultaneously on 4 different kernel
trees.

> It is useful to watch the amount of CPU which is consumed with dbench,
> btw.  That's one thing which tends to be fairly repeatable between runs.

Like "time dbench 64", or something else?

>> Sequential Writes ext2
>> There is a dramatic reduction in cpu utilization in 2.5.33-mm5 and increase in
>> throughput compared to 2.5.33 when thread count is high.
>>
>>                    Num                    Avg       Maximum      Lat%   CPU
>> Kernel             Thr   Rate  (CPU%)   Latency     Latency      >10s   Eff
>> ------------------ ---  ---------------------------------------------------
>> 2.4.19-rc5-aa1     128   37.40 45.99%    32.405    46333.30   0.00105    81
>> 2.4.20-pre4-ac1    128   34.01 36.94%    40.121    47331.57   0.00058    92
>> 2.4.20-pre5        128   32.98 49.33%    39.692    52093.19   0.01446    67
>> 2.5.33             128   12.17 222.9%   108.966   910455.61   0.19503     5
>> 2.5.33-mm5         128   30.78 30.03%    32.973   909931.81   0.07858   102

> This test is highly dependent upon the size of the request queues.  The
> queues have 128 slots and you're running 128 threads.  One would expect
> to see a lot of variability with that combo.  Would be interesting to also
> test 64 threads, and 256.

> -aa has the "merge even after latency has expired" logic in the elevator,
> which could make some difference at the 128 thread level.

On 2.5.33-mm1, the throughput and cpu is pretty comparable at 64, 128 and
256 threads.  cpu utilization on -aa is very different at 64 and 256
threads compared to 128.

Sequential Writes ext2
                    Num                    Avg       Maximum       Lat%    CPU
Kernel              Thr   Rate  (CPU%)   Latency     Latency       >10s    Eff
------------------- ---  -----------------------------------------------------
2.4.19-rc1-aa1       64   35.62 92.35%    19.063    23691.67    0.00000     39
2.4.20-pre4-ac1      64   34.17 37.34%    20.282    23123.27    0.00000     92
2.4.20-pre5          64   33.19 48.62%    20.235    28646.79    0.00003     68
2.5.33               64   14.06 191.6%    47.371   275718.71    0.09892      7
2.5.33-mm5           64   30.69 29.55%    19.323   277839.26    0.07670    104

2.4.19-rc1-aa1      256   35.29 91.34%    72.996    83127.21    0.16864     39
2.4.20-pre4-ac1     256   34.88 38.32%    76.128    91906.08    0.48809     91
2.4.20-pre5         256   33.20 49.30%    76.394    95761.85    0.50046     67
2.5.33              256   12.65 252.6%   197.722  1334605.09    0.31655      5
2.5.33-mm5          256   28.37 29.96%    67.484   699119.03    0.10001     95

>> Sequential Reads ext3
>> 2.5.33-mm5 has a more graceful degradation in throughput on ext3.
>> Fairness is better too.
>>
>>                    Num                    Avg       Maximum      Lat%   CPU
>> Kernel             Thr   Rate  (CPU%)   Latency     Latency      >10s   Eff
>> ------------------ ---  ---------------------------------------------------
>> 2.4.19-rc5-aa1       1   51.13 29.59%     0.227      460.92   0.00000   173
>> 2.4.20-pre4-ac1      1   34.12 17.37%     0.341     1019.65   0.00000   196
>> 2.4.20-pre5          1   33.28 20.62%     0.350      137.44   0.00000   161
>> 2.5.33-mm5           1   31.70 14.75%     0.367      581.89   0.00000   215

> 20% drop in CPU load is typical, but the reduced bandwidth on such
> a simple test is unexpected.  Presumably that's the driver thing.

>> 2.4.19-rc5-aa1      64    7.38  4.51%    98.947    20638.56   0.00000   164
>> 2.4.20-pre4-ac1     64    6.55  3.94%   110.432    14937.49   0.00000   166
>> 2.4.20-pre5         64    6.34  4.16%   111.299    14234.83   0.00000   152
>> 2.5.33-mm5          64   12.29  8.51%    55.372     8799.99   0.00000   144

> hm.  Don't know.  Something went right in the 2.5 elevator I guess.

It went right at 32 threads too.  128 and 256 are better than average 
on 2.5.33-mm5.

Sequential Reads ext3
                  Num                    Avg       Maximum       Lat%    CPU
Kernel            Thr   Rate  (CPU%)   Latency     Latency      >10s    Eff
----------------- ---  -----------------------------------------------------
2.4.19-rc1-aa1     32    7.19  5.13%    51.480    14981.42    0.00000    140
2.4.20-pre4-ac1    32    6.70  3.96%    54.502     6613.54    0.00000    169
2.4.20-pre5        32    7.25  4.72%    49.839     7344.23    0.00000    153
2.5.33-mm5         32   15.26  9.89%    23.999    10942.51    0.00000    154

2.4.19-rc1-aa1    128    6.70  4.86%   220.082    56700.25    0.91508    138
2.4.20-pre4-ac1   128    6.17  3.71%   227.375    26637.67    0.00000    166
2.4.20-pre5       128    6.41  4.21%   212.999    32363.01    0.00009    152
2.5.33-mm5        128    9.63  7.89%   128.288    16677.89    0.00000    122

2.4.19-rc1-aa1    256    6.51  4.70%   450.763   109737.74    2.23919    139
2.4.20-pre4-ac1   256    5.69  3.41%   475.816    54311.24    0.00703    167
2.4.20-pre5       256    5.74  3.90%   470.792    55091.26    0.05414    147
2.5.33-mm5        256    7.39  6.92%   305.286    46425.82    0.08529    107




-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

