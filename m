Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSHIO0E>; Fri, 9 Aug 2002 10:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSHIO0E>; Fri, 9 Aug 2002 10:26:04 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18589 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313070AbSHIOZ7>; Fri, 9 Aug 2002 10:25:59 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Andries Brouwer <aebr@win.tue.nl>
Subject: Analysis for Linux-2.5 fix/improve get_pid(), comparing various approaches
Date: Fri, 9 Aug 2002 07:22:08 -0400
User-Agent: KMail/1.4.1
Cc: Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       andrea@suse.de, gh@us.ibm.com
References: <1028757835.22405.300.camel@plars.austin.ibm.com> <3D51A7DD.A4F7C5E4@zip.com.au> <20020808002419.GA528@win.tue.nl>
In-Reply-To: <20020808002419.GA528@win.tue.nl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W8QKWF6GAWOQHBSXEPHI"
Message-Id: <200208090722.08223.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_W8QKWF6GAWOQHBSXEPHI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Subject: 



Folks, below is the analysis that I promised yesterday.
Attached is also the harness program that brings this into userspace and 
computes basic overhead for pid allocation in a random setting.
The tar file contains the following stuff and represents the
status last time I gave this consideration. I had posted it to
lkml but other than from Andrea I had not received any feedback 
and dropped the issue.

total 52
   4 -rw-rw-r--    1 frankeh  frankeh       141 Mar 28 11:25 Makefile
  12 -rw-rw-r--    1 frankeh  frankeh      8306 Mar 22 16:59 res-2
  16 -rw-rw-r--    1 frankeh  frankeh     13268 Mar 20 10:11 getpid1.c
  16 -rw-rw-r--    1 frankeh  frankeh     15124 Mar 14 18:19 res-1
   4 -rwxrw-r--    1 frankeh  frankeh       316 Mar 13 12:01 bm

getpid1 is the harness. bm is the batch driver.
res-1 and res-2 are two result files that each were mangled together from
the outputs of <bm> executed on different machines.
I attach res-1 here , which I posted earlier in March, so you can read through 
it and draw your own conclusions with respect on where we should go with 
this.
It might be worthwile to independenly redo the test and also include
Andrea's <getpid> there, allthough it resembles <algo-1>. 

Volunteers ?

Note that based on the results I got, I still favor a version of the
mark and sweep that continues to go forward to find the next range
rather than always start from the beginning again.
I am not really sure whether Bill's version can be easily integrated.

The second part of the message (res-1) also experiments with a partial
maximum safe pid-range, i.e., once a range of 256 free pids has been 
established we stop the mark and sweep. That looks very competitive 
as well. I gives too simple improvements
(a) bitmask can be located on the stack  
(b) we could potentially deal with 32-bit pid numbers as we can limit
    the bitmask to partial space of the pid range.

-- Hubertus

----------------<previous post>-----------------------------------------------

I implemented an alternative version of getpid, that for large thread counts
( > 210000), provides "significantly" better performance as shown in attached
performance analysis. This is particulary viable for PID_MAX=32768.

-- Hubertus Franke <frankeh@watson.ibm.com>

---------------------------------------------------------------------------------

Currently the getpid algorithm works as follows:
At any given time an interval of [ last_pid .. next_safe ) is known to hold     
unused pids. Initially the interval is set to [0 .. 32767]

Hence to allocate a new pid the following is sufficient:

       if (++last_pid < next_safe) return last_pid;

However, if we move out of the safe interval, the next safe interval needs 
to be established first.
This is currently done by a repetive search 

repeat:
     foralltasks(p) {
        if (p uses lastpid) { last_pid++; goto repeat; }
        /* narrow [ last_pid .. next_safe ) */
        if (p->pids in [ last_pid .. next_safe ) ) next_safe = p->pid
     }

Particulary for large number of tasks, this can lead to frequent exercise of
the repeat resulting in a O(N^2) algorithm. We call this : <algo-0>.

