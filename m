Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWCPENu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWCPENu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbWCPENu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:13:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:60870 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752040AbWCPENu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:13:50 -0500
From: Neil Brown <neilb@suse.de>
To: Joshua Kugler <joshua.kugler@uaf.edu>
Date: Thu, 16 Mar 2006 15:12:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17432.58799.147308.149539@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.6.16-rc6 RAID size reporting
In-Reply-To: message from Joshua Kugler on Wednesday March 15
References: <200603151248.29893.joshua.kugler@uaf.edu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 15, joshua.kugler@uaf.edu wrote:
> In my quest to get some stability in my system with large RAID devices, I 
> installed mdadm 2.3.1 and compiled and installed 2.6.16-rc6.
> 
> Ran this command:
> 
> mdadm -C /dev/md1 --auto=yes -l raid1 -n 2 /dev/etherd/e0.0 /dev/etherd/e1.0
> 
> Those are AoE devices, by the way.
> 
> Started fine, syncing at 43000K/sec or so.  Came in this morning, 
> and /proc/mdstat had this to report:
> 
> Personalities : [raid1] 
> md1 : active raid1 etherd/e1.0[1] etherd/e0.0[0]
>       5469958900 blocks super 1.0 [2/2] [UU]
>       [==========================================================>]  resync 
> =292.8% (3440402688/1174991604) finish=785.8min speed=43043K/sec
> 
> You'll notice that it says 5469958900 blocks, but 3440402688/1174991604 done.  

Hmmm. there is sever bitrot in that code.  The following patch might
help.

> 
> if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery))
> 	max_blocks = mddev->resync_max_sectors >> 1;
> else
> 	max_blocks = mddev->size;
> 
> Should max_blocks be mddev->size even if it is resyncing?

Yes, you have to resync the entire array - all ->size of it...  maybe
you are misunderstanding one of the (probably undocumented)
variables..

NeilBrown



### Diffstat output
 ./drivers/md/md.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-14 17:40:12.000000000 +1100
+++ ./drivers/md/md.c	2006-03-16 15:08:18.000000000 +1100
@@ -4376,7 +4376,10 @@ static void status_unused(struct seq_fil
 
 static void status_resync(struct seq_file *seq, mddev_t * mddev)
 {
-	unsigned long max_blocks, resync, res, dt, db, rt;
+	sector_t max_blocks, resync, res;
+	unsigned long dt, db, rt;
+	int scale;
+	unsigned int per_milli;
 
 	resync = (mddev->curr_resync - atomic_read(&mddev->recovery_active))/2;
 
@@ -4392,9 +4395,22 @@ static void status_resync(struct seq_fil
 		MD_BUG();
 		return;
 	}
-	res = (resync/1024)*1000/(max_blocks/1024 + 1);
+	/* Pick 'scale' such that (resync>>scale)*1000 will fit
+	 * in a sector_t, and (max_blocks>>scale) will fit in a
+	 * u32, as those are the requirements for sector_div.
+	 * Thus 'scale' must be at least 10
+	 */
+	scale = 10;
+	if (sizeof(sector_t) > sizeof(unsigned long)) {
+		while ( max_blocks/2 > (1ULL<<(scale+32)))
+			scale++;
+	}
+	res = (resync>>scale)*1000;
+	sector_div(res, (u32)((max_blocks>>scale)+1));
+
+	per_milli = res;
 	{
-		int i, x = res/50, y = 20-x;
+		int i, x = per_milli/50, y = 20-x;
 		seq_printf(seq, "[");
 		for (i = 0; i < x; i++)
 			seq_printf(seq, "=");
@@ -4403,12 +4419,14 @@ static void status_resync(struct seq_fil
 			seq_printf(seq, ".");
 		seq_printf(seq, "] ");
 	}
-	seq_printf(seq, " %s =%3lu.%lu%% (%lu/%lu)",
+	seq_printf(seq, " %s =%3u.%u%% (%llu/%llu)",
 		   (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery)?
 		    "reshape" :
 		      (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?
 		       "resync" : "recovery")),
-		      res/10, res % 10, resync, max_blocks);
+		      per_milli/10, per_milli % 10,
+		   (unsigned long long) resync,
+		   (unsigned long long) max_blocks);
 
 	/*
 	 * We do not want to overflow, so the order of operands and
