Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263296AbRFABUp>; Thu, 31 May 2001 21:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbRFABUg>; Thu, 31 May 2001 21:20:36 -0400
Received: from patan.Sun.COM ([192.18.98.43]:9642 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263296AbRFABUT>;
	Thu, 31 May 2001 21:20:19 -0400
Message-ID: <3B16EE31.D1D829CE@sun.com>
Date: Thu, 31 May 2001 18:21:53 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [PATCH] IDE GET/SET_BUSSTATE ioctls
In-Reply-To: <Pine.LNX.4.10.10103272243300.17821-100000@master.linux-ide.org>
Content-Type: multipart/mixed;
 boundary="------------781C5C80E2756B5098370AEA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------781C5C80E2756B5098370AEA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andre,

We spoke a while back about a GET/SET BUSSTATE API for IDE.  Attached is my
(very simple) patch adding 2 ioctls, and obsoleting 1.  I will send the
implementation of this for the HPT370 in a different message.  Please let
me know if there are any problems with this preventing general inclusion.

This patch also includes support for a configurable 'max failures'
parameter, and one change for better DMA error reporting.

Tim


Andre Hedrick wrote:
> 
> Bring it on! ;-)
> 
> On Tue, 27 Mar 2001, Tim Hockin wrote:
> 
> > Andre,
> >
> > I'm doing some work toward hotswap IDE, and I had a query for you.  On
> > 2.2.x we added a HDIO_GET_BUSSTATE and HDIO_SET_BUSSTATE ioctl() pair.  Now
> > I see in 2.4 that there is an HDIO_TRISTATE_HWIF ioctl(), but no way to
> > un-tristate or query the status.
> >
> > Are there plans to add the converse APIs?  I see no one has yet implemented
> > the HWIF_TRISTATE_BUS ioctl() - would you accept my patch to
> > implement the HDIO_{GET,SET}_BUSSTATE, and implementation of it on the
> > HPT366 driver?


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------781C5C80E2756B5098370AEA
Content-Type: text/plain; charset=us-ascii;
 name="ide-failures,tristate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-failures,tristate.diff"

diff -ruN dist-2.4.5/include/linux/hdreg.h cobalt-2.4.5/include/linux/hdreg.h
--- dist-2.4.5/include/linux/hdreg.h	Fri May 25 18:01:27 2001
+++ cobalt-2.4.5/include/linux/hdreg.h	Thu May 31 14:33:16 2001
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
diff -ruN dist-2.4.5/include/linux/ide.h cobalt-2.4.5/include/linux/ide.h
--- dist-2.4.5/include/linux/ide.h	Fri May 25 18:02:42 2001
+++ cobalt-2.4.5/include/linux/ide.h	Thu May 31 14:33:16 2001
@@ -349,6 +350,8 @@
 	byte		init_speed;	/* transfer rate set at boot */
 	byte		current_speed;	/* current transfer rate set */
 	byte		dn;		/* now wide spread use */
+	unsigned int	failures;	/* current failure count */
+	unsigned int	max_failures;	/* maximum allowed failure count */
 } ide_drive_t;
 
 /*
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
 
 
diff -ruN dist-2.4.5/drivers/ide/ide.c cobalt-2.4.5/drivers/ide/ide.c
--- dist-2.4.5/drivers/ide/ide.c	Tue May  1 16:05:00 2001
+++ cobalt-2.4.5/drivers/ide/ide.c	Thu May 31 14:32:16 2001
@@ -161,6 +161,9 @@
 #include <linux/kmod.h>
 #endif /* CONFIG_KMOD */
 
+/* default maximum number of failures */
+#define IDE_DEFAULT_MAX_FAILURES 	1
+
 static const byte ide_hwif_to_major[] = { IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR, IDE5_MAJOR, IDE6_MAJOR, IDE7_MAJOR, IDE8_MAJOR, IDE9_MAJOR };
 
 static int	idebus_parameter; /* holds the "idebus=" parameter */
@@ -248,6 +251,7 @@
 	hwif->name[1]	= 'd';
 	hwif->name[2]	= 'e';
 	hwif->name[3]	= '0' + index;
+	hwif->bus_state = BUSSTATE_ON;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 
@@ -262,6 +266,7 @@
 		drive->name[0]			= 'h';
 		drive->name[1]			= 'd';
 		drive->name[2]			= 'a' + (index * MAX_DRIVES) + unit;
+		drive->max_failures		= IDE_DEFAULT_MAX_FAILURES;
 		init_waitqueue_head(&drive->wqueue);
 	}
 }
