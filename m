Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbTDDNIb (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDDNIb (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:08:31 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:2347 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id S263483AbTDDNIP (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:08:15 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] only use 48-bit lba when necessary
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030404122936.GB786@suse.de> (Jens Axboe's message of "Fri, 4
 Apr 2003 14:29:36 +0200")
References: <20030404122936.GB786@suse.de>
Date: Fri, 04 Apr 2003 15:19:37 +0200
Message-ID: <86k7ea2ydy.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "jens" == Jens Axboe <axboe@suse.de> writes:

jens> Hi,
jens> 48-bit lba has a non-significant overhead (twice the outb's, 12 instead
jens> of 6 per command), so it makes sense to use 28-bit lba commands whenever
jens> we can.

jens> Patch is against 2.5.66-BK.

jens> ===== drivers/ide/ide-disk.c 1.36 vs edited =====
jens> --- 1.36/drivers/ide/ide-disk.c	Wed Mar 26 21:23:01 2003
jens> +++ edited/drivers/ide/ide-disk.c	Fri Apr  4 14:18:41 2003
jens> @@ -367,12 +367,15 @@
jens> static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, sector_t block)
jens> {
jens> ide_hwif_t *hwif	= HWIF(drive);
jens> -	u8 lba48		= (drive->addressing == 1) ? 1 : 0;
jens> +	u8 lba48		= 0;
jens> task_ioreg_t command	= WIN_NOP;
jens> ata_nsector_t		nsectors;
 
jens> nsectors.all		= (u16) rq->nr_sectors;
 
jens> +	if (drive->addressing == 1 && block > 0xfffffff)
jens> +		lba48 = 1;
jens> +

lba48 = (drive->addressing == 1) && (block > 0xfffffff);

should do the trick.

jens> +	int lba48bit = 0;
jens> +
jens> +	if (drive->addressing == 1 && block > 0xfffffff)
jens> +		lba48bit = 1;

see above (more cases of that stripped).

jens> +	if (lba48bit && block > 0xfffffff)

that test should be equivalent to:

if (lba48bit)

(at least the cvs copy of that function don't modify block isnce the
definition of lba48bit).

Talking about consistency, wouldn't be better to use always the same
name, lba48 or lba48bit?

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
