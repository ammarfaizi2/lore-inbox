Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270496AbTHSOeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTHSOeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:34:25 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:41660 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270496AbTHSOc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:32:27 -0400
Subject: Strange (scheduler/vm?) starvations in latest 2.6 tree
From: Christophe Saout <christophe@saout.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061303543.4268.11.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 16:32:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some days ago after updating the kernel source from bkcvs my system
started behaving very strange. When compiling something (without make
-j) the mouse cursor sometimes got *very* jumpy and even hangs for some
time, also xmms likes to skip. It seems like the whole system freezes
for some time.

I've got Ingo's and Con's scheduler tweaks applied and they worked great
so far so I don't think they are the problem.

I've found that pdflush somehow seems to be involved. When these hangs
appear, top shows some processes in uninterruptible sleep (including
pdflush), and pdflush takes a lot of cpu time, like 15%.

The system doesn't swap, it has a lot of memory and is also quite fast.

vmstat -n 1 output is added below (the system didn't swap in or out a
single page so I've removed the columns that were entirey zero).

The hangs always show up when the bo number gets big. The only processes
running are X, xmms and the compiler, the problems show up without doing
anything special. 

The kernel is compiled with x86/athlon support, preemptible kernel,
local io-apic and acpi and runs on a via kt400 chipset.

procs-----memory----------  -----io---- --system-- ----cpu----
 r  b   free   buff  cache     bi    bo   in    cs us sy id wa
 3  1  48072  75336 228300     84   205 1276  1508 26  4 64  7
 2  0  48136  75372 228392     52    52 1150  1647 90 10  0  0
 6  2  59784  75376 228384      0  4476 1580  1103 60 40  0  0
 0  2  59784  75376 228384      0  1040 1368   726  2  1  0 97
 3  2  43464  75376 228404     16   652 1409  1624 43  4  0 53
 1  2  42248  75380 228548     68   668 1341  1477 87  8  0  5
 0  2  27224  75380 228552      4   328 1255   723 77  5  0 18
 0  3  59480  75380 228592      0  2452 1325   723 11  6  0 83
 0  3  59480  75380 228592      0   472 1267  1669  7  2  0 91
 4  1  49808  75388 228732    128  1608 1301  1430 43 12  0 45
 3  2  52624  75392 229220    444     0 1409  2726 89 11  0  0
 2  1  48400  75396 229556    276     0 1421  2619 85 15  0  0
 2  1  44936  75412 230344    468     0 1291  3516 76 17  0  6
 4  1  41072  75424 230900    512     0 1426  3178 90 10  0  0
 6  3  47216  75424 230944     40  3708 1569  1434 80 20  0  0
 1  4  34480  75424 230976      0   808 1309  1222 92  8  0  0
 0  5  33312  75424 231428      0   728 1619  1660 61  4  0 35
 3  0  37472  75428 231912     44   244 1251  2515 87 12  0  1
 3  0  40136  75432 232140    124     0 1431  2431 86 13  0  1
 2  1  33352  75440 232392    128     0 1632  3621 84 16  0  0
 4  0  38272  75440 232472    144     0 1369  2812 87 12  0  1
 4  1  38976  75444 233128    340     0 1724  2990 80 16  0  4
 6  2  30016  75448 233208     48  2888 1506  1607 91  9  0  0
 2  2  27712  75448 233212      8   992 1624  2378 95  5  0  0
 4  0  38336  75448 233264      8   172 1255  1778 93  7  0  0
 2  0  30016  75452 233428    136     0 1276  2325 91  9  0  0
 1  0  37216  75456 233472     28     0 1129  1926 88 12  0  0
 1  0  34016  75456 233636     16     0 1396  1774 92  8  0  0
 1  0  33000  75460 233832    100     0 1129  1694 86 11  0  3
 4  1  36200  75464 233912     64  2532 1392  1356 90 10  0  0
 1  1  32664  75464 233912      0   736 1545  1856 23  4  0 72
 2  0  21208  75464 232352      0   252 1324  1989 93  7  0  0

procs-----memory----------  -----io---- --system-- ----cpu----
 r  b   free   buff  cache     bi    bo   in    cs us sy id wa
 2  0   7024  76040 271172     85   240 1289  1533 27  4 61  7
 0  0   6960  76040 271300      0     0 1235  1557  0  0 100  0
 0  0   6960  76040 271300      0     0 1119  1551  1  0 99  0
 0  0   6992  76040 271300      0     0 1115  1539  0  0 100  0
 0  0   6992  76040 271300      0     0 1416  3066  9  2 89  0
 0  0   6992  76040 271300      0   108 1523  3338 12  4 84  0
 0  0   6992  76040 271300      0     0 1541  2773  7  2 91  0
 0  0   6864  76040 271428      0     0 1282  1639  1  0 99  0
 0  0   6864  76040 271428      0     0 1124  1581  0  0 100  0
 0  0   6864  76040 271428      0     0 1123  1633  1  0 99  0
 0  0   6864  76040 271428      0    44 1140  1843  0  1 98  1
 0  0   6856  76040 271428      0     0 1133  1696  1  1 98  0
 0  0   6728  76040 271556      0     0 1224  1676  1  0 99  0
 0  0   8456  76040 269868      8     0 1121  1633  1  1 98  0
 0  0   8456  76040 269868      0     0 1130  1725  1  0 99  0
 0  0   8464  76040 269868      0   100 1142  1736  1  1 98  0
 5  0   9160  76048 269096      4  3951 1676  1475  3  2 91  3
 0  0   9160  76048 269096      0    72 1209  1283  1  0 97  1
 0  0   9032  76048 269224      0     0 1253  1771  2  1 97  0
 0  0   9032  76048 269224      0     0 1136  1669  1  0 99  0
 0  0   9032  76048 269224      0    60 1132  1603  0  1 99  0
 2  0   6808  76052 268776     40     0 1125  1764 41 11 47  0
 1  0   6744  76056 268820      0     0 1115  1576 86 14  0  0
 2  0  13400  74948 264776      8     0 1216  1699 83 17  0  0
 1  0  13272  74948 264832      0     0 1115  1649 85 15  0  0
 0  2  13080  74952 264900      0  3976 1378   658 34 20  0 46
 0  2  12952  74952 264932      0   916 1316  1654  3  2  0 95
 1  1  11928  74960 265028      0   896 1322  1800 79 18  0  3
 2  0  12696  74960 265108      0     0 1245  1727 81 19  0  0
 1  0  12240  74964 260876      0     0 1211  1756 81 19  0  0
 1  0   6096  74964 264596      0     0 1115  1961 71 29  0  0
 1  0  11408  74964 264552      4     0 1265  2390 80 20  0  0
 1  0  13392  74976 264596      0     0 1128  2456 91  9  0  0
 0  3  12752  74976 265268      0  2680 1319  1098 76  6  0 18
 0  2  12880  74976 265328      0   420 1382  1586  5  1  0 94
 2  1   9744  75028 268256      8  2813 1649  1617 20 35  0 45
 0  1   9296  75548 268324      2   833 1498  2829  2 19  0 79
 1  0   8720  76064 268388      3   818 1499  2807  1 17  0 82
 1  2   8720  76268 267936      1  6467 1503  1578  8 18  0 74
 5  3   8608  76268 267936      0  8180 2206   991 15  9  0 77
 8  2   8352  76268 268064      0  6504 3534   677 34 16  0 50
 5  4   8432  76272 268064      0  5783 1555  1025  9  4  0 87
 4  3   8424  76276 268064      0  2305 1497   372 37 16  0 47
 1  0  12264  76284 264624      0     9 1233  1597 49 12  0 39
 0  0   9832  76312 268192      0     0 1216  3298 43 50  7  0
 0  0   9832  76312 268192      0     0 1123  1581  1  0 99  0

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

