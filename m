Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267115AbTAPORi>; Thu, 16 Jan 2003 09:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTAPORi>; Thu, 16 Jan 2003 09:17:38 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:20955 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S267115AbTAPORg>;
	Thu, 16 Jan 2003 09:17:36 -0500
Date: Thu, 16 Jan 2003 16:40:28 -0500
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cciss/cpqarray/md should use generic BLKGETSIZE
Message-ID: <20030116164028.A10049@sgi.com>
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



--- 1.28/drivers/block/cciss.c	Thu Dec 12 17:14:12 2002
+++ edited/drivers/block/cciss.c	Wed Jan 15 23:15:36 2003
@@ -505,16 +505,12 @@
 			return  -EFAULT;
 		return 0;
 	}
-	case BLKGETSIZE:
-		put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects, (unsigned long *)arg);
-		return 0;
-	case BLKGETSIZE64:
-		put_user((u64)hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects << 9, (u64*)arg);
-		return 0;
 	case BLKRRPART:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		return revalidate_logvol(inode->i_rdev, 1);
+	case BLKGETSIZE:
+	case BLKGETSIZE64:
 	case BLKFLSBUF:
 	case BLKBSZSET:
 	case BLKBSZGET:
===== drivers/block/cpqarray.c 1.27 vs edited =====
--- 1.27/drivers/block/cpqarray.c	Tue Dec 17 00:26:25 2002
+++ edited/drivers/block/cpqarray.c	Wed Jan 15 23:16:02 2003
@@ -1279,13 +1279,6 @@
 		ida_ioctl_t *io = (ida_ioctl_t*)arg;
 		return copy_to_user(&io->c.drv,&hba[ctlr]->drv[dsk],sizeof(drv_info_t));
 	}
-	case BLKGETSIZE:
-		if (!arg) 
-			return -EINVAL;
-		return put_user(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects, 
-			(unsigned long *)arg);
-	case BLKGETSIZE64:
-		return put_user((u64)(hba[ctlr]->hd[MINOR(inode->i_rdev)].nr_sects) << 9, (u64*)arg);
 	case BLKRRPART:
 		return revalidate_logvol(inode->i_rdev, 1);
 	case IDAPASSTHRU:
@@ -1379,6 +1372,8 @@
 		return(0);
 	}
 
+	case BLKGETSIZE:
+	case BLKGETSIZE64:
 	case BLKFLSBUF:
 	case BLKBSZSET:
 	case BLKBSZGET:
===== drivers/md/md.c 1.37 vs edited =====
--- 1.37/drivers/md/md.c	Fri Jan  3 00:45:34 2003
+++ edited/drivers/md/md.c	Wed Jan 15 23:15:01 2003
@@ -2617,21 +2617,8 @@
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
