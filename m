Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTIPOuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTIPOuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:50:05 -0400
Received: from mailout.zma.compaq.com ([161.114.64.103]:2057 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S261804AbTIPOto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:49:44 -0400
Date: Tue, 16 Sep 2003 09:59:19 -0500
From: mike.miller@hp.com
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: >8 controller support for cciss
Message-ID: <20030916145919.GA30892@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch enables support for more than 8 controllers in the cciss driver. It was tested against the 2.4.23-pre4 kernel tree.

Changes:
Enables support for more than 8 controllers by passing 0 as a major number and allowing the OS the to dynamically assign a major number. Primary reasons for this are to support the 6402 & 6404 controllers and to avoid preallocating any more major numbers than we already have.

Please consider this for inclusion.

Thanks,
mikem
--------------------------------------------------------------------------------
diff -burN lx2422rc2-detect/Documentation/cciss.txt lx2422rc2/Documentation/cciss.txt
--- lx2422rc2-detect/Documentation/cciss.txt	2003-08-12 13:37:02.000000000 -0500
+++ lx2422rc2/Documentation/cciss.txt	2003-08-12 13:50:21.000000000 -0500
@@ -53,6 +53,56 @@
 /dev/cciss/c1d1p2		Controller 1, disk 1, partition 2
 /dev/cciss/c1d1p3		Controller 1, disk 1, partition 3
 
+Support for more than 8 controllers
+-----------------------------------
+Originally the driver only supports 8 controllers in the system,
+and this is due to the major numbers assigned to the driver
+(104 thru 111).
+
+The driver can now support up to 32 controllers in the system.
+
+For the ninth controller and beyond, the major numbers will be
+assigned dynamically by the kernel when it is discovered,
+and there is no guarantee what the major number you will get,
+but most likely it will start from 254 and goes down from there.
+
+You can check the assigned major numbers by typing
+	cat /proc/devices
+And look for cciss controllers
+
+Once you have this, you need to create device nodes in
+/dev/cciss directory. The nodes for the first 8 controllers
+should already be created by mkdev.cciss script or
+/etc/makedev.d/cciss script. You can add the major number(s)
+in those scripts, or create the nodes manually by using
+the mknod command.
+
+You can also use mknod_dyn.cciss and rmnod_dyn.cciss scripts
+to create or remove nodes easily. These scripts can be found
+in the Documentation directory.
+
+Then you can mount the devices and create partitions
+(You also need to make nodes for these partitions).
+
+As for the minor number, the disk device will have a minor
+number divisible by 16 (e.g: 0, 16, 32 etc), and the 
+partitions on those disk devices will have the minor number
+of the disk device plus the partition number (1-15).
+For example, disk d2 will have minor number 32, and its
+partitions 1 and 2 will have minor numbers 33 and 34.
+
+Look at the mkdev.cciss script for example.
+ 
+Note:
+ In 2.4 kernel, partition names are hard coded in
+ /usr/src/linux/fs/partitions/check.c
+ and only for the first 8 cciss controllers. The rest
+ will be reported as ccissXX. This should not affect 
+ I/O operation or performance. Please apply the 
+ cciss_2.4_partition_name.patch to address this. This 
+ will not be an issue under 2.5 kernel, since partition
+ names will be handled by the driver.
+
 SCSI tape drive and medium changer support
 ------------------------------------------
 
diff -burN lx2422rc2-detect/Documentation/mkdev_dyn.cciss lx2422rc2/Documentation/mkdev_dyn.cciss
--- lx2422rc2-detect/Documentation/mkdev_dyn.cciss	1969-12-31 18:00:00.000000000 -0600
+++ lx2422rc2/Documentation/mkdev_dyn.cciss	2003-08-12 13:50:21.000000000 -0500
@@ -0,0 +1,171 @@
+#!/bin/sh
+#
+# Author: Francis Wiran <Francis.Wiran@hp.com>
+#
+# Script to create device nodes for SMART Array controllers, idea from
+# mkdev.cciss found in Documentation. The argument syntax is different,
+# hence, the name change.
+#
+# Usage:
+# 	mkdev_dyn.cciss [ctlr num] [major num] [num log vol] [num partitions]
+#
+# With no arguments, the script will check to see if there are any cciss
+# nodes already created in the /dev directory. If so, then it will assume
+# that the nodes for the first 8 controllers are already created by
+# /etc/makedev.d, which is likely. If not, then the script will create 
+# them, using the major numbers reserved for cciss controllers (104 thru 111).
+#
+# After that, it will start creating nodes for the controllers which major
+# numbers are dynamically allocated by the kernel. It will check 
+# /proc/devices for any cciss controllers with major numbers other than
+# 104 thru 111 and creates the nodes.
+#
+# Note that it is a good idea to run rmdev_dyn.cciss script if you remove
+# those controllers (the ones which major numbers were dynamically allocated)
+# This will unclutter /dev, as well as preventing possible problems due to 
+# referenced devices and major numbers no longer available or taken by
+# other non-cciss drivers.
+#
+# With no arguments, the script assumes 16 logical volumes per controller
+# and 16 partitions per volume; 
+#
+# Passing arguments:
+# If you know that one of your controllers, say cciss8, has been dynamically 
+# assigned major number 254, and were planning on no more than 2 logical 
+# volumes, using a maximum of 4 partitions per volume, you could do:
+#
+# mkdev_dyn.cciss 8 254 2 4
+#
+# Of course, this has no real benefit over "mkdev_dyn.cciss 8 254" except 
+# that it doesn't create as many device nodes in /dev/cciss.
+#
+
+# Inputs
+NR_CTLR=${1-8}
+NR_MAJOR=${2-254}
+NR_VOL=${3-16}
+NR_PART=${4-16}
+
+echo_usage()
+{
+	echo "Usage: mkdev_dyn.cciss [ctlr num] [maj] [volumes] [partitions]"
+	echo "The script assumes that ctlr 0 thru 7 is statically created"
+	echo "Therefore, if you want to pass arguments make sure that"
+	echo "ctlr num is equal or greater than 8, and the major number"
+	echo "is not one that's statically assigned for cciss controller."
+	echo "Check the correct major number in /proc/devices"
+
+	# Hmm... we don't support volumes and partitions greater than 16
+	# either.
+}
+
+echo_create()
+{
+	echo "created /dev/cciss/c${1}* nodes using major number ${2}"
+}
+
+
+# Function: do_mknod()
+#           Creates devices nodes under /dev/cciss
+# Inputs: $1 - ctlr number
+#	  $2 - major number
+#	  $3 - number of devices on controller
+#	  $4 - number of partitions per device
+do_mknod()
+{
+	D=0;
+	while [ $D -lt $3 ]; do
+		P=0;
+		while [ $P -lt $4 ]; do
+			MIN=`expr $D \* 16 + $P`;
+			if [ $P -eq 0 ]; then
+				mknod /dev/cciss/c${1}d${D} b $2 $MIN
+			else
+				mknod /dev/cciss/c${1}d${D}p${P} b $2 $MIN
+			fi
+			P=`expr $P + 1`;
+		done
+		D=`expr $D + 1`;
+	done
+}
+
+# Function: do_dyn
+#           Search and create cciss nodes for the controllers which
+#           major numbers are allocated dynamically by the kernel
+#           instead of using kernel.org 's value of 104 to 111.
+#
+# Input: $1 - ctlr num - will create nodes /dev/cciss/c${1}
+#	 $2 - major num - the major number to assign to the nodes
+#	 $3 - volumes - max number of volumes per controller
+#	 $4 - partitions - max number of partitions per volume
+#
+# Note: Without input, this function will start creating nodes
+#       for controller c8 and above, making assumption that 
+#       c0 thru c7 are already made, and the name c8 and above 
+#       are not already taken.
+do_dyn()
+{
+	if [ $# -eq 0 ]; then
+		C=0;
+		for MAJ in `cat /proc/devices |\
+			grep cciss |\
+			awk '/cciss[0-9]$/ { sub("cciss", "cciss0") }; {print}' |\
+			sort -k 2,2 |\
+			awk '{print $1-i}'`;
+		do
+			if [ `ls -l /dev/cciss/c* |\
+				awk '{print $5-i}' |\
+				uniq |\
+				grep $MAJ |\
+				wc -l` -gt 0 ]; then
+				:
+			else
+				do_mknod $C $MAJ $NR_VOL $NR_PART;
+				echo_create $C $MAJ;
+			fi
+			C=`expr $C + 1`;
+		done
+	else
+		do_mknod $1 $2 $3 $4;
+		echo_create $1 $2;
+	fi
+	
+	exit
+}
+
+# Start here
+
+# Check the input values
+if [ $NR_CTLR -lt 8 ]; then
+	echo_usage;
+	exit
+fi
+
+if [ $NR_CTLR -ge 8 ]; then
+	if [ \( $NR_MAJOR -ge 104 \) -a \( $NR_MAJOR -le 111 \) ]; then
+		echo_usage;
+		exit
+	fi
+fi
+
+if [ ! -d /dev/cciss ]; then
+        mkdir -p /dev/cciss
+fi
+
+# Assume that if c0d0p1 node already exist, then all nodes from c0d0p1
+# to c7d15p15 have been created for us.
+if [ ! -b /dev/cciss/c0d0p1 ]; then
+	C=0; 
+	while [ $C -lt 8 ]; do
+		MAJ=`expr $C + 104`;
+		do_mknod $C $MAJ $NR_VOL $NR_PART;
+		echo_create $C $MAJ;
+		C=`expr $C + 1`;
+	done
+fi
+
+if [ $# -gt 0 ]; then
+	do_dyn $NR_CTLR $NR_MAJOR $NR_VOL $NR_PART;
+else
+	do_dyn;
+fi
diff -burN lx2422rc2-detect/Documentation/rmdev_dyn.cciss lx2422rc2/Documentation/rmdev_dyn.cciss
--- lx2422rc2-detect/Documentation/rmdev_dyn.cciss	1969-12-31 18:00:00.000000000 -0600
+++ lx2422rc2/Documentation/rmdev_dyn.cciss	2003-08-12 13:50:21.000000000 -0500
@@ -0,0 +1,87 @@
+#!/bin/sh 
+#
+# Author: Francis Wiran <Francis.Wiran@hp.com>
+#
+# Script to remove device nodes for SMART Array controllers. This will
+# be the device nodes with major numbers which are dynamically allocated
+# by the kernel. This script will not attempt to remove the device
+# nodes with major number 104 thru 111 (c0 thru c7), which are 
+# the major numbers that's allocated for cciss controllers by kernel.org.
+#
+# Usage:
+# rmdev_dyn.cciss [ctlr num]
+#
+# With no arguments, the script will check to see if there are any nodes
+# under /dev/cciss, whose major number no longer shows in /proc/partitions,
+# or to be exact, no longer shows to be owned by cciss driver.
+# If there is, then it will be removed.
+#
+# Note that it is a good idea to run rmdev_dyn.cciss script if you remove
+# those controllers (the ones which major numbers were dynamically allocated)
+# This will unclutter /dev, as well as preventing possible problems due to
+# referenced devices and major numbers no longer available or taken by
+# other non-cciss drivers.
+#
+# Passing arguments:
+# If you know that one of your controllers, say cciss8, has been removed
+# and the nodes are no longer valid, you could do
+#
+# rmdev_dyn.cciss 8 
+#
+# This is the same as doing `rm -f /dev/cciss/c8*` 
+
+# Inputs
+NR_CTLR=${1}
+
+echo_usage()
+{
+	echo "Usage: rmdev_dyn.cciss [ctlr num]"
+	echo "The script will not attempt to remove nodes for controllers"
+	echo "0 thru 7, therefore if you want to pass an argument,"
+	echo "make sure that ctlr num is equal or greater than 8"
+}
+
+rm_nod1()
+{
+	if [ $1 -lt 8 ]; then
+		echo_usage;
+		exit
+	else
+		rm -f /dev/cciss/c${1}*
+		echo "removed /dev/cciss/c${1}*"
+	fi
+}
+
+rm_nod2()
+{
+	for X in `ls -l /dev/cciss/c* |\
+		awk '{print $5-i}' |\
+		uniq`; do
+		if [ \( $X -ge 104 \) -a \( $X -le 111 \) ]; then
+			:
+		elif [ `cat /proc/devices |\
+			grep cciss |\
+			grep $X |\
+			wc -l` -eq 0 ]; then
+
+			Y=`ls -l /dev/cciss/ |\
+				awk '{print $5-i ":"  $10}'|\
+				tr d ':' |\
+				grep $X |\
+				awk -F: '{print $2}' |\
+				uniq`
+
+			Z="/dev/cciss/${Y}*"
+
+			rm -f $Z
+			echo "removed $Z"
+		fi
+	done
+}
+
+# Start here
+if [ $# -gt 0 ]; then
+	rm_nod1 $NR_CTLR;
+else
+	rm_nod2;
+fi
diff -burN lx2422rc2-detect/drivers/block/cciss.c lx2422rc2/drivers/block/cciss.c
--- lx2422rc2-detect/drivers/block/cciss.c	2003-08-12 13:38:55.000000000 -0500
+++ lx2422rc2/drivers/block/cciss.c	2003-08-12 14:15:16.000000000 -0500
@@ -106,7 +106,15 @@
 
 #define READ_AHEAD 	 128
 #define NR_CMDS		 128 /* #commands that can be outstanding */
-#define MAX_CTLR 8
+#define MAX_CTLR	 32 
+
+/* No sense in giving up our preallocated major numbers */
+#if MAX_CTLR < 8
+#error"cciss.c: MAX_CTLR must be 8 or greater"
+#endif
+
+/* Originally cciss driver only supports 8 major number */
+#define MAX_CTLR_ORIG  COMPAQ_CISS_MAJOR7 - COMPAQ_CISS_MAJOR + 1
 
 #define CCISS_DMA_MASK 0xFFFFFFFFFFFFFFFF /* 64 bit DMA */
 
@@ -121,7 +129,7 @@
 #endif
 
 static ctlr_info_t *hba[MAX_CTLR];
-
+static int map_major_to_ctlr[MAX_BLKDEV] = {0}; /* gets ctlr num from maj num */
 static struct proc_dir_entry *proc_cciss;
 
 static void do_cciss_request(request_queue_t *q);
@@ -421,7 +429,7 @@
  */
 static int cciss_open(struct inode *inode, struct file *filep)
 {
-	int ctlr = MAJOR(inode->i_rdev) - MAJOR_NR;
+ 	int ctlr = map_major_to_ctlr[MAJOR(inode->i_rdev)];
 	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
 
 #ifdef CCISS_DEBUG
@@ -462,7 +470,7 @@
  */
 static int cciss_release(struct inode *inode, struct file *filep)
 {
-	int ctlr = MAJOR(inode->i_rdev) - MAJOR_NR;
+	int ctlr = map_major_to_ctlr[MAJOR(inode->i_rdev)];
 	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
 
 #ifdef CCISS_DEBUG
@@ -482,7 +490,7 @@
 static int cciss_ioctl(struct inode *inode, struct file *filep, 
 		unsigned int cmd, unsigned long arg)
 {
-	int ctlr = MAJOR(inode->i_rdev) - MAJOR_NR;
+	int ctlr = map_major_to_ctlr[MAJOR(inode->i_rdev)];
 	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
 
 #ifdef CCISS_DEBUG
@@ -1028,7 +1036,7 @@
         int i;
 
         target = MINOR(dev) >> NWD_SHIFT;
-        ctlr = MAJOR(dev) - MAJOR_NR;
+	ctlr = map_major_to_ctlr[MAJOR(dev)];
         gdev = &(hba[ctlr]->gendisk);
 
         spin_lock_irqsave(&io_request_lock, flags);
@@ -1047,12 +1055,12 @@
 
         for(i=max_p-1; i>=0; i--) {
                 int minor = start+i;
-                invalidate_device(MKDEV(MAJOR_NR + ctlr, minor), 1);
+                invalidate_device(MKDEV(hba[ctlr]->major, minor), 1);
                 gdev->part[minor].start_sect = 0;
                 gdev->part[minor].nr_sects = 0;
 
                 /* reset the blocksize so we can read the partition table */
-                blksize_size[MAJOR_NR+ctlr][minor] = 1024;
+                blksize_size[hba[ctlr]->major][minor] = 1024;
         }
 	/* setup partitions per disk */
 	grok_partitions(gdev, target, MAX_PART, 
@@ -1093,7 +1101,7 @@
 	for (i=max_p-1; i>=0; i--) {
 		int minor = start+i;
 		/* printk("invalidating( %d %d)\n", ctlr, minor); */
-		invalidate_device(MKDEV(MAJOR_NR+ctlr, minor), 1);
+		invalidate_device(MKDEV(hba[ctlr]->major, minor), 1);
 		/* so open will now fail */
 		h->sizes[minor] = 0;
 		/* so it will no longer appear in /proc/partitions */
@@ -1581,12 +1589,12 @@
 
 	for(i=max_p-1; i>=0; i--) {
 		int minor = start+i;
-		invalidate_device(MKDEV(MAJOR_NR + ctlr, minor), 1);
+		invalidate_device(MKDEV(hba[ctlr]->major, minor), 1);
 		gdev->part[minor].start_sect = 0;
 		gdev->part[minor].nr_sects = 0;
 
 		/* reset the blocksize so we can read the partition table */
-		blksize_size[MAJOR_NR+ctlr][minor] = block_size;
+		blksize_size[hba[ctlr]->major][minor] = block_size;
 		hba[ctlr]->hardsizes[minor] = block_size;
 	}
 
@@ -1700,12 +1708,12 @@
 
 	for (i=max_p-1; i>=0; i--) {
 		int minor = start+i;
-		invalidate_device(MKDEV(MAJOR_NR + ctlr, minor), 1);
+		invalidate_device(MKDEV(hba[ctlr]->major, minor), 1);
 		gdev->part[minor].start_sect = 0;
 		gdev->part[minor].nr_sects = 0;
 
 		/* reset the blocksize so we can read the partition table */
-		blksize_size[MAJOR_NR+ctlr][minor] = 1024;
+		blksize_size[hba[ctlr]->major][minor] = block_size;
 		hba[ctlr]->hardsizes[minor] = block_size;
 	}
 
@@ -2269,7 +2277,7 @@
 	if (creq->nr_segments > MAXSGENTRIES)
                 BUG();
 
-        if (h->ctlr != MAJOR(creq->rq_dev)-MAJOR_NR ) {
+	if( h->ctlr != map_major_to_ctlr[MAJOR(creq->rq_dev)] ) {
                 printk(KERN_WARNING "doreq cmd for %d, %x at %p\n",
                                 h->ctlr, creq->rq_dev, creq);
                 blkdev_dequeue_request(creq);
@@ -2436,7 +2444,7 @@
 	/*
 	 * See if we can queue up some more IO
 	 */
-	do_cciss_request(BLK_DEFAULT_QUEUE(MAJOR_NR + h->ctlr));
+	do_cciss_request(BLK_DEFAULT_QUEUE(h->major));
 	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 /* 
@@ -2874,8 +2882,10 @@
 			return i;
 		}
 	}
-	printk(KERN_WARNING "cciss: This driver supports a maximum"
-		" of 8 controllers.\n");
+	printk(KERN_WARNING 
+		"cciss: This driver supports a maximum of %d controllers.\n"
+		"You can change this value in cciss.c and recompile.\n",
+		MAX_CTLR);
 	return -1;
 }
 
@@ -3063,6 +3073,7 @@
 	request_queue_t *q;
 	int i;
 	int j;
+	int rc;
 
 	printk(KERN_DEBUG "cciss: Device 0x%x has been found at"
 			" bus %d dev %d func %d\n",
@@ -3078,16 +3089,33 @@
 	}
 	sprintf(hba[i]->devname, "cciss%d", i);
 	hba[i]->ctlr = i;
+
+	/* register with the major number, or get a dynamic major number */
+	/* by passing 0 as argument */
+
+	if (i < MAX_CTLR_ORIG)
+		hba[i]->major = MAJOR_NR + i;
+
 	hba[i]->pdev = pdev;
 	ASSERT_CTLR_ALIVE(hba[i]);
 
-	if (register_blkdev(MAJOR_NR+i, hba[i]->devname, &cciss_fops)) {
+	rc = (register_blkdev(hba[i]->major, hba[i]->devname, &cciss_fops));
+	if (rc < 0) {
 		printk(KERN_ERR "cciss:  Unable to get major number "
-			"%d for %s\n", MAJOR_NR+i, hba[i]->devname);
+			"%d for %s\n", hba[i]->major, hba[i]->devname);
 		release_io_mem(hba[i]);
 		free_hba(i);
 		return -1;
+	} else {
+		if (i < MAX_CTLR_ORIG) {
+			hba[i]->major = MAJOR_NR + i;
+			map_major_to_ctlr[MAJOR_NR + i] = i;
+		} else {
+			hba[i]->major = rc;
+			map_major_to_ctlr[rc] = i;
+		}
 	}
+
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
 	if (request_irq(hba[i]->intr, do_cciss_intr, 
@@ -3096,7 +3124,8 @@
 
 		printk(KERN_ERR "cciss: Unable to get irq %d for %s\n",
 			hba[i]->intr, hba[i]->devname);
-		unregister_blkdev( MAJOR_NR+i, hba[i]->devname);
+		unregister_blkdev( hba[i]->major, hba[i]->devname);
+		map_major_to_ctlr[hba[i]->major] = 0;
 		release_io_mem(hba[i]);
 		free_hba(i);
 		return -1;
@@ -3125,7 +3154,8 @@
 				hba[i]->errinfo_pool, 
 				hba[i]->errinfo_pool_dhandle);
                 free_irq(hba[i]->intr, hba[i]);
-                unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+                unregister_blkdev(hba[i]->major, hba[i]->devname);
+		map_major_to_ctlr[hba[i]->major] = 0;
 		release_io_mem(hba[i]);
 		free_hba(i);
                 printk( KERN_ERR "cciss: out of memory");
@@ -3152,16 +3182,16 @@
 
 	cciss_procinit(i);
 
-	q = BLK_DEFAULT_QUEUE(MAJOR_NR + i);
+	q = BLK_DEFAULT_QUEUE(hba[i]->major);
 	q->queuedata = hba[i];
 	blk_init_queue(q, do_cciss_request);
 	blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
 	blk_queue_headactive(q, 0);		
 
 	/* fill in the other Kernel structs */
-	blksize_size[MAJOR_NR+i] = hba[i]->blocksizes;
-        hardsect_size[MAJOR_NR+i] = hba[i]->hardsizes;
-        read_ahead[MAJOR_NR+i] = READ_AHEAD;
+	blksize_size[hba[i]->major] = hba[i]->blocksizes;
+        hardsect_size[hba[i]->major] = hba[i]->hardsizes;
+        read_ahead[hba[i]->major] = READ_AHEAD;
 
 	/* Set the pointers to queue functions */ 
 	q->back_merge_fn = cpq_back_merge_fn;
@@ -3170,7 +3200,7 @@
 
 
 	/* Fill in the gendisk data */ 	
-	hba[i]->gendisk.major = MAJOR_NR + i;
+	hba[i]->gendisk.major = hba[i]->major;
 	hba[i]->gendisk.major_name = "cciss";
 	hba[i]->gendisk.minor_shift = NWD_SHIFT;
 	hba[i]->gendisk.max_p = MAX_PART;
@@ -3185,7 +3215,7 @@
 	cciss_geninit(i);
 	for(j=0; j<NWD; j++)
 		register_disk(&(hba[i]->gendisk),
-			MKDEV(MAJOR_NR+i, j <<4), 
+			MKDEV(hba[i]->major, j <<4), 
 			MAX_PART, &cciss_fops, 
 			hba[i]->drv[j].nr_blocks);
 
@@ -3228,7 +3258,8 @@
 	pci_set_drvdata(pdev, NULL);
 	iounmap((void*)hba[i]->vaddr);
 	cciss_unregister_scsi(i);  /* unhook from SCSI subsystem */
-	unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+	unregister_blkdev(hba[i]->major, hba[i]->devname);
+	map_major_to_ctlr[hba[i]->major] = 0;
 	remove_proc_entry(hba[i]->devname, proc_cciss);	
 	
 
diff -burN lx2422rc2-detect/drivers/block/cciss.h lx2422rc2/drivers/block/cciss.h
--- lx2422rc2-detect/drivers/block/cciss.h	2003-08-12 13:37:02.000000000 -0500
+++ lx2422rc2/drivers/block/cciss.h	2003-08-12 13:50:21.000000000 -0500
@@ -40,6 +40,7 @@
 struct ctlr_info 
 {
 	int	ctlr;
+	int	major;
 	char	devname[8];
 	char    *product_name;
 	char	firm_ver[4]; // Firmware version 
diff -burN lx2422rc2-detect/drivers/block/cciss_scsi.c lx2422rc2/drivers/block/cciss_scsi.c
--- lx2422rc2-detect/drivers/block/cciss_scsi.c	2003-08-12 13:22:26.000000000 -0500
+++ lx2422rc2/drivers/block/cciss_scsi.c	2003-08-12 13:50:21.000000000 -0500
@@ -71,16 +71,7 @@
 #endif
 #endif
 
-static struct cciss_scsi_hba_t ccissscsi[MAX_CTLR] = {
-	{ name: "cciss0", ndevices: 0 },
-	{ name: "cciss1", ndevices: 0 },
-	{ name: "cciss2", ndevices: 0 },
-	{ name: "cciss3", ndevices: 0 },
-	{ name: "cciss4", ndevices: 0 },
-	{ name: "cciss5", ndevices: 0 },
-	{ name: "cciss6", ndevices: 0 },
-	{ name: "cciss7", ndevices: 0 },
-};
+static struct cciss_scsi_hba_t ccissscsi[MAX_CTLR];
 
 /* We need one Scsi_Host_Template *per controller* instead of
    the usual one Scsi_Host_Template per controller *type*. This
@@ -92,11 +83,7 @@
    (that's called from cciss.c:cciss_init_one()) */
 
 static
-Scsi_Host_Template driver_template[MAX_CTLR] =
-{
-	CCISS_SCSI, CCISS_SCSI, CCISS_SCSI, CCISS_SCSI,
-	CCISS_SCSI, CCISS_SCSI, CCISS_SCSI, CCISS_SCSI,
-};
+Scsi_Host_Template driver_template[MAX_CTLR];
 
 #pragma pack(1)
 struct cciss_scsi_cmd_stack_elem_t {
@@ -803,13 +790,7 @@
 
 	sh->this_id = SELF_SCSI_ID;
 
-	/* This is a bit kludgey, using the adapter name to figure out */
-	/* which scsi host template we've got, won't scale beyond 9 ctlrs. */
-	i = tpnt->name[5] - '0';
-
-#	if MAX_CTLR > 9
-#		error "cciss_scsi.c: MAX_CTLR > 9, code maintenance needed."
-#	endif
+	i = simple_strtol((char *)&tpnt->name[5], NULL, 10);
 
 	if (i<0 || i>=MAX_CTLR || hba[i] == NULL) {
 		/* we didn't find ourself... we shouldn't get here. */
@@ -1528,9 +1509,10 @@
 	unsigned long flags;
 
 	CPQ_TAPE_LOCK(ctlr, flags);
-	driver_template[ctlr].name = ccissscsi[ctlr].name;
-	driver_template[ctlr].proc_name = ccissscsi[ctlr].name;
-	driver_template[ctlr].module = THIS_MODULE;;
+
+	sprintf( ccissscsi[ctlr].name, "cciss%d", ctlr );
+	
+	init_driver_template(ctlr);
 
 	/* Since this is really a block driver, the SCSI core may not be
 	   initialized yet, in which case, calling scsi_register_module
diff -burN lx2422rc2-detect/drivers/block/cciss_scsi.h lx2422rc2/drivers/block/cciss_scsi.h
--- lx2422rc2-detect/drivers/block/cciss_scsi.h	2003-06-13 09:51:32.000000000 -0500
+++ lx2422rc2/drivers/block/cciss_scsi.h	2003-08-12 13:50:21.000000000 -0500
@@ -89,7 +89,7 @@
 };
 
 struct cciss_scsi_hba_t {
-	char *name;
+	char name[32];
 	int ndevices;
 #define CCISS_MAX_SCSI_DEVS_PER_HBA 16
 	struct cciss_scsi_dev_t dev[CCISS_MAX_SCSI_DEVS_PER_HBA];
