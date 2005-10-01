Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVJALI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVJALI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 07:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVJALIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 07:08:55 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:14728 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750785AbVJALIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 07:08:55 -0400
Message-ID: <433E6E26.5030305@gmail.com>
Date: Sat, 01 Oct 2005 13:08:22 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IDE] kmalloc + memset -> kzalloc conversion
References: <20051001074415.GL25424@plexity.net>
In-Reply-To: <20051001074415.GL25424@plexity.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena napsal(a):

>Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
>
>diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>--- a/drivers/ide/ide-cd.c
>+++ b/drivers/ide/ide-cd.c
>@@ -3449,7 +3449,7 @@ static int ide_cd_probe(struct device *d
> 		printk(KERN_INFO "ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
> 		goto failed;
> 	}
>-	info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
>+	info = (struct cdrom_info *) kzalloc (sizeof (struct cdrom_info), GFP_KERNEL);
>  
>
no need to cast and 80 chars on a line is upper bound.

> 	if (info == NULL) {
> 		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n", drive->name);
> 		goto failed;
>@@ -3463,8 +3463,6 @@ static int ide_cd_probe(struct device *d
> 
> 	ide_register_subdriver(drive, &ide_cdrom_driver);
> 
>-	memset(info, 0, sizeof (struct cdrom_info));
>-
> 	kref_init(&info->kref);
> 
> 	info->drive = drive;
>diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
>--- a/drivers/ide/ide-disk.c
>+++ b/drivers/ide/ide-disk.c
>@@ -1215,7 +1215,7 @@ static int ide_disk_probe(struct device 
> 	if (drive->media != ide_disk)
> 		goto failed;
> 
>-	idkp = kmalloc(sizeof(*idkp), GFP_KERNEL);
>+	idkp = kzalloc(sizeof(*idkp), GFP_KERNEL);
> 	if (!idkp)
> 		goto failed;
> 
>@@ -1228,8 +1228,6 @@ static int ide_disk_probe(struct device 
> 
> 	ide_register_subdriver(drive, &idedisk_driver);
> 
>-	memset(idkp, 0, sizeof(*idkp));
>-
> 	kref_init(&idkp->kref);
> 
> 	idkp->drive = drive;
>diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
>--- a/drivers/ide/ide-floppy.c
>+++ b/drivers/ide/ide-floppy.c
>@@ -2146,7 +2146,7 @@ static int ide_floppy_probe(struct devic
> 		printk("ide-floppy: passing drive %s to ide-scsi emulation.\n", drive->name);
> 		goto failed;
> 	}
>-	if ((floppy = (idefloppy_floppy_t *) kmalloc (sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
>+	if ((floppy = (idefloppy_floppy_t *) kzalloc (sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
>  
>
detto

> 		printk (KERN_ERR "ide-floppy: %s: Can't allocate a floppy structure\n", drive->name);
> 		goto failed;
> 	}
>@@ -2159,8 +2159,6 @@ static int ide_floppy_probe(struct devic
> 
> 	ide_register_subdriver(drive, &idefloppy_driver);
> 
>-	memset(floppy, 0, sizeof(*floppy));
>-
> 	kref_init(&floppy->kref);
> 
> 	floppy->drive = drive;
>diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
>--- a/drivers/ide/ide-probe.c
>+++ b/drivers/ide/ide-probe.c
>@@ -596,14 +596,13 @@ static inline u8 probe_for_drive (ide_dr
> 	 *	Also note that 0 everywhere means "can't do X"
> 	 */
>  
>-	drive->id = kmalloc(SECTOR_WORDS *4, GFP_KERNEL);
>+	drive->id = kzalloc(SECTOR_WORDS *4, GFP_KERNEL);
> 	drive->id_read = 0;
> 	if(drive->id == NULL)
> 	{
> 		printk(KERN_ERR "ide: out of memory for id data.\n");
> 		return 0;
> 	}
>-	memset(drive->id, 0, SECTOR_WORDS * 4);
> 	strcpy(drive->id->model, "UNKNOWN");
> 	
> 	/* skip probing? */
>@@ -1097,14 +1096,13 @@ static int init_irq (ide_hwif_t *hwif)
> 		hwgroup->hwif->next = hwif;
> 		spin_unlock_irq(&ide_lock);
> 	} else {
>-		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
>+		hwgroup = kzalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
> 					hwif_to_node(hwif->drives[0].hwif));
> 		if (!hwgroup)
> 	       		goto out_up;
> 
> 		hwif->hwgroup = hwgroup;
> 
>-		memset(hwgroup, 0, sizeof(ide_hwgroup_t));
> 		hwgroup->hwif     = hwif->next = hwif;
> 		hwgroup->rq       = NULL;
> 		hwgroup->handler  = NULL;
>diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
>--- a/drivers/ide/ide-tape.c
>+++ b/drivers/ide/ide-tape.c
>@@ -4844,7 +4844,7 @@ static int ide_tape_probe(struct device 
> 		printk(KERN_WARNING "ide-tape: Use drive %s with ide-scsi emulation and osst.\n", drive->name);
> 		printk(KERN_WARNING "ide-tape: OnStream support will be removed soon from ide-tape!\n");
> 	}
>-	tape = (idetape_tape_t *) kmalloc (sizeof (idetape_tape_t), GFP_KERNEL);
>+	tape = (idetape_tape_t *) kzalloc (sizeof (idetape_tape_t), GFP_KERNEL);
>  
>
... and so on

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

