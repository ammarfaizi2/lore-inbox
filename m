Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQKNATR>; Mon, 13 Nov 2000 19:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQKNATH>; Mon, 13 Nov 2000 19:19:07 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:34866 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129410AbQKNASu>; Mon, 13 Nov 2000 19:18:50 -0500
From: "LA Walsh" <law@sgi.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: IDE0 /dev/hda performance hit in 2217 on my HW - more info - maybe extended partitions
Date: Mon, 13 Nov 2000 15:47:27 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHCEJECJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <00111322024100.20267@dax.joh.cam.ac.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some further information in response to a private email, I did hdparm -ti
under both
2216 and 2217 -- they are identical -- this may be something weird
w/extended
partitions...

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3278/240/63, sectors = 49577472, start = 0

 Model=IBM-DARA-225000, FwRev=SHAOA50A, SerialNo=SQASQ023976
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=3(DualPortCache), BuffSize=418kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=49577472
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2 mode3 mode4
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3
ATA-4
---
Speed comparisons, 2216:
 Timing buffered disk reads:  64 MB in  4.61 seconds = 13.88 MB/sec
 Timing buffered disk reads:  64 MB in  4.65 seconds = 13.76 MB/sec
 Timing buffered disk reads:  64 MB in  4.69 seconds = 13.65 MB/sec
2217:
 Timing buffered disk reads:  64 MB in  4.59 seconds = 13.94 MB/sec
 Timing buffered disk reads:  64 MB in  4.63 seconds = 13.82 MB/sec
 Timing buffered disk reads:  64 MB in  4.56 seconds = 14.04 MB/sec

-------------

	After rebooting several times, I can get equally bad performance on both.
:-(

	Here's the key.  I read from /dev/hda, hda1, {hda4, hda5, hda6, hda7} hda3.

	The performance in reading from a, a1 and a3 is near or above 10M/s -- but
in the "Extended" partition, rates from 4-7 are all under 3M/s.  So what's
the
deal?  Why do extended partitions drop performance?  Here's the log.  Did
dd's if=device of=/dev/null, bs=128k count=1k.  Timings are interwoven with
vmstat
output:
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1  0  0   1928   3188 432352  10976   1   3  3111     3  183   424   3   6
91
 0  0  0   1928   3448 432352  10984   0   0     1     0  125   352   1   1
98
 0  0  0   1928   3356 432352  11016   0   0     1     3  107   180   0   0
99
/dev/hda
 1  0  0   1928   2068 433716  10984   0   0 12597     3  302   598   0  11
89
 1  0  0   1928   2196 433600  10972   0   0  6810     0  208   388   0   6
94
 0  1  0   1928   2132 433668  10968   0   0  8806     0  239   454   0  12
88
 0  1  0   1928   2132 433668  10968   0   0  5914     0  193   357   0   4
96
 2  0  0   1928   2100 430184  10484   0   0 12365     0  295   558   0  12
88
1024+0 records in
1024+0 records out
0.01user 2.31system 0:27.43elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda1
 0  2  0   2572   2120 426948  10268   0 129 11805    33  292   544   0  14
86
 0  1  0   2572   2940 422320  10268   0   0 10972     0  275   511   0  11
89
 1  0  0   2572   2660 419024  10268   0   0 10266     2  264   485   0   9
91
 0  1  0   2572   2052 418192  10268   0   0 11789     0  285   554   0  13
87
 2  0  0   2572   2176 418044  10296   0   0 13045     0  307   608   0  17
83
1024+0 records in
1024+0 records out
0.01user 2.83system 0:22.71elapsed 12%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda3
 1  0  0   2572   2048 418168  10296   0   0 14220     0  324   655   0  11
89
 0  1  0   2572   2180 418040  10296   0   0  7027     3  213   398   0   7
93
 0  1  0   2700   2116 418104  10424   0  26  8858     7  240   460   0  10
90
 1  0  0   2956   2112 418464  10288   0  51  9651    13  253   488   0  17
83
1024+0 records in
1024+0 records out
0.03user 2.65system 0:24.70elapsed 10%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda4
 2  1  0   2952   2736 417752  10424  26   0 13216     0  310   577   0  14
86
 1  0  0   2952   2192 419716  10544  26   0  2159     0  237   428   0   9
91
 1  0  0   2952   2808 419488  10484   0   0  2304     2  247   456   0   9
91
 1  0  0   2948   3092 420260  10476   0   0  2406     1  252   461   0   9
91
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1  0  0   2948   2304 421540  10476   0   0  2355     0  249   459   0   7
93
 2  0  0   2948   2588 421604  10476   0   0  2496     0  257   480   0   9
91
1024+0 records in
1024+0 records out
0.01user 2.12system 0:28.64elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda5
 1  0  0   2948   2340 423172  10476   0   0  2394     1  251   471   0   8
92
 1  0  0   3460   2596 425420   9988   0 102  2752    28  282   512   0  12
88
 1  0  0   3460   2868 427536   9988   0   0  3162     0  299   559   0  12
88
 1  0  0   3460   3088 428432   9988   0   0  3021     0  290   550   0  10
90
 2  0  0   3460   2192 430288   9988   0   0  3059     0  293   550   0  12
88
1024+0 records in
1024+0 records out
0.02user 2.27system 0:21.96elapsed 10%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda6
 0  1  0   3460   2192 430560   9988   0   0  2410     3  257   485   0   9
91
 1  0  0   3460   2180 431232   9988   0   0  3085     0  295   560   0  11
89
 1  0  0   3460   3068 430812   9988   0   0  2573     1  262   498   0   7
93
 1  0  0   3460   2068 432412   9988   0   0  3162     0  299   577   0  10
90
1024+0 records in
1024+0 records out
0.00user 2.01system 0:24.25elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
/dev/hda7
  2  0  0   3460   2176 432488   9988   0   0  2292     1  246   464   0   9
91
 1  0  0   3460   2196 432584   9988   0   0  2637     3  268   502   0  11
89
 1  0  0   3460   3100 431980   9992   0   0  2662     1  268   508   0  10
90
 0  1  0   3460   2192 433284   9992   0   0  2380     0  249   462   0   8
92
 1  0  0   3460   2184 433572   9992  11   0  1334     0  185   324   0   6
94
 2  0  0   3452   2176 434184  10044   2   0  2970     0  287   543   0  12
88
1024+0 records in
1024+0 records out
0.00user 2.32system 0:27.18elapsed 8%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (104major+76minor)pagefaults 0swaps
 1  0  0   3452   3028 433744  10044   0   0   794     0  151   256   0   3
97
 0  0  0   3452   3156 433616  10044   0   0     0     0  102   143   0   0
100
 0  0  0   3452   3132 433616  10044   0   0     0     0  114   241   1   0
99
 0  0  0   3452   3132 433616  10044   0   0     0     0  114   182   0   0
100

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
