Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269574AbUI3WHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269574AbUI3WHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269582AbUI3WHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:07:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62851 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269574AbUI3WHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:07:25 -0400
Date: Thu, 30 Sep 2004 18:07:09 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: PATCH: (Test) it8212 driver for 2.6.9rc3
Message-ID: <20040930220709.GC10545@devserv.devel.redhat.com>
References: <20040930184535.GA31197@devserv.devel.redhat.com> <200409302245.18866.bzolnier@elka.pw.edu.pl> <20040930213500.GC2175@devserv.devel.redhat.com> <200410010001.27607.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410010001.27607.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 12:01:27AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > I'd prefer to keep it (there are likely to be some related devices from
> > the databook)
> 
> you can add it when needed

I think its needed. I'll keep it 8)

Ok first patch then. This adds raw_taskfile as a hook allowing a driver to
filter, mangle (or indeed just throw debug) on taskfile commands being
issued.  (Note - ide_diag_taskfile has always been exported just never
used by a driver and missing in the headers..)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/ide/ide-taskfile.c linux-2.6.9rc3/drivers/ide/ide-taskfile.c
--- linux.vanilla-2.6.9rc3/drivers/ide/ide-taskfile.c	2004-09-30 16:13:08.058460344 +0100
+++ linux-2.6.9rc3/drivers/ide/ide-taskfile.c	2004-09-30 22:55:55.504450104 +0100
@@ -555,7 +555,11 @@
 
 int ide_raw_taskfile (ide_drive_t *drive, ide_task_t *args, u8 *buf)
 {
-	return ide_diag_taskfile(drive, args, 0, buf);
+	ide_hwif_t *hwif = HWIF(drive);
+	if(hwif->raw_taskfile)
+		return hwif->raw_taskfile(drive, args, buf);
+	else
+		return ide_diag_taskfile(drive, args, 0, buf);
 }
 
 EXPORT_SYMBOL(ide_raw_taskfile);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/include/linux/ide.h linux-2.6.9rc3/include/linux/ide.h
--- linux.vanilla-2.6.9rc3/include/linux/ide.h	2004-09-30 16:13:13.182681344 +0100
+++ linux-2.6.9rc3/include/linux/ide.h	2004-09-30 22:58:15.749129672 +0100
@@ -822,6 +822,7 @@
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
 
 struct ide_pci_device_s;
+struct ide_task_s;
 
 typedef struct hwif_s {
 	struct hwif_s *next;		/* for linked-list in ide_hwgroup_t */
@@ -886,6 +887,8 @@
 //	u8	(*ratemask)(ide_drive_t *);
 //	/* device rate limiter */
 //	u8	(*ratefilter)(ide_drive_t *, u8);
+	/* allow command filter/control */
+	int	(*raw_taskfile)(ide_drive_t *, struct ide_task_s *, u8 *);
 #endif
 
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
@@ -1426,6 +1429,7 @@
 extern ide_startstop_t pre_task_out_intr(ide_drive_t *, struct request *);
 extern ide_startstop_t task_out_intr(ide_drive_t *);
 
+extern int ide_diag_taskfile(ide_drive_t *, ide_task_t *, unsigned long, u8 *);
 extern int ide_raw_taskfile(ide_drive_t *, ide_task_t *, u8 *);
 
 int ide_taskfile_ioctl(ide_drive_t *, unsigned int, unsigned long);
