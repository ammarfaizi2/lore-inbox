Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270979AbRHOAsE>; Tue, 14 Aug 2001 20:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270988AbRHOAry>; Tue, 14 Aug 2001 20:47:54 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:49645 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S270979AbRHOArp>;
	Tue, 14 Aug 2001 20:47:45 -0400
Message-ID: <3B79C781.E16B03B@sun.com>
Date: Tue, 14 Aug 2001 17:51:13 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, torvalds@transmeta.com, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide busproc() method
Content-Type: multipart/mixed;
 boundary="------------D6EFECAA8812092899309CAA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D6EFECAA8812092899309CAA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a smallpatch which implements the HDIO_GET/SET_BUSSTATE
ioctls.  These ioctl numbers were added as part of a previous patch I sent,
but the actual use of them did not get included.  

This adds support for the two ioctls and adds a hwif struct member to track
current state and a method to change the bus state.  This code is a key
part of hot-swappable IDE.

We've been using it for months without problems. Please patch this in for
the next 2.4.x.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------D6EFECAA8812092899309CAA
Content-Type: text/plain; charset=us-ascii;
 name="ide_busproc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_busproc.diff"

diff -ruN dist+patches-2.4.8/drivers/ide/ide.c cobalt-2.4.8/drivers/ide/ide.c
--- dist+patches-2.4.8/drivers/ide/ide.c	Mon Aug 13 16:52:18 2001
+++ cobalt-2.4.8/drivers/ide/ide.c	Mon Aug 13 16:41:56 2001
@@ -249,6 +253,7 @@
 	hwif->name[1]	= 'd';
 	hwif->name[2]	= 'e';
 	hwif->name[3]	= '0' + index;
+	hwif->bus_state = BUSSTATE_ON;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 
@@ -2090,6 +2112,8 @@
 	hwif->quirkproc		= old_hwif.quirkproc;
 	hwif->rwproc		= old_hwif.rwproc;
 	hwif->dmaproc		= old_hwif.dmaproc;
+	hwif->busproc		= old_hwif.busproc;
+	hwif->bus_state		= old_hwif.bus_state;
 	hwif->dma_base		= old_hwif.dma_base;
 	hwif->dma_extra		= old_hwif.dma_extra;
 	hwif->config_data	= old_hwif.config_data;
@@ -2673,6 +2697,20 @@
  		case BLKBSZSET:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
 
+		case HDIO_GET_BUSSTATE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			if (put_user(HWIF(drive)->bus_state, (long *)arg))
+				return -EFAULT;
+			return 0;
+
+		case HDIO_SET_BUSSTATE:
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			if (HWIF(drive)->busproc)
+				HWIF(drive)->busproc(HWIF(drive), arg);
+			return 0;
+
 		default:
 			if (drive->driver != NULL)
 				return DRIVER(drive)->ioctl(drive, inode, file, cmd, arg);
diff -ruN dist+patches-2.4.8/include/linux/ide.h cobalt-2.4.8/include/linux/ide.h
--- dist+patches-2.4.8/include/linux/ide.h	Fri Aug 10 18:15:44 2001
+++ cobalt-2.4.8/include/linux/ide.h	Mon Aug 13 16:42:49 2001
@@ -397,6 +403,11 @@
 typedef void (ide_rw_proc_t) (ide_drive_t *, ide_dma_action_t);
 
 /*
+ * ide soft-power support
+ */
+typedef int (ide_busproc_t) (struct hwif_s *, int);
+
+/*
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
  */
@@ -467,6 +478,8 @@
 #endif
 	byte		straight8;	/* Alan's straight 8 check */
 	void		*hwif_data;	/* extra hwif data */
+	ide_busproc_t	*busproc;	/* driver soft-power interface */
+	byte		bus_state;	/* power state of the IDE bus */
 } ide_hwif_t;
 
 

--------------D6EFECAA8812092899309CAA--

