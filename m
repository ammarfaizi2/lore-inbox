Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311864AbSCNXSW>; Thu, 14 Mar 2002 18:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311865AbSCNXSJ>; Thu, 14 Mar 2002 18:18:09 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22914 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311864AbSCNXRk>; Thu, 14 Mar 2002 18:17:40 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: "Rajan Ravindran" <rajancr@us.ibm.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] get_pid() performance fix
Date: Thu, 14 Mar 2002 18:18:35 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZQKZB94OUWGSP0WBQMM8"
Message-Id: <20020314231733.638C03FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZQKZB94OUWGSP0WBQMM8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

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

testprogram is attached:  
executed program example: getpid -c 2 -s 10 -e 100 -D 10 -t <0,1> 
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
22000  1000 10000 |    5177      3609.28 |  6944   3788.19 | 6389    3492.97 
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


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)


diff -urbN linux-2.5.7-pre1/kernel/fork.c linux-2.5.7-pre1pid/kernel/fork.c
--- linux-2.5.7-pre1/kernel/fork.c	Thu Mar  7 21:18:12 2002
+++ linux-2.5.7-pre1pid/kernel/fork.c	Thu Mar 14 16:03:23 2002
@@ -125,24 +125,101 @@
 /* Protects next_safe and last_pid. */
 spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
 
+/* this should be provided in every architecture */
+#ifndef SHIFT_PER_LONG
+#if BITS_PER_LONG == 64
+#   define SHIFT_PER_LONG 6
+#elif BITS_PER_LONG == 32
+#   define SHIFT_PER_LONG 5
+#else
+#error "SHIFT_PER_LONG"
+#endif
+#endif
+
+#define RESERVED_PIDS       (300)
+#define GETPID_THRESHOLD    (21000)  /* when to switch to a mapped algo */
+#define PID_MAP_SIZE        (PID_MAX >> SHIFT_PER_LONG)
+static unsigned long pid_map[PID_MAP_SIZE];
+static int next_safe = PID_MAX;
+
+static inline void mark_pid(int pid)
+{
+	pid_map[(pid) >> SHIFT_PER_LONG] |= (1 << ((pid) & (BITS_PER_LONG-1)));
+}
+
+static int get_pid_by_map(int last_pid) 
+{
+        struct task_struct *p;
+        int i;
+	int again = 1;
+	unsigned long mask;
+	int fpos;
+
+repeat:
+	for_each_task(p) {
+		mark_pid(p->pid);
+		mark_pid(p->pgrp);
+		mark_pid(p->tgid);
+		mark_pid(p->session);
+	}
+
+	/* find next free pid */
+	i = (last_pid >> SHIFT_PER_LONG);
+	mask = pid_map[i] | (((last_pid & (BITS_PER_LONG-1)) << 1) - 1);
+	
+	while ((mask == ~0) && (++i < PID_MAP_SIZE)) 
+		mask = pid_map[i];
+	
+	if (i == PID_MAP_SIZE) { 
+		if (again) {
+			/* we didn't find any pid , sweep and try again */
+			again = 0;
+			memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
+			last_pid = RESERVED_PIDS;
+			goto repeat;
+		}
+		next_safe = RESERVED_PIDS;
+		return 0; 
+	}
+
+	fpos = ffz(mask);
+	i &= (PID_MAX-1);
+	last_pid = (i << SHIFT_PER_LONG) + fpos;
+
+	/* find next save pid */
+	mask &= ~((1 << fpos) - 1);
+
+	while ((mask == 0) && (++i < PID_MAP_SIZE)) 
+		mask = pid_map[i];
+
+	if (i==PID_MAP_SIZE) 
+		next_safe = PID_MAX;
+	else 
+		next_safe = (i << SHIFT_PER_LONG) + ffs(mask) - 1;
+	return last_pid;
+}
+
 static int get_pid(unsigned long flags)
 {
-	static int next_safe = PID_MAX;
 	struct task_struct *p;
-	int pid;
+	int pid,beginpid;
 
 	if (flags & CLONE_PID)
 		return current->pid;
 
 	spin_lock(&lastpid_lock);
+	beginpid = last_pid;
 	if((++last_pid) & 0xffff8000) {
-		last_pid = 300;		/* Skip daemons etc. */
+		last_pid = RESERVED_PIDS;		/* Skip daemons etc. */
 		goto inside;
 	}
 	if(last_pid >= next_safe) {
 inside:
 		next_safe = PID_MAX;
 		read_lock(&tasklist_lock);
+		if (nr_threads > GETPID_THRESHOLD) {
+			last_pid = get_pid_by_map(last_pid);
+		} else {
 	repeat:
 		for_each_task(p) {
 			if(p->pid == last_pid	||
@@ -151,9 +228,11 @@
 			   p->session == last_pid) {
 				if(++last_pid >= next_safe) {
 					if(last_pid & 0xffff8000)
-						last_pid = 300;
+							last_pid = RESERVED_PIDS;
 					next_safe = PID_MAX;
 				}
+					if(unlikely(last_pid == beginpid))
+						goto nomorepids;
 				goto repeat;
 			}
 			if(p->pid > last_pid && next_safe > p->pid)
@@ -162,6 +241,9 @@
 				next_safe = p->pgrp;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
+				if(p->tgid > last_pid && next_safe > p->tgid)
+					next_safe = p->tgid;
+			}
 		}
 		read_unlock(&tasklist_lock);
 	}
@@ -169,6 +251,10 @@
 	spin_unlock(&lastpid_lock);
 
 	return pid;
+nomorepids:
+	read_unlock(&tasklist_lock);
+	spin_unlock(&lastpid_lock);
+	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)