Instead I have provided an alternative mechanism that at the time
of determining the next interval marks a bitmask by walking the tasklist
once [ O(N) ] and then finding the proper bit offsets to mark the next free
interval starting from last_pid. The bitmap requires 4096 bytes.
This is <algo-1>.

An optimization to this to keep the last bitmap instead of clearing it
with every search. Only if we fail to obtain a free range, then we have
to go back and clear the bitmap and redo the search one more time.
This is <algo-2>.

I dragged the various algorithms into a userlevel test program to figure
out where the cut off points are with PID_MAX=32768. In this testprogram
I maintain A tasks, and for 10 rounds (delete D random tasks and 
reallocate D tasks again) resulting in T=10*D total measured allocations.

Si states how many interval searches where needed for algo-i.
Gi states the average overhead per get_pid for algo-i in usecs.

Based on that one should use the current algorithm until ~ 22K tasks and
beyond that use algo-2. Only the last 15 tasks are a bit faster under algo-1.
We can safely ignore that case.

Based on that providing an adaptive implementation seems the right choice.
The patch for 2.5.7-pre1 is attached.


executed program example: getpid -c 2 -s 10 -e 100 -d 10 -t <0,1> 
        0 is old 1 is new algo 2.

   A     D      T |      S0           G0 |    S1        G1 |    S2        G2 
----------------------------------------------------------------------------
   10    10    80 |       1         0.34 |     1      0.59 |    1       0.81 
   20    10   100 |       1         0.30 |     1      0.49 |    1       0.64 
   30    10   100 |       1         0.29 |     1      0.55 |    1       0.65 
   40    10   100 |       1         0.35 |     1      0.51 |    1       0.65 
   50    10   100 |       1         0.35 |     1      0.54 |    1       0.67 
   60    10   100 |       2         0.38 |    21      1.95 |    2       0.79 
   70    10   100 |       1         0.39 |     1      0.59 |    1       0.76 
   80    10   100 |       1         0.41 |     1      0.62 |    1       0.76 
  100    50   500 |       2         0.22 |    63      1.26 |    2       0.30 
  150    50   500 |       3         0.24 |    12      0.56 |    4       0.36 
  200    50   500 |       3         0.27 |    56      2.26 |    5       0.46 
  250    50   500 |       2         0.26 |   119      5.63 |    6       0.54 
  300    50   500 |       3         0.32 |   148      8.73 |    9       0.76 
  350    50   500 |       5         0.45 |   168     11.51 |    6       0.76 
  400    50   500 |       4         0.44 |    90      7.28 |   10       1.10 
  450    50   500 |       6         0.61 |   143     13.08 |    7       0.97 
  500    50   500 |       6         0.65 |   100     10.47 |    7       1.06 
  550    50   500 |       5         0.63 |    71      8.10 |    9       1.34 
  600    50   500 |       7         0.86 |   115     14.32 |   14       2.04 
  650    50   500 |       8         1.00 |   112     15.08 |   13       2.07 
  700    50   500 |       8         1.06 |   127     18.12 |   10       1.79 
  750    50   500 |       8         1.26 |    62      9.73 |   15       2.73 
  800    50   500 |      11         1.68 |    92     15.14 |   12       2.42 
  850    50   500 |      14         2.03 |    78     13.73 |   13       2.67 
  900    50   500 |      21         3.17 |   102     18.74 |   27       5.18 
 1000  1000  9980 |       1         0.18 |     4      0.19 |    1       0.18 
 2000  1000 10000 |      76         1.22 |  3604     53.03 |  322       4.81 
 3000  1000 10000 |     161         3.84 |  4502    112.24 |  606      15.49 
 4000  1000 10000 |     359        11.17 |  4912    183.37 |  901      33.76 
 5000  1000 10000 |     539        23.33 |  4949    257.35 | 1165      59.91 
 6000  1000 10000 |     724        43.42 |  4918    349.59 | 1498     104.36 
 7000  1000 10000 |    1026        85.38 |  4886    447.58 | 1835     165.08 
 8000  1000 10000 |    1228       126.45 |  4870    565.29 | 2084     234.73 
 9000  1000 10000 |    1516       193.62 |  4826    699.85 | 2489     354.27 
