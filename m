Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281452AbRKMCkI>; Mon, 12 Nov 2001 21:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281451AbRKMCj6>; Mon, 12 Nov 2001 21:39:58 -0500
Received: from mw3.texas.net ([206.127.30.13]:6610 "EHLO mw3.texas.net")
	by vger.kernel.org with ESMTP id <S281052AbRKMCjp>;
	Mon, 12 Nov 2001 21:39:45 -0500
Message-ID: <3BF087DA.2010908@btech.com>
Date: Mon, 12 Nov 2001 20:39:22 -0600
From: "Malcolm H. Teas" <mhteas@btech.com>
Organization: Blaze Technology, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: alan@redhat.com
Subject: [PATCH] Ramdisk ioctl bug fix, kernel 2.4.14
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the ramdisk return the actual size that is currently 
allocated instead of returning the max size we can possibly allocate.  Affects 
system calls ioctl(filedes, BLKGETSIZE) and ioctl(filedes, BLKGETSIZE64) for 
ramdisk devices.

Malcolm Teas
mhteas@btech.com
http://www.btech.com
Austin, TX USA

--- linux-2.4.14/drivers/block/rd.c	Thu Oct 25 15:58:35 2001
+++ linux/drivers/block/rd.c	Mon Nov 12 20:15:16 2001
@@ -40,6 +40,9 @@
   *
   * Make block size and block size shift for RAM disks a global macro
   * and set blk_size for -ENOSPC,     Werner Fink <werner@suse.de>, Apr '99
+ *
+ * Make BLKGETSIZE and BLKGETSIZE64 return the actual allocated size, not
+ * the max possible allocated size  - Malcolm Teas Nov 2001
   */

  #include <linux/config.h>
@@ -349,6 +352,7 @@
  {
  	int error = -EINVAL;
  	unsigned int minor;
+ 
unsigned long size;

  	if (!inode || !inode->i_rdev) 	
  		goto out;
@@ -373,10 +377,12 @@
           	case BLKGETSIZE:   /* Return device size */
  	 
	if (!arg)
  	 
		break;
- 
		error = put_user(rd_kbsize[minor] << 1, (unsigned long *) arg);
+ 
		size = (rd_bdev[minor]->bd_inode->i_mapping->nrpages * PAGE_SIZE) >> 9;
+ 
		error = put_user(size, (unsigned long *) arg);
  	 
	break;
           	case BLKGETSIZE64:
- 
		error = put_user((u64)rd_kbsize[minor]<<10, (u64*)arg);
+ 
		size = rd_bdev[minor]->bd_inode->i_mapping->nrpages;
+ 
		error = put_user((u64) (size * PAGE_SIZE), (u64*)arg);
  	 
	break;
  		case BLKROSET:
  		case BLKROGET:

