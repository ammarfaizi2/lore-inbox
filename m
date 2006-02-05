Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWBEWox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWBEWox (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWBEWox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 17:44:53 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:17793 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750766AbWBEWow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 17:44:52 -0500
To: Damian Pietras <daper@daper.net>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
	<20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com>
	<m3ek39z09f.fsf@telia.com> <20060115210443.GA6096@daper.net>
	<m33bixaaav.fsf@telia.com> <20060205210746.GA16023@daper.net>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Feb 2006 23:44:46 +0100
In-Reply-To: <20060205210746.GA16023@daper.net>
Message-ID: <m3oe1l8ly9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Pietras <daper@daper.net> writes:

> Now I can mount CD-R, CD-RW, DVD+RW using pktcdvd.
> 
> Something strange happend when I copied files to DVD+RW und used eject.
> After some time eject exitet, but the disc was stil in the burner, I was
> allowed to open it by pressing the eject button, but then:
> 
> hda: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> hda: media error (bad sector): error=0x34 { AbortedCommand LastFailedSense=0x03

Thanks for testing. Please try this patch: It makes sure not to unlock
the door if the disc is in use.

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f92d22f..a43f68d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2436,7 +2436,8 @@ static int pkt_ioctl(struct block_device
 		 * The door gets locked when the device is opened, so we
 		 * have to unlock it or else the eject command fails.
 		 */
-		pkt_lock_door(pd, 0);
+		if (pd->refcnt == 1)
+			pkt_lock_door(pd, 0);
 		return blkdev_ioctl(pd->bdev, file, cmd, arg);
 
 	default:

> And also many messages like this:
> pktcdvd: Unknown ioctl for pktcdvd0 (5326)
> 
> When inserting CD-R I get:
> pktcdvd: Wrong disc profile (9)
> pktcdvd: pktcdvd0 failed probe
> 
> but everything works OK.

Yes, those messages are quite useless except for debugging. I'll make
them go away.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
