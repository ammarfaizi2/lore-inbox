Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSBMVyW>; Wed, 13 Feb 2002 16:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBMVyE>; Wed, 13 Feb 2002 16:54:04 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:40208 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288996AbSBMVxa>; Wed, 13 Feb 2002 16:53:30 -0500
Date: Wed, 13 Feb 2002 22:53:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE cleanup for 2.5.4-pre3
Message-ID: <20020213225326.A10409@suse.cz>
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020211181013.K729@suse.de>; from axboe@suse.de on Mon, Feb 11, 2002 at 06:10:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2002 at 06:10:13PM +0100, Jens Axboe wrote:
> On Mon, Feb 11 2002, Pavel Machek wrote:
> > Hi!
> > 
> > > > Here are first small ide cleanups. Jens, please apply,
> > > 
> > > Looks good to me.
> > 
> > Is it "Looks good to me, applied", or "Looks good to me, good luck
> > pushing it to Linus?" :-).
> 
> As in I've applied it to my tree, it should find it's way upwards :-)

Here is another version of the patch, doing more extensive cleanups of
unnecessary casts, unnecessary assignments and (void *) pointers where
typed pointers should be.

I'm not sure if it's better to replace the Pavel's original one with
this one or to combine them together - this one is less intrusive and
even Andre shouldn't find a nit to pick in it ...

Decision is yours.

-- 
Vojtech Pavlik
SuSE Labs

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-clean-8-all-happy.diff"

diff -urN linux-2.5.4/drivers/ide/ide-cd.c linux-2.5.4-ide-all-happy/drivers/ide/ide-cd.c
--- linux-2.5.4/drivers/ide/ide-cd.c	Thu Jan 31 16:45:20 2002
+++ linux-2.5.4-ide-all-happy/drivers/ide/ide-cd.c	Wed Feb 13 22:33:31 2002
@@ -534,7 +534,7 @@
 	rq = &info->request_sense_request;
 	ide_init_drive_cmd(rq);
 	rq->flags = REQ_SENSE;
-	rq->special = (char *) pc;
+	rq->special = pc;
 	rq->waiting = wait;
 	(void) ide_do_drive_cmd(drive, rq, ide_preempt);
 }
