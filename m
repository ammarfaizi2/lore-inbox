Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbUBBVof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUBBVof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:44:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:51921 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266008AbUBBVoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:44:32 -0500
Subject: Re: ide taskfile and cdrom hang
From: Mark Haverkamp <markh@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Cliff White <cliffw@osdl.org>
In-Reply-To: <200402022235.47439.bzolnier@elka.pw.edu.pl>
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net>
	 <200402022045.02346.bzolnier@elka.pw.edu.pl>
	 <1075754718.8503.201.camel@markh1.pdx.osdl.net>
	 <200402022235.47439.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1075758247.12117.1.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 02 Feb 2004 13:44:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-02 at 13:35, Bartlomiej Zolnierkiewicz wrote:
> On Monday 02 of February 2004 21:45, Mark Haverkamp wrote:
> > On Mon, 2004-02-02 at 11:45, Bartlomiej Zolnierkiewicz wrote:
> > > On Monday 02 of February 2004 19:46, Mark Haverkamp wrote:
> > > > On Sun, 2004-02-01 at 12:48, Bartlomiej Zolnierkiewicz wrote:
> >
> > [ .... ]
> >
> > > > Thanks,
> > > >
> > > > hdparm -I /dev/hda didn't hang.  I got this on the console:
> > > >
> > > > hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > > > hda: drive_cmd: error=0x04Aborted Command
> > >
> > > That's okay.
> > > hdparm first tries WIN_IDENTIFY which can fail on ATAPI devices.
> > >
> > > > I added the patch that you provided and I still get the hang when I cat
> > > > /proc/ide/hda/identify.  I put a printk In the code to make sure that
> > > > it was going through the added code, and it is.
> > >
> > > So it is something different.  Can you give this patch a go?
> > > We will know more about what's going on.
> > >
> > > Thanks,
> > > --bart
> >
> > OK, Here it is:
> >
> > hda: (WAIT_NOT_BUSY) status=0xd0
> > hda: (CHECK_STATUS) status=0xd0
> > hda: (BUSY) status=0xd0
> > hda: lost interrupt
> > hda: (BUSY) status=0x50
> > hda: lost interrupt
> > hda: (BUSY) status=0x50
> > hda: lost interrupt
> > hda: (BUSY) status=0x50
> > hda: lost interrupt
> > hda: (BUSY) status=0x50
> 
> Here we go with next (incremental) patch...
> 
>  linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff -puN drivers/ide/ide-taskfile.c~ide_tf_identify_debug2 drivers/ide/ide-taskfile.c
> --- linux-2.6.2-rc2/drivers/ide/ide-taskfile.c~ide_tf_identify_debug2	2004-02-02 22:24:31.802461904 +0100
> +++ linux-2.6.2-rc2-root/drivers/ide/ide-taskfile.c	2004-02-02 22:33:54.987844712 +0100
> @@ -786,14 +786,18 @@ EXPORT_SYMBOL(task_mulout_intr);
>  static u8 wait_drive_not_busy(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif = HWIF(drive);
> -	int retries = 5;
> +	int retries = 100;
>  	u8 stat;
> +
>  	/*
> -	 * (ks) Last sector was transfered, wait until drive is ready.
> -	 * This can take up to 10 usec. We willl wait max 50 us.
> +	 * Last sector was transfered, wait until drive is ready.
> +	 * This can take up to 10 usec, but we will wait max 1 ms
> +	 * (drive_cmd_intr() waits that long).
>  	 */
> -	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--)
> +	while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && retries--) {
> +		printk("%s: (UDELAY(10)) status=0x%02x\n", drive->name, stat);
>  		udelay(10);
> +	}
>  	printk("%s: (WAIT_NOT_BUSY) status=0x%02x\n", drive->name, stat);
>  	return stat;
>  }
> 
> _

No hang this time.  Saw this on the console:

hda: (UDELAY(10)) status=0xd8
hda: (WAIT_NOT_BUSY) status=0x50
hda: (CHECK_STATUS) status=0x50
hda: (UDELAY(10)) status=0xd8
hda: (WAIT_NOT_BUSY) status=0x50
hda: (CHECK_STATUS) status=0x50


-- 
Mark Haverkamp <markh@osdl.org>

