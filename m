Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWBYWni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWBYWni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBYWni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:43:38 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:63965 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932179AbWBYWni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:43:38 -0500
To: linuxer@ever.mine.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: pktcdvd DVD+RW always writes at max drive speed (not media speed)
References: <200602182023.k1IKNNuI012372@rhodes.mine.nu>
	<m3r760cntz.fsf@telia.com>
	<200602182335.k1INZFoi012487@rhodes.mine.nu>
	<m3ek1v58qi.fsf@telia.com>
	<200602250112.k1P1CCqm009307@rhodes.mine.nu>
From: Peter Osterlund <petero2@telia.com>
Date: 25 Feb 2006 23:43:22 +0100
In-Reply-To: <200602250112.k1P1CCqm009307@rhodes.mine.nu>
Message-ID: <m3y7zz2h6d.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxer@ever.mine.nu writes:

>  petero@p4.localdomain writes:
>   > 
>   > linuxer@ever.mine.nu writes:
>   > 
>   > > Peter Osterlund <petero2@telia.com> writes:
>   > >   > 
>   > >   > linuxer@ever.mine.nu writes:
>   > >   > 
>   > >   > > In drivers/block/pktcdvd.c it appears that in the case of DVD
>   > >   > > rewriting, pkt_open_write always sets the write speed to pkt_get_max_speed
>   > >   > > (the maximum writing speed reported by the drive). 
>   > >   > > 
>   > >   > > In my case, I have a new drive capable of 8x re-writing. However, all of
>   > >   > > my existing media is rated for only 4x rewrite speed. 
>   > >   > > 
>   > >   > > When attempting to rw mount these disks, pktcdvd reports:
>   > >   > > 
>   > >   > > Feb 18 00:09:52 ever kernel: pktcdvd: write speed 11080kB/s
>   > >   > > Feb 18 00:09:54 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 -
>   > >   > > sense 00.54.9c (No sense)
>   > >   > > Feb 18 00:09:54 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
>   > >   > > 
>   > >   > > And then of course a huge heap of I/O errors on the disk. 
>   > >   > 
>   > >   > Have you verified that this is caused by the speed setting, ie does it
>   > >   > work correctly if you hack the driver to write at 4x speed?
>   > > 
>   > > Correct. Adding a hard-coded manual setting of write_speed = 5540 to
>   > > pkt_open_write results in functional operation (at least with 4x rated
>   > > DVD+RW media).
>   > 
>   > Does this patch work for you?
>   > 
>   > 
>   > pktcdvd: Don't try to write faster than the DVD media speed allows.
>   > 
>   > In theory the drive firmware should limit the speed to the fastest
>   > allowed by the currently loaded media, but it doesn't always work in
>   > practice.
...
> Unfortunately, no. It -should- work, but the extra DPRINTK's tell a further
> story of the drives stupidity.
> 
> Upon running 
>  % pktsetup 0 /dev/hde ; mkudffs /dev/pktcdvd/0'
> I get the following output:
> 
> Feb 24 19:30:31 ever kernel: pktcdvd: inserted media is DVD+RW
> Feb 24 19:30:31 ever kernel: pktcdvd: Max drive write speed 11080kB/s
> Feb 24 19:30:31 ever kernel: pktcdvd: Max. media speed: 5540kB/s
> Feb 24 19:30:31 ever kernel: pktcdvd: write speed 5540kB/s
> Feb 24 19:30:48 ever kernel: pktcdvd: 4590208kB available on disc
> 
> All seems well and good. However, upon then issuing 
>  % mount /dev/pktcdvd/0 /mnt/dvdrw -t auto -o noatime,rw
> 
> Feb 24 19:31:28 ever kernel: pktcdvd: inserted media is DVD+RW
> Feb 24 19:31:28 ever kernel: pktcdvd: Max drive write speed 11080kB/s
> Feb 24 19:31:28 ever kernel: pktcdvd: Max. media speed: 11080kB/s
> Feb 24 19:31:28 ever kernel: pktcdvd: write speed 11080kB/s
> Feb 24 19:31:30 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 - sense 00.54.1c (No sense)
> Feb 24 19:31:30 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
> Feb 24 19:31:30 ever kernel: pktcdvd: 4590208kB available on disc
> Feb 24 19:31:31 ever kernel: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2006/02/24 18:30 (1ed4)
> Feb 24 19:31:40 ever kernel: hde: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> Feb 24 19:31:40 ever kernel: hde: media error (bad sector): error=0x34 { AbortedCommand LastFailedSense=0x03 }
> Feb 24 19:31:40 ever kernel: ide: failed opcode was: unknown
> Feb 24 19:31:40 ever kernel: end_request: I/O error, dev hde, sector 1088
> Feb 24 19:31:40 ever kernel: hde: command error: status=0x51 { DriveReady SeekComplete Error }
> Feb 24 19:31:40 ever kernel: hde: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
> .
> . (and so on)
> 
> I'm somewhat confused as to what could be happening here, but my first
> guess is that after being spun up to high speed for reading in
> pkt_iosched_process_queue, the firmware promptly forgets whatever it knew
> about the media speed. Perhaps it only stores a single speed value
> internally, so calling pkt_set_speed (pd, pd->write_speed, pd->read_speed)
> with a larger value of read_speed sets them both. And afterwards the drive
> reports this as the maximum media speed on future opens?

You could test that theory with a hack like this:

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 94ff3ac..a0d6687 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -461,6 +461,8 @@ static int pkt_set_speed(struct pktcdvd_
 	struct request_sense sense;
 	int ret;
 
+	read_speed = write_speed;
+
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
 	cgc.sense = &sense;
 	cgc.cmd[0] = GPCMD_SET_SPEED;
@@ -2028,7 +2030,9 @@ static void pkt_release_dev(struct pktcd
 
 	pkt_lock_door(pd, 0);
 
+#if 0
 	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
+#endif
 	bd_release(pd->bdev);
 	blkdev_put(pd->bdev);
 

> If you are curious as to who would curse the market with such a
> buggy product, the drive is a BenQ Q60.

Maybe there is a firmware upgrade available?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
