Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbTCWSPF>; Sun, 23 Mar 2003 13:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262910AbTCWSPF>; Sun, 23 Mar 2003 13:15:05 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:50679 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262763AbTCWSPD>; Sun, 23 Mar 2003 13:15:03 -0500
Date: Sun, 23 Mar 2003 19:25:54 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: ide: indeed, using list_for_each_entry_safe removes endless looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
Message-ID: <20030323182554.GA1270@brodo.de>
References: <20030322140337.GA1193@brodo.de> <1048350905.9219.1.camel@irongate.swansea.linux.org.uk> <20030322162502.GA870@brodo.de> <1048354921.9221.17.camel@irongate.swansea.linux.org.uk> <20030323010338.GA886@brodo.de> <1048434472.10729.28.camel@irongate.swansea.linux.org.uk> <20030323145915.GA865@brodo.de> <1048444868.10729.54.camel@irongate.swansea.linux.org.uk> <20030323181532.GA6819@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323181532.GA6819@brodo.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 07:15:33PM +0100, Dominik Brodowski wrote:
> On Sun, Mar 23, 2003 at 06:41:10PM +0000, Alan Cox wrote:
> > > printk("%4s\n", drive->name) prints out "hdd" all the time. 
> > > 
> > > hda is an ATA disk drive
> > > hdb is empty
> > > hdc is an ATAPI CD/DVD-ROM drive
> > > hdd is an ATAPI CD-ROM CD-R/RW drive
> > 
> > This gets weirder by the minute, and I still can't get it to happen here
> > annoyingly.  
> >
> > The list thats breaking is a private list. We delete the drive from that
> > list, if its present (it may be an empty bay) we then use ata_attach 
> > to add it to a device list (or back to ata_unused). 
> > 
> > I find it hard to believe something like this is a compiler bug, but right
> > now I don't see how stuff is reappearing on the list.
> 
> Just got it to boot :) -- the while(!list_empty...) { list_entry ... looks
> suspicious. Might be better to use list_for_each_safe() which is designed
> exactly for this purpouse. I'm currently recompiling
> 2.5.65-bk-current-as-of-yesterday with the attached patch. Let's see whether
> it works with this kernel, too...

Yes, it also works with 2.5.65-bkX.

--- linux/drivers/ide/ide.c.original	2003-03-23 19:08:40.000000000 +0100
+++ linux/drivers/ide/ide.c	2003-03-23 19:10:25.000000000 +0100
@@ -2392,6 +2392,8 @@
 int ide_register_driver(ide_driver_t *driver)
 {
 	struct list_head list;
+	struct list_head *list_loop;
+	struct list_head *tmp_storage;
 
 	spin_lock(&drivers_lock);
 	list_add(&driver->drivers, &drivers);
@@ -2402,8 +2404,8 @@
 	list_splice_init(&ata_unused, &list);
 	spin_unlock(&drives_lock);
 
-	while (!list_empty(&list)) {
-		ide_drive_t *drive = list_entry(list.next, ide_drive_t, list);
+	list_for_each_safe(list_loop, tmp_storage, &list) {
+		ide_drive_t *drive = container_of(list_loop, ide_drive_t, list);
 		list_del_init(&drive->list);
 		if (drive->present)
 			ata_attach(drive);
