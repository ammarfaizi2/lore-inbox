Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271552AbRIJStc>; Mon, 10 Sep 2001 14:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271586AbRIJStX>; Mon, 10 Sep 2001 14:49:23 -0400
Received: from ns.caldera.de ([212.34.180.1]:12265 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271552AbRIJStN>;
	Mon, 10 Sep 2001 14:49:13 -0400
Date: Mon, 10 Sep 2001 20:49:28 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010910204928.A22889@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20010910175416.A714@athlon.random> <200109101741.f8AHfwx17136@ns.caldera.de> <20010910200344.C714@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010910200344.C714@athlon.random>; from andrea@suse.de on Mon, Sep 10, 2001 at 08:03:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 08:03:44PM +0200, Andrea Arcangeli wrote:
> On Mon, Sep 10, 2001 at 07:41:58PM +0200, Christoph Hellwig wrote:
> > In article <20010910175416.A714@athlon.random> you wrote:
> > > Only in 2.4.10pre4aa1: 00_paride-max_sectors-1
> > > Only in 2.4.10pre7aa1: 00_paride-max_sectors-2
> > >
> > > 	Rediffed (also noticed the gendisk list changes deleted too much stuff
> > > 	here so resurrected it).
> > 
> > Do you plan to submit the max_sectors changes to Linus & Alan?
> > Otherwise I will do as they seem to be needed for reliable operation.
> 
> agreed, Linus, here it is ready for merging into mainline:

I think the sd part is much more interesting for most users..
Version from 2.4.10pre7aa1 is here:

diff -urN 2.4.7/drivers/scsi/sd.c sd_max_sectors/drivers/scsi/sd.c
--- 2.4.7/drivers/scsi/sd.c	Sat Jul 21 00:04:23 2001
+++ sd_max_sectors/drivers/scsi/sd.c	Mon Jul 23 04:31:00 2001
@@ -90,6 +90,7 @@
 static int *sd_sizes;
 static int *sd_blocksizes;
 static int *sd_hardsizes;	/* Hardware sector size */
+static int *sd_max_sectors;
 
 static int check_scsidisk_media_change(kdev_t);
 static int fop_revalidate_scsidisk(kdev_t);
@@ -1095,15 +1096,30 @@
 	if (!sd_hardsizes)
 		goto cleanup_blocksizes;
 
+	sd_max_sectors = kmalloc((sd_template.dev_max << 4) * sizeof(int), GFP_ATOMIC);
+	if (!sd_max_sectors)
+		goto cleanup_max_sectors;
+
 	for (i = 0; i < sd_template.dev_max << 4; i++) {
 		sd_blocksizes[i] = 1024;
 		sd_hardsizes[i] = 512;
+		/*
+		 * Allow lowlevel device drivers to generate 512k large scsi
+		 * commands if they know what they're doing and they ask for it
+		 * explicitly via the SHpnt->max_sectors API.
+		 */
+		sd_max_sectors[i] = MAX_SEGMENTS*8;
 	}
 
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		blksize_size[SD_MAJOR(i)] = sd_blocksizes + i * (SCSI_DISKS_PER_MAJOR << 4);
 		hardsect_size[SD_MAJOR(i)] = sd_hardsizes + i * (SCSI_DISKS_PER_MAJOR << 4);
+		max_sectors[SD_MAJOR(i)] = sd_max_sectors + i * (SCSI_DISKS_PER_MAJOR << 4);
 	}
+	/*
+	 * FIXME: should unregister blksize_size, hardsect_size and max_sectors when
+	 * the module is unloaded.
+	 */
 	sd = kmalloc((sd_template.dev_max << 4) *
 					  sizeof(struct hd_struct),
 					  GFP_ATOMIC);
@@ -1155,6 +1171,8 @@
 cleanup_sd_gendisks:
 	kfree(sd);
 cleanup_sd:
+	kfree(sd_max_sectors);
+cleanup_max_sectors:
 	kfree(sd_hardsizes);
 cleanup_blocksizes:
 	kfree(sd_blocksizes);
diff -urN 2.4.7/drivers/scsi/sym53c8xx.h sd_max_sectors/drivers/scsi/sym53c8xx.h
--- 2.4.7/drivers/scsi/sym53c8xx.h	Wed Jun 20 16:50:58 2001
+++ sd_max_sectors/drivers/scsi/sym53c8xx.h	Mon Jul 23 04:30:58 2001
@@ -96,6 +96,7 @@
 			this_id:        7,			\
 			sg_tablesize:   SCSI_NCR_SG_TABLESIZE,	\
 			cmd_per_lun:    SCSI_NCR_CMD_PER_LUN,	\
+			max_sectors:    MAX_SEGMENTS*8,		\
 			use_clustering: DISABLE_CLUSTERING} 
 
 #else
