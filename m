Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTKIO5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 09:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTKIO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 09:57:17 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:63914 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262522AbTKIO5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 09:57:14 -0500
Date: Sun, 9 Nov 2003 15:56:51 +0100
From: Tobias Diedrich <ranma@gmx.at>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom blocksize reset bug with 2.4.x kernels
Message-ID: <20031109145651.GA1203@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702111835.GC839@suse.de>
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://studserv.stud.uni-hannover.de/~ranma/gpg-key
User-Agent: Mutt/1.5.4i
X-Seen: false
X-ID: VadC9oZBwezBKIUgIs3uJGzOx+GryVax78fkl-JIAmtEljZBc-spEa@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As it seems Attila did not write a follow up, I had a look at his patch
and the problem.  The following patch fixes it for me (Plextor PX-32TS).

Please CC me on replies, I am not subscribed to the list.

--- linux-2.4.22/include/linux/cdrom.h	2003-10-28 01:30:34.000000000 +0100
+++ linux/include/linux/cdrom.h	2003-11-09 15:44:20.000000000 +0100
@@ -743,7 +743,8 @@
     	char name[20];                  /* name of the device type */
 /* per-device flags */
         __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
-        __u8 reserved		: 6;	/* not used yet */
+        __u8 use_read10	: 1;		/* Use READ10 instead of READCD */
+        __u8 reserved		: 5;	/* not used yet */
 	struct cdrom_write_settings write;
 };
 
--- linux-2.4.22/drivers/cdrom/cdrom.c	2003-11-07 23:46:49.000000000 +0100
+++ linux/drivers/cdrom/cdrom.c	2003-11-09 15:52:14.000000000 +0100
@@ -1400,6 +1400,8 @@
 	return 0;
 }
 
+static int cdrom_switch_blocksize(struct cdrom_device_info *cdi, int size);
+
 /*
  * Specific READ_10 interface
  */
@@ -1408,6 +1410,7 @@
 			 int blocksize, int nblocks)
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
+	int ret = 0;
 
 	memset(&cgc->cmd, 0, sizeof(cgc->cmd));
 	cgc->cmd[0] = GPCMD_READ_10;
@@ -1419,7 +1422,22 @@
 	cgc->cmd[7] = (nblocks >>  8) & 0xff;
 	cgc->cmd[8] = nblocks & 0xff;
 	cgc->buflen = blocksize * nblocks;
-	return cdo->generic_packet(cdi, cgc);
+
+	if (blocksize != CD_FRAMESIZE) {
+		ret = cdrom_switch_blocksize(cdi, blocksize);
+		ret |= cdo->generic_packet(cdi, cgc);
+		ret |= cdrom_switch_blocksize(cdi, CD_FRAMESIZE);
+	} else ret = cdo->generic_packet(cdi, cgc);
+
+	/*
+	 * Switch cdrom_read_block back to default behaviour
+	 * if we get an error.
+	 * FIXME: Maybe this should not be done on all errors.
+	 */
+	if (ret != 0)
+		cdi->use_read10 = 0;
+
+	return ret;
 }
 
 /* very generic interface for reading the various types of blocks */
@@ -1428,8 +1446,15 @@
 			    int lba, int nblocks, int format, int blksize)
 {
 	struct cdrom_device_ops *cdo = cdi->ops;
+	int ret;
+
+	if (cdi->use_read10)
+		return cdrom_read_cd(cdi, cgc, lba, blksize, nblocks);
 
 	memset(&cgc->cmd, 0, sizeof(cgc->cmd));
+	/*
+	 * SCSI-II devices are not required to support READ_CD.
+	 */
 	cgc->cmd[0] = GPCMD_READ_CD;
 	/* expected sector size - cdda,mode1,etc. */
 	cgc->cmd[1] = format << 2;
@@ -1452,7 +1477,15 @@
 	default			: cgc->cmd[9] = 0x10;
 	}
 	
-	return cdo->generic_packet(cdi, cgc);
+	ret = cdo->generic_packet(cdi, cgc);
+	if (ret && cgc->sense && cgc->sense->sense_key==0x05 && cgc->sense->asc==0x20 && cgc->sense->ascq==0x00) {
+		ret = cdrom_read_cd(cdi, cgc, lba, blksize, nblocks);
+		if (ret == 0) {
+			cdi->use_read10 = 1;
+			printk(KERN_INFO "cdrom.c: drive does not like READ_CD for blksize=%d, switching to READ_10.\n", blksize);
+		}
+	}
+	return ret;
 }
 
 /* Just about every imaginable ioctl is supported in the Uniform layer
@@ -1956,20 +1989,6 @@
 		cgc.sense = &sense;
 		cgc.data_direction = CGC_DATA_READ;
 		ret = cdrom_read_block(cdi, &cgc, lba, 1, format, blocksize);
-		if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {
-			/*
-			 * SCSI-II devices are not required to support
-			 * READ_CD, so let's try switching block size
-			 */
-			/* FIXME: switch back again... */
-			if ((ret = cdrom_switch_blocksize(cdi, blocksize))) {
-				kfree(cgc.buffer);
-				return ret;
-			}
-			cgc.sense = NULL;
-			ret = cdrom_read_cd(cdi, &cgc, lba, blocksize, 1);
-			ret |= cdrom_switch_blocksize(cdi, blocksize);
-		}
 		if (!ret && copy_to_user((char *)arg, cgc.buffer, blocksize))
 			ret = -EFAULT;
 		kfree(cgc.buffer);

-- 
Tobias						PGP: http://9ac7e0bc.2ya.com
