Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSLMPbD>; Fri, 13 Dec 2002 10:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSLMPbD>; Fri, 13 Dec 2002 10:31:03 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:44446 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264863AbSLMPbB>;
	Fri, 13 Dec 2002 10:31:01 -0500
Date: Fri, 13 Dec 2002 17:52:32 -0500
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cciss/cpqarray/md should use generic BLKGETSIZE
Message-ID: <20021213175232.A2581@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did that already in 2.4.9/2.4.10 timeframe but it looks like a few
offenders started duplicating code again..


--- 1.27/drivers/block/cciss.c	Wed Dec  4 01:00:00 2002
+++ edited/drivers/block/cciss.c	Fri Dec 13 15:23:19 2002
@@ -468,16 +468,12 @@
 			return  -EFAULT;
 		return(0);
 	}
-	case BLKGETSIZE:
-		put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects, (unsigned long *)arg);
-		return 0;
-	case BLKGETSIZE64:
-		put_user((u64)hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects << 9, (u64*)arg);
-		return 0;
 	case BLKRRPART:
 		if(!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		return revalidate_logvol(inode->i_rdev, 1);
+	case BLKGETSIZE:
+	case BLKGETSIZE64:
 	case BLKFLSBUF:
 	case BLKBSZSET:
 	case BLKBSZGET:
--- 1.26/drivers/block/cpqarray.c	Mon Oct 28 16:18:57 2002
+++ edited/drivers/block/cpqarray.c	Fri Dec 13 15:24:07 2002
@@ -1287,12 +1287,6 @@
 
 	case IDAGETDRVINFO:
 		return copy_to_user(&io->c.drv,&hba[ctlr]->drv[dsk],sizeof(drv_info_t));
-	case BLKGETSIZE:
-		if (!arg) return -EINVAL;
-		return put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects, 
-			(unsigned long *)arg);
-	case BLKGETSIZE64:
-		return put_user((u64)(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects) << 9, (u64*)arg);
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
 	case IDAPASSTHRU:
@@ -1360,6 +1354,8 @@
 		return(0);
 	}
 
+	case BLKGETSIZE:
+	case BLKGETSIZE64:
 	case BLKFLSBUF:
 	case BLKBSZSET:
 	case BLKBSZGET:
--- 1.33/drivers/md/md.c	Tue Aug  6 16:42:18 2002
+++ edited/drivers/md/md.c	Fri Dec 13 15:24:42 2002
@@ -2610,21 +2610,8 @@
 			goto done;
 #endif
 
-		case BLKGETSIZE:	/* Return device size */
-			if (!arg) {
-				err = -EINVAL;
-				MD_BUG();
-				goto abort;
-			}
-			err = md_put_user(md_hd_struct[minor].nr_sects,
-						(unsigned long *) arg);
-			goto done;
-
-		case BLKGETSIZE64:	/* Return device size */
-			err = md_put_user((u64)md_hd_struct[minor].nr_sects << 9,
-						(u64 *) arg);
-			goto done;
-
+		case BLKGETSIZE:
+		case BLKGETSIZE64:
 		case BLKRAGET:
 		case BLKRASET:
 		case BLKFLSBUF:
