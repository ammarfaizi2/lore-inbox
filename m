Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRAQNgr>; Wed, 17 Jan 2001 08:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132345AbRAQNgl>; Wed, 17 Jan 2001 08:36:41 -0500
Received: from [213.8.187.203] ([213.8.187.203]:32517 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S132140AbRAQNg1> convert rfc822-to-8bit;
	Wed, 17 Jan 2001 08:36:27 -0500
Date: Wed, 17 Jan 2001 15:35:46 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] fs/super.c - paratition boundary checking before mount
Message-ID: <Pine.LNX.4.21.0101171505310.6904-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Accidental mounting of a paratition on a clipped drive, which a part of it
extends beyond the clipped area, may cause serious damage to the file 
system (and confusion on the VFS layer side).

This patch adds boundary checking to the read_super() function. If the
paratition extends beyond the clipped area, the mount will fail. 
The patch was tested successfully with a clipped drive.

p.s. I'm not sure if it breaks mounting on md/lvm, so I would like
your comments on it.


--- linux/fs/super.c	Sat Dec 30 00:18:42 2000
+++ linux/fs/super.c	Tue Jan 16 22:14:46 2001
@@ -18,6 +18,7 @@
  *    Torbjörn Lindh (torbjorn.lindh@gopta.se), April 14, 1996.
  *  Added devfs support: Richard Gooch <rgooch@atnf.csiro.au>, 13-JAN-1998
  *  Heavily rewritten for 'one fs - one tree' dcache architecture. AV, Mar 2000
+ *  Added paratition boundary checks: Dan Aloni <dax@karrde.org>, Jan 2001
  */
 
 #include <linux/config.h>
@@ -30,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/quotaops.h>
 #include <linux/acct.h>
+#include <linux/genhd.h>
 
 #include <asm/uaccess.h>
 
@@ -718,11 +720,63 @@
 	return s;
 }
 
+/**
+ *	paratition_in_range - 	checks if a paratition is in range
+ *				of the drive's sectors
+ *
+ *	Used for sanity checks before mounting. 
+ *	Returns true when the device is not a paratition, and false if the
+ *     device is a paratition which isn't the range of its drive.
+ *
+ */
+
+static int paratition_in_range(kdev_t dev)
+{
+	int major = MAJOR(dev);
+	int minor = MINOR(dev);
+	int hdsize, psize, pofs, first_minor;
+	struct gendisk *dsk;
+	
+	/* get the gendisk struct for this device */
+	for (dsk = gendisk_head; dsk; dsk = dsk->next)
+		if (dsk->major == major)
+			break;
+
+	/* returns true for all non-disk devices */
+	if (!dsk) 
+		return 1;
+		
+	first_minor = minor & ~((1 << dsk->minor_shift) - 1);
+	if (first_minor == minor) 
+		return 1; /* this is the drive itself not a paratition */
+	
+	/* get disk size in sectors */
+	hdsize = dsk->part[first_minor].nr_sects;
+	
+	if (hdsize > 0) {
+		psize = dsk->part[minor].nr_sects; /* paratition size */
+		pofs = dsk->part[minor].start_sect; /* paratition offset */
+		
+		/* checks if paratition is not in range of disk's sectors */
+		if (!(pofs >= 0  &&  pofs < hdsize  &&  pofs + psize <= hdsize))
+			return 0;
+	}	
+	return 1;
+}
+
 static struct super_block * read_super(kdev_t dev, struct block_device *bdev,
 				       struct file_system_type *type, int flags,
 				       void *data, int silent)
 {
-	struct super_block * s;
+	struct super_block * s = NULL;
+	
+	if (!paratition_in_range(dev)) {
+		printk("VFS: cannot mount device (%02d:%02d), "
+			"paratition is out of boundary\n", 
+			MAJOR(dev), MINOR(dev));
+		goto out;
+	}
+	
 	s = get_empty_super();
 	if (!s)
 		goto out;


-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
