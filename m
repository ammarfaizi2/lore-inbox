Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135968AbRAGVAB>; Sun, 7 Jan 2001 16:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136409AbRAGU7v>; Sun, 7 Jan 2001 15:59:51 -0500
Received: from inje.iskon.hr ([213.191.128.16]:37902 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S135762AbRAGU7n>;
	Sun, 7 Jan 2001 15:59:43 -0500
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Subtle MM bug
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 07 Jan 2001 21:59:37 +0100
Message-ID: <87k8879iyu.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get more familiar with the MM code in 2.4.0, as can be
seen from lots of questions I have on the subject. I discovered nasty
mm behaviour under even moderate load (2.2 didn't have troubles).

Things go berzerk if you have one big process whose working set is
around your physical memory size. Typical memory hoggers are good
enough to trigger the bad behaviour. Final effect is that physical
memory gets extremely flooded with the swap cache pages and at the
same time the system absorbs ridiculous amount of the swap space.
xmem is as usual very good at detecting this and you just need to
press Alt-SysReq-M to see that most of the memory (e.g. 90%) is
populated with the swap cache pages.

For instance on my 192MB configuration, firing up the hogmem program
which allocates let's say 170MB of memory and dirties it leads to
215MB of swap used. vmstat 1 shows that the pagecache size is
constantly growing - that is swapcache enlarging in fact - during the
second pass of the hogmem program.

...
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd  free buff  cache   si   so    bi    bo   in    cs  us  sy  id
 0  1  1 131488  1592  400  62384 4172 5188  1092  1298  353  1447   2   4  94
 0  1  1 136584  1592  400  67428 5860 4104  1465  1034  322  1327   3   3  93
 0  1  1 141668  1592  388  72536 5504 4420  1376  1106  323  1423   1   3  95
 0  1  1 146724  1592  380  77592 5996 4236  1499  1060  335  1096   2   3  94
 0  1  1 151876  1600  320  82764 6264 3712  1566   936  327  1226   3   4  93
 0  1  1 157016  1600  320  87908 5284 4268  1321  1068  315  1248   1   2  96
 1  0  0 157016  1600  308  87792 1836 5168   459  1293  281  1324   3   3  94
 0  1  0 162204  1600  304  92892 7784 5236  1946  1315  385  1353   3   5  92
 0  1  0 167216  1600  304  97780 3496 5016   874  1256  301  1222   0   2  97
 0  1  1 177904  1608  284 108276 5160 5168  1290  1300  330  1453   1   4  94
 0  1  2 182008  1588  288 112264 4936 3344  1268   838  293   801   2   3  95
 0  2  1 183620  1588  260 114012 3064 1756   830   445  290   846   0  15  85
 0  2  2 185384  1596  180 115864 2320 2620   635   658  285   722   1  29  70
 0  3  2 187528  1592  220 117892 2488 2224   657   557  273   754   3  30  67
 0  4  1 190512  1592  236 120772 2524 3012   725   760  343  1080   1  14  85
 0  4  1 195780  1592  240 125868 2336 5316   613  1331  381  1624   2   2  96
 1  0  1 200992  1592  248 131052 2080 2176   623   552  234  1044   3  23  74
 0  1  0 200996  1592  252 130948 2208 3048   580   762  256  1065  10  10  80
 0  1  1 206240  1592  252 136076 2988 5252   760  1314  309  1406   7   4  8
 0  2  1 211408  1592  256 141080 5424 5180  1389  1303  395  1885   3   5  91
 0  2  0 214744  1592  264 144280 4756 3328  1223   834  327  1211   1   5  95
 1  0  0 214868  1592  244 144468 4344 5148  1087  1295  303  1189  11   2  86
 0  1  1 214900  1592  248 144496 4360 3244  1098   812  318  1467   7   4  89
 0  1  1 214916  1592  248 144520 4280 3452  1070   865  336  1602   3   3  94
 0  1  1 214964  1592  248 144580 4972 4184  1243  1054  368  1620   3   5  92
 0  2  2 214956  1592  272 144548 3700 4544  1081  1142  665  2952   1   1  98
 0  1  0 214992  1592  272 144588 1220 5088   305  1274  282  1363   1   4  95
 0  1  1 215012  1592  272 144600 3640 4420   910  1106  325  1579   3   2  9

Any thoughts on this?
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
