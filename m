Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbTHYXUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 19:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTHYXUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 19:20:25 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:19094 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262512AbTHYXUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 19:20:17 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Tue, 26 Aug 2003 09:20:05 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16202.39333.830809.797201@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 md raid5 disk faulty marking bug was: md: bug in file raid5.c, line 1909 in 2.4.22-pre7
In-Reply-To: message from Mike Fedyk on Friday August 22
References: <20030819203712.GB4083@matchmail.com>
	<16197.43158.905670.891510@gargle.gargle.HOWL>
	<20030822172142.GF1040@matchmail.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 22, mfedyk@matchmail.com wrote:
> > As far as I can see, the 2.4 code would never set just MD_DISK_REMOVED
> > (though it really should cope with it).  It is possible that the 2.6
> > code does.  Has this array had 2.6 running on it?  Does it have any
> > interesting history?
> 
> Yes, it was running 2.6-test2-mm2 or so (don't remember exactly, I can check
> though if needed) previously, but I didn't notice any bug messages from
> there, and seeing that it was 2.4 I was surprised to see bug
> messages from md.

The 2.4 code is very fragile.  It can easily bug if the superblock
looks wrong in some obscure way.

> 
> Do you have any patches for 2.6 md?  Right now this system is still in
> testing, and I'd like to help get this code path tested, and fixed.

The following should fix it.
With this applied to 2.6, you can simply 
  start the array under 2.6
  stop the array
  reboot into 2.4
and it should be fine again.

NeilBrown

==================================================
Fix md superblock incompatabilities with 2.4 kernels.

2.4 kernels are very fussy about some values in the superblock, and
2.6 got them wrong.  This fixes it.


 ----------- Diffstat output ------------
 ./drivers/md/md.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2003-08-24 08:07:18.000000000 +1000
+++ ./drivers/md/md.c	2003-08-26 09:11:39.000000000 +1000
@@ -638,14 +638,13 @@ static void super_90_sync(mddev_t *mddev
 	/* make rdev->sb match mddev data..
 	 *
 	 * 1/ zero out disks
-	 * 2/ Add info for each disk, keeping track of highest desc_nr
-	 * 3/ any empty disks < highest become removed
+	 * 2/ Add info for each disk, keeping track of highest desc_nr (next_spare);
+	 * 3/ any empty disks < next_spare become removed
 	 *
 	 * disks[0] gets initialised to REMOVED because
 	 * we cannot be sure from other fields if it has
 	 * been initialised or not.
 	 */
-	int highest = 0;
 	int i;
 	int active=0, working=0,failed=0,spare=0,nr_disks=0;
 
@@ -716,17 +715,17 @@ static void super_90_sync(mddev_t *mddev
 			spare++;
 			working++;
 		}
-		if (rdev2->desc_nr > highest)
-			highest = rdev2->desc_nr;
 	}
 	
-	/* now set the "removed" bit on any non-trailing holes */
-	for (i=0; i<highest; i++) {
+	/* now set the "removed" and "faulty" bits on any missing devices */
+	for (i=0 ; i < mddev->raid_disks ; i++) {
 		mdp_disk_t *d = &sb->disks[i];
 		if (d->state == 0 && d->number == 0) {
 			d->number = i;
 			d->raid_disk = i;
 			d->state = (1<<MD_DISK_REMOVED);
+			d->state |= (1<<MD_DISK_FAULTY);
+			failed++;
 		}
 	}
 	sb->nr_disks = nr_disks;
