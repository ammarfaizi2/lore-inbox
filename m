Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWCVJAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWCVJAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWCVJAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:00:12 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:22700 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751128AbWCVJAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:00:09 -0500
Date: Wed, 22 Mar 2006 10:00:06 +0100
From: Sander <sander@humilis.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Sander <sander@humilis.net>,
       Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060322090006.GA8462@favonius>
Reply-To: sander@humilis.net
References: <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org> <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org> <20060321204435.GE25066@favonius> <Pine.LNX.4.64.0603211249270.3622@g5.osdl.org> <44206B81.1030309@garzik.org> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org>
X-Uptime: 09:27:09 up 19 days, 13:37, 28 users,  load average: 1.44, 2.20, 2.38
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote (ao):
> On Tue, 21 Mar 2006, Jeff Garzik wrote:
> > In any case, one could be lazy, and simply bisect the main tree
> > (and/or simply verify that the problem is gone in
> > 2.6.16-git<today>).
> 
> Yes, just testing the current git tree (and if you're not a git user,
> just waiting for the next nightly snapshot) sounds like the
> appropriate thing to do.

The 2.6.16-git3 snapshot is stable for me like -rc6-mm1 and -rc6-mm2
are :-)

To recap:
Running eight Maxtor disks connected to a
MV88SX6081 8-port SATA II PCI-X Controller (rev 09)

mdadm -C -l5 -n8 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 \
/dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1 /dev/sdh1

mke2fs -j -m1 /dev/md0
mount -o data=writeback,nobh /dev/md0 /mnt

for i in `seq 4`
do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
dd if=bigfile.$i of=/dev/null bs=1024k count=10000
done
time md5sum bigfile.*
time rm bigfile.*

or

for i in `seq 4`
do ( dd if=/dev/zero of=bigfile.$i bs=1024k count=10000 ; \
time md5sum bigfile.$i ) &
done

Kernel 2.6.16-rc6 and 2.6.16 always crash during the md5sum (and leave
no output).

2.6.16-rc6-mm1, 2.6.16-rc6-mm2 and 2.6.16-git3 are stable without a
crash or data corruption.


I'm aware that the test is very simple and bugs might still hide. I'll
go and find some more serious stress tests.

Should I do more testing/bisecting/etc?

Btw, I do still get these (any kernel), but with no visible effect:

[ 2306.952183] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 2306.952246] ata6: status=0xd0 { Busy }
[ 2891.892225] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 2891.892277] ata5: status=0xd0 { Busy }
[ 4550.013582] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 4550.013637] ata6: status=0xd0 { Busy }
[ 4864.850340] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 4864.850393] ata9: status=0xd0 { Busy }
[ 4968.681651] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 4968.681711] ata9: status=0xd0 { Busy }


Thanks!

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
