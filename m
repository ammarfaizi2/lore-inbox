Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbUBBTk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUBBTk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:40:59 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58043 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265836AbUBBTky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:40:54 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Haverkamp <markh@osdl.org>
Subject: Re: ide taskfile and cdrom hang
Date: Mon, 2 Feb 2004 20:45:02 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net> <200402012148.20590.bzolnier@elka.pw.edu.pl> <1075747608.8503.198.camel@markh1.pdx.osdl.net>
In-Reply-To: <1075747608.8503.198.camel@markh1.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402022045.02346.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 of February 2004 19:46, Mark Haverkamp wrote:
> On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > On Friday 30 of January 2004 23:36, Mark Haverkamp wrote:
> > > We have some test machines here at OSDL that have a problem with the
> > > ide cdrom driver hanging when we cat the /proc/ide/hda/identify file.
> > > After 30 seconds the console displays: "hda: lost interrupt" which
> > > reoccurs every 30 seconds forever. We noticed it on 2.6.2-rc2-mm1 but
> > > It looks like this has been a problem for a while. Our test machines
> > > just changed their configuration to use make defconfig.  I found that
> > > if
> > > CONFIG_IDE_TASKFILE_IO is N then the hang doesn't occur.  Is this a
> > > common problem or are there just certain drives that won't work with
> > > taskfile i/o enabled?  I've included my .config, lspci as attachments.
> > > The cdrom model is CD-224E.
> >
> > Does 'hdparm -I /dev/hda" work?  If so can you try this patch?
> > It reverts taskfile code to use old (non-taskfile) order of accessing
> > port registers for ATAPI identify command.  This is a good starting
> > point.
> >
> > If CONFIG_IDE_TASKFILE_IO is N code just ignores BUSY status of a drive
> > and reads some random data.  I would like to have this problem solved
> > at least instead of adding the same workaround to CONFIG_IDE_TASKFILE_IO.
> >
> > Cheers,
> > --bart
>
> Thanks,
>
> hdparm -I /dev/hda didn't hang.  I got this on the console:
>
> hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hda: drive_cmd: error=0x04Aborted Command

That's okay.
hdparm first tries WIN_IDENTIFY which can fail on ATAPI devices.

> I added the patch that you provided and I still get the hang when I cat
> /proc/ide/hda/identify.  I put a printk In the code to make sure that it
> was going through the added code, and it is.

So it is something different.  Can you give this patch a go?
We will know more about what's going on.

Thanks,
--bart

 linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_identify_debug1 drivers/ide/ide-taskfile.c
--- linux-2.6.2-rc2/drivers/ide/ide-taskfile.c~ide_tf_identify_debug1	2004-02-02 20:30:16.435636072 +0100
+++ linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c	2004-02-02 20:40:25.604028400 +0100
@@ -794,6 +794,7 @@ static u8 wait_drive_not_busy(ide_drive_
 	 */
 	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
 		udelay(10);
+	printk("%s: (WAIT_NOT_BUSY) status=0x%02x\n", drive->name, stat);
 	return stat;
 }
 
@@ -811,6 +812,7 @@ check_status:
 	if (!OK_STAT(stat, good_stat, BAD_R_STAT)) {
 		if (stat & (ERR_STAT | DRQ_STAT))
 			return DRIVER(drive)->error(drive, __FUNCTION__, stat);
+		printk("%s: (BUSY) status=0x%02x\n", drive->name, stat);
 		/* BUSY_STAT: No data yet, so wait for another IRQ. */
 		ide_set_handler(drive, &task_in_intr, WAIT_WORSTCASE, NULL);
 		return ide_started;
@@ -836,6 +838,7 @@ check_status:
 	if (!rq->nr_sectors) {
 		good_stat = 0;
 		stat = wait_drive_not_busy(drive);
+		printk("%s: (CHECK_STATUS) status=0x%02x\n", drive->name, stat);
 		goto check_status;
 	}
 

_

