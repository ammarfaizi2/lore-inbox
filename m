Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSDOHHf>; Mon, 15 Apr 2002 03:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313026AbSDOHHe>; Mon, 15 Apr 2002 03:07:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64017 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312998AbSDOHHe>;
	Mon, 15 Apr 2002 03:07:34 -0400
Date: Mon, 15 Apr 2002 09:07:28 +0200
From: Jens Axboe <axboe@suse.de>
To: "Ivan G." <ivangurdiev@yahoo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
Message-ID: <20020415070728.GB12608@suse.de>
In-Reply-To: <02041416483500.07641@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14 2002, Ivan G. wrote:
> 2) 
> ERROR:
> ide.c: In function `ide_teardown_commandlist':
> ide.c:2704: structure has no member named `pci_dev'
> ide.c: In function `ide_build_commandlist':
> ide.c:2719: structure has no member named `pci_dev'
> make[3]: *** [ide.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.8/drivers/ide'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.8/drivers/ide'
> make[1]: *** [_subdir_ide] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.8/drivers'
> make: *** [_dir_drivers] Error 2

This should fix it.

--- drivers/ide/ide.c~	2002-04-15 09:05:58.000000000 +0200
+++ drivers/ide/ide.c	2002-04-15 09:06:52.000000000 +0200
@@ -2701,7 +2701,11 @@
 
 void ide_teardown_commandlist(ide_drive_t *drive)
 {
+#ifdef CONFIG_BLK_DEV_IDEPCI
 	struct pci_dev *pdev= drive->channel->pci_dev;
+#else
+	struct pci_dev *pdev = NULL;
+#endif
 	struct list_head *entry;
 
 	list_for_each(entry, &drive->free_req) {
@@ -2716,7 +2720,11 @@
 
 int ide_build_commandlist(ide_drive_t *drive)
 {
+#ifdef CONFIG_BLK_DEV_IDEPCI
 	struct pci_dev *pdev= drive->channel->pci_dev;
+#else
+	struct pci_dev *pdev = NULL;
+#endif
 	struct ata_request *ar;
 	ide_tag_info_t *tcq;
 	int i, err;

-- 
Jens Axboe

