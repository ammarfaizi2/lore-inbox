Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262993AbTDBMuw>; Wed, 2 Apr 2003 07:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262994AbTDBMuw>; Wed, 2 Apr 2003 07:50:52 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:4624 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262993AbTDBMus>; Wed, 2 Apr 2003 07:50:48 -0500
Date: Wed, 2 Apr 2003 15:02:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Joel Becker <Joel.Becker@oracle.com>,
       bert hubert <ahu@ds9a.nl>, <Andries.Brouwer@cwi.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030401163522.GD1448@kroah.com>
Message-ID: <Pine.LNX.4.44.0304021442460.12110-100000@serv>
References: <Pine.LNX.4.44.0303281031120.5042-100000@serv>
 <20030328180545.GG32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303281924530.5042-100000@serv>
 <20030331083157.GA29029@outpost.ds9a.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv>
 <20030331172403.GM32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303312215020.5042-100000@serv>
 <1049149133.1287.1.camel@dhcp22.swansea.linux.org.uk>
 <Pine.LNX.4.44.0304010137250.5042-100000@serv>
 <1049208134.16073.11.camel@dhcp22.swansea.linux.org.uk> <20030401163522.GD1448@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 1 Apr 2003, Greg KH wrote:

> On Tue, Apr 01, 2003 at 03:42:14PM +0100, Alan Cox wrote:
> 
> > We need to default to 12:20 for char but where the 20 is actually
> > defaulting to 0000xx so we don't get extra minors for any device
> > that hasnt been audited for it

Why do we need to introduce new arbitrary limits?
I played a bit with the patch below, which adds dynamic device numbers and 
with a simple script like this the corresponding dev entries can be 
created:

mount -tsysfs none /sysfs
cd /sysfs/block
for d in *; do
        n=0x`cat $d/dev`
        ~/mn /dev/$d $n
        p=1
        while [ $p -lt `cat $d/range` ]; do
                ~/mn /dev/$d$p $[$n+$p]
                p=$[$p+1]
        done
done

We are sooo close to dynamic device numbers, so I really don't understand 
why people want to go back all the way back to static numbers.
The kernel is mostly ready, what is missing now is the userspace and a 
driver audit.

> I thought Andries's patch prevented the need for this, as it restricted
> the number of minors assigned to a device unless they converted to the
> new API.

This 'new API' is _huge_ step backwards, because it puts the burden of 
managing static device numbers on the drivers again.

bye, Roman

Index: drivers/block/genhd.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/drivers/block/genhd.c,v
retrieving revision 1.1.1.31
diff -u -p -r1.1.1.31 genhd.c
--- drivers/block/genhd.c	25 Mar 2003 09:21:17 -0000	1.1.1.31
+++ drivers/block/genhd.c	2 Apr 2003 11:07:16 -0000
@@ -253,6 +253,14 @@ static int exact_lock(dev_t dev, void *d
  */
 void add_disk(struct gendisk *disk)
 {
+	if (disk->flags & GENHD_FL_DYNAMIC) {
+		static dev_t next_dev = 0x10000;
+
+		disk->major = MAJOR(next_dev);
+		disk->first_minor = 0;
+		next_dev += 0x100;
+	}
+
 	disk->flags |= GENHD_FL_UP;
 	blk_register_region(MKDEV(disk->major, disk->first_minor),
 			    disk->minors, NULL, exact_match, exact_lock, disk);
Index: drivers/scsi/sd.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/drivers/scsi/sd.c,v
retrieving revision 1.1.1.38
diff -u -p -r1.1.1.38 sd.c
--- drivers/scsi/sd.c	18 Mar 2003 09:37:07 -0000	1.1.1.38
+++ drivers/scsi/sd.c	2 Apr 2003 12:41:34 -0000
@@ -56,7 +56,7 @@
  * Remaining dev_t-handling stuff
  */
 #define SD_MAJORS	16
-#define SD_DISKS	(SD_MAJORS << 4)
+#define SD_DISKS	4096
 
 /*
  * Time out in seconds for disks and Magneto-opticals (which are slower).
@@ -125,8 +125,7 @@ static int sd_major(int major_idx)
 	case 8 ... 15:
 		return SCSI_DISK8_MAJOR + major_idx;
 	default:
-		BUG();
-		return 0;	/* shut up gcc */
+		return 0;
 	}
 }
 
@@ -1344,6 +1343,10 @@ static int sd_attach(struct scsi_device 
 
 	gd->driverfs_dev = &sdp->sdev_driverfs_dev;
 	gd->flags = GENHD_FL_DRIVERFS | GENHD_FL_DEVFS;
+#if 0
+	if (!gd->major)
+#endif
+		gd->flags |= GENHD_FL_DYNAMIC;
 	if (sdp->removable)
 		gd->flags |= GENHD_FL_REMOVABLE;
 	gd->private_data = &sdkp->driver;
Index: include/asm-i386/posix_types.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/asm-i386/posix_types.h,v
retrieving revision 1.1.1.2
diff -u -p -r1.1.1.2 posix_types.h
--- include/asm-i386/posix_types.h	25 Feb 2003 11:50:47 -0000	1.1.1.2
+++ include/asm-i386/posix_types.h	2 Apr 2003 11:07:16 -0000
@@ -7,7 +7,7 @@
  * assume GCC is being used.
  */
 
-typedef unsigned short	__kernel_dev_t;
+typedef unsigned long	__kernel_dev_t;
 typedef unsigned long	__kernel_ino_t;
 typedef unsigned short	__kernel_mode_t;
 typedef unsigned short	__kernel_nlink_t;
Index: include/linux/genhd.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/linux/genhd.h,v
retrieving revision 1.1.1.18
diff -u -p -r1.1.1.18 genhd.h
--- include/linux/genhd.h	18 Mar 2003 09:39:54 -0000	1.1.1.18
+++ include/linux/genhd.h	2 Apr 2003 11:07:16 -0000
@@ -71,6 +71,7 @@ struct hd_struct {
 #define GENHD_FL_DEVFS	4
 #define GENHD_FL_CD	8
 #define GENHD_FL_UP	16
+#define GENHD_FL_DYNAMIC 32
 
 struct disk_stats {
 	unsigned read_sectors, write_sectors;
Index: include/linux/kdev_t.h
===================================================================
RCS file: /home/other/cvs/linux/linux-2.5/include/linux/kdev_t.h,v
retrieving revision 1.1.1.6
diff -u -p -r1.1.1.6 kdev_t.h
--- include/linux/kdev_t.h	5 Nov 2002 10:48:59 -0000	1.1.1.6
+++ include/linux/kdev_t.h	2 Apr 2003 11:07:16 -0000
@@ -70,7 +70,7 @@ aeb - 950811
  * static arrays, and they are sized for a 8-bit index.
  */
 typedef struct {
-	unsigned short value;
+	unsigned long value;
 } kdev_t;
 
 #define KDEV_MINOR_BITS		8
@@ -112,7 +112,7 @@ static inline int kdev_same(kdev_t dev1,
 
 /* Mask off the high bits for now.. */
 #define minor(dev)	((dev).value & 0xff)
-#define major(dev)	(((dev).value >> KDEV_MINOR_BITS) & 0xff)
+#define major(dev)	((dev).value >> KDEV_MINOR_BITS)
 
 /* These are for user-level "dev_t" */
 #define MINORBITS	8

