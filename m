Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbRAXAJC>; Tue, 23 Jan 2001 19:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbRAXAIw>; Tue, 23 Jan 2001 19:08:52 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:22846 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130163AbRAXAIf>; Tue, 23 Jan 2001 19:08:35 -0500
Message-ID: <3A6E1C97.3B87EE00@sgi.com>
Date: Tue, 23 Jan 2001 16:06:47 -0800
From: Linda Walsh <law@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.17 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: barryn@pobox.com
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 disk speed 66% slowdown...
In-Reply-To: <200101232137.NAA02344@cx518206-b.irvn1.occa.home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we're on to something.  I did gen's of the kernel with
the following configs: 1) 2.2.17 (w/apm), 2) 2.4(w/apm), 3) 2.4(w/o apm).
The apm seems to be a red herring in terms of actual performance
hit.  It seems to count apm time as 'system' time instead of 'idle'.

Kernel gen times were:
1) real    6m33.046s, user    6m1.380s, sys     0m18.450s
2)         6m45s real         6m12s user        0m26s sys  
3) real    6m49.275s, user    6m14.740s, sys    0m26.690s

The REAL problem was in disk performance.  The apm made no difference:

hdparm -t /dev/hda1 /dev/hda3 /dev/hda4 /dev/hda5 /dev/hda7
1) 2.2.17
/dev/hda1: Timing buffered disk reads:  64 MB in  4.76 seconds = 13.45 MB/sec
/dev/hda3: Timing buffered disk reads:  64 MB in  4.57 seconds = 14.00 MB/sec
/dev/hda4: Timing buffered disk reads:  64 MB in  6.47 seconds =  9.89 MB/sec
/dev/hda5: Timing buffered disk reads:  64 MB in  5.08 seconds = 12.60 MB/sec
/dev/hda7: Timing buffered disk reads:  64 MB in  5.10 seconds = 12.55 MB/sec

2) 2.4 w/apm
/dev/hda1: Timing buffered disk reads:  64 MB in 16.03 seconds =  3.99 MB/sec
/dev/hda3: Timing buffered disk reads:  64 MB in 15.87 seconds =  4.03 MB/sec
/dev/hda4: Timing buffered disk reads:  64 MB in 15.67 seconds =  4.08 MB/sec
/dev/hda5: Timing buffered disk reads:  64 MB in 15.82 seconds =  4.05 MB/sec
/dev/hda7: Timing buffered disk reads:  64 MB in 15.85 seconds =  4.04 MB/sec

3) 2.4 w/o apm
/dev/hda1: Timing buffered disk reads:  64 MB in 16.02 seconds =  4.00 MB/sec
/dev/hda3: Timing buffered disk reads:  64 MB in 15.88 seconds =  4.03 MB/sec
/dev/hda4: Timing buffered disk reads:  64 MB in 15.67 seconds =  4.08 MB/sec
/dev/hda5: Timing buffered disk reads:  64 MB in 15.85 seconds =  4.04 MB/sec
/dev/hda7: Timing buffered disk reads:  64 MB in 15.86 seconds =  4.04 MB/sec   

Mine is on a ide1 device on a Dell Insp. 7500:
 hdparm -i /dev/hda (from 2.2.17)
 
/dev/hda:
 
 Model=IBM-DARA-225000, FwRev=SHAOA54A, SerialNo=SQASQ202564
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=3(DualPortCache), BuffSize=418kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=49577472
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2 mode3 mode4
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4


"Barry K. Nathan" wrote:
> Specifically, the following command read off the disk more slowly:
> 
> gzip -1 < /dev/hda | nc some_other_box some_port -w 1
...
-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
