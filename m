Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUBBVbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUBBVbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:31:46 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63197 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265973AbUBBVbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:31:42 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Haverkamp <markh@osdl.org>
Subject: Re: ide taskfile and cdrom hang
Date: Mon, 2 Feb 2004 22:35:47 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net> <200402022045.02346.bzolnier@elka.pw.edu.pl> <1075754718.8503.201.camel@markh1.pdx.osdl.net>
In-Reply-To: <1075754718.8503.201.camel@markh1.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402022235.47439.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 of February 2004 21:45, Mark Haverkamp wrote:
> On Mon, 2004-02-02 at 11:45, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 02 of February 2004 19:46, Mark Haverkamp wrote:
> > > On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz wrote:
>
> [ .... ]
>
> > > Thanks,
> > >
> > > hdparm -I /dev/hda didn't hang.  I got this on the console:
> > >
> > > hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > > hda: drive_cmd: error=0x04Aborted Command
> >
> > That's okay.
> > hdparm first tries WIN_IDENTIFY which can fail on ATAPI devices.
> >
> > > I added the patch that you provided and I still get the hang when I cat
> > > /proc/ide/hda/identify.  I put a printk In the code to make sure that
> > > it was going through the added code, and it is.
> >
> > So it is something different.  Can you give this patch a go?
> > We will know more about what's going on.
> >
> > Thanks,
> > --bart
>
> OK, Here it is:
>
> hda: (WAIT_NOT_BUSY) status=0xd0
> hda: (CHECK_STATUS) status=0xd0
> hda: (BUSY) status=0xd0
> hda: lost interrupt
> hda: (BUSY) status=0x50
> hda: lost interrupt
> hda: (BUSY) status=0x50
> hda: lost interrupt
> hda: (BUSY) status=0x50
> hda: lost interrupt
> hda: (BUSY) status=0x50

Here we go with next (incremental) patch...

 linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_identify_debug2 drivers/ide/ide-taskfile.c
--- linux-2.6.2-rc2/drivers/ide/ide-taskfile.c~ide_tf_identify_debug2	2004-02-02 22:24:31.802461904 +0100
+++ linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c	2004-02-02 22:33:54.987844712 +0100
@@ -786,14 +786,18 @@ EXPORT_SYMBOL(task_mulout_intr);
 static u8 wait_drive_not_busy(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	int retries = 5;
+	int retries = 100;
 	u8 stat;
+
 	/*
-	 * (ks) Last sector was transfered, wait until drive is ready.
-	 * This can take up to 10 usec. We willl wait max 50 us.
+	 * Last sector was transfered, wait until drive is ready.
+	 * This can take up to 10 usec, but we will wait max 1 ms
+	 * (drive_cmd_intr() waits that long).
 	 */
-	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
+	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--) {
+		printk("%s: (UDELAY(10)) status=0x%02x\n", drive->name, stat);
 		udelay(10);
+	}
 	printk("%s: (WAIT_NOT_BUSY) status=0x%02x\n", drive->name, stat);
 	return stat;
 }

_


