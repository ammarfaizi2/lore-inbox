Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUAaVmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUAaVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:42:21 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:8432 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265102AbUAaVmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:42:09 -0500
Date: Sat, 31 Jan 2004 16:42:05 -0500
From: Willem Riede <wrlk@riede.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The survival of ide-scsi in 2.6.x [PATCH 1/3]
Message-ID: <20040131214205.GW23308@serve.riede.org>
Reply-To: wrlk@riede.org
References: <1072809890.2839.24.camel@mulgrave> <20040103190857.GY5523@suse.de> <20040128132400.GA23308@serve.riede.org> <200401302356.59401.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200401302356.59401.bzolnier@elka.pw.edu.pl> (from B.Zolnierkiewicz@elka.pw.edu.pl on Fri, Jan 30, 2004 at 17:56:59 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.01.30 17:56, Bartlomiej Zolnierkiewicz wrote:
> 
> Can you split your patch and drop cosmetic changes?

I've split the patch in three pieces: 

1. some code streamlining that does not change ide-scsi's behavior, 
   included below;

2. white-space changes and printk priority consistency changes,
   the only impact is what might get logged under different
   circumstances, see second mail;

3. changes in the error handling, only this one is not cosmetic, so
   I very much want you to review this one, see third mail.

Thanks, Willem Riede.

Changes in patch 1 of 3:
- reduce use of casts with idescsi_check_condition
- use ide_execute_command rather than duplicate its code
- do not initialize "scsi" twice in idescsi_queue
- in idescsi_attach, rename idescsi_scsi_t *idescsi to scsi as
  it is called in the rest of the code.

--- p0/drivers/scsi/ide-scsi.c	2004-01-31 10:29:11.000000000 -0500
+++ p1/drivers/scsi/ide-scsi.c	2004-01-31 15:37:31.000000000 -0500
@@ -270,7 +270,7 @@
 	printk("]\n");
 }
 
-static int idescsi_check_condition(ide_drive_t *drive, struct request *failed_command)
+static int idescsi_check_condition(ide_drive_t *drive, idescsi_pc_t *failed_command)
 {
 	idescsi_scsi_t *scsi = drive_to_idescsi(drive);
 	idescsi_pc_t   *pc;
@@ -298,8 +298,8 @@
 	rq->flags = REQ_SENSE;
 	pc->timeout = jiffies + WAIT_READY;
 	/* NOTE! Save the failed packet command in "rq->buffer" */
-	rq->buffer = (void *) failed_command->special;
-	pc->scsi_cmd = ((idescsi_pc_t *) failed_command->special)->scsi_cmd;
+	rq->buffer = (void *) failed_command;
+	pc->scsi_cmd = failed_command->scsi_cmd;
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log)) {
 		printk ("ide-scsi: %s: queue cmd = ", drive->name);
 		hexdump(pc->c, 6);
@@ -342,7 +342,7 @@
 	} else if (rq->errors) {
 		if (log)
 			printk ("ide-scsi: %s: check condition for %lu\n", drive->name, pc->scsi_cmd->serial_number);
-		if (!idescsi_check_condition(drive, rq))
+		if (!idescsi_check_condition(drive, pc))
 			/* we started a request sense, so we'll be back, exit for now */
 			return 0;
 		pc->scsi_cmd->result = (CHECK_CONDITION << 1) | (DID_OK << 16);
@@ -537,12 +537,7 @@
 		set_bit(PC_DMA_OK, &pc->flags);
 
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
-		if (HWGROUP(drive)->handler != NULL)
-			BUG();
-		ide_set_handler(drive, &idescsi_transfer_pc,
-				get_timeout(pc), NULL);
-		/* Issue the packet command */
-		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+		ide_execute_command(drive, WIN_PACKETCMD, &idescsi_transfer_pc, get_timeout(pc), NULL);
 		return ide_started;
 	} else {
 		/* Issue the packet command */
@@ -788,17 +783,17 @@
 
 static int idescsi_queue (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
-	struct Scsi_Host *host = cmd->device->host;
-	idescsi_scsi_t *scsi = scsihost_to_idescsi(host);
-	ide_drive_t *drive = scsi->drive;
-	struct request *rq = NULL;
-	idescsi_pc_t *pc = NULL;
+	struct Scsi_Host *host  = cmd->device->host;
+	idescsi_scsi_t   *scsi  = scsihost_to_idescsi(host);
+	ide_drive_t      *drive = scsi->drive;
+	struct request   *rq    = NULL;
+	idescsi_pc_t     *pc    = NULL;
 
 	if (!drive) {
 		printk (KERN_ERR "ide-scsi: drive id %d not present\n", cmd->device->id);
 		goto abort;
 	}
-	scsi = drive_to_idescsi(drive);
+//	scsi = drive_to_idescsi(drive);				scsi already initialized above!
 	pc = kmalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
 	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
 	if (rq == NULL || pc == NULL) {
@@ -917,8 +912,8 @@
 static int idescsi_bios(struct scsi_device *sdev, struct block_device *bdev,
 		sector_t capacity, int *parm)
 {
-	idescsi_scsi_t *idescsi = scsihost_to_idescsi(sdev->host);
-	ide_drive_t *drive = idescsi->drive;
+	idescsi_scsi_t *scsi = scsihost_to_idescsi(sdev->host);
+	ide_drive_t *drive = scsi->drive;
 
 	if (drive->bios_cyl && drive->bios_head && drive->bios_sect) {
 		parm[0] = drive->bios_head;
@@ -950,7 +945,7 @@
 
 static int idescsi_attach(ide_drive_t *drive)
 {
-	idescsi_scsi_t *idescsi;
+	idescsi_scsi_t *scsi;
 	struct Scsi_Host *host;
 	static int warned;
 	int err;
@@ -969,12 +964,12 @@
 	host->max_id = 1;
 	host->max_lun = 1;
 	drive->driver_data = host;
-	idescsi = scsihost_to_idescsi(host);
-	idescsi->drive = drive;
+	scsi = scsihost_to_idescsi(host);
+	scsi->drive = drive;
 	err = ide_register_subdriver (drive, &idescsi_driver,
 				      IDE_SUBDRIVER_VERSION);
 	if (!err) {
-		idescsi_setup (drive, idescsi);
+		idescsi_setup (drive, scsi);
 		drive->disk->fops = &idescsi_ops;
 		err = scsi_add_host(host, &drive->gendev);
 		if (!err) {


