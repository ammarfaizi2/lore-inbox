Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312871AbSCVWNp>; Fri, 22 Mar 2002 17:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312868AbSCVWN3>; Fri, 22 Mar 2002 17:13:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55247 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312871AbSCVWNX>; Fri, 22 Mar 2002 17:13:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, davej@suse.de,
        marcelo@cnectiva.com.br
Subject: [PATCH] get_pid() performance fix
Date: Fri, 22 Mar 2002 17:14:03 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "Rajan Ravindran" <rajancr@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com> <20020315183610.212993FE06@smtp.linux.ibm.com> <87zo19jdu7.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020322221318.5F6083FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I implemented an alternative version of getpid, that for large thread counts
( > 220000), provides "significantly" better performance as shown in attached
performance analysis. This is particulary viable for PID_MAX=32768.
Note under the current algorithm, allocating the last pid will take 32 
seconds (!!!) on a 500MHZ P-III.
I addressed the correctnes issue that Hirofumi brought up with the last 
submission (now test case "-c 4")
Attached patch is against 2.5.7.

-- Hubertus Franke <frankeh@watson.ibm.com>

------------------------------------------------------------------------------

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
This is <algo-2>. Here I omit the results, as they have only shown 
improvements for the very last few pids.

I dragged the various algorithms into a userlevel test program to figure
out where the cut off points are with PID_MAX=32768. In this testprogram
I maintain <TH> tasks, and for 10 rounds (delete <DEL> random tasks and 
reallocate <DEL> tasks again) resulting in T=10*D total measured allocations.

Si states how many interval searches where needed for algo-i.
Gi states the average overhead per get_pid for algo-i in usecs.

Based on that one should use the current algorithm until ~ 22-25K tasks and
beyond that use algo-2. Only the last 15 tasks are a bit faster under algo-1.
We can safely ignore that case.

Based on that providing an adaptive implementation seems the right choice.
The patch for 2.5.7 is attached.


executed program example: getpid -c 2 -s 10 -e 100 -D 10 -t <0,1> 
        0 is old 1 is new algo 2.

TH:  average thread count in system
DEL: number of randomly deleted threads and then reallocated
TAL: total number of getpid invocation
C-NEW: number of times search was invoked 
T-NEW: per getpid() overhead
C-OLD: number of times search was invoked 
T-OLD: per getpid() overhead


   TH   DEL   TAL |   C-NEW       T-NEW |   C-OLD       T-OLD
   10    10    80 |      1        0.79  |      1        0.41
   20    10   100 |      1        0.56  |      1        0.36
   30    10   100 |      1        0.56  |      1        0.38
   40    10   100 |      1        0.58  |      1        0.42
   50    10   100 |      1        0.59  |      1        0.43
   60    10   100 |      2        0.84  |      2        0.52
   70    10   100 |      1        0.72  |      1        0.43
   80    10   100 |      1        0.72  |      1        0.48
  100    50   500 |      2        0.38  |      2        0.27
  150    50   500 |      4        0.56  |      3        0.32
  200    50   500 |      5        0.79  |      4        0.40
  250    50   500 |      6        1.03  |      2        0.35
  300    50   500 |      9        1.68  |      2        0.38
  350    50   500 |      6        1.47  |      4        0.58
  400    50   500 |     10        2.54  |      8        1.05
  450    50   500 |      7        2.10  |      7        1.02
  500    50   500 |      7        2.32  |      4        0.75
  550    50   500 |      9        3.13  |      5        0.95
  600    50   500 |     14        5.14  |      6        1.18
  650    50   500 |     13        5.23  |      9        1.79
  700    50   500 |     10        4.35  |      9        1.87
  750    50   500 |     15        6.91  |      8        2.02
  800    50   500 |     12        5.98  |      8        1.95
  850    50   500 |     13        6.85  |      9        2.29
  900    50   500 |     27       14.55  |     18        4.46
 1000  1000  9980 |      1        0.21  |      1        0.21
 2000  1000 10000 |    322       14.36  |     76        2.03
 3000  1000 10000 |    606       46.10  |    161        6.63
 4000  1000 10000 |    901       97.58  |    359       18.87
 5000  1000 10000 |   1165      164.19  |    539       38.75
 6000  1000 10000 |   1498      266.58  |    724       66.96
 7000  1000 10000 |   1835      396.91  |   1026      122.35
 8000  1000 10000 |   2084      531.83  |   1228      179.70
 9000  1000 10000 |   2489      746.99  |   1516      264.16