--------------Boundary-00=_ZQKZB94OUWGSP0WBQMM8
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="getpid1.c"
Content-Transfer-Encoding: 8bit
Content-Description: Test Program
Content-Disposition: attachment; filename="getpid1.c"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/time.h>
#include <unistd.h>   
#include <sys/sysinfo.h>
#include <asm/bitops.h>

int SEARCH;

#define spin_lock(x)
#define spin_unlock(x)
#define read_lock(x)
#define read_unlock(x)
#define unlikely(x)	(x)
#define SET_LINKS(p) do {			\
	(p)->next_task = &init_task;		\
	(p)->prev_task = init_task.prev_task;	\
	init_task.prev_task->next_task = (p);	\
	init_task.prev_task = (p);		\
} while (0)
#define REMOVE_LINKS(p) do {				\
	(p)->next_task->prev_task = (p)->prev_task;	\
	(p)->prev_task->next_task = (p)->next_task;	\
} while (0)
#define CLONE_PID	0x00001000	/* set if pid shared */
#define PID_MAX		0x8000
#define THRES_VALUE     threshold
#define MAX_TASKS       (PID_MAX-1)
#define RESERVED_PIDS   reserved

#define for_each_task(p) \
	for (p = &init_task ; (p = p->next_task) != &init_task ; )

struct task_struct {
	struct task_struct *next_task, *prev_task;
	pid_t pid;
	pid_t pgrp;
	pid_t session;
	pid_t tgid;
	int did_exec;
};

struct task_struct init_task = {
	next_task: 	&init_task,
	prev_task: 	&init_task,
	pid:		0,
	pgrp:		0,
	session:	0,
	tgid:		0,
	did_exec:	0,
};
struct task_struct *current = &init_task;
static pid_t last_pid = 0;
static int next_safe = PID_MAX;
int nr_threads;
int threshold = 0;
int reserved = 1; /* need to keep 0 */
int verbose;

#define BITS_PER_LONG  32  /* no in the kernel !! */

#ifndef SHIFT_PER_LONG
#if BITS_PER_LONG == 64
#   define SHIFT_PER_LONG 6
#elif BITS_PER_LONG == 32
#   define SHIFT_PER_LONG 5
#else
#error "SHIFT_PER_LONG"
#endif
#endif

#define PID_MAP_SIZE (PID_MAX >> SHIFT_PER_LONG)
static unsigned long pid_map[PID_MAP_SIZE];

static inline void mark_pid(int pid)
{
	pid_map[(pid) >> SHIFT_PER_LONG] |= (1 << ((pid) & (BITS_PER_LONG-1)));
}

static int get_pid_by_map(int last_pid) 
{
        struct task_struct *p;
        int i, end;
	int again = 1;
	unsigned long mask, fpos;

#if 0
	/* testing version <algo-1> ... won't pay off */
	memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
	again = 0;
	last_pid = RESERVED_PIDS;
#endif

repeat:
	for_each_task(p) {
		mark_pid(p->pid);
		mark_pid(p->pgrp);
		mark_pid(p->tgid);
		mark_pid(p->session);
	}

	/* find next free pid */
	i = last_pid >> SHIFT_PER_LONG;
	mask = pid_map[i] | (((last_pid & (BITS_PER_LONG-1)) << 1) - 1);
	
	while ((mask == ~0) && (++i < PID_MAP_SIZE)) 
		mask = pid_map[i];
	
	if (i == PID_MAP_SIZE) { 
		if (again) {
			/* we didn't find any pid , sweep and try again */
			again = 0;
			memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
			last_pid = RESERVED_PIDS;
			goto repeat;
		}
		next_safe = RESERVED_PIDS;
		return 0; 
	}

	fpos = ffz(mask);
	i &= (PID_MAX-1);
	last_pid = (i << SHIFT_PER_LONG) + fpos;

	/* find next save pid */
	mask &= ~((1 << fpos) - 1);

#if 0
	/* testing to see whether interval max size brings 
	 * benefits
	 */
	end = last_pid + 8;
	if (end > PID_MAP_SIZE) 
#endif
		end = PID_MAP_SIZE;
	while ((mask == 0) && (++i < end)) 
		mask = pid_map[i];

	if (i==PID_MAP_SIZE) 
		next_safe = PID_MAX;
	else 
		next_safe = (i << SHIFT_PER_LONG) + ffs(mask) - 1;
	return last_pid;
}

