Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422862AbWJGBqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbWJGBqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 21:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWJGBqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 21:46:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:8847 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422731AbWJGBqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 21:46:22 -0400
Message-ID: <452706EA.3040702@in.ibm.com>
Date: Fri, 06 Oct 2006 18:46:18 -0700
From: Suzuki K P <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: [RFC] Fix check_partition routines ( was Re: [RFC] PATCH to fix rescan_partitions
 to return errors properly - take 2)
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com> <20061004170827.GE18800@harddisk-recovery.nl> <4523F16D.5060808@in.ibm.com> <20061005104018.GC7343@harddisk-recovery.nl> <45256BE2.5040702@in.ibm.com> <20061006125336.GA27183@harddisk-recovery.nl> <452695CE.8080901@in.ibm.com> <20061006210721.GC31233@harddisk-recovery.nl>
In-Reply-To: <20061006210721.GC31233@harddisk-recovery.nl>
Content-Type: multipart/mixed;
 boundary="------------050409090806010108020908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050409090806010108020908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


Here is a followup patch, which cleans up the check_partition() as well 
as some of the partition check routines.

check_partition would now record the I/O error notice and proceed with 
the other partitions. The error will only be reported when all of the 
partitions have left the disk as "Unknown".

Cleanup for partition checkers for ibm, atari and amiga.

Comments ?

Thanks

Suzuki


Erik Mouw wrote:
> On Fri, Oct 06, 2006 at 10:43:42AM -0700, Suzuki K P wrote:
> 
>>Erik Mouw wrote:
>>
>>>I think it's best not to change the current behaviour and let all
>>>partition checkers run, even if one of them failed due to device
>>>errors. I wouldn't mind if the behaviour changed like you propose,
>>>though.
>>>
>>
>>At present, the partition checkers doesn't run, if one of the preceeding 
>>checker has reported an error ! *But*, some of the checkers doesn't 
>>report the I/O error which they came across! So, this may let others 
>>run. Thats not we want, right. We would like them to return I/O errors, 
>>and and the check_partition should let other partition checkers continue.
> 
> 
> Indeed, we want them to behave the same. I.e.: a partition checker
> should tell when it encounters an I/O error.
> 
> 
> Erik
> 



--------------050409090806010108020908
Content-Type: text/x-patch;
 name="fix-check_partition-methods.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-check_partition-methods.diff"

*  The check_partition() stops its probe once it hits an I/O error from the partition checkers. This would prevent the actual partition checker getting a chance to verify the partition. So, this patch lets the check_partition continue probing untill it hits a success while recording the I/O error which might have been reported by the checking routines.

Also, it does some cleanup of the partition methods for ibm, atari and amiga to return -1 upon hitting an I/O error.

Signed-Off-by: Suzuki K P <suzuki@in.ibm.com>


Index: linux-2.6.18/fs/partitions/check.c
===================================================================
--- linux-2.6.18.orig/fs/partitions/check.c	2006-10-07 06:10:16.000000000 +0530
+++ linux-2.6.18/fs/partitions/check.c	2006-10-07 06:21:39.000000000 +0530
@@ -153,7 +153,7 @@
 check_partition(struct gendisk *hd, struct block_device *bdev)
 {
 	struct parsed_partitions *state;
-	int i, res;
+	int i, res, err;
 
 	state = kmalloc(sizeof(struct parsed_partitions), GFP_KERNEL);
 	if (!state)
@@ -165,13 +165,24 @@
 		sprintf(state->name, "p");
 
 	state->limit = hd->minors;
-	i = res = 0;
+	i = res = err = 0;
 	while (!res && check_part[i]) {
 		memset(&state->parts, 0, sizeof(state->parts));
 		res = check_part[i++](state, bdev);
+		if (res < 0) {
+			/* We have hit an I/O error which we don't report now.
+		 	* But record it, and let the others do their job.
+		 	*/
+			err = res;
+			res = 0;
+		}
+		
 	}
 	if (res > 0)
 		return state;
+	if (!err)
+	/* The partition is unrecognized. So report I/O errors if there were any */
+		res = err;
 	if (!res)
 		printk(" unknown partition table\n");
 	else if (warn_no_part)
Index: linux-2.6.18/fs/partitions/amiga.c
===================================================================
--- linux-2.6.18.orig/fs/partitions/amiga.c	2006-09-20 09:12:06.000000000 +0530
+++ linux-2.6.18/fs/partitions/amiga.c	2006-10-07 06:57:44.000000000 +0530
@@ -43,6 +43,7 @@
 			if (warn_no_part)
 				printk("Dev %s: unable to read RDB block %d\n",
 				       bdevname(bdev, b), blk);
+			res = -1;
 			goto rdb_done;
 		}
 		if (*(__be32 *)data != cpu_to_be32(IDNAME_RIGIDDISK))
