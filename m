Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbRGJGyB>; Tue, 10 Jul 2001 02:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbRGJGxw>; Tue, 10 Jul 2001 02:53:52 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:46263 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265790AbRGJGxg>;
	Tue, 10 Jul 2001 02:53:36 -0400
Message-ID: <3B4AA824.550D3F15@sun.com>
Date: Tue, 10 Jul 2001 00:00:52 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH]  IDE get/set busstate ioctls
Content-Type: multipart/mixed;
 boundary="------------204317AD517094E269BCB3B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------204317AD517094E269BCB3B8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre (et al),

We spoke a while back about a GET/SET BUSSTATE API for IDE.  Attached is a
very small implementation of this API.  It adds 2 ioctls and obsoletes 1.

Please let me know if there is any reason this can not be accepted for the
mainline kernel.

Thanks

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------204317AD517094E269BCB3B8
Content-Type: text/plain; charset=us-ascii;
 name="ide_busproc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_busproc.diff"

diff -ruN dist-2.4.6/drivers/ide/ide.c cobalt-2.4.6/drivers/ide/ide.c
--- dist-2.4.6/drivers/ide/ide.c	Tue May  1 16:05:00 2001
+++ cobalt-2.4.6/drivers/ide/ide.c	Thu Jun 21 15:32:31 2001
@@ -248,6 +252,7 @@
 	hwif->name[1]	= 'd';
 	hwif->name[2]	= 'e';
 	hwif->name[3]	= '0' + index;
+	hwif->bus_state = BUSSTATE_ON;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 
@@ -2089,6 +2109,8 @@
 	hwif->quirkproc		= old_hwif.quirkproc;
 	hwif->rwproc		= old_hwif.rwproc;
 	hwif->dmaproc		= old_hwif.dmaproc;
+	hwif->busproc		= old_hwif.busproc;
+	hwif->bus_state		= old_hwif.bus_state;
 	hwif->dma_base		= old_hwif.dma_base;
 	hwif->dma_extra		= old_hwif.dma_extra;
 	hwif->config_data	= old_hwif.config_data;
@@ -2670,6 +2692,20 @@
 		case BLKELVSET:
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
diff -ruN dist-2.4.6/include/linux/hdreg.h cobalt-2.4.6/include/linux/hdreg.h
--- dist-2.4.6/include/linux/hdreg.h	Tue Jul  3 15:42:55 2001
+++ cobalt-2.4.6/include/linux/hdreg.h	Mon Jul  9 15:43:20 2001
@@ -181,9 +181,10 @@
 #define HDIO_GET_DMA		0x030b	/* get use-dma flag */
 #define HDIO_GET_NICE		0x030c	/* get nice flags */
 #define HDIO_GET_IDENTITY	0x030d	/* get IDE identification info */
+#define HDIO_GET_BUSSTATE	0x030e  /* get the bus state of the hwif */
 
 #define HDIO_DRIVE_RESET	0x031c	/* execute a device reset */
-#define HDIO_TRISTATE_HWIF	0x031d	/* execute a channel tristate */
+#define HDIO_TRISTATE_HWIF	0x031d	/* OBSOLETE - use SET_BUSSTATE */
 #define HDIO_DRIVE_TASK		0x031e	/* execute task and special drive command */
 #define HDIO_DRIVE_CMD		0x031f	/* execute a special drive command */
 
@@ -200,6 +201,14 @@
 #define HDIO_SCAN_HWIF		0x0328	/* register and (re)scan interface */
 #define HDIO_SET_NICE		0x0329	/* set nice flags */
 #define HDIO_UNREGISTER_HWIF	0x032a  /* unregister interface */
+#define HDIO_SET_BUSSTATE	0x032b  /* set the bus state of the hwif */
+
+/* bus states */
+enum {
+	BUSSTATE_OFF = 0,
+	BUSSTATE_ON,
+	BUSSTATE_TRISTATE
+};
 
 /* BIG GEOMETRY */
 struct hd_big_geometry {
diff -ruN dist-2.4.6/include/linux/ide.h cobalt-2.4.6/include/linux/ide.h
--- dist-2.4.6/include/linux/ide.h	Tue Jul  3 15:44:16 2001
+++ cobalt-2.4.6/include/linux/ide.h	Mon Jul  9 15:56:19 2001
@@ -397,6 +400,11 @@
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
@@ -467,6 +475,8 @@
 #endif
 	byte		straight8;	/* Alan's straight 8 check */
 	void		*hwif_data;	/* extra hwif data */
+	ide_busproc_t	*busproc;	/* driver soft-power interface */
+	byte		bus_state;	/* power state of the IDE bus */
 } ide_hwif_t;
 
 

--------------204317AD517094E269BCB3B8--