static int get_pid(unsigned long flags)
{
	struct task_struct *p;
	int pid, beginpid;

	if (flags & CLONE_PID)
		return current->pid;

	spin_lock(&lastpid_lock);
	beginpid = last_pid;
	if((++last_pid) & 0xffff8000) {
		beginpid = last_pid = RESERVED_PIDS;		/* Skip daemons etc. */
		goto inside;
	}
	if(last_pid >= next_safe) {
inside:
		next_safe = PID_MAX;
		read_lock(&tasklist_lock);
		SEARCH++;
		if (nr_threads > THRES_VALUE) {
			last_pid = get_pid_by_map(last_pid);
		} else {
			repeat:
				for_each_task(p) {
					if(p->pid == last_pid	||
					   p->pgrp == last_pid	||
					   p->tgid == last_pid	||
					   p->session == last_pid) {
						if(++last_pid >= next_safe) {
							if(last_pid & 0xffff8000)
								last_pid = RESERVED_PIDS;
							next_safe = PID_MAX;
						}
						if(unlikely(last_pid == beginpid))
							goto nomorepids;

						goto repeat;
					}
					if(p->pid > last_pid && next_safe > p->pid)
						next_safe = p->pid;
					if(p->pgrp > last_pid && next_safe > p->pgrp)
						next_safe = p->pgrp;
					if(p->tgid > last_pid && next_safe > p->tgid)
						next_safe = p->tgid;
					if(p->session > last_pid && next_safe > p->session)
						next_safe = p->session;
				}
		}	
		read_unlock(&tasklist_lock);
	}
	pid = last_pid;
	spin_unlock(&lastpid_lock);
	return pid;

nomorepids:
	read_unlock(&tasklist_lock);
	spin_unlock(&lastpid_lock);
	return 0;
}


static void fatal(char *msg,...)
{
	char buf[256];
	va_list ap;

	va_start(ap,msg);
	vsprintf(buf,msg,ap);
	va_end(ap);
	fprintf(stderr,"%s: %s\n", buf, strerror(errno));
	exit(1);
}


static struct task_struct  tasks[PID_MAX];
static struct task_struct *tasks_by_pid[PID_MAX];
static struct task_struct *tasks_free;

static struct task_struct *find_task_by_pid(pid_t pid)
{
	if (pid & ~(PID_MAX-1)) {
		fatal("find_task_by_pid");
		return NULL;
	}
	return tasks_by_pid[pid];
}

static struct task_struct *add_task(pid_t pid, pid_t pgrp, pid_t session,
				    pid_t tgid)
{
	static int initialized = 0;
	struct task_struct *tsk;

	if (!initialized) {
		int i;
		for ( i=0 ; i<PID_MAX ; i++) {
			tasks[i].next_task = tasks_free;
			tasks_free = &tasks[i];
		}
		initialized = 1;
	}
		
	tsk = tasks_free;
	
	if (tsk == NULL)
		fatal("add_task:  pid=%d:%d",pid,nr_threads);

	tasks_free = tasks_free->next_task;
	nr_threads++;
	tasks_by_pid[pid] = tsk;

	tsk->pid = pid;
	tsk->pgrp = pgrp;
	tsk->session = session;
	tsk->tgid = tgid;
	SET_LINKS(tsk);

	return tsk;
}

static void del_task(struct task_struct *tsk)
{
	nr_threads--;
	tasks_by_pid[tsk->pid] = NULL;
	REMOVE_LINKS(tsk);
	tsk->next_task = tasks_free;
	tasks_free = tsk;
}


