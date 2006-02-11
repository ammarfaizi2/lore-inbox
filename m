Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWBKLVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWBKLVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 06:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWBKLVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 06:21:09 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:17388 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751403AbWBKLVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 06:21:08 -0500
To: Damian Pietras <daper@daper.net>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
	<20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com>
	<m3ek39z09f.fsf@telia.com> <20060115210443.GA6096@daper.net>
	<m33bixaaav.fsf@telia.com> <20060205210746.GA16023@daper.net>
	<m3oe1l8ly9.fsf@telia.com> <20060206201523.GA9204@daper.net>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Feb 2006 12:21:04 +0100
In-Reply-To: <20060206201523.GA9204@daper.net>
Message-ID: <m3y80i87kv.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Pietras <daper@daper.net> writes:

> On Sun, Feb 05, 2006 at 11:44:46PM +0100, Peter Osterlund wrote:
> > Damian Pietras <daper@daper.net> writes:
> > 
> > > Now I can mount CD-R, CD-RW, DVD+RW using pktcdvd.
> > > 
> > > Something strange happend when I copied files to DVD+RW und used eject.
> > > After some time eject exitet, but the disc was stil in the burner, I was
> > > allowed to open it by pressing the eject button, but then:
> > > 
> > > hda: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> > > hda: media error (bad sector): error=0x34 { AbortedCommand LastFailedSense=0x03
> > 
> > Thanks for testing. Please try this patch: It makes sure not to unlock
> > the door if the disc is in use.
> 
> It still allows to eject the disc while `umount /media/cdrom0` is
> waiting to finish.

That patch was accidentally created on top of another patch which I
haven't posted yet, so it didn't apply cleanly. Can you please try
again with the patch below and 2.6.16-rc2-git10 or later?

If that still doesn't work as expected, how did you eject the disc?
With the button or with the eject command? If it was the eject
command, please run eject with strace and send the output to me.


pktcdvd: Don't unlock the door if the disc is in use

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d747f28..d794f2b 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2436,7 +2436,8 @@ static int pkt_ioctl(struct inode *inode
 		 * The door gets locked when the device is opened, so we
 		 * have to unlock it or else the eject command fails.
 		 */
-		pkt_lock_door(pd, 0);
+		if (pd->refcnt == 1)
+			pkt_lock_door(pd, 0);
 		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	default:

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
