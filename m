Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbSJ0QgM>; Sun, 27 Oct 2002 11:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262461AbSJ0QgM>; Sun, 27 Oct 2002 11:36:12 -0500
Received: from nameservices.net ([208.234.25.16]:25678 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262460AbSJ0QgI>;
	Sun, 27 Oct 2002 11:36:08 -0500
Message-ID: <3DBC1881.165F74BD@opersys.com>
Date: Sun, 27 Oct 2002 11:46:57 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: LTT benchmarks and patch update
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, here's the latest LTT patch:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021026-2.2.bz2

We've run the latest LTT through a series of stress tests.  The tests
demonstrate that LTT has negligible impact when compiled out or with the
daemon off (and compiled in).  Even under the most stressful LMbench tests
we show minimal system impact.

We ran 2 sets of tests:
1- Measuring the overall execution time of 3 tasks: a complete 2.5 kernel
build, a bzip2 on a 2.5 kernel tar archive, and the total time to run
LMbench.
2- A complete LMbench run.

Each of these was run in 4 different configurations (Configuration B
was only run on test set #2 since the micro-benchmarks already show
no difference with vanilla):
A- A vanilla 2.5.44 kernel
B- A patched 2.5.44 kernel with tracing off
C- A patched 2.5.44 kernel with tracing on, daemon off
D- A patched 2.5.44 kernel with tracing on, daemon running

All tests were run using the lockless scheme with TSC timestamping.

When the LTT patch is applied to the kernel the results point to the fact
that when tracing is disabled there is no impact on the kernel performance.
Some numbers even seem to imply that the LTT patch speeds up the kernel by
fractions of a percent reinforcing our belief that the differences being
measured are in the noise.

Even when tracing is built-in, the difference is minimal, if at all
measurable. Test set #1 shows the decrease in performance to be equal
or below 0.5%, while test set #2 shows almost no difference for most
operations, including null syscalls.

As expected, nevertheless, there is a cost to having the trace daemon
running, tracing all kernel events and logging events to disk. Even then,
however, the impact on the real-life workloads (test set #1) is around
2.0%, which is quite low given the quantity of data being collected.
Some micro-benchmarks show relatively large impact. Because the large
majority of applications behave much closer to test set #1 than test set
#2, however, we believe the results are acceptable.

Here's a summary of test set #1:
----------------------------------------------------------------
| Kernel    |  Compile  | Compress  | LMbench SMP | LMbench UP |
----------------------------------------------------------------
| A (secs)  |     638   |    200    |     867     |   272.05   |
----------------------------------------------------------------
| C (secs)  |     640   |    201    |     871     |   270.87   |
| delta (%) |     0.3%  |    0.5%   |     0.5%    |    -0.15%  |
----------------------------------------------------------------
| D (secs)  |     651   |    204    |     872     |   275.08   |
| delta (%) |     2.0%  |    2.0%   |     0.5%    |     1.11%  |
----------------------------------------------------------------
[Compile and Compress columns are an average of 10 runs on SMP system;
LMbench SMP column is on one run only; LMbench UP is 5 runs without
disk tests.]

Test set #2 was run both on UP and SMP system.

The UP run of test set #2 was run 10 times and the results below are an
average of these runs (Average obtained using the tools available from:
http://home.earthlink.net/~rwhron/kernel/lmbench_comparison.html). This
is a complete LMbench test, including disk tests (not the same test run
as the LMbench UP measurements on 5 runs for test set #1 above).
#######################################################################
                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
           null     null                       open    signal   signal    fork    execve  /bin/sh
kernel     call      I/O     stat    fstat    close   install   handle  process  process  process
-------  -------  -------  -------  -------  -------  -------  -------  -------  -------  -------
  A        0.346  0.50314    4.193    0.730    5.186    0.843    3.201    292.3   1014.7   4985.2
  B        0.346  0.50274    4.441    0.730    5.449    0.843    3.180    288.1   1002.0   5024.6
  C        0.352  0.56244    4.241    0.735    5.432    0.849    3.156    301.0   1038.3   5134.7
  D        0.963   1.5442    6.282    1.367    9.079    1.662    8.903    345.2   2472.6   6622.2

File select - times in microseconds - smaller is better
-------------------------------------------------------
          select   select   select   select   select   select   select   select
kernel     10 fd   100 fd   250 fd   500 fd   10 tcp  100 tcp  250 tcp  500 tcp
-------  -------  -------  -------  -------  -------  -------  -------  -------
  A        1.992    8.518   19.693   37.959    3.557  33.3852  51.2701  113.087
  B        1.979    8.522   19.684   37.944    2.708  15.7315  37.7146  73.9382
  C        2.594   14.305   34.586   67.002    3.265  22.8394  50.5247  100.358
  D        6.015   39.079   94.875  232.318    8.283  85.7979   111.75   285.22

Context switching with 0K - times in microseconds - smaller is better
---------------------------------------------------------------------
          2proc/0k   4proc/0k   8proc/0k  16proc/0k  32proc/0k  64proc/0k  96proc/0k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          2.413      2.348      2.508      2.745      3.430      4.707      5.860
  B          2.681      2.455      2.559      2.904      3.600      4.912      6.034
  C          3.048      2.852      2.954      3.176      3.865      5.285      6.558
  D          3.572      3.434      3.691      3.895      4.999      6.881      8.229

Context switching with 4K - times in microseconds - smaller is better
---------------------------------------------------------------------
          2proc/4k   4proc/4k   8proc/4k  16proc/4k  32proc/4k  64proc/4k  96proc/4k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          2.624      4.423      4.458      5.413      8.061     12.465     15.230
  B          2.549      3.932      4.001      5.690      9.042     12.923     15.309
  C          3.185      4.882      5.174      6.220      8.887     13.114     15.681
  D          4.244      5.326      5.310      6.713      9.837     15.242     18.726

Context switching with 8K - times in microseconds - smaller is better
---------------------------------------------------------------------
          2proc/8k   4proc/8k   8proc/8k  16proc/8k  32proc/8k  64proc/8k  96proc/8k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          2.947      5.219      5.536      8.439     13.366     21.788     25.691
  B          2.904      5.689      6.158      8.515     14.220     22.450     28.341
  C          3.655      5.809      6.368      9.488     15.176     22.614     26.432
  D          4.908      6.618      6.813      9.620     15.692     23.165     26.995

Context switching with 16K - times in microseconds - smaller is better
----------------------------------------------------------------------
         2proc/16k  4proc/16k  8proc/16k  16prc/16k  32prc/16k  64prc/16k  96prc/16k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          3.696      8.210     12.007     19.677     32.724     43.699     46.730
  B          3.614      8.830     12.493     20.421     32.938     43.577     46.612
  C          4.006      8.649     11.366     20.512     34.509     44.386     47.505
  D          5.297      9.768     12.313     19.213     35.063     46.570     49.722

Context switching with 32K - times in microseconds - smaller is better
----------------------------------------------------------------------
         2proc/32k  4proc/32k  8proc/32k  16prc/32k  32prc/32k  64prc/32k  96prc/32k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          5.137     15.498     28.268     54.907     77.701     88.583     84.718
  B          6.458     17.387     27.123     52.752     76.295     84.247     84.857
  C          6.404     17.144     32.665     54.851     76.668     84.841     85.616
  D          6.979     15.674     25.008     53.044     79.204     87.115     87.739

Context switching with 64K - times in microseconds - smaller is better
----------------------------------------------------------------------
         2proc/64k  4proc/64k  8proc/64k  16prc/64k  32prc/64k  64prc/64k  96prc/64k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A         25.314     41.236     92.619    141.911    157.626    159.468    159.455
  B         31.503     47.503     96.400    141.198    157.873    159.476    159.537
  C         27.062     45.031     93.894    142.703    158.984    160.380    160.481
  D         27.648     36.102     81.103    147.793    162.497    163.387    163.377

File create/delete and VM system latencies in microseconds - smaller is better
----------------------------------------------------------------------------
           0K       0K       1K       1K       4K       4K      10K      10K     Mmap     Prot    Page
kernel   Create   Delete   Create   Delete   Create   Delete   Create   Delete   Latency  Fault   Fault
-------  -------  -------  -------  -------  -------  -------  -------  -------  -------  ------  ------
  A        59.18    19.39   100.00    35.14   102.86    36.10   169.11    42.11   1371.1   1.045    4.00
  B        59.47    20.97   100.92    36.18   102.06    35.84   168.89    42.61   1502.3   0.867    4.00
  C        59.17    20.04   101.04    33.85   102.10    33.76   169.36    41.13   1368.5   0.948    5.80
  D        67.19    23.82   112.33    40.62   115.90    41.30   187.37    50.20   1907.2   6.283    5.70

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel     Pipe   AF/Unix     UDP   RPC/UDP     TCP   RPC/TCP  TCPconn
-------  -------  -------  -------  -------  -------  -------  -------
  A        6.509   11.130  18.3123  45.6148  25.7486  63.1761  102.210
  B        6.443    9.948  17.0914  46.7833  25.7519  61.3685  102.340
  C        6.206   11.718  18.8520  47.5403  25.2025  67.8464  100.232
  D      484.605  168.968  116.732  1222.69  269.400  556.922  121.171

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
                                       File     Mmap    Bcopy    Bcopy   Memory   Memory
kernel     Pipe   AF/Unix    TCP     reread   reread   (libc)   (hand)     read    write
-------  -------  -------  -------  -------  -------  -------  -------  -------  -------
  A       323.57   221.12    95.28   203.32   386.49   191.25   190.68   411.29   293.50
  B       324.01   205.28   129.15   208.22   386.53   191.13   190.76   414.87   293.78
  C       324.79   200.83   111.97   206.33   385.56   191.11   190.70   414.64   293.52
  D       145.22   158.78    98.09   198.87   384.65   190.64   188.14   413.70   292.82

*Local* More Communication bandwidths in MB/s - bigger is better
----------------------------------------------------------------
            File     Mmap  Aligned  Partial  Partial  Partial  Partial  
OS          open     open    Bcopy    Bcopy     Mmap     Mmap     Mmap    Bzero
           close    close   (libc)   (hand)     read    write   rd/wrt     copy     HTTP
-------  -------  -------  -------  -------  -------  -------  -------  -------  -------
  A       206.83   293.34   189.77   230.56   674.92   330.34   312.93   293.96    8.969
  B       208.91   298.47   190.07   231.22   674.97   333.76   313.55   294.28    8.867
  C       207.15   295.53   189.75   230.87   674.32   332.87   313.11   293.99    8.890
  D       208.27   273.29   188.14   229.86   672.54   329.64   312.23   293.30    7.122

Memory latencies in nanoseconds - smaller is better
---------------------------------------------------
kernel    Mhz     L1 $     L2 $    Main mem
-------  -----  -------  -------  ---------
  A        800    3.783   44.180     172.92
  B        800    3.781   38.313     172.94
  C        800    3.788   48.874     173.18
  D        800    3.789   38.492     173.51
#######################################################################


Test set #2 was run 5 times on a 4x SMP system and the results below are
an average of the those runs (The same tools as earlier were used to
extract this data):
#######################################################################
                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
           null     null                       open    signal   signal    fork    execve  /bin/sh
kernel     call      I/O     stat    fstat    close   install   handle  process  process  process
-------  -------  -------  -------  -------  -------  -------  -------  -------  -------  -------
  A       0.501  0.92795    5.270    1.216    6.773    1.293    4.494    233.0    716.8   2912.9
  B       0.501  0.93778    5.213    1.212    6.717    1.292    4.481    232.0    716.7   2901.2
  C       0.504  1.08863    4.982    1.206    6.970    1.293    4.442    242.8    747.9   3053.7
  D       1.916  3.12815    7.734    3.698   11.709    2.858    7.559    277.0    925.5   3959.3

File select - times in microseconds - smaller is better
-------------------------------------------------------
          select   select   select   select   select   select   select   select
kernel     10 fd   100 fd   250 fd   500 fd   10 tcp  100 tcp  250 tcp  500 tcp
-------  -------  -------  -------  -------  -------  -------  -------  -------
  A        4.411   27.406   66.021  130.107    5.246  35.1106  87.3160  168.771
  B        4.424   27.378   65.973  130.098    5.170  35.0629  85.2186  172.147
  C        5.754   42.016  100.761  196.230    6.670  50.1556  121.856  242.663
  D       13.142  102.394  249.196  500.868   14.271  113.352   283.88  546.154

Context switching with 0K - times in microseconds - smaller is better
---------------------------------------------------------------------
          2proc/0k   4proc/0k   8proc/0k  16proc/0k  32proc/0k  64proc/0k  96proc/0k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          1.778      1.944      2.370      2.926      3.450      3.522      4.338
  B          1.724      1.910      2.028      2.614      3.010      3.412      4.748
  C          1.906      2.074      2.348      2.978      3.576      3.326      4.110
  D          6.046      5.448      6.466      5.654      5.800      5.488      5.280

Context switching with 4K - times in microseconds - smaller is better
---------------------------------------------------------------------
          2proc/4k   4proc/4k   8proc/4k  16proc/4k  32proc/4k  64proc/4k  96proc/4k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          2.988      5.778      7.428      8.454      8.496      8.394      7.934
  B          6.818      6.644      7.614      8.698      8.548      8.598      7.906
  C          5.528      6.526      7.810      8.820      8.422      8.724      8.348
  D          8.064      8.208      8.606      9.034      8.774      8.482      8.906

Context switching with 8K - times in microseconds - smaller is better
---------------------------------------------------------------------
          2proc/8k   4proc/8k   8proc/8k  16proc/8k  32proc/8k  64proc/8k  96proc/8k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          8.388      8.816      9.804      9.546      8.758      9.364     14.334
  B          8.402      8.098      8.990      9.326      8.204      9.286     14.350
  C          6.636      6.758      6.884      7.170      7.416     10.052     13.452
  D          8.462      8.994      9.986      9.284      9.380      9.726      9.978

Context switching with 16K - times in microseconds - smaller is better
----------------------------------------------------------------------
         2proc/16k  4proc/16k  8proc/16k  16prc/16k  32prc/16k  64prc/16k  96prc/16k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A          9.358      8.954      9.740     10.228     11.780     23.400     27.402
  B         11.792     11.962     12.350     11.138     11.658     26.948     36.402
  C         11.742     12.130     12.420     12.922     12.088     21.380     31.318
  D         12.266     12.572     12.712     12.906     12.720     13.940     20.930

Context switching with 32K - times in microseconds - smaller is better
----------------------------------------------------------------------
         2proc/32k  4proc/32k  8proc/32k  16prc/32k  32prc/32k  64prc/32k  96prc/32k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A         16.122     17.358     17.826     17.946     22.550     48.360     67.204
  B         18.504     17.958     17.784     17.574     20.966     49.100     71.354
  C         16.342     17.150     17.372     17.746     24.338     45.454     66.822
  D         19.286     18.684     18.322     18.990     24.352     51.198     68.866

Context switching with 64K - times in microseconds - smaller is better
----------------------------------------------------------------------
         2proc/64k  4proc/64k  8proc/64k  16prc/64k  32prc/64k  64prc/64k  96prc/64k
kernel   ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
-------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
  A         27.460     31.226     29.184     31.742     50.472    135.096    176.156
  B         28.674     28.366     27.690     29.234     53.842    130.884    178.004
  C         28.816     28.060     28.566     29.886     51.270    141.374    178.096
  D         28.772     28.816     28.736     42.250     67.816    159.820    180.094

File create/delete and VM system latencies in microseconds - smaller is better
----------------------------------------------------------------------------
           0K       0K       1K       1K       4K       4K      10K      10K     Mmap     Prot    Page
kernel   Create   Delete   Create   Delete   Create   Delete   Create   Delete   Latency  Fault   Fault
------- -------  -------  -------  -------  -------  -------  -------  -------  -------  ------  ------
  A       88.76    33.00   162.68    58.29   187.13    58.17   268.37    70.43   4653.0   1.086    4.00
  B       90.26    32.96   164.18    58.25   166.26    58.42   262.70    70.80   4638.6   1.053    4.00
  C       91.75    31.96   164.47    57.70   168.66    58.05   261.68    71.00   5020.2   1.359    4.00
  D      101.59    35.90   154.57    63.19   155.20    63.26   244.55    77.66   6931.2   2.012    7.00

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel     Pipe   AF/Unix     UDP   RPC/UDP     TCP   RPC/TCP  TCPconn
-------  -------  -------  -------  -------  -------  -------  -------
  A        8.381   20.217   33.332  59.6795  41.2206  74.5685  117.646
  B        8.223   15.084  33.4689  55.7983  38.1489  71.8043  121.885
  C        9.135   16.638  39.5581  67.6097  47.3104  82.4835  118.360
  D       19.460   29.729  49.8840  465.325  61.6741  131.809  131.579


*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
                                       File     Mmap    Bcopy    Bcopy   Memory   Memory
kernel     Pipe   AF/Unix    TCP     reread   reread   (libc)   (hand)     read    write
-------  -------  -------  -------  -------  -------  -------  -------  -------  -------
  A       509.65   504.18   172.52   290.36   330.88   193.43   157.06   330.87   201.57
  B       514.71   503.90   154.21   289.53   330.19   193.63   156.88   330.18   201.73
  C       474.63   496.20   144.88   289.44   330.55   194.23   158.10   330.58   200.94
  D       360.74   344.55   137.47   284.20   327.97   195.28   159.18   328.65   203.26

*Local* More Communication bandwidths in MB/s - bigger is better
----------------------------------------------------------------
            File     Mmap  Aligned  Partial  Partial  Partial  Partial  
OS          open     open    Bcopy    Bcopy     Mmap     Mmap     Mmap    Bzero
           close    close   (libc)   (hand)     read    write   rd/wrt     copy     HTTP
-------  -------  -------  -------  -------  -------  -------  -------  -------  -------
  A       292.56   269.89   192.90   167.37   785.96   202.14   202.73   350.89   10.298
  B       291.84   270.12   191.63   165.61   784.42   202.30   202.98   350.96   10.310
  C       291.89   265.37   192.08   165.79   785.20   201.56   202.06   350.30    9.952
  D       285.84   244.90   194.22   169.39   781.87   203.51   205.93   349.57    7.180

Memory latencies in nanoseconds - smaller is better
---------------------------------------------------
kernel    Mhz     L1 $     L2 $    Main mem
-------  -----  -------  -------  ---------
  A        700    4.301   12.907     182.16
  B        700    4.301   12.908     182.13
  C        700    4.303   12.915     182.30
  D        700    4.326   12.989     183.39
#######################################################################

Karim