10000  1000 10000 |    1818       289.32 |  4910    843.32 | 2763     472.47 
11000  1000 10000 |    2093       389.33 |  5005   1023.08 | 3095     629.70 
12000  1000 10000 |    2305       506.23 |  5095   1194.71 | 3277     773.06 
13000  1000 10000 |    2680       683.66 |  5289   1424.81 | 3711    1003.67 
14000  1000 10000 |    2959       853.10 |  5358   1602.05 | 3878    1172.70 
15000  1000 10000 |    3167      1037.79 |  5539   1835.64 | 4301    1436.40 
16000  1000 10000 |    3466      1272.80 |  5669   2087.03 | 4485    1635.48 
17000  1000 10000 |    3743      1539.06 |  5932   2338.50 | 4844    1924.27 
18000  1000 10000 |    4069      1869.63 |  6097   2613.60 | 5218    2232.52 
19000  1000 10000 |    4293      2183.98 |  6242   2866.34 | 5501    2519.60 
20000  1000 10000 |    4616      2607.10 |  6508   3175.90 | 5770    2823.98 
21000  1000 10000 |    4974      3119.34 |  6700   3460.95 | 6161    3183.73 
22000  1000 10000 |    5177      3609.28 |  6944   3788.19 | 6389    3492.97 =
23000  1000 10000 |    5483      4214.03 |  7183   4136.25 | 6665    3823.38 
24000  1000 10000 |    5838      4971.60 |  7404   4460.62 | 6982    4199.61 
25000  1000 10000 |    6183      5880.92 |  7736   4891.80 | 7209    4546.18 
26000  1000 10000 |    6413      6829.07 |  7890   5210.85 | 7533    4939.12 
27000  1000 10000 |    6748      8132.96 |  8148   5598.19 | 7959    5442.25 
28000  1000 10000 |    7139     10065.52 |  8445   6047.42 | 8140    5767.13 
29000  1000 10000 |    7638     12967.20 |  8736   6475.23 | 8501    6250.86 
30000  1000 10000 |    8178     16991.05 |  8994   6907.40 | 8911    6791.97 
32000    50   500 |     482     26446.69 |   488   7405.63 |  487    7494.39 
32050    50   500 |     488     34769.89 |   488   7463.11 |  486    7541.61 
32100    50   500 |     489     44564.86 |   493   7593.99 |  486    7589.02 
32150    50   500 |     486     58150.58 |   487   7549.96 |  492    7731.18 
32200    50   500 |     490     64875.38 |   495   7721.82 |  497    7854.59 
32250    50   500 |     491     81790.21 |   491   7697.57 |  490    7795.12 
32300    50   500 |     489     88975.62 |   493   7763.04 |  495    7909.77 
32350    50   500 |     489    115797.38 |   492   7782.34 |  495    7967.86 
32400    50   500 |     490    120958.50 |   497   7898.45 |  496    8018.98 
32450    50   500 |     492    147541.84 |   493   7874.27 |  492    7982.34 
32500    50   500 |     493    175498.39 |   495   7940.18 |  495    8060.97 
32550    50   500 |     492    207229.29 |   496   7973.88 |  498    8134.02 
32600    50   500 |     495    267057.05 |   498   8028.86 |  498    8171.97 
32650    50   500 |     492    375722.28 |   500   8088.30 |  498    8213.85 
32700    50   500 |     497    528321.07 |   500   8110.51 |  499    8267.67 
32751     1    10 |      10    259785.80 |    10   7851.50 |   10    8549.30 
32752     1    10 |      10   1121285.60 |    10   7846.30 |   10    8556.10 
32753     1    10 |      10    383729.50 |    10   7848.60 |   10    8562.20 
32754     1    10 |      10   1061467.50 |    10   7849.80 |   10    8564.40 
32755     1    10 |      10    612726.50 |    10   7853.00 |   10    8553.90 
32756     1    10 |      10   1725559.90 |    10   7851.90 |   10    8553.00 
32757     1    10 |      10   1679818.50 |    10   7847.80 |   10    8552.10 
32758     1    10 |      10   2991838.60 |    10   7865.70 |   10    8557.20 
32759     1    10 |      10   883388.90  |    10   7859.40 |   10    8562.00 
32760     1    10 |      10   4830405.90 |    10   7850.50 |   10    9336.60 
32761     1    10 |      10   7105809.20 |    10   7863.90 |   10    9337.20 
32762     1    10 |      10   7919703.40 |    10   7867.10 |   10    9340.70 
32763     1    10 |      10   1537522.50 |    10   7869.40 |   10    9340.70 
32764     1    10 |      10   6173019.20 |    10   7866.60 |   10    9340.00 
32765     1    10 |      10   8104105.00 |    10   7876.20 |   10   10112.80 
32766     1    10 |      10  16145415.40 |    10   7880.80 |   10   10893.50 
32767     1    10 |      10  16135267.10 |    10   7878.60 |   10   11674.40 


