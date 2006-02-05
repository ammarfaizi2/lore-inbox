Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWBETNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWBETNg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 14:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWBETNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 14:13:36 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:41367 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751160AbWBETNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 14:13:36 -0500
To: Damian Pietras <daper@daper.net>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
	<20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com>
	<m3ek39z09f.fsf@telia.com> <20060115210443.GA6096@daper.net>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Feb 2006 20:13:28 +0100
In-Reply-To: <20060115210443.GA6096@daper.net>
Message-ID: <m33bixaaav.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Pietras <daper@daper.net> writes:

> On Sun, Jan 15, 2006 at 09:47:40PM +0100, Peter Osterlund wrote:
> > 
> > The irq timeout problem might be broken hardware/firmware, but there
> > is a problem with drive locking and the pktcdvd driver.
> > 
> > If you do
> > 
> > 	pktsetup 0 /dev/hdc
> > 	mount /dev/hdc /mnt/tmp
> > 	umount /mnt/tmp
> > 
> > the door will be left in a locked state. (It gets unlocked when you
> > run "pktsetup -d 0" though.) However, if you do:
> > 
> > 	pktsetup 0 /dev/hdc
> > 	mount /dev/pktcdvd/0 /mnt/tmp
> > 	umount /mnt/tmp
> 
> Thanks!
> 
> It works this way without any irq timeout. Unfortunately I can't use it
> as a workaround, because CD-R media must be mounted with '-o ro' or I
> get 'pktcdvd: Wrong disc profile (9)', so I can't just put it in fstab
> and use 'mount /media/cdrom' for both CD-R and RW discs.

Please try this patch.


Allow non-writable media to be mounted.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 3445386..04117a7 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1896,7 +1896,7 @@ static int pkt_open_write(struct pktcdvd
 
 	if ((ret = pkt_probe_settings(pd))) {
 		DPRINTK("pktcdvd: %s failed probe\n", pd->name);
-		return -EIO;
+		return -EROFS;
 	}
 
 	if ((ret = pkt_set_write_settings(pd))) {
@@ -2054,10 +2054,9 @@ static int pkt_open(struct inode *inode,
 			goto out_dec;
 		}
 	} else {
-		if (pkt_open_dev(pd, file->f_mode & FMODE_WRITE)) {
-			ret = -EIO;
+		ret = pkt_open_dev(pd, file->f_mode & FMODE_WRITE);
+		if (ret)
 			goto out_dec;
-		}
 		/*
 		 * needed here as well, since ext2 (among others) may change
 		 * the blocksize at mount time

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
