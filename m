Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbTDCPeP>; Thu, 3 Apr 2003 10:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbTDCPeP>; Thu, 3 Apr 2003 10:34:15 -0500
Received: from mail.explainerdc.com ([212.72.36.220]:29331 "EHLO
	mail.explainerdc.com") by vger.kernel.org with ESMTP
	id <S261218AbTDCPeJ> convert rfc822-to-8bit; Thu, 3 Apr 2003 10:34:09 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RAID 5 performance problems
Date: Thu, 3 Apr 2003 17:45:34 +0200
Message-ID: <73300040777B0F44B8CE29C87A0782E101FA97B2@exchange.explainerdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID 5 performance problems
Thread-Index: AcL5+BBkv/oXT2fhRtuc8Dy9eqhFXw==
From: "Jonathan Vardy" <jonathan@explainerdc.com>
To: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having trouble with getting the right performance out of my software
raid 5 system. I've installed Red Hat 9.0 with kernel 2.4.20 compiled
myself to match my harware (had the same problem with the default
kernel). When I test the raid device's speed using 'hdparm -Tt /dev/hdx'
I get this:

/dev/md0:
Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28 MB/sec
Timing buffered disk reads:  64 MB in  2.39 seconds = 26.78 MB/sec

Using bonny I get similar speeds (complete info further below):
Write 13668 K/sec, CPU load = 35%
Read  29752 K/sec, CPU load = 45%

This is really low for a raid system and I can't figure out what is
causing this. I use rounded cables but I also tried the original Promise
cables and there was no difference in performance. I've set the
parameters for hdparm so that the harddrives are optmised = 'hdparm -a8
-A1 -c1 -d1 -m16 -u1 /dev/hdc' which results in these settings:

 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 14593/255/63, sectors = 234441648, start = 0

But still the raid performs slow. Does anybody have an idea how I could
improve the performance? I've seen raid systems like my own performing
much better (speeds of around 80MB/sec). I've added as many specs as I
could find below so you can see what my configuration is.

cat /proc/mdstat gives: 

Personalities : [raid0] [raid5] 
read_ahead 1024 sectors
md0 : active raid5 hdk1[4] hdi1[3] hdg1[2] hde1[1] hdc1[0]
      468872704 blocks level 5, 128k chunk, algorithm 0 [5/5] [_UUUU]
unused devices: <none>

The hardware in the machine is as following:

Maiboard   	: Asus P2B-d dual PII slot 1 with latest bios update
Processors 	: 2x Intel PII 350Mhz
Memory     	: 512MB SDRam 100Mhz ECC
Controller 	: Promise FastTrak100 TX4 with latest firmware update
Boot HD	: Maxtor 20GB 5400rpm
Raid HD's	: 5x WDC1200BB 120GB 7200rpm ATA100

4 of the raid HD's are connected to the Promise controller and the other
raid HD is master on the second onboard IDE channel (udma2/ATA33)

Here are the speeds found using 'hdparm -Tt /dev/hdx'

hda (boot on onboard ATA33)
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  4.33 seconds = 14.78
MB/sec

hdc (raid on onboard ATA33)
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  4.56 seconds = 14.04
MB/sec

hde (raid on promise )
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.42 seconds = 26.45
MB/sec

hdg (raid on promise )
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.43 seconds = 26.34
MB/sec

hdi (raid on promise )
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.41 seconds = 26.56
MB/sec

hdk (raid on promise )
	Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28
MB/sec
	Timing buffered disk reads:  64 MB in  2.42 seconds = 26.45
MB/sec

As you see /dev/hdc is on the onboard IDE channel. Tos be certain that
this was not the bottleneck, I removed it from the raid so that is runs
in degraded mode. This did not change the performance much. Rebuild
speed is laso very slow, it is round 6MB/sec.

The drives originally came from a friend's file server where they were
also employed in a raid configuration. I've compared my results in
Bonny++ to his results:

My raid:

Version  1.03       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
/sec %CP
store.datzegik.c 1G  3712  99 13668  37  6432  28  3948  96 29752  45
342.8   6
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
/sec %CP
                 16   318  91 +++++ +++ 13157 100   351  98 +++++ +++
1332  92
store.datzegik.com,1G,3712,99,13668,37,6432,28,3948,96,29752,45,342.8,6,
16,318,91,+++++,+++,13157,100,351,98,+++++,+++,1332,92

His raid:

---raid0 5*120gb sw raid:

Version 1.02c       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
/sec %CP
storagenew.a2000 1G 19931  99 99258  73 61688  31 23784  98 178478  41
616.9   2
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
/sec %CP
                 16  1966  96 +++++ +++ +++++ +++  2043  99 +++++ +++
5518  99
storagenew.a2000.nu,1G,19931,99,99258,73,61688,31,23784,98,178478,41,616
.9,2,16,1966,96,+++++,+++,+++++,+++,2043,99,+++++,+++,5518,99


His machine has dual P Xeon 2000Mhz processors but that shouldn't be the
reason that the results are so different. My processor isn't at 100%
while testing. Even his older system which had 80gig drives and dual
500Mhz processors is much faster:

---raid5 6*80gb sw raid:
Version 1.02c       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
/sec %CP
storage.a2000.nu 2G  7935  98 34886  35 15362  25  8073  97 71953  53
180.1   2
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
/sec %CP
                 16   711 100 +++++ +++ +++++ +++   710  99 +++++ +++
2856 100
storage.a2000.nu,2G,7935,98,34886,35,15362,25,8073,97,71953,53,180.1,2,1
6,711,100,+++++,+++,+++++,+++,710,99,+++++,+++,2856,100

Yours sincerely, Jonathan Vardy
