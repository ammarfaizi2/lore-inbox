Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbUBAUoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 15:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUBAUoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 15:44:16 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2688 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265413AbUBAUoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 15:44:08 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mark Haverkamp <markh@osdl.org>
Subject: Re: ide taskfile and cdrom hang
Date: Sun, 1 Feb 2004 21:48:20 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net>
In-Reply-To: <1075502193.26342.61.camel@markh1.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200402012148.20590.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Friday 30 of January 2004 23:36, Mark Haverkamp wrote:
> We have some test machines here at OSDL that have a problem with the ide
> cdrom driver hanging when we cat the /proc/ide/hda/identify file. After
> 30 seconds the console displays: "hda: lost interrupt" which reoccurs
> every 30 seconds forever. We noticed it on 2.6.2-rc2-mm1 but It looks
> like this has been a problem for a while. Our test machines just changed
> their configuration to use make defconfig.  I found that if
> CONFIG_IDE_TASKFILE_IO is N then the hang doesn't occur.  Is this a
> common problem or are there just certain drives that won't work with
> taskfile i/o enabled?  I've included my .config, lspci as attachments.
> The cdrom model is CD-224E.

Does 'hdparm -I /dev/hda" work?  If so can you try this patch?
It reverts taskfile code to use old (non-taskfile) order of accessing
port registers for ATAPI identify command.  This is a good starting point.

If CONFIG_IDE_TASKFILE_IO is N code just ignores BUSY status of a drive
and reads some random data.  I would like to have this problem solved
at least instead of adding the same workaround to CONFIG_IDE_TASKFILE_IO.

Cheers,
--bart

 linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_identify_debug drivers/ide/ide-taskfile.c
--- linux-2.6.2-rc2/drivers/ide/ide-taskfile.c~ide_tf_identify_debug	2004-02-01 21:06:58.494873136 +0100
+++ linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c	2004-02-01 21:15:06.268720240 +0100
@@ -142,6 +142,20 @@ ide_startstop_t do_rw_taskfile (ide_driv
 	void debug_taskfile(drive, task);
 #endif /* CONFIG_IDE_TASK_IOCTL_DEBUG */
 
+	if (taskfile->command == WIN_PIDENTIFY) {
+		hwif->OUTB(taskfile->feature, IDE_FEATURE_REG);
+
+		if (IDE_CONTROL_REG)
+			hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
+		SELECT_MASK(drive, 0);
+
+		hwif->OUTB(taskfile->sector_count, IDE_NSECTOR_REG);
+
+		ide_execute_command(drive, taskfile->command, task->handler,
+				    WAIT_WORSTCASE, NULL);
+		return ide_started;
+	}
+
 	/* ALL Command Block Executions SHALL clear nIEN, unless otherwise */
 	if (IDE_CONTROL_REG) {
 		/* clear nIEN */

_

