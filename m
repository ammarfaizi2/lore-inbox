Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJaWMS>; Wed, 31 Oct 2001 17:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRJaWMJ>; Wed, 31 Oct 2001 17:12:09 -0500
Received: from [209.195.52.30] ([209.195.52.30]:11530 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S273796AbRJaWLw>;
	Wed, 31 Oct 2001 17:11:52 -0500
From: David Lang <david.lang@digitalinsight.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Date: Wed, 31 Oct 2001 13:48:43 -0800 (PST)
Subject: 2.4.13 (and 2.4.5) performance drops under load and does not recover
In-Reply-To: <9rpks1$bk$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0110311211090.7434-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

symptoms: when the firewall is freshly booted it supports >200
connections/sec, when the firewall is hit with lots of simultanious
requests it slows down, after the flood of requests stops and the machine
sits idle it never recovers back to it's origional performance. I can
drive the performance down to <50 connections/sec permanently. The CPU
is eaten up more and more by the system, leaving less time for userspace.

the single threaded requests do outperform the massivly parallel test (as
can be expected as the scheduler isn't optimized for long runqueues :-) I
am not asking to optimize things for the large runqueue, just to be able
to recover after the long runqueue had finished.

killing and restarting the proxy does not fix the problem. The only way I
have discovered to resotre performance is a reboot of the firewall.

test setup:

client---firewall---server

all boxes are 1.2GHz athlon, 512MB ram, IDE drive, D-link quad ethernet,
2GB swap space (although it never comes close to useing it)

ethernet switches are cisco 3548

firewall is running 4 proxies, each proxy accepts incoming connections,
forks to handle that connection, relays the data to/from the server and
then exits. (yes I know this is not the most efficiant way to do things,
but this _is_ a real world use)

I did a vmstat 1 on the firewall during the test and exerpts from it are
listed below.

server is running apache (maxclients set to 250 after prior runs noted
that it ran up against the 150 limit)

client is running ab (apache benchmark tool)

testing procedure:

1. boot firewall

2. get performance data
run ab -n 400 firewall:port/index.html.en twice (first to get past
initalization delays, second to get a performace value)
This does 400 sequential connections and reports the time to get the
responses

3. flood the firewall
run 5 copies of ab -n 5000 -c 200 firewall:port/index.html.en
this does 5000 connections attempting to make up to 200 connections at a
time

4. wait for all the connections to clear on the firewall (at least,
possibly longer if I am in a meeting). The idea here is to return
everything to a stable mode.

5. run ab -n 400 firewall:port/index.html and record the connections/sec

loop back to 3.

after 4 iterations of load reboot the firewall and do two more runs of ab
-n 400 to make sure that performance is back up and the slowdown is not
due to large logfiles anywhere.

at the start of the test vmstat looks like this


ab -n 200 (219 connections/sec) this is two runs sequentially
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0 496744    604   8076   0   0     0     0  101    11   0   0 100
 1  0  1      0 496548    604   8124   0   0    48     0 3814  1759  36  41  24
 0  0  0      0 496588    604   8124   0   0     0     0 4007  1899  42  34  25
 0  0  0      0 496576    604   8128   0   0     0     0  103    16   0   0 100
 1  0  0      0 496452    604   8128   0   0     0     0  924   405  11   6  83
 2  0  0      0 496360    604   8128   0   0     0     0 4252  2015  41  40  20
 0  0  0      0 496492    604   8128   0   0     0     0 2628  1240  26  21  53
 0  0  0      0 496492    604   8128   0   0     0     0  101     7   0   0 100


5xab -n 5000 -c 200 (~210 connections/sec)
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
19  0  1      0 493192    604   8124   0   0     0     0 5938  1139  55  45   0
13  0  1      0 492980    604   8124   0   0     0     0 4956  1059  58  42   0
11  0  1      0 492692    604   8124   0   0     0     0 4878  1057  45  55   0
17  0  1      0 492900    604   8124   0   0     0     0 4890  1072  57  43   0
29  0  1      0 492572    604   8124   0   0     0     0 4648  1049  46  54   0
13  0  1      0 492608    604   8124   0   0     0     0 4650  1041  50  50   0
11  0  1      0 492484    604   8124   0   0     0     0 4645  1043  38  62   0
18  0  1      0 492472    604   8128   0   0     0     0 4779  1029  56  44   0
17  0  1      0 492440    604   8128   0   0     0     0 4691  1057  46  54   0
18  0  1      0 492476    604   8128   0   0     0     0 4598  1074  54  46   0
18  0  1      0 492488    604   8128   0   0     0     0 4625  1051  53  47   0
22  0  1      0 492388    604   8128   0   0     0     0 4661  1057  50  50   0
10  0  1      0 492448    604   8128   0   0     0     0 4569  1033  56  44   0
22  0  1      0 492364    604   8128   0   0     0     0 4589  1036  48  52   0
18  0  1      0 492384    604   8128   0   0     0     0 4536  1031  48  52   0
15  0  1      0 492236    604   8128   0   0     0     0 4528  1034  43  57   0
26  0  1      0 492132    604   8128   0   0     0     0 4554  1037  50  50   0
24  0  1      0 492016    604   8128   0   0     0     0 4518  1037  48  52   0

at the end of 4 runs

5xab -n 5000 -c 200 (~40 connections/sec)
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
23  0  1      0 482356    624   8524   0   0     0     0 1053   181   7  93   0
29  0  1      0 481724    624   8528   0   0     0     0  960   206   7  93   0
23  0  1      0 482300    624   8528   0   0     0     0 1059   176   5  95   0
30  0  1      0 482104    624   8528   0   0     0    72 1095   197   9  91   0
19  0  1      0 482760    624   8528   0   0     0     0 1014   179   5  95   0
31  0  1      0 481892    624   8528   0   0     0     0 1010   198   6  94   0
16  0  1      0 482488    624   8524   0   0     0     0 1001   176   8  92   0
29  0  1      0 482236    624   8524   0   0     0     0 1037   179   9  91   0
12  0  1      0 483008    624   8528   0   0     0     0 1182   188   8  92   0
25  0  1      0 482620    624   8528   0   0     0     0  988   173   8  92   0
19  0  1      0 482696    624   8528   0   0     0     0  931   173   7  93   0
20  0  1      0 482776    624   8528   0   0     0     0  985   171   9  91   0
20  0  1      0 482116    624   8528   0   0     0     0 1122   119   5  95   0
21  0  1      0 482888    624   8528   0   0     0     0  830   144   3  97   0
16  0  1      0 481916    624   8528   0   0     0     0 1054   155   9  91   0
18  0  1      0 482892    624   8528   0   0     0     0  875   143  12  88   0
20  0  1      0 483100    624   8528   0   0     0     0  875   146   7  93   0
27  0  1      0 482428    624   8528   0   0     0     0  859   153   6  94   0
26  0  1      0 482688    624   8528   0   0     0     0  874   151   8  92   0

ab -n 400 (~48 connections/sec) this is a single run
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0      0 483552    624   8544   0   0     0     0  103    13   0   0 100
 2  0  0      0 483388    624   8544   0   0     0     0  592   225  10  38  52
 1  0  0      0 483392    624   8544   0   0     0     0 1088   488  13  87   0
 2  0  0      0 483392    624   8544   0   0     0     0 1108   468  10  89   1
 1  0  0      0 483404    624   8548   0   0     0     0 1081   452   9  89   2
 1  0  0      0 483508    624   8548   0   0     0     0 1096   486   7  90   3
 2  0  1      0 483368    624   8548   0   0     0     0 1091   458  11  87   2
 1  0  0      0 483364    624   8548   0   0     0     0 1085   480  13  85   2
 1  0  0      0 483356    624   8552   0   0     0     0 1098   478   9  87   4
 0  0  0      0 483520    624   8548   0   0     0     0  796   330   9  59  32
 0  0  0      0 483520    624   8548   0   0     0     0  103    13   0   0 100

Please tell me what additional things I should try to identify what the
kernel is getting tied up doing.

I was able to duplicate this problem with 2.4.5 as well as 2.4.13. the
performance of 2.4.5 is ~4% lower then 2.4.13 in all cases.

David Lang