void populate_all(int count, int fast)
{
	int i,pid;
	int oldthreshold = 0;
	int mode;

	if (count == 0) {
		mode = 0;
		count = MAX_TASKS;
	} else {
		mode = 1;
	}
      
	if (fast) { 
		/* use the new map version */
		oldthreshold = threshold; 
		threshold = 0; 
	}

	/* first allocate all PIDs available */
	for (i = 0; i < count; i++) {
		pid = get_pid(0);
		if (pid == 0) {
			if (mode) {
				printf("failed %d\n",i);
				continue;
			} else 
				break;
		}
		add_task(pid, pid, pid, pid);
		if ((verbose >= 3) && ((i % 1000) == 0)) 
			printf("add task %d  %d %d\n",i,pid, nr_threads);
	}
	if (fast) { 
		/* return to global setting */
		threshold = oldthreshold; 
	}
}

int delete_range(int spid, int epid)
{
	int i;
	struct task_struct *tsk;
	
	for(i=spid; i<=epid; i++) {
		if ((tsk = find_task_by_pid(i))) 
			del_task(tsk);
	}
	return epid-spid+1;
}

int delete_random(int cnt)
{
	int delcnt = 0;
	int coll=0;
	while ((delcnt < cnt) && (nr_threads > RESERVED_PIDS)) {
		struct task_struct *tsk;
		int rnums = random() & (PID_MAX-1);
		if ((rnums < RESERVED_PIDS) || ((tsk = find_task_by_pid(rnums)) == NULL))
		{
			coll++;
			continue;
		}
		del_task(tsk); 
		delcnt++; 
		if ((verbose >= 3) && ((delcnt % 1000) == 0))
			printf("\t del %d\n",delcnt);
	}
	return delcnt;
}

static inline void difftime(struct timeval *dtime, struct timeval *stime, struct timeval *etime)
{
	dtime->tv_sec = etime->tv_sec - stime->tv_sec;
	if (etime->tv_usec < stime->tv_usec) {
		dtime->tv_usec = 1000000 - stime->tv_usec + etime->tv_usec;
		dtime->tv_sec--;
	} else
		dtime->tv_usec = etime->tv_usec - stime->tv_usec;
}


static inline void addtime(struct timeval *rtime, struct timeval *dtime)
{
	rtime->tv_sec += dtime->tv_sec;
	if ((rtime->tv_usec += dtime->tv_usec) >= 1000000) {
		rtime->tv_usec -= 1000000;
		rtime->tv_sec++;
	}
}

int runtest1(int rnums[], int cnt, struct timeval *response)
{
	int i,delcnt;
	struct timeval stime, etime, ttime;
	struct task_struct *tsk;

	/* first delete */
	delcnt = 0;
	for ( i=0 ; i<cnt ; i++ ) {
		if (rnums[i] < RESERVED_PIDS) continue;
		tsk = find_task_by_pid(rnums[i]);
		if (tsk) { del_task(tsk); delcnt++; }
	}

	gettimeofday(&stime, (struct timezone *) 0); 
	for ( i=0 ; i<delcnt ; i++ ) {
		int pid = get_pid(0);
		if (pid == 0) {
			printf("failed %d\n",i);
			continue;
		}
		add_task(pid, pid, pid, pid);
	}
	gettimeofday(&etime, (struct timezone *) 0); 
	difftime(&ttime,&etime,&stime);
	addtime(response,&ttime);
	return delcnt;
}

void runtest2(int start, int end, int incr, int dels)
{
	int i,j;
	struct timeval ttime;
	int cnt;
	int aveth;

	/* first create some randomness:
	 *   a few loops delete random and refill some 
	 */	
#if 1
	populate_all(0,1);
	for (i=0;i<2;i++) {
		int n;
		if (verbose >= 2) printf("P%d\n",i);
		n = delete_random(PID_MAX/4);
		populate_all(n-1000,1);
	}
#endif	
	
	/* now delete until we get to the aveth */
	for (aveth = start ; aveth < end ; aveth += incr) {
		struct timeval response = {0,0};
		int tsearch = 0;
		int talloc  = 0;
		double avtime;

		populate_all(0,1); /* fill all remaining */
		cnt = delete_random(PID_MAX-aveth);

		for ( j=0 ; j< 10 ; j++) {
			struct timeval stime, etime;
			int delcnt = delete_random(dels);
			
			SEARCH = 0;
			gettimeofday(&stime, (struct timezone *) 0); 
			for ( i=0 ; i<delcnt ; i++ ) {
				int pid = get_pid(0);
				if (pid == 0) {
					printf("failed %d\n",i);
					continue;
				}
				add_task(pid, pid, pid, pid);
				talloc++;
			}
			gettimeofday(&etime, (struct timezone *) 0); 
			difftime(&ttime,&stime,&etime);
			addtime(&response,&ttime);
			tsearch += SEARCH;
			if (verbose >= 1) 
				printf("next_phase %d %5d %5d %5d  %ld:%06ld\n",
				       j,SEARCH,delcnt, nr_threads,
				       ttime.tv_sec, ttime.tv_usec);
		}
		avtime = ((1.0E+6*response.tv_sec) + 
			   (double)response.tv_usec) / (double)talloc;
			       
		printf("%5d %5d %5d %5d %d %ld:%06ld %10.2lf\n",
		       aveth,dels,talloc,tsearch,(threshold>0),
		       response.tv_sec,response.tv_usec, avtime
		       );
	}
}

