Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262094AbTCRF2B>; Tue, 18 Mar 2003 00:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbTCRF2A>; Tue, 18 Mar 2003 00:28:00 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:56522 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262094AbTCRF2A>; Tue, 18 Mar 2003 00:28:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Simon Kirby <sim@netnation.com>
Date: Tue, 18 Mar 2003 16:38:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15990.45282.847803.279070@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.65] MD RAID1 weirdness
In-Reply-To: message from Simon Kirby on Monday March 17
References: <20030318053335.GA673@netnation.com>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 17, sim@netnation.com wrote:
> Just booted from 2.5.65-BK6 to 2.5.65 after an unexpected lockup in X,
> and found weird MD messages at boot followed by an amazingly fast
> (broken :)) resync.  /proc/mdstat now reports:

Sorry 'bout that.

Should be fixed by following patch.

NeilBrown


diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2003-03-15 14:40:12.000000000 +1100
+++ ./drivers/md/raid1.c	2003-03-17 09:39:57.000000000 +1100
@@ -840,7 +840,8 @@ static void sync_request_write(mddev_t *
 			 * we read from here, no need to write
 			 */
 			continue;
-		if (conf->mirrors[i].rdev->in_sync && mddev->in_sync)
+		if (conf->mirrors[i].rdev->in_sync && 
+			r1_bio->sector + (bio->bi_size>>9) <= mddev->recovery_cp)
 			/*
 			 * don't need to write this we are just rebuilding
 			 */



