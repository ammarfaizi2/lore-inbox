Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288804AbSAQO1l>; Thu, 17 Jan 2002 09:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSAQO1c>; Thu, 17 Jan 2002 09:27:32 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:40588 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288804AbSAQO1S>; Thu, 17 Jan 2002 09:27:18 -0500
Message-Id: <5.1.0.14.2.20020117141843.02615430@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 17 Jan 2002 14:29:49 +0000
To: Jens Axboe <axboe@suse.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [patch] 2.5.3-pre1 ide updates
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020117144648.L20994@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I think there is a bug here...

At 13:46 17/01/02, Jens Axboe wrote:
>diff -urN -X exclude /ata/linux-2.5.3-pre1/drivers/ide/ide-taskfile.c 
>linux/drivers/ide/ide-taskfile.c
>--- /ata/linux-2.5.3-pre1/drivers/ide/ide-taskfile.c    Thu Jan 17 
>06:32:54 2002
>+++ linux/drivers/ide/ide-taskfile.c    Thu Jan 17 06:29:13 2002
>@@ -994,10 +1032,11 @@
>         if (!msect) {
>                 nsect = 1;
>                 while (rq->current_nr_sectors) {
>-                       pBuf = rq->buffer + ((rq->nr_sectors - 
>rq->current_nr_sectors) * SECTOR_SIZE);
>+                       pBuf = ide_unmap_buffer(rq, &flags);

That should be: pBuf = ide_map_buffer(rq, &flags);

But I think it actually ought to be:

                         pBuf = ide_map_rq(rq, &flags)

and the below unmap should consequently be:

                         ide_unmap_rq(rq, pBuf, &flags)

In either case it's wrong at the moment AFAICS...

>                         DTF("Multiwrite: %p, nsect: %d, 
> rq->current_nr_sectors: %ld\n", pBuf, nsect, rq->current_nr_sectors);
>                         drive->io_32bit = 0;
>                         taskfile_output_data(drive, pBuf, nsect * 
> SECTOR_WORDS);
>+                       ide_unmap_buffer(pBuf, &flags);
>                         drive->io_32bit = io_32bit;
>                         rq->errors = 0;
>                         rq->current_nr_sectors -= nsect;

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

