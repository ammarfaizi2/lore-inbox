Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSHWFoV>; Fri, 23 Aug 2002 01:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSHWFoV>; Fri, 23 Aug 2002 01:44:21 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:5118 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318202AbSHWFoT>; Fri, 23 Aug 2002 01:44:19 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.52393.815871.338981@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:48:25 +1000
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Large Block Device patch, part 2 of 9
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
   Here's part two of the patch.  This just fixes the BLKGETSIZE ioctl
to return EFBIG if the size of a block device is too large to be
represented in a long.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.509   -> 1.510  
#	drivers/block/blkpg.c	1.38    -> 1.39   
#	drivers/block/loop.c	1.55    -> 1.56   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.510
# Fix BLKGETSIZE ioctl to return -EFBIG if size is out of range for a long.
# --------------------------------------------
#
diff -Nru a/drivers/block/blkpg.c b/drivers/block/blkpg.c
--- a/drivers/block/blkpg.c	Fri Aug 23 13:52:11 2002
+++ b/drivers/block/blkpg.c	Fri Aug 23 13:52:11 2002
@@ -261,10 +261,17 @@
 			intval = bdev_hardsect_size(bdev);
 			return put_user(intval, (int *) arg);
 
-		case BLKGETSIZE:
+		case BLKGETSIZE: 
+		{
+			unsigned long ret;
 			/* size in sectors, works up to 2 TB */
 			ullval = bdev->bd_inode->i_size;
-			return put_user((unsigned long)(ullval >> 9), (unsigned long *) arg);
+			ret = ullval >> 9;
+			if ((u64)ret != (ullval >> 9))
+				return -EFBIG;
+			return put_user(ret, (unsigned long *) arg);
+		}
+		
 		case BLKGETSIZE64:
 			/* size in bytes */
 			ullval = bdev->bd_inode->i_size;
diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Fri Aug 23 13:52:11 2002
+++ b/drivers/block/loop.c	Fri Aug 23 13:52:11 2002
@@ -901,18 +901,25 @@
 		err = loop_get_status(lo, (struct loop_info *) arg);
 		break;
 	case BLKGETSIZE:
+	{
+		unsigned long val;
 		if (lo->lo_state != Lo_bound) {
 			err = -ENXIO;
 			break;
 		}
-		err = put_user((unsigned long) loop_sizes[lo->lo_number] << 1, (unsigned long *) arg);
+		val = loop_sizes[lo->lo_number] << 1;
+		if ((sector_t)val  != loop_sizes[lo->lo_number] << 1)
+			err = -EFBIG;
+		else
+			err = put_user(val, (unsigned long *) arg);
 		break;
+	}
 	case BLKGETSIZE64:
 		if (lo->lo_state != Lo_bound) {
 			err = -ENXIO;
 			break;
 		}
-		err = put_user((u64)loop_sizes[lo->lo_number] << 10, (u64*)arg);
+		err = put_user(((u64)loop_sizes[lo->lo_number]) << 10, (u64*)arg);
 		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
