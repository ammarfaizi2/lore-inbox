Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSETHsX>; Mon, 20 May 2002 03:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSETHsW>; Mon, 20 May 2002 03:48:22 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:17442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314241AbSETHsV>;
	Mon, 20 May 2002 03:48:21 -0400
Message-ID: <3CE89C2F.20ED671B@gmx.net>
Date: Mon, 20 May 2002 08:48:15 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE PIO write Fix #2
In-Reply-To: <Pine.LNX.4.10.10205191826310.8582-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

1)
I follow your arguments regarding BUSY_STAT handled earlier.

2)
Can you explain, why the code looks at  "rq->current_nr_sectors==1" ?
In ATA-4 there is no special handling for "single-sector-transfer" or
"last-sector-transfer".

Andre Hedrick wrote:

> Hi Gunther,
>
> If you isolate that single section of code you are correct!
> However taking into the entire state diagram handler, you are wrong.
>
> Your issue of BUSY_STAT is addressed long before we even consider
> transferring a sector.  Additionally since we exit the state diagram after
> the last interrupt and check status we have met the requirements.
> DRIVE_READY exclusive to BUSY_STAT.
>
> Also note, my code base properly attempts to rewind the one whole sector
> on a media failure, this works since it is single sector transfers.
> Also note it is perfectly safe for partial completions and updating to the
> upper layers.
>
> /*
>  * Handler for command with PIO data-out phase WRITE
>  */
> ide_startstop_t task_out_intr (ide_drive_t *drive)
> {
>         byte stat               = INB(drive, IDE_STATUS_REG);
>         struct request *rq      = HWGROUP(drive)->rq;
>         char *pBuf              = NULL;
>         unsigned long flags;
>
>         if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat)) {
>                 DTF("%s: WRITE attempting to recover last " \
>                         "sector counter status=0x%02x\n",
>                         drive->name, stat);
>                 rq->current_nr_sectors++;
>                 return DRIVER(drive)->error(drive, "task_out_intr", stat);
>         }
>         /*
>          * Safe to update request for partial completions.
>          * We have a good STATUS CHECK!!!
>          */
>         if (!rq->current_nr_sectors)
>                 if (!DRIVER(drive)->end_request(drive, 1))
>                         return ide_stopped;
>         if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
>

...

