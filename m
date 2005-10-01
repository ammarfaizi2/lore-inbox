Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVJAHoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVJAHoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVJAHoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:44:14 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21227 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750771AbVJAHoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:44:13 -0400
Date: Sat, 1 Oct 2005 00:44:15 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [IDE] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001074415.GL25424@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -3449,7 +3449,7 @@ static int ide_cd_probe(struct device *d
 		printk(KERN_INFO "ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
 		goto failed;
 	}
-	info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
+	info = (struct cdrom_info *) kzalloc (sizeof (struct cdrom_info), GFP_KERNEL);
 	if (info == NULL) {
 		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
 		goto failed;
@@ -3463,8 +3463,6 @@ static int ide_cd_probe(struct device *d
 
 	ide_register_subdriver(drive, &ide_cdrom_driver);
 
-	memset(info, 0, sizeof (struct cdrom_info));
-
 	kref_init(&info->kref);
 
 	info->drive = drive;
diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -1215,7 +1215,7 @@ static int ide_disk_probe(struct device 
 	if (drive->media != ide_disk)
 		goto failed;
 
-	idkp = kmalloc(sizeof(*idkp), GFP_KERNEL);
+	idkp = kzalloc(sizeof(*idkp), GFP_KERNEL);
 	if (!idkp)
 		goto failed;
 
@@ -1228,8 +1228,6 @@ static int ide_disk_probe(struct device 
 
 	ide_register_subdriver(drive, &idedisk_driver);
 
-	memset(idkp, 0, sizeof(*idkp));
-
 	kref_init(&idkp->kref);
 
 	idkp->drive = drive;
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -2146,7 +2146,7 @@ static int ide_floppy_probe(struct devic
 		printk("ide-floppy: passing drive %s to ide-scsi emulation.\n", drive->name);
 		goto failed;
 	}
-	if ((floppy = (idefloppy_floppy_t *) kmalloc (sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
+	if ((floppy = (idefloppy_floppy_t *) kzalloc (sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
 		printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
 		goto failed;
 	}
@@ -2159,8 +2159,6 @@ static int ide_floppy_probe(struct devic
 
 	ide_register_subdriver(drive, &idefloppy_driver);
 
-	memset(floppy, 0, sizeof(*floppy));
-
 	kref_init(&floppy->kref);
 
 	floppy->drive = drive;
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -596,14 +596,13 @@ static inline u8 probe_for_drive (ide_dr
 	 *	Also note that 0 everywhere means "can't do X"
 	 */
  
-	drive->id = kmalloc(SECTOR_WORDS *4, GFP_KERNEL);
+	drive->id = kzalloc(SECTOR_WORDS *4, GFP_KERNEL);
 	drive->id_read = 0;
 	if(drive->id == NULL)
 	{
 		printk(KERN_ERR "ide: out of memory for id data.\n");
 		return 0;
 	}
-	memset(drive->id, 0, SECTOR_WORDS * 4);
 	strcpy(drive->id->model, "UNKNOWN");
 	
 	/* skip probing? */
@@ -1097,14 +1096,13 @@ static int init_irq (ide_hwif_t *hwif)
 		hwgroup->hwif->next = hwif;
 		spin_unlock_irq(&ide_lock);
 	} else {
-		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
+		hwgroup = kzalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
 					hwif_to_node(hwif->drives[0].hwif));
 		if (!hwgroup)
 	       		goto out_up;
 
 		hwif->hwgroup = hwgroup;
 
-		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
 		hwgroup->hwif     = hwif->next = hwif;
 		hwgroup->rq       = NULL;
 		hwgroup->handler  = NULL;
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4844,7 +4844,7 @@ static int ide_tape_probe(struct device 
 		printk(KERN_WARNING "ide-tape: Use drive %s with ide-scsi emulation and osst.\n", drive->name);
 		printk(KERN_WARNING "ide-tape: OnStream support will be removed soon from ide-tape!\n");
 	}
-	tape = (idetape_tape_t *) kmalloc (sizeof (idetape_tape_t), GFP_KERNEL);
+	tape = (idetape_tape_t *) kzalloc (sizeof (idetape_tape_t), GFP_KERNEL);
 	if (tape == NULL) {
 		printk(KERN_ERR "ide-tape: %s: Can't allocate a tape structure\n", drive->name);
 		goto failed;
@@ -4858,8 +4858,6 @@ static int ide_tape_probe(struct device 
 
 	ide_register_subdriver(drive, &idetape_driver);
 
-	memset(tape, 0, sizeof(*tape));
-
 	kref_init(&tape->kref);
 
 	tape->drive = drive;
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -528,9 +528,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 //	printk("IDE Taskfile ...\n");
 
-	req_task = kmalloc(tasksize, GFP_KERNEL);
+	req_task = kzalloc(tasksize, GFP_KERNEL);
 	if (req_task == NULL) return -ENOMEM;
-	memset(req_task, 0, tasksize);
 	if (copy_from_user(req_task, buf, tasksize)) {
 		kfree(req_task);
 		return -EFAULT;
@@ -541,12 +540,11 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	if (taskout) {
 		int outtotal = tasksize;
-		outbuf = kmalloc(taskout, GFP_KERNEL);
+		outbuf = kzalloc(taskout, GFP_KERNEL);
 		if (outbuf == NULL) {
 			err = -ENOMEM;
 			goto abort;
 		}
-		memset(outbuf, 0, taskout);
 		if (copy_from_user(outbuf, buf + outtotal, taskout)) {
 			err = -EFAULT;
 			goto abort;
@@ -555,12 +553,11 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 
 	if (taskin) {
 		int intotal = tasksize + taskout;
-		inbuf = kmalloc(taskin, GFP_KERNEL);
+		inbuf = kzalloc(taskin, GFP_KERNEL);
 		if (inbuf == NULL) {
 			err = -ENOMEM;
 			goto abort;
 		}
-		memset(inbuf, 0, taskin);
 		if (copy_from_user(inbuf, buf + intotal, taskin)) {
 			err = -EFAULT;
 			goto abort;
@@ -709,10 +706,9 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
 
 	if (args[3]) {
 		argsize = 4 + (SECTOR_WORDS * 4 * args[3]);
-		argbuf = kmalloc(argsize, GFP_KERNEL);
+		argbuf = kzalloc(argsize, GFP_KERNEL);
 		if (argbuf == NULL)
 			return -ENOMEM;
-		memcpy(argbuf, args, 4);
 	}
 	if (set_transfer(drive, &tfargs)) {
 		xfer_rate = args[1];
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -864,9 +864,8 @@ static int __ide_add_setting(ide_drive_t
 	down(&ide_setting_sem);
 	while ((*p) && strcmp((*p)->name, name) < 0)
 		p = &((*p)->next);
-	if ((setting = kmalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
+	if ((setting = kzalloc(sizeof(*setting), GFP_KERNEL)) == NULL)
 		goto abort;
-	memset(setting, 0, sizeof(*setting));
 	if ((setting->name = kmalloc(strlen(name) + 1, GFP_KERNEL)) == NULL)
 		goto abort;
 	strcpy(setting->name, name);
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -116,9 +116,8 @@ static dev_link_t *ide_attach(void)
     DEBUG(0, "ide_attach()\n");
 
     /* Create new ide device */
-    info = kmalloc(sizeof(*info), GFP_KERNEL);
+    info = kzalloc(sizeof(*info), GFP_KERNEL);
     if (!info) return NULL;
-    memset(info, 0, sizeof(*info));
     link = &info->link; link->priv = info;
 
     link->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
@@ -221,9 +220,8 @@ static void ide_config(dev_link_t *link)
 
     DEBUG(0, "ide_config(0x%p)\n", link);
 
-    stk = kmalloc(sizeof(*stk), GFP_KERNEL);
+    stk = kzalloc(sizeof(*stk), GFP_KERNEL);
     if (!stk) goto err_mem;
-    memset(stk, 0, sizeof(*stk));
     cfg = &stk->parse.cftable_entry;
 
     tuple.TupleData = (cisdata_t *)&stk->buf;
diff --git a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1516,7 +1516,7 @@ static void __devinit init_dma_hpt366(id
 
 static void __devinit init_iops_hpt366(ide_hwif_t *hwif)
 {
-	struct hpt_info *info = kmalloc(sizeof(struct hpt_info), GFP_KERNEL);
+	struct hpt_info *info = kzalloc(sizeof(struct hpt_info), GFP_KERNEL);
 	unsigned long dmabase = pci_resource_start(hwif->pci_dev, 4);
 	u8 did, rid;
 
@@ -1524,7 +1524,6 @@ static void __devinit init_iops_hpt366(i
 		printk(KERN_WARNING "hpt366: out of memory.\n");
 		return;
 	}
-	memset(info, 0, sizeof(struct hpt_info));
 	ide_set_hwifdata(hwif, info);
 
 	if(dmabase) {
diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -642,14 +642,13 @@ static void __devinit it821x_fixups(ide_
 
 static void __devinit init_hwif_it821x(ide_hwif_t *hwif)
 {
-	struct it821x_dev *idev = kmalloc(sizeof(struct it821x_dev), GFP_KERNEL);
+	struct it821x_dev *idev = kzalloc(sizeof(struct it821x_dev), GFP_KERNEL);
 	u8 conf;
 
 	if(idev == NULL) {
 		printk(KERN_ERR "it821x: out of memory, falling back to legacy behaviour.\n");
 		goto fallback;
 	}
-	memset(idev, 0, sizeof(struct it821x_dev));
 	ide_set_hwifdata(hwif, idev);
 
 	pci_read_config_byte(hwif->pci_dev, 0x50, &conf);
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
