Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbSKCOzp>; Sun, 3 Nov 2002 09:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSKCOzp>; Sun, 3 Nov 2002 09:55:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36799 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262065AbSKCOzm>;
	Sun, 3 Nov 2002 09:55:42 -0500
Date: Sun, 3 Nov 2002 16:01:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.45] CDRW not working
Message-ID: <20021103150150.GO3612@suse.de>
References: <20021102152143.GA515@dreamland.darkstar.net> <20021102152725.GD1922@suse.de> <20021102174727.GA294@dreamland.darkstar.net> <20021102213529.GB3612@suse.de> <20021103145352.GA1083@dreamland.darkstar.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <20021103145352.GA1083@dreamland.darkstar.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 03 2002, Kronos wrote:
> Il Sat, Nov 02, 2002 at 10:35:29PM +0100, Jens Axboe ha scritto: 
> > On Sat, Nov 02 2002, Kronos wrote:
> > > Il Sat, Nov 02, 2002 at 04:27:25PM +0100, Jens Axboe ha scritto: 
> > > > > I can't even mount a cd using my CDRW drive (CD-ROM drive is ok).
> > > > 
> > > > Does 2.5.42 work?
> > > 
> > > I can reproduce it using hdparm -i /dev/hdd:
> 
> [cut]
>  
> > What is this, 2.5.42 or 2.5.45?
> 
> Both.
> 
> > Does 2.5.42 work or not? 
> 
> If I don't use hdparm 2.5.42 works. On 2.5.45 it's random.

2.5.45 with attached patch, how does that compare?

-- 
Jens Axboe


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=idecd-cdb-size-3

===== drivers/ide/ide-cd.c 1.27 vs edited =====
--- 1.27/drivers/ide/ide-cd.c	Fri Oct 18 20:02:55 2002
+++ edited/drivers/ide/ide-cd.c	Sun Nov  3 14:45:32 2002
@@ -872,15 +872,16 @@
  * changed 5 parameters to 3 for dvd-ram
  * struct packet_command *pc; now packet_command_t *pc;
  */
+#define ATAPI_MIN_CDB_BYTES 12
 static ide_startstop_t cdrom_transfer_packet_command (ide_drive_t *drive,
 					  struct request *rq,
 					  ide_handler_t *handler)
 {
 	unsigned char *cmd_buf	= rq->cmd;
-	int cmd_len		= sizeof(rq->cmd);
 	unsigned int timeout	= rq->timeout;
 	struct cdrom_info *info = drive->driver_data;
 	ide_startstop_t startstop;
+	unsigned int cmd_len;
 
 	if (CDROM_CONFIG_FLAGS(drive)->drq_interrupt) {
 		/* Here we should have been called after receiving an interrupt
@@ -902,6 +903,11 @@
 
 	/* Arm the interrupt handler. */
 	ide_set_handler(drive, handler, timeout, cdrom_timer_expiry);
+
+	/* cdb length, pad upto the 12th byte if necessary */
+	cmd_len = COMMAND_SIZE(rq->cmd[0]);
+	if (cmd_len < ATAPI_MIN_CDB_BYTES)
+		cmd_len = ATAPI_MIN_CDB_BYTES;
 
 	/* Send the command to the device. */
 	HWIF(drive)->atapi_output_bytes(drive, cmd_buf, cmd_len);
===== drivers/scsi/scsi.h 1.29 vs edited =====
--- 1.29/drivers/scsi/scsi.h	Thu Oct 17 23:16:34 2002
+++ edited/drivers/scsi/scsi.h	Sun Nov  3 14:45:10 2002
@@ -164,8 +164,6 @@
 #define SCSI_OWNER_BH_HANDLER     0x104
 #define SCSI_OWNER_NOBODY         0x105
 
-#define COMMAND_SIZE(opcode) scsi_command_size[((opcode) >> 5) & 7]
-
 #define IDENTIFY_BASE       0x80
 #define IDENTIFY(can_disconnect, lun)   (IDENTIFY_BASE |\
 		     ((can_disconnect) ?  0x40 : 0) |\
@@ -415,7 +413,6 @@
 extern unsigned int scsi_need_isa_buffer;	/* True if some devices need indirection
 						   * buffers */
 extern volatile int in_scan_scsis;
-extern const unsigned char scsi_command_size[8];
 
 extern struct bus_type scsi_driverfs_bus_type;
 
===== include/scsi/scsi.h 1.5 vs edited =====
--- 1.5/include/scsi/scsi.h	Mon Jun 10 02:34:54 2002
+++ edited/include/scsi/scsi.h	Sun Nov  3 14:45:09 2002
@@ -223,4 +223,7 @@
 /* Used to get the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI 0x5387
 
+extern const unsigned char scsi_command_size[8];
+#define COMMAND_SIZE(opcode) scsi_command_size[((opcode) >> 5) & 7]
+
 #endif

--vEao7xgI/oilGqZ+--