Other variants are possible, for instance if 4096 bytes is too much
(hell I don't know how that could be), one can break it up into smaller
search chunks (e.g. 256 bytes).

Another alternative is to allocate the page on the first occasion of
getting into get_pid_my_map....

In the following I give a comparative result between algo-2 and
algo-2 with a max interval size of 256. The times are very comparative.
Also the search count values are identical, but in 2 cases suggesting
that a interval size particular for large thread counts of 256 is certainly 
sufficient, but it brings some small overhead. Question to answer is 
wether setting aside an extra page is such a crime..... 

   A     D      T |    S2        G2 |  S2-256     G2-256
-------------------------------------------------------
   10    10    80 |    1       0.81 |      1       0.84
   20    10   100 |    1       0.64 |      1       0.67
   30    10   100 |    1       0.65 |      1       0.68
   40    10   100 |    1       0.65 |      1       0.69
   50    10   100 |    1       0.67 |      1       0.71
   60    10   100 |    2       0.79 |      2       0.82
   70    10   100 |    1       0.76 |      1       0.76
   80    10   100 |    1       0.76 |      1       0.79
  100    50   500 |    2       0.30 |      2       0.31
  150    50   500 |    4       0.36 |      5       0.39  <=
  200    50   500 |    5       0.46 |      5       0.46
  250    50   500 |    6       0.54 |      6       0.55
  300    50   500 |    9       0.76 |      9       0.76
  350    50   500 |    6       0.76 |      6       0.75
  400    50   500 |   10       1.10 |     10       1.10
  450    50   500 |    7       0.97 |      7       0.97
  500    50   500 |    7       1.06 |      7       1.06
  550    50   500 |    9       1.34 |      9       1.35
  600    50   500 |   14       2.04 |     14       2.06
  650    50   500 |   13       2.07 |     13       2.09
  700    50   500 |   10       1.79 |     10       1.82
  750    50   500 |   15       2.73 |     15       2.69
  800    50   500 |   12       2.42 |     12       2.38
  850    50   500 |   13       2.67 |     13       2.66
  900    50   500 |   27       5.18 |     27       5.25
 1000  1000  9980 |    1       0.18 |      3       0.19 <=
 2000  1000 10000 |  322       4.81 |    322       4.84
 3000  1000 10000 |  606      15.49 |    606      15.55
 4000  1000 10000 |  901      33.76 |    901      34.42
 5000  1000 10000 | 1165      59.91 |   1165      62.35
 6000  1000 10000 | 1498     104.36 |   1498     105.55
 7000  1000 10000 | 1835     165.08 |   1835     174.82
 8000  1000 10000 | 2084     234.73 |   2084     244.18
 9000  1000 10000 | 2489     354.27 |   2489     372.11
10000  1000 10000 | 2763     472.47 |   2763     486.73
11000  1000 10000 | 3095     629.70 |   3095     648.31
12000  1000 10000 | 3277     773.06 |   3277     784.75
13000  1000 10000 | 3711    1003.67 |   3711    1006.94
14000  1000 10000 | 3878    1172.70 |   3878    1168.71
15000  1000 10000 | 4301    1436.40 |   4301    1429.89
16000  1000 10000 | 4485    1635.48 |   4485    1620.90
17000  1000 10000 | 4844    1924.27 |   4844    1904.92
18000  1000 10000 | 5218    2232.52 |   5218    2218.80
19000  1000 10000 | 5501    2519.60 |   5501    2508.83
20000  1000 10000 | 5770    2823.98 |   5770    2895.66
21000  1000 10000 | 6161    3183.73 |   6161    3307.54
22000  1000 10000 | 6389    3492.97 |   6389    3620.53
23000  1000 10000 | 6665    3823.38 |   6665    3995.63
24000  1000 10000 | 6982    4199.61 |   6982    4347.95
25000  1000 10000 | 7209    4546.18 |   7209    4701.95
26000  1000 10000 | 7533    4939.12 |   7533    5088.13
27000  1000 10000 | 7959    5442.25 |   7959    5599.85
28000  1000 10000 | 8140    5767.13 |   8140    5817.86
29000  1000 10000 | 8501    6250.86 |   8501    6250.30
30000  1000 10000 | 8911    6791.97 |   8911    6788.51
32000    50   500 |  487    7494.39 |    487    7493.47
32050    50   500 |  486    7541.61 |    486    7541.05
32100    50   500 |  486    7589.02 |    486    7586.12
32150    50   500 |  492    7731.18 |    492    7728.76
32200    50   500 |  497    7854.59 |    497    7854.94
32250    50   500 |  490    7795.12 |    490    7783.10
32300    50   500 |  495    7909.77 |    495    7902.70
32350    50   500 |  495    7967.86 |    495    7946.20
32400    50   500 |  496    8018.98 |    496    7999.34
32450    50   500 |  492    7982.34 |    492    7962.93
32500    50   500 |  495    8060.97 |    495    8048.18
32550    50   500 |  498    8134.02 |    498    8122.08
32600    50   500 |  498    8171.97 |    498    8169.34
32650    50   500 |  498    8213.85 |    498    8209.95
32700    50   500 |  499    8267.67 |    499    8266.13
32751     1    10 |   10    8549.30 |     10    8629.00
32752     1    10 |   10    8556.10 |     10    8636.30
32753     1    10 |   10    8562.20 |     10    8632.00
32754     1    10 |   10    8564.40 |     10    8633.40
32755     1    10 |   10    8553.90 |     10    8635.40
32756     1    10 |   10    8553.00 |     10    8637.60
32757     1    10 |   10    8552.10 |     10    8640.90
32758     1    10 |   10    8557.20 |     10    8644.90
32759     1    10 |   10    8562.00 |     10    8644.10
32760     1    10 |   10    9336.60 |     10    9436.10
32761     1    10 |   10    9337.20 |     10    9435.60
32762     1    10 |   10    9340.70 |     10    9439.10
32763     1    10 |   10    9340.70 |     10    9433.60
32764     1    10 |   10    9340.00 |     10    9440.60
32765     1    10 |   10   10112.80 |     10   10228.40
32766     1    10 |   10   10893.50 |     10   11023.50
32767     1    10 |   10   11674.40 |     10   11813.70


--------------Boundary-00=_W8QKWF6GAWOQHBSXEPHI
Content-Type: application/x-tgz;
  name="gp.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gp.tar.gz"

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
LGc5y1m+/PIvJ5VKDgDIAAA=

--------------Boundary-00=_W8QKWF6GAWOQHBSXEPHI--

