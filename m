Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbREPDef>; Tue, 15 May 2001 23:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbREPDe0>; Tue, 15 May 2001 23:34:26 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:37650 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261781AbREPDeL>; Tue, 15 May 2001 23:34:11 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 16 May 2001 13:33:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15105.62716.592982.424602@notabene.cse.unsw.edu.au>
Cc: dmchan@stanford.edu (david chan), mingo@redhat.com (Ingo Molnar),
        calle@calle.in-berlin.de (Carsten Paeth), kkeil@suse.de (Karsten Keil),
        linux-kernel@vger.kernel.org (lkml), linux-raid@vger.kernel.org
Subject: Re: [PATCH] RAID5 NULL Checking Bug Fix
In-Reply-To: message from Alan Cox on Wednesday May 9
In-Reply-To: <Pine.LNX.4.30.0105081923540.21906-100000@waulogy.stanford.edu>
	<E14xPhG-0001q2-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 9, alan@lxorguk.ukuu.org.uk wrote:
> > Hi,
> > In drivers/md/raid5.c, the author does not check to see if alloc_page() returns
> > NULL. This patch also adds checks that return 1 (following the
> > error-path convention in the respective function).
> 
> This is fixed in 2.4.4-ac and has been for a while (and a little more
> cleanly in some respects). However it needs someone who knows the raid code
> well to push the raid fixes on to Linus
> 
> Alan

Can I put my hand up for that?

First patch (against 2.4.5-pre1):

The "ac" patches have code to swap the rdev->desc_nr of the failed
and spare drives when swapping in a spare after it has been
reconstructed.
This is needed to keep the "rdev" structures pointing to the right
raid-superblock slot.
However it isn't quite right.
It "ac" patches avoid the swap if either spare_rdev or failed_rdev
cannot be found, which is wrong (I put it in the avoid an oops.  I
didn't know the full story then).

The situation that would cause one of these to not be found is if the
"failed" drive is actually a "missing" drive.  i.e. the drive failed
and then was raid_hot_removed, or it just wan't present and working
at boot time.

When this happens, we still need to set spare_rdev->desc_nr to the
correct slot number.

The following patch gets this right for raid5.c and raid1.c (The only
places where it is relevant).

NeilBrown

(more patches to come.  They will go to Linus, Alan, and linux-raid only).

--- ./drivers/md/raid5.c	2001/05/15 04:02:07	1.1
+++ ./drivers/md/raid5.c	2001/05/15 04:06:19	1.2
@@ -1704,6 +1704,7 @@
 	struct disk_info *tmp, *sdisk, *fdisk, *rdisk, *adisk;
 	mdp_super_t *sb = mddev->sb;
 	mdp_disk_t *failed_desc, *spare_desc, *added_desc;
+	mdk_rdev_t *spare_rdev, *failed_rdev;
 
 	print_raid5_conf(conf);
 	md_spin_lock_irq(&conf->device_lock);
@@ -1875,6 +1876,16 @@
 		/*
 		 * do the switch finally
 		 */
+		spare_rdev = find_rdev_nr(mddev, spare_desc->number);
+		failed_rdev = find_rdev_nr(mddev, failed_desc->number);
+
+		/* There must be a spare_rdev, but there may not be a
+		 * failed_rdev.  That slot might be empty...
+		 */
+		spare_rdev->desc_nr = failed_desc->number;
+		if (failed_rdev)
+			failed_rdev->desc_nr = spare_desc->number;
+		
 		xchg_values(*spare_desc, *failed_desc);
 		xchg_values(*fdisk, *sdisk);
 
--- ./drivers/md/raid1.c	2001/05/15 04:02:07	1.1
+++ ./drivers/md/raid1.c	2001/05/15 04:06:19	1.2
@@ -832,6 +832,7 @@
 	struct mirror_info *tmp, *sdisk, *fdisk, *rdisk, *adisk;
 	mdp_super_t *sb = mddev->sb;
 	mdp_disk_t *failed_desc, *spare_desc, *added_desc;
+	mdk_rdev_t *spare_rdev, *failed_rdev;
 
 	print_raid1_conf(conf);
 	md_spin_lock_irq(&conf->device_lock);
@@ -989,6 +990,16 @@
 		/*
 		 * do the switch finally
 		 */
+		spare_rdev = find_rdev_nr(mddev, spare_desc->number);
+		failed_rdev = find_rdev_nr(mddev, failed_desc->number);
+
+		/* There must be a spare_rdev, but there may not be a
+		 * failed_rdev.  That slot might be empty...
+		 */
+		spare_rdev->desc_nr = failed_desc->number;
+		if (failed_rdev)
+			failed_rdev->desc_nr = spare_desc->number;
+		
 		xchg_values(*spare_desc, *failed_desc);
 		xchg_values(*fdisk, *sdisk);
 