@@ -79,6 +80,7 @@
 			if (warn_no_part)
 				printk("Dev %s: unable to read partition block %d\n",
 				       bdevname(bdev, b), blk);
+			res = -1;
 			goto rdb_done;
 		}
 		pb  = (struct PartitionBlock *)data;
Index: linux-2.6.18/fs/partitions/ibm.c
===================================================================
--- linux-2.6.18.orig/fs/partitions/ibm.c	2006-09-20 09:12:06.000000000 +0530
+++ linux-2.6.18/fs/partitions/ibm.c	2006-10-07 06:55:23.000000000 +0530
@@ -43,7 +43,7 @@
 int
 ibm_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
-	int blocksize, offset, size;
+	int blocksize, offset, size,res;
 	loff_t i_size;
 	dasd_information_t *info;
 	struct hd_geometry *geo;
@@ -55,16 +55,17 @@
 	} *label;
 	unsigned char *data;
 	Sector sect;
-
+	
+	res = 0;
 	blocksize = bdev_hardsect_size(bdev);
 	if (blocksize <= 0)
-		return 0;
+		goto out_exit;
 	i_size = i_size_read(bdev->bd_inode);
 	if (i_size == 0)
-		return 0;
+		goto out_exit;
 
 	if ((info = kmalloc(sizeof(dasd_information_t), GFP_KERNEL)) == NULL)
-		goto out_noinfo;
+		goto out_exit;
 	if ((geo = kmalloc(sizeof(struct hd_geometry), GFP_KERNEL)) == NULL)
 		goto out_nogeo;
 	if ((label = kmalloc(sizeof(union label_t), GFP_KERNEL)) == NULL)
@@ -72,7 +73,7 @@
 
 	if (ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)info) != 0 ||
 	    ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
-		goto out_noioctl;
+		goto out_freeall;
 
 	/*
 	 * Get volume label, extract name and type.
@@ -91,6 +92,8 @@
 
 	EBCASC(type, 4);
 	EBCASC(name, 6);
+	
+	res = 1;
 
 	/*
 	 * Three different types: CMS1, VOL1 and LNX1/unlabeled
@@ -156,6 +159,9 @@
 			counter++;
 			blk++;
 		}
+		if (!data)
+		/* Are we not supposed to report this ? */
+			goto out_readerr;
 	} else {
 		/*
 		 * Old style LNX1 or unlabeled disk
@@ -171,18 +177,17 @@
 	}
 
 	printk("\n");
-	kfree(label);
-	kfree(geo);
-	kfree(info);
-	return 1;
+	goto out_freeall;
+
 
 out_readerr:
-out_noioctl:
+	res = -1;
+out_freeall:
 	kfree(label);
 out_nolab:
 	kfree(geo);
 out_nogeo:
 	kfree(info);
-out_noinfo:
-	return 0;
+out_exit:
+	return res;
 }
Index: linux-2.6.18/fs/partitions/atari.c
===================================================================
--- linux-2.6.18.orig/fs/partitions/atari.c	2006-09-20 09:12:06.000000000 +0530
+++ linux-2.6.18/fs/partitions/atari.c	2006-10-07 06:58:22.000000000 +0530
@@ -88,7 +88,7 @@
 			if (!xrs) {
 				printk (" block %ld read failed\n", partsect);
 				put_dev_sector(sect);
-				return 0;
+				return -1;
 			}
 
 			/* ++roman: sanity check: bit 0 of flg field must be set */

--------------050409090806010108020908--
