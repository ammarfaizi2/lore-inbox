Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUEWI57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUEWI57 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 04:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUEWI56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 04:57:58 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:19903 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262398AbUEWI5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 04:57:35 -0400
From: Lorenzo Allegrucci <l_allegrucci@despammed.com>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.6-mm5 oops mounting ext3 or reiserfs with -o barrier
Date: Sun, 23 May 2004 10:58:03 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405222107.55505.l_allegrucci@despammed.com> <20040522212028.GA31188@suse.de> <20040522213018.GA31224@suse.de>
In-Reply-To: <20040522213018.GA31224@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405231058.03336.l_allegrucci@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 May 2004 23:30, Jens Axboe wrote:
> On Sat, May 22 2004, Jens Axboe wrote:
> > On Sat, May 22 2004, Andrew Morton wrote:
> > > Lorenzo Allegrucci <l_allegrucci@despammed.com> wrote:
> > > > I get a 100% reproducible oops mounting an ext3 or reiserfs
> > > > partition with -o barrier enabled.
> > > > Hand written oops (for ext3):
> > >
> > > That's a lot of hand-writing.  Thanks for doing that.  You can usually
> > > omit the hex numbers in [brackets] when doing this.
> > >
> > > The crash is here:
> > >
> > > static inline void blkdev_dequeue_request(struct request *req)
> > > {
> > > 	BUG_ON(list_empty(&req->queuelist));
> > >
> > > perhaps related to that I/O error sending the code through less-tested
> > > paths.
> >
> > Ouch indeed, I'll get that fixed up first thing in the morning.
>
> Can you test this work-around? The work-around should be perfectly safe,
> this is just a case where a BUG_ON() does more harm than good :-)
>
> --- drivers/ide/ide-io.c~	2004-05-21 11:02:58.000000000 +0200
> +++ drivers/ide/ide-io.c	2004-05-22 23:28:37.692944185 +0200
> @@ -291,6 +291,8 @@
>  		sector = real_rq->hard_sector;
>
>  	bad_sectors = real_rq->hard_nr_sectors - good_sectors;
> +	/* work-around, make sure request is on queue */
> +	elv_requeue_request(drive->queue, real_rq);
>  	if (good_sectors)
>  		__ide_end_request(drive, real_rq, 1, good_sectors);
>  	if (bad_sectors)

The oops goes away but:

hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
end_request: I/O error, dev hda, sector 84667085
Buffer I/O error on device hda11, logical block 559
lost page write due to I/O error on hda11
hda: failed barrier write: sector=50beacd(good=0/bad=8)
Aborting journal on device hda11.
ext3_abort called.
EXT3-fs abort (device hda11): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only

-- 
Lorenzo