@@ -545,7 +545,7 @@
 	struct request *rq = HWGROUP(drive)->rq;
 
 	if ((rq->flags & REQ_SENSE) && uptodate) {
-		struct packet_command *pc = (struct packet_command *) rq->special;
+		struct packet_command *pc = rq->special;
 		cdrom_analyze_sense_data(drive,
 			(struct packet_command *) pc->sense,
 			(struct request_sense *) (pc->buffer - pc->c[4]));
@@ -589,7 +589,7 @@
 		   from the drive (probably while trying
 		   to recover from a former error).  Just give up. */
 
-		pc = (struct packet_command *) rq->special;
+		pc = rq->special;
 		pc->stat = 1;
 		cdrom_end_request (1, drive);
 		*startstop = ide_error (drive, "request sense failure", stat);
@@ -597,7 +597,7 @@
 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
 		/* All other functions, except for READ. */
 		struct completion *wait = NULL;
-		pc = (struct packet_command *) rq->special;
+		pc = rq->special;
 
 		/* Check for tray open. */
 		if (sense_key == NOT_READY) {
@@ -1247,7 +1247,7 @@
 {
 	int ireason, len, stat, thislen;
 	struct request *rq = HWGROUP(drive)->rq;
-	struct packet_command *pc = (struct packet_command *) rq->special;
+	struct packet_command *pc = rq->special;
 	ide_startstop_t startstop;
 
 	/* Check for errors. */
@@ -1343,7 +1343,7 @@
 static ide_startstop_t cdrom_do_pc_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	struct packet_command *pc = (struct packet_command *) rq->special;
+	struct packet_command *pc = rq->special;
 
 	if (!pc->timeout)
 		pc->timeout = WAIT_CMD;
@@ -1357,7 +1357,7 @@
 {
 	int len;
 	struct request *rq = HWGROUP(drive)->rq;
-	struct packet_command *pc = (struct packet_command *) rq->special;
+	struct packet_command *pc = rq->special;
 	struct cdrom_info *info = drive->driver_data;
 
 	info->dma = 0;
@@ -1397,7 +1397,7 @@
 	do {
 		ide_init_drive_cmd (&req);
 		req.flags = REQ_PC;
-		req.special = (char *) pc;
+		req.special = pc;
 		if (ide_do_drive_cmd (drive, &req, ide_wait)) {
 			printk("%s: do_drive_cmd returned stat=%02x,err=%02x\n",
 				drive->name, req.buffer[0], req.buffer[1]);
@@ -1624,7 +1624,7 @@
 	memcpy(pc.c, rq->cmd, sizeof(pc.c));
 	pc.quiet = 1;
 	pc.timeout = 60 * HZ;
-	rq->special = (char *) &pc;
+	rq->special = &pc;
 
 	startstop = cdrom_do_packet_command(drive);
 	if (pc.stat)
@@ -1891,8 +1891,7 @@
 
 	if (toc == NULL) {
 		/* Try to allocate space. */
-		toc = (struct atapi_toc *) kmalloc (sizeof (struct atapi_toc),
-						    GFP_KERNEL);
+		toc = kmalloc (sizeof (struct atapi_toc), GFP_KERNEL);
 		info->toc = toc;
 		if (toc == NULL) {
 			printk ("%s: No cdrom TOC buffer!\n", drive->name);
@@ -2213,7 +2212,7 @@
 	 */
 	case CDROMPLAYTRKIND: {
 		unsigned long lba_start, lba_end;
-		struct cdrom_ti *ti = (struct cdrom_ti *)arg;
+		struct cdrom_ti *ti = arg;
 		struct atapi_toc_entry *first_toc, *last_toc;
 
 		stat = cdrom_get_toc_entry(drive, ti->cdti_trk0, &first_toc);
@@ -2236,7 +2235,7 @@
 	}
 
 	case CDROMREADTOCHDR: {
-		struct cdrom_tochdr *tochdr = (struct cdrom_tochdr *) arg;
+		struct cdrom_tochdr *tochdr = arg;
 		struct atapi_toc *toc;
 
 		/* Make sure our saved TOC is valid. */
@@ -2484,9 +2483,9 @@
 	devinfo->dev = mk_kdev(HWIF(drive)->major, minor);
 	devinfo->ops = &ide_cdrom_dops;
 	devinfo->mask = 0;
-	*(int *)&devinfo->speed = CDROM_STATE_FLAGS (drive)->current_speed;
-	*(int *)&devinfo->capacity = nslots;
-	devinfo->handle = (void *) drive;
+	devinfo->speed = CDROM_STATE_FLAGS(drive)->current_speed;
+	devinfo->capacity = nslots;
+	devinfo->handle = drive;
 	strcpy(devinfo->name, drive->name);
 	
 	/* set capability mask to match the probe. */
@@ -2539,7 +2538,7 @@
 	 * registered with the Uniform layer yet, it can't do this.
 	 * Same goes for cdi->ops.
 	 */
-	cdi->handle = (ide_drive_t *) drive;
+	cdi->handle = drive;
 	cdi->ops = &ide_cdrom_dops;
 	init_cdrom_command(&cgc, cap, size, CGC_DATA_UNKNOWN);
 	do { /* we seem to get stat=0x01,err=0x00 the first time (??) */
@@ -2829,7 +2828,7 @@
 
 	MOD_INC_USE_COUNT;
 	if (info->buffer == NULL)
-		info->buffer = (char *) kmalloc(SECTOR_BUFFER_SIZE, GFP_KERNEL);
+		info->buffer = kmalloc(SECTOR_BUFFER_SIZE, GFP_KERNEL);
 	if ((info->buffer == NULL) || (rc = cdrom_open(ip, fp))) {
 		drive->usage--;
 		MOD_DEC_USE_COUNT;
@@ -2957,7 +2956,7 @@
 	int failed = 0;
 
 	MOD_INC_USE_COUNT;
-	info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
+	info = kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
 	if (info == NULL) {
 		printk ("%s: Can't allocate a cdrom structure\n", drive->name);
 		return 1;
@@ -3016,7 +3015,7 @@
 			printk("ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
 			continue;
 		}
-		info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
+		info = kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
 		if (info == NULL) {
 			printk ("%s: Can't allocate a cdrom structure\n", drive->name);
 			continue;
diff -urN linux-2.5.4/drivers/ide/ide-disk.c linux-2.5.4-ide-all-happy/drivers/ide/ide-disk.c
--- linux-2.5.4/drivers/ide/ide-disk.c	Tue Feb 12 12:22:53 2002
+++ linux-2.5.4-ide-all-happy/drivers/ide/ide-disk.c	Wed Feb 13 22:21:29 2002
@@ -123,14 +123,11 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
-	if (rq->flags & REQ_CMD)
-		goto good_command;
-
-	blk_dump_rq_flags(rq, "do_rw_disk, bad command");
-	ide_end_request(0, HWGROUP(drive));
-	return ide_stopped;
-
-good_command:
+	if (!(rq->flags & REQ_CMD)) {
+		blk_dump_rq_flags(rq, "do_rw_disk, bad command");
+		ide_end_request(0, HWGROUP(drive));
+		return ide_stopped;
+	}
 
 #ifdef CONFIG_BLK_DEV_PDC4030
 	if (IS_PDC4030_DRIVE) {
@@ -140,12 +137,12 @@
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 
 	if ((drive->id->cfs_enable_2 & 0x0400) && (drive->addressing))	/* 48-bit LBA */
-		return lba_48_rw_disk(drive, rq, (unsigned long long) block);
+		return lba_48_rw_disk(drive, rq, block);
 	if (drive->select.b.lba)		/* 28-bit LBA */
-		return lba_28_rw_disk(drive, rq, (unsigned long) block);
+		return lba_28_rw_disk(drive, rq, block);
 
 	/* 28-bit CHS : DIE DIE DIE piece of legacy crap!!! */
-	return chs_rw_disk(drive, rq, (unsigned long) block);
+	return chs_rw_disk(drive, rq, block);
 }
 
 static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
@@ -186,8 +183,8 @@
 	unsigned int head	= (track % drive->head);
 	unsigned int cyl	= (track / drive->head);
 
-	memset(&taskfile, 0, sizeof(task_struct_t));
-	memset(&hobfile, 0, sizeof(hob_struct_t));
+	memset(&taskfile, 0, sizeof(taskfile));
+	memset(&hobfile, 0, sizeof(hobfile));
 
 	sectors = rq->nr_sectors;
 	if (sectors == 256)
@@ -216,10 +213,9 @@
 	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
 	args.handler		= ide_handler_parser(&taskfile, &hobfile);
 	args.posthandler	= NULL;
-	args.rq			= (struct request *) rq;
+	args.rq			= rq;
 	args.block		= block;
-	rq->special		= NULL;
-	rq->special		= (ide_task_t *)&args;
+	rq->special		= &args;
 
 	return do_rw_taskfile(drive, &args);
 }
@@ -237,8 +233,8 @@
 	if (sectors == 256)
 		sectors = 0;
 
-	memset(&taskfile, 0, sizeof(task_struct_t));
-	memset(&hobfile, 0, sizeof(hob_struct_t));
+	memset(&taskfile, 0, sizeof(taskfile));
+	memset(&hobfile, 0, sizeof(hobfile));
 
 	taskfile.sector_count	= sectors;
 	taskfile.sector_number	= block;
@@ -263,10 +259,9 @@
 	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
 	args.handler		= ide_handler_parser(&taskfile, &hobfile);
 	args.posthandler	= NULL;
-	args.rq			= (struct request *) rq;
+	args.rq			= rq;
 	args.block		= block;
-	rq->special		= NULL;
-	rq->special		= (ide_task_t *)&args;
+	rq->special		= &args;
 
 	return do_rw_taskfile(drive, &args);
 }
@@ -286,8 +281,8 @@
 
 	task_ioreg_t command	= get_command(drive, rq_data_dir(rq));
 
-	memset(&taskfile, 0, sizeof(task_struct_t));
-	memset(&hobfile, 0, sizeof(hob_struct_t));
+	memset(&taskfile, 0, sizeof(taskfile));
+	memset(&hobfile, 0, sizeof(hobfile));
 
 	sectors = rq->nr_sectors;
 	if (sectors == 65536)
@@ -296,11 +291,6 @@
 	taskfile.sector_count	= sectors;
 	hobfile.sector_count	= sectors >> 8;
 
-	if (rq->nr_sectors == 65536) {
-		taskfile.sector_count	= 0x00;
-		hobfile.sector_count	= 0x00;
-	}
-
 	taskfile.sector_number	= block;	/* low lba */
 	taskfile.low_cylinder	= (block>>=8);	/* mid lba */
 	taskfile.high_cylinder	= (block>>=8);	/* hi  lba */
@@ -327,10 +317,9 @@
 	args.prehandler		= ide_pre_handler_parser(&taskfile, &hobfile);
 	args.handler		= ide_handler_parser(&taskfile, &hobfile);
 	args.posthandler	= NULL;
-	args.rq			= (struct request *) rq;
+	args.rq			= rq;
 	args.block		= block;
-	rq->special		= NULL;
-	rq->special		= (ide_task_t *)&args;
+	rq->special		= &args;
 
 	return do_rw_taskfile(drive, &args);
 }
@@ -740,7 +729,7 @@
 static int proc_idedisk_read_cache
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	char		*out = page;
 	int		len;
 
@@ -754,11 +743,11 @@
 static int proc_idedisk_read_smart_thresholds
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
+	ide_drive_t	*drive = data;
 	int		len = 0, i = 0;
 
 	if (!get_smart_thresholds(drive, page)) {
-		unsigned short *val = (unsigned short *) page;
+		u16 *val = (u16 *) page;
 		char *out = ((char *)val) + (SECTOR_WORDS * 4);
 		page = out;
 		do {
@@ -773,11 +762,11 @@
 static int proc_idedisk_read_smart_values
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
+	ide_drive_t	*drive = data;
 	int		len = 0, i = 0;
 
 	if (!get_smart_values(drive, page)) {
-		unsigned short *val = (unsigned short *) page;
+		u16 *val = (u16 *) page;
 		char *out = ((char *)val) + (SECTOR_WORDS * 4);
 		page = out;
 		do {
diff -urN linux-2.5.4/drivers/ide/ide-proc.c linux-2.5.4-ide-all-happy/drivers/ide/ide-proc.c
--- linux-2.5.4/drivers/ide/ide-proc.c	Tue Feb 12 12:22:53 2002
+++ linux-2.5.4-ide-all-happy/drivers/ide/ide-proc.c	Wed Feb 13 22:17:34 2002
@@ -163,7 +163,7 @@
 static int proc_ide_write_config
 	(struct file *file, const char *buffer, unsigned long count, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
+	ide_hwif_t	*hwif = data;
 	int		for_real = 0;
 	unsigned long	startn = 0, n, flags;
 	const char	*start = NULL, *msg = NULL;
@@ -338,7 +338,7 @@
 	int		len;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_hwif_t	*hwif = (ide_hwif_t *)data;
+	ide_hwif_t	*hwif = data;
 	struct pci_dev	*dev = hwif->pci_dev;
 	if (!IDE_PCI_DEVID_EQ(hwif->pci_devid, IDE_PCI_DEVID_NULL) && dev && dev->bus) {
 		int reg = 0;
@@ -394,7 +394,7 @@
 static int proc_ide_read_imodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
+	ide_hwif_t	*hwif = data;
 	int		len;
 	const char	*name;
 
@@ -424,7 +424,7 @@
 static int proc_ide_read_mate
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
+	ide_hwif_t	*hwif = data;
 	int		len;
 
 	if (hwif && hwif->mate && hwif->mate->present)
@@ -437,7 +437,7 @@
 static int proc_ide_read_channel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_hwif_t	*hwif = (ide_hwif_t *) data;
+	ide_hwif_t	*hwif = data;
 	int		len;
 
 	page[0] = hwif->channel ? '1' : '0';
@@ -462,7 +462,7 @@
 static int proc_ide_read_identify
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
+	ide_drive_t	*drive = data;
 	int		len = 0, i = 0;
 
 	if (drive && !proc_ide_get_identify(drive, page)) {
@@ -483,8 +483,8 @@
 static int proc_ide_read_settings
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_settings_t	*setting = (ide_settings_t *) drive->settings;
+	ide_drive_t	*drive = data;
+	ide_settings_t	*setting = drive->settings;
 	char		*out = page;
 	int		len, rc, mul_factor, div_factor;
 
@@ -515,7 +515,7 @@
 static int proc_ide_write_settings
 	(struct file *file, const char *buffer, unsigned long count, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	char		name[MAX_LEN + 1];
 	int		for_real = 0, len;
 	unsigned long	n;
@@ -590,21 +590,21 @@
 int proc_ide_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
+	ide_drive_t	*drive = data;
+	ide_driver_t    *driver = drive->driver;
 	int		len;
 
 	if (!driver)
 		len = sprintf(page, "(none)\n");
         else
-		len = sprintf(page,"%llu\n", (unsigned long long) ((ide_driver_t *)drive->driver)->capacity(drive));
+		len = sprintf(page,"%llu\n", (unsigned long long) drive->driver->capacity(drive));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
 int proc_ide_read_geometry
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	char		*out = page;
 	int		len;
 
@@ -617,7 +617,7 @@
 static int proc_ide_read_dmodel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	struct hd_driveid *id = drive->id;
 	int		len;
 
@@ -628,8 +628,8 @@
 static int proc_ide_read_driver
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
+	ide_drive_t	*drive = data;
+	ide_driver_t	*driver = drive->driver;
 	int		len;
 
 	if (!driver)
@@ -642,7 +642,7 @@
 static int proc_ide_write_driver
 	(struct file *file, const char *buffer, unsigned long count, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -654,7 +654,7 @@
 static int proc_ide_read_media
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	ide_drive_t	*drive = data;
 	const char	*media;
 	int		len;
 
@@ -746,7 +746,6 @@
 	struct proc_dir_entry *ent;
 	struct proc_dir_entry *parent = hwif->proc;
 	char name[64];
-//	ide_driver_t *driver = drive->driver;
 
 	if (drive->present && !drive->proc) {
 		drive->proc = proc_mkdir(drive->name, parent);
diff -urN linux-2.5.4/drivers/ide/ide.c linux-2.5.4-ide-all-happy/drivers/ide/ide.c
--- linux-2.5.4/drivers/ide/ide.c	Tue Feb 12 12:22:53 2002
+++ linux-2.5.4-ide-all-happy/drivers/ide/ide.c	Wed Feb 13 22:17:34 2002
@@ -2279,7 +2279,7 @@
 
 void ide_add_setting (ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
 {
-	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting = NULL;
+	ide_settings_t **p = &drive->settings, *setting = NULL;
 
 	while ((*p) && strcmp((*p)->name, name) < 0)
 		p = &((*p)->next);
@@ -2305,7 +2305,7 @@
 
 void ide_remove_setting (ide_drive_t *drive, char *name)
 {
-	ide_settings_t **p = (ide_settings_t **) &drive->settings, *setting;
+	ide_settings_t **p = &drive->settings, *setting;
 
 	while ((*p) && strcmp((*p)->name, name))
 		p = &((*p)->next);
diff -urN linux-2.5.4/include/linux/ide.h linux-2.5.4-ide-all-happy/include/linux/ide.h
--- linux-2.5.4/include/linux/ide.h	Thu Jan 31 16:45:22 2002
+++ linux-2.5.4-ide-all-happy/include/linux/ide.h	Wed Feb 13 22:17:34 2002
@@ -367,6 +367,8 @@
 	} b;
 } special_t;
 
+struct ide_settings_s;
+
 typedef struct ide_drive_s {
 	request_queue_t		 queue;	/* request queue */
 	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
@@ -424,16 +426,16 @@
 	unsigned long	capacity;	/* total number of sectors */
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
-	void		  *hwif;	/* actually (ide_hwif_t *) */
+	struct hwif_s   *hwif;		/* interface data */
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 	char		name[4];	/* drive name, such as "hda" */
-	void 		*driver;	/* (ide_driver_t *) */
+	struct ide_driver_s *driver;	/* driver data */
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
-	void		*settings;	/* /proc/ide/ drive settings */
+	struct ide_settings_s *settings;/* /proc/ide/ drive settings */
 	char		driver_req[10];	/* requests specific driver */
 	int		last_lun;	/* last logical unit */
 	int		forced_lun;	/* if hdxlun was given at boot */

--rwEMma7ioTxnRzrJ--
