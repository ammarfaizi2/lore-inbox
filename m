Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSLYLPd>; Wed, 25 Dec 2002 06:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266191AbSLYLPd>; Wed, 25 Dec 2002 06:15:33 -0500
Received: from m3.azalea.se ([217.75.96.207]:59305 "HELO m3.azalea.se")
	by vger.kernel.org with SMTP id <S266186AbSLYLPb>;
	Wed, 25 Dec 2002 06:15:31 -0500
Subject: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
From: Mikael Olenfalk <mikael@netgineers.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Netgineers
Message-Id: <1040815160.533.6.camel@devcon-x>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Dec 2002 12:19:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everybody,

I wish you all a nice Christmas and A Happy New Year!


Now to the stuff that matters (for me 8) ):

I recently bought 4 80G IDE disks which I considered to combine into a
software RAID (RAID5). The four discs are connected via a Promise
Ultra100 TX2 (driver: PDC202xx, PDC20268 - I believe ;) ). It all works
fine for me just that the data throughput (i.e. speed) has been very
varying.

I had an older 80G IDE disc (yet capable of UDMA5) which I wanted to
make a spare disk.

This is my configuration:

raiddev /dev/md0
        raid-level              5
        nr-raid-disks           4
        nr-spare-disks          1
        persistent-superblock   1
        parity-algorithm        left-symmetric
        chunk-size              64

        ## ALL NEW DISCS :)
        device                  /dev/hde
        raid-disk               0
        device                  /dev/hdf
        raid-disk               1
        device                  /dev/hdg
        raid-disk               2
        device                  /dev/hdh
        raid-disk               3

        ## GOOD, OLD, BRAVE DISC ;)
        device                  /dev/hdc
        spare-disk              0
        


Now to the funny part:

For some funny reason, a 2.4.20 kernel refuses to set the DMA-level on
the new disks (all connected to a UDMA5-capable Ultra100 TX2 controller)
to UDMA5,4,3 and settles it for UDMA2, which is the highest possibility
for the OLD onboard-controller (but NOT for the promise card). A recent
2.5.52 gives me :) UDMA5 on the new discs while (correctly) UDMA2 for
the old drive.

This is generally not a very big problem, I can live 8( with my new fine
discs only being used in UDMA2 (instead of 5).

After I initialized the array using 'mkraid /dev/md0' I open up 'while
true; do clear; cat /proc/mdstat; sleep 1; done' on one terminal to
watch the progress.

The first try I gave it was (very satisfying) giving me 15MB/sec at the
beginning. After about 30-40% the speed fell down to unsatisfying
100-200KB/sec (nothing CPU-intensive running besides raid5d).

I have been having problems with the older controller and I was not sure
about the throughput of the old drive, therefore I stopped the syncing,
stopped the raid and ran five synced (i.e. with a semaphore) bonnie++
processes to benchmark the discs, they all performed likely well (the
old one was a little slower at random seeks, but that was indeed
expected).

I tried the same thing on a 2.4.18 kernel (bf2.4 flavour from Debian
SID) but that gave me funny DMA timeout errors (something like DMA
timeout func 14 only supported) and kicked out one of (sporadic) my
newer drives from the array.

I wanted to try a 2.5.x kernel and settled for the newest one: 2.5.52
(vanilla). This wonderful kernel detected the UDMA5 capability of the
new drives and the new controller (veeery satisfying =) ) and gave me a
throughput of about 20-22MB/sec in the beginning. Sadly the system
Ooopsed at 30% percent giving me some DMA errors.

I have been wondering if it could be the powersupply, I have a 360W (max
load) powersupply, 4 new IBM 80G discs, 1 older 80G SEAGATE, 1 20G
MAXTOR.

Hmm, there it was again, one of my new drives got kicked out of the
array before the initial sync was ready.

The errors was (2.4.20):

<DATE> webber kernel: hdg: dma_intr: status=0x51
<DATE> webber kernel: hdg: end_request: I/O error, dev 22:00 (hdg)
sector 58033224
<DATE> webber kernel: hdg: dma_intr: status=0x51
<DATE> webber kernel: hdg: dma_intr: error=0x40 LBAsect=58033238,
sector=58033232
<DATE> webber kernel: end_request: I/O error, dev 22:00 (hdg), sector
58033232


Hmm, what could it be, this didn't happen while running bonnie++ :(



Any help will be appreciated,

Regards,
        Mikael


-- 
Mikael Olenfalk <mikael@netgineers.se>
Netgineers