10000  1000 10000 |   2763      946.99  |   1818      375.22
11000  1000 10000 |   3095     1199.73  |   2093      502.47
12000  1000 10000 |   3277     1422.02  |   2305      648.17
13000  1000 10000 |   3711     1776.28  |   2680      854.89
14000  1000 10000 |   3878     2033.30  |   2959     1061.61
15000  1000 10000 |   4301     2452.35  |   3167     1266.78
16000  1000 10000 |   4485     2757.00  |   3466     1554.22
17000  1000 10000 |   4844     3210.19  |   3743     1857.74
18000  1000 10000 |   5218     3681.90  |   4069     2247.13
19000  1000 10000 |   5501     4118.69  |   4293     2605.90
20000  1000 10000 |   5770     4594.99  |   4616     3095.39
21000  1000 10000 |   6161     5172.44  |   4974     3686.87
22000  1000 10000 |   6389     5637.80  |   5177     4258.81
23000  1000 10000 |   6665     6191.73  |   5483     4949.61
24000  1000 10000 |   6982     6777.02  |   5838     5831.25
25000  1000 10000 |   7209     7318.15  |   6183     6905.34
----------------> Break even range <------------------------
26000  1000 10000 |   7533     7954.33  |   6413     7955.66
27000  1000 10000 |   7959     8749.97  |   6748     9444.79
28000  1000 10000 |   8140     9302.36  |   7139    11617.75
29000  1000 10000 |   8501    10085.77  |   7638    14960.53
30000  1000 10000 |   8911    10946.80  |   8178    19584.24
32000    50   500 |    487    12265.89  |    486    94498.36
32050    50   500 |    486    12314.17  |    486    95832.03
32100    50   500 |    486    12389.38  |    488   108895.28
32150    50   500 |    492    12599.58  |    484   111742.39
32200    50   500 |    497    12792.36  |    491   124440.45
32250    50   500 |    490    12659.33  |    490   134499.09
32300    50   500 |    495    12843.78  |    489   145873.72
32350    50   500 |    495    12915.18  |    493   158940.66
32400    50   500 |    496    12988.64  |    494   183092.45
32450    50   500 |    492    12924.86  |    490   196135.28
32500    50   500 |    495    13043.85  |    488   223226.98
32550    50   500 |    498    13164.09  |    495   265431.10
32600    50   500 |    498    13222.56  |    495   326363.36
32650    50   500 |    498    13279.90  |    497   441002.09
32700    50   500 |    499    13368.66  |    499   656269.52
32751     1    10 |     10    12836.40  |     10  4031660.40
32752     1    10 |     10    12831.70  |     10  4620214.70
32753     1    10 |     10    12832.60  |     10  4188605.70
32754     1    10 |     10    12837.60  |     10  2972975.40
32755     1    10 |     10    12835.90  |     10  4434635.70
32756     1    10 |     10    12833.80  |     10  3892058.30
32757     1    10 |     10    12839.10  |     10  5002365.30
32758     1    10 |     10    12840.20  |     10  6332786.20
32759     1    10 |     10    12840.20  |     10  5269462.90
32760     1    10 |     10    14127.80  |     10  8234780.40
32761     1    10 |     10    14134.90  |     10  7558043.20
32762     1    10 |     10    14129.70  |     10  9117119.40
32763     1    10 |     10    14134.70  |     10 13895498.10
32764     1    10 |     10    14140.10  |     10 13608972.90
32765     1    10 |     10    15427.30  |     10 12930469.20
32766     1    10 |     10    16708.30  |     10 23576610.90
32767     1    10 |     10    17997.90  |     10 32603396.10

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)

diff -urbN linux-2.5.7/kernel/fork.c linux-2.5.7-pid/kernel/fork.c
--- linux-2.5.7/kernel/fork.c	Mon Mar 18 15:37:05 2002
+++ linux-2.5.7-pid/kernel/fork.c	Fri Mar 22 16:38:29 2002
@@ -125,24 +125,111 @@
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
+#define GETPID_THRESHOLD    (26000)  /* when to switch to a mapped algo */
+#define PID_MAP_SIZE        (PID_MAX >> SHIFT_PER_LONG)
+static unsigned long pid_map[PID_MAP_SIZE];
+static int next_safe = PID_MAX;
+
+static inline void mark_pid(int pid)
+{
+	__set_bit(pid,pid_map);
+}
+
+static int get_pid_by_map(int lastpid) 
+{
+	static int mark_and_sweep = 0;
+
+	int round = 0;
+        struct task_struct *p;
+        int i;
+	unsigned long mask;
+	int fpos;
+
+
+	if (mark_and_sweep) {
+repeat:
+		mark_and_sweep = 0;
+		memset(pid_map, 0, PID_MAP_SIZE * sizeof(unsigned long));
+		lastpid = RESERVED_PIDS;
+	}
+	for_each_task(p) {
+		mark_pid(p->pid);
+		mark_pid(p->pgrp);
+		mark_pid(p->tgid);
+		mark_pid(p->session);
+	}
+
+	/* find next free pid */
+	i = (lastpid >> SHIFT_PER_LONG);
+	mask = pid_map[i] | (((lastpid & (BITS_PER_LONG-1)) << 1) - 1);
+	
+	while ((mask == ~0) && (++i < PID_MAP_SIZE)) 
+		mask = pid_map[i];
+	
+	if (i == PID_MAP_SIZE) { 
+		if (round == 0) {
+			round = 1;
+			goto repeat;
+		}
+		next_safe = RESERVED_PIDS;
+		mark_and_sweep = 1;  /* mark next time */
+		return 0; 
+	}
+
+	fpos = ffz(mask);
+	i &= (PID_MAX-1);
+	lastpid = (i << SHIFT_PER_LONG) + fpos;
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
+	return lastpid;
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
+			if (unlikely(last_pid == 0)) {
+				last_pid = PID_MAX;
+				goto nomorepids; 
+			}
+		} else {
 	repeat:
 		for_each_task(p) {
 			if(p->pid == last_pid	||
@@ -151,9 +238,11 @@
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
@@ -162,6 +251,9 @@
 				next_safe = p->pgrp;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
+				if(p->tgid > last_pid && next_safe > p->tgid)
+					next_safe = p->tgid;
+			}
 		}
 		read_unlock(&tasklist_lock);
 	}
@@ -169,6 +261,10 @@
 	spin_unlock(&lastpid_lock);
 
 	return pid;
+nomorepids:
+	read_unlock(&tasklist_lock);
+	spin_unlock(&lastpid_lock);
+	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