@@ -636,11 +641,14 @@
 			return ide_started;	/* continue polling */
 		}
 		printk("%s: reset timed-out, status=0x%02x\n", hwif->name, tmp);
+		drive->failures++;
 	} else  {
 		printk("%s: reset: ", hwif->name);
-		if ((tmp = GET_ERR()) == 1)
+		if ((tmp = GET_ERR()) == 1) {
 			printk("success\n");
-		else {
+			drive->failures = 0;
+		} else {
+			drive->failures++;
 #if FANCY_STATUS_DUMPS
 			printk("master: ");
 			switch (tmp & 0x7f) {
@@ -1048,6 +1056,12 @@
 	int i;
 	unsigned long flags;
  
+	/* bail early if we've exceeded max_failures */
+	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+		*startstop = ide_stopped;
+		return 1;
+	}
+
 	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
 	if ((stat = GET_STAT()) & BUSY_STAT) {
 		__save_flags(flags);	/* local CPU only */
@@ -1144,6 +1158,11 @@
 #ifdef DEBUG
 	printk("%s: start_request: current=0x%08lx\n", hwif->name, (unsigned long) rq);
 #endif
+	/* bail early if we've exceeded max_failures */
+	if (drive->max_failures && (drive->failures > drive->max_failures)) {
+		goto kill_rq;
+	}
+
 	if (unit >= MAX_DRIVES) {
 		printk("%s: bad device number: %s\n", hwif->name, kdevname(rq->rq_dev));
 		goto kill_rq;
@@ -2089,6 +2108,8 @@
 	hwif->quirkproc		= old_hwif.quirkproc;
 	hwif->rwproc		= old_hwif.rwproc;
 	hwif->dmaproc		= old_hwif.dmaproc;
+	hwif->busproc		= old_hwif.busproc;
+	hwif->bus_state		= old_hwif.bus_state;
 	hwif->dma_base		= old_hwif.dma_base;
 	hwif->dma_extra		= old_hwif.dma_extra;
 	hwif->config_data	= old_hwif.config_data;
@@ -2669,6 +2690,20 @@
 		case BLKELVGET:
 		case BLKELVSET:
 			return blk_ioctl(inode->i_rdev, cmd, arg);
+
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
 
 		default:
 			if (drive->driver != NULL)
diff -ruN dist-2.4.5/drivers/ide/ide-dma.c cobalt-2.4.5/drivers/ide/ide-dma.c
--- dist-2.4.5/drivers/ide/ide-dma.c	Mon Jan 15 13:08:15 2001
+++ cobalt-2.4.5/drivers/ide/ide-dma.c	Thu May 31 14:32:16 2001
@@ -206,7 +206,8 @@
 			}
 			return ide_stopped;
 		}
-		printk("%s: dma_intr: bad DMA status\n", drive->name);
+		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n", 
+		       drive->name, dma_stat);
 	}
 	return ide_error(drive, "dma_intr", stat);
 }
@@ -514,7 +515,7 @@
 			dma_stat = inb(dma_base+2);		/* get DMA status */
 			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
 			ide_destroy_dmatable(drive);	/* purge DMA mappings */
-			return (dma_stat & 7) != 4;	/* verify good DMA status */
+			return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 		case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
 #if 0	/* do not set unless you know what you are doing */
diff -ruN dist-2.4.5/drivers/ide/ide-disk.c cobalt-2.4.5/drivers/ide/ide-disk.c
--- dist-2.4.5/drivers/ide/ide-disk.c	Fri Feb  9 11:30:23 2001
+++ cobalt-2.4.5/drivers/ide/ide-disk.c	Thu May 31 14:32:16 2001
@@ -692,6 +692,8 @@
 	ide_add_setting(drive,	"file_readahead",	SETTING_RW,					BLKFRAGET,		BLKFRASET,		TYPE_INTA,	0,	INT_MAX,			1,	1024,	&max_readahead[major][minor],	NULL);
 	ide_add_setting(drive,	"max_kb_per_request",	SETTING_RW,					BLKSECTGET,		BLKSECTSET,		TYPE_INTA,	1,	255,				1,	2,	&max_sectors[major][minor],	NULL);
 	ide_add_setting(drive,	"lun",			SETTING_RW,					-1,			-1,			TYPE_INT,	0,	7,				1,	1,	&drive->lun,			NULL);
+	ide_add_setting(drive,	"failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->failures,		NULL);
+	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
 /*

--------------781C5C80E2756B5098370AEA--