int main(int argc, char *argv[])
{
	int i,cnt,c;
	pid_t pid=0;
	pid_t pgrp=0;
	struct task_struct *tsk = NULL;
	int si,sv;
	int testcase = 2;
	struct timeval response,stime,etime,ttime;
	int startth, endth, incth, dels;

	startth = endth = incth = dels = 1000;
	
        while ((c = getopt(argc, argv, "s:e:i:d:t:c:v:r:")) != -1) {
		switch (c) {
		case 's': startth   = atoi(optarg); break;
		case 'e': endth     = atoi(optarg); break;
		case 'i': incth     = atoi(optarg); break;
		case 'd': dels      = atoi(optarg); break;
		case 't': threshold = atoi(optarg); break;
		case 'c': testcase  = atoi(optarg); break;
		case 'v': verbose   = atoi(optarg); break;
		case 'r': reserved  = atoi(optarg); break;
		}
	}
	if (threshold) threshold = (1<<20);
	if ((reserved < 1) || (reserved > 1000)) 
		fatal("bad reserved %d\n",reserved);

	response.tv_sec = response.tv_usec = 0;
	switch (testcase) {
	case 0:
		populate_all(MAX_TASKS,1);
		cnt = 0;
		cnt += delete_range(300,337);
		cnt += delete_range(1037,1097);
		cnt += delete_range(32723,32767);
		
		/* fork() */
		printf("allocate more %d\n",cnt);
		si = -1; sv=-1;
		for (i=0; i<cnt; i++) {
			pid = get_pid(0);
			if (pid == 0) {
				printf("failed %d\n",i);
				continue;
			}
			if (si == -1) {
				si = pid;
				sv = pid;
			} else {
				if (pid != sv+1) {
					printf("%d - %d\n",si,sv);
					si = pid;
				}
				sv = pid;
			}
			add_task(pid, pid, pid, pid);
		}
		printf("%d - %d\n",si,sv);
		break;

	case 1:
		threshold = 0;
		while (1) {
			const int NUM=100;
			int rnums[NUM];
			int num;
			for (i=0;i<NUM;i++)
				rnums[i] = random() & (PID_MAX-1);
			
			num = runtest1(rnums,NUM,&response);
			printf("%5d %ld:%06ld\n",num,
			       response.tv_sec,response.tv_usec);
		}
		break;

	case 2:
		SEARCH=0;
		runtest2(startth,endth,incth,dels);
		break;

	case 3:
		gettimeofday(&stime, (struct timezone *) 0); 
		pid = get_pid(0);
		add_task(pid, pid, pid, pid);
		printf("new pid: %d, 300: pid %d, pgrp %d\n",
		       pid, tsk->pid, tsk->pgrp);
		/* exit() */
		tsk = find_task_by_pid(300);
		del_task(tsk);
		/* fork() */
		pid = get_pid(0);
		add_task(pid, pgrp, pid, pid);
		printf("new pid: %d, 300: pid %d, pgrp %d\n",
		       pid, tsk->pid, tsk->pgrp);
		/* exit() */
		tsk = find_task_by_pid(301);
		del_task(tsk);
		
		/* fork() */
		pid = get_pid(0);
		add_task(pid, pgrp, pid, pid);
		printf("new pid: %d, 300: pid %d, pgrp %d\n",
		       pid, tsk->pid, tsk->pgrp);
		
		tsk = find_task_by_pid(300);
		gettimeofday(&etime, (struct timezone *) 0); 
		difftime(&ttime,&stime,&etime);
		addtime(&response,&ttime);
		printf("new pid: %d, 300: pid %d, pgrp %d, time:%ld:%ld sec\n",
		       pid, tsk->pid, tsk->pgrp, response.tv_sec,response.tv_usec);
		break;
		
	default: 
		printf("Unknown testcase %d\n",testcase);
		break;
	}
	return 0;
}


--------------Boundary-00=_ZQKZB94OUWGSP0WBQMM8--
