Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSAQHhD>; Thu, 17 Jan 2002 02:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAQHgy>; Thu, 17 Jan 2002 02:36:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34829 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287003AbSAQHgk>;
	Thu, 17 Jan 2002 02:36:40 -0500
Date: Thu, 17 Jan 2002 08:36:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: john e weber <john@worldwideweber.org>, linux-kernel@vger.kernel.org
Subject: Re: DO NOT USE IT (Re: linux-2.5.3-pre1 and IDE Driver Trouble) FATAL
Message-ID: <20020117083622.J13372@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201091206030.2530-100000@worldwideweber.org> <Pine.LNX.4.10.10201161259270.29434-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201161259270.29434-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 16 2002, Andre Hedrick wrote:
> 
> 
> This is a problem that is bigger than simplely issueing a simple
> setfeatures non-data-pio command.  All of the PIO data-phases are broken.
> Nothing works but DMA, and there is no reason it should fail.
> 
> Something has gone totally wrong between the 2.5.1 patch submitted to it
> being applied for the creation of 2.5.3-pre1.
> 
> If the driver falls out of DMA, DEADBOX!!!!
> There is a conflict of BIO and ACB and it is very fatal.
> 
> Therefore I will have to withdraw the patch and resubmit with the legacy
> data-path added back so the kernel development can continue.
> 
> The only kernel in the development series known to work is 2.5.1.
> However it appears that several people can not successfully use this
> CodeBase either.

2.5.1 still requires at least this patch to be closer to correct, I
haven't verified if it does the trick completely though. For 2.5.3-pre1,
more work needs to be done.

-- 
Jens Axboe


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=ide-map-1

--- /opt/kernel/linux-2.5.3-pre1/drivers/ide/ide-taskfile.c	Wed Jan 16 02:25:35 2002
+++ drivers/ide/ide-taskfile.c	Thu Jan 17 00:29:27 2002
@@ -723,6 +723,7 @@
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
@@ -735,11 +736,12 @@
 		}
 	}
 	DTF("stat: %02x\n", stat);
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+	pBuf = ide_map_buffer(rq, &flags);
 	DTF("Read: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 
 	drive->io_32bit = 0;
 	taskfile_input_data(drive, pBuf, SECTOR_WORDS);
+	ide_unmap_buffer(pBuf, &flags);
 	drive->io_32bit = io_32bit;
 
 	if (--rq->current_nr_sectors <= 0) {
@@ -809,6 +811,7 @@
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
 		if (stat & (ERR_STAT|DRQ_STAT)) {
@@ -834,10 +837,11 @@
 		 */
 		nsect = 1;
 		while (rq->current_nr_sectors) {
-			pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+			pBuf = ide_map_buffer(rq, &flags);
 			DTF("Multiread: %p, nsect: %d, rq->current_nr_sectors: %ld\n", pBuf, nsect, rq->current_nr_sectors);
 			drive->io_32bit = 0;
 			taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
+			ide_unmap_buffer(pBuf, &flags);
 			drive->io_32bit = io_32bit;
 			rq->errors = 0;
 			rq->current_nr_sectors -= nsect;
@@ -849,12 +853,13 @@
 #endif /* ALTSTAT_SCREW_UP */
 
 	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+	pBuf = ide_map_buffer(rq, &flags);
 
 	DTF("Multiread: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
 		pBuf, nsect, rq->current_nr_sectors);
 	drive->io_32bit = 0;
 	taskfile_input_data(drive, pBuf, nsect * SECTOR_WORDS);
+	ide_unmap_buffer(pBuf, &flags);
 	drive->io_32bit = io_32bit;
 	rq->errors = 0;
 	rq->current_nr_sectors -= nsect;
@@ -913,6 +918,7 @@
 	byte io_32bit		= drive->io_32bit;
 	struct request *rq	= HWGROUP(drive)->rq;
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	if (!rq->current_nr_sectors) { 
 		ide_end_request(1, HWGROUP(drive));
@@ -924,10 +930,11 @@
 	}
 	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
 		rq = HWGROUP(drive)->rq;
-		pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+		pBuf = ide_map_buffer(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 		drive->io_32bit = 0;
 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
+		ide_unmap_buffer(pBuf, &flags);
 		drive->io_32bit = io_32bit;
 		rq->errors = 0;
 		rq->current_nr_sectors--;
@@ -961,6 +968,7 @@
 	struct request *rq	= HWGROUP(drive)->rq;
 	ide_hwgroup_t *hwgroup	= HWGROUP(drive);
 	char *pBuf		= NULL;
+	unsigned long flags;
 
 	/*
 	 * (ks/hs): Handle last IRQ on multi-sector transfer,
@@ -994,10 +1002,11 @@
 	if (!msect) {
 		nsect = 1;
 		while (rq->current_nr_sectors) {
-			pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+			pBuf = ide_unmap_buffer(rq, &flags);
 			DTF("Multiwrite: %p, nsect: %d, rq->current_nr_sectors: %ld\n", pBuf, nsect, rq->current_nr_sectors);
 			drive->io_32bit = 0;
 			taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
+			ide_unmap_buffer(pBuf, &flags);
 			drive->io_32bit = io_32bit;
 			rq->errors = 0;
 			rq->current_nr_sectors -= nsect;
@@ -1009,11 +1018,12 @@
 #endif /* ALTSTAT_SCREW_UP */
 
 	nsect = (rq->current_nr_sectors > msect) ? msect : rq->current_nr_sectors;
-	pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
+	pBuf = ide_map_buffer(rq, &flags);
 	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
 		pBuf, nsect, rq->current_nr_sectors);
 	drive->io_32bit = 0;
 	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
+	ide_unmap_buffer(pBuf, &flags);
 	drive->io_32bit = io_32bit;
 	rq->errors = 0;
 	rq->current_nr_sectors -= nsect;

--jI8keyz6grp/JLjh--
