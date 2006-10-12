Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWJLMVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWJLMVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWJLMVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:21:38 -0400
Received: from brick.kernel.dk ([62.242.22.158]:347 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750935AbWJLMVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:21:37 -0400
Date: Thu, 12 Oct 2006 14:21:46 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012122146.GS6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk> <1160648885.5897.6.camel@Homer.simpson.net> <1160662435.6177.3.camel@Homer.simpson.net> <20061012120927.GQ6515@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012120927.GQ6515@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Jens Axboe wrote:
> On Thu, Oct 12 2006, Mike Galbraith wrote:
> > On Thu, 2006-10-12 at 10:28 +0000, Mike Galbraith wrote:
> > > On Thu, 2006-10-12 at 08:53 +0200, Jens Axboe wrote:
> > > > Test case, please.
> > > 
> > > Xine.
> > > 
> > > I just built it from scratch(the one that comes with SuSE 10.1 is
> > > useless for DVDs), and tried it in 2.6.19-rc1 after verifying that it
> > > worked fine in 2.6.17.
> > 
> > s/17/18
> > 
> > > hdd: BENQ DVD DD DW1625, ATAPI CD/DVD-ROM drive
> > > hdd: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> > > 
> > > hdd: read_intr: Drive wants to transfer data the wrong way!
> > > hdd: read_intr: Drive wants to transfer data the wrong way!
> > 
> > We're having secret handshake troubles?
> > 
> > [pid  8348] stat64("/dev/dvd", {st_dev=makedev(0, 13), st_ino=3750, st_mode=S_IFBLK|0640, st_nlink=1, st_uid=0, st_gid=6, st_blksize=4096, st_blocks=0, st_rdev=makedev(22, 64), st_atime=2006/10/12-10:03:04, st_mtime=2006/10/12-10:00:12, st_ctime=2006/10/12-10:00:17}) = 0
> > [pid  8348] open("/dev/dvd", O_RDONLY|O_LARGEFILE <unfinished ...>
> > [pid  8348] <... open resumed> )        = 8
> > [pid  8348] fstat64(8, {st_dev=makedev(0, 13), st_ino=3750, st_mode=S_IFBLK|0640, st_nlink=1, st_uid=0, st_gid=6, st_blksize=4096, st_blocks=0, st_rdev=makedev(22, 64), st_atime=2006/10/12-10:03:04, st_mtime=2006/10/12-10:00:12, st_ctime=2006/10/12-10:00:17}) = 0
> > [pid  8348] ioctl(8, DVD_READ_STRUCT <unfinished ...>
> > [pid  8348] <... ioctl resumed> , 0xbfc792a4) = 0
> > [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> > [pid  8348] <... ioctl resumed> , 0xbfc7916c) = 0
> > [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> > [pid  8348] <... ioctl resumed> , 0xbfc7916c) = 0
> > [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> > [pid  8348] <... ioctl resumed> , 0xbfc7916c) = 0
> > [pid  8348] ioctl(8, DVD_AUTH <unfinished ...>
> > [pid  8348] <... ioctl resumed> , 0xbfc79170) = 0
> > [pid  8348] close(8)                    = 0
> > [pid  8348] write(2, "libdvdread: Could not open /dev/"..., 52 <unfinished ...>
> > [pid  8348] <... write resumed> )       = 52
> > [pid  8348] write(2, "libdvdread: Can\'t open /dev/dvd "..., 44 <unfinished ...>
> > [pid  8348] <... write resumed> )       = 44
> > [pid  8348] write(1, "libdvdnav: vm: faild to open/rea"..., 42 <unfinished ...>
> > [pid  8348] <... write resumed> )       = 42
> > [pid  8348] write(1, "libdvdnav: Using dvdnav version "..., 62 <unfinished ...>
> > [pid  8348] <... write resumed> )       = 62
> > [pid  8348] write(2, "libdvdread: Using libdvdcss vers"..., 57 <unfinished ...>
> > [pid  8348] <... write resumed> )       = 57
> 
> It's the rq-cmd-type patch, it must be causing a disturbance for some of
> the internal cd commands. I bet it's the same thing affecting the report
> on broken dvd identification on ppc from Olaf.

Mike/Alex/Olaf, can you give this a spin? Totally untested here, but I
think it should fix it.

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 69bbb62..e7513e5 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -597,7 +597,7 @@ static void cdrom_prepare_request(ide_dr
 	struct cdrom_info *cd = drive->driver_data;
 
 	ide_init_drive_cmd(rq);
-	rq->cmd_type = REQ_TYPE_BLOCK_PC;
+	rq->cmd_type = REQ_TYPE_ATA_PC;
 	rq->rq_disk = cd->disk;
 }
 
@@ -2023,7 +2023,8 @@ ide_do_rw_cdrom (ide_drive_t *drive, str
 		}
 		info->last_block = block;
 		return action;
-	} else if (rq->cmd_type == REQ_TYPE_SENSE) {
+	} else if (rq->cmd_type == REQ_TYPE_SENSE ||
+		   rq->cmd_type == REQ_TYPE_ATA_PC) {
 		return cdrom_do_packet_command(drive);
 	} else if (blk_pc_request(rq)) {
 		return cdrom_do_block_pc(drive, rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 26f7856..d370d2c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -157,6 +157,7 @@ enum rq_cmd_type_bits {
 	REQ_TYPE_ATA_CMD,
 	REQ_TYPE_ATA_TASK,
 	REQ_TYPE_ATA_TASKFILE,
+	REQ_TYPE_ATA_PC,
 };
 
 /*

-- 
Jens Axboe

