Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJACOM>; Mon, 30 Sep 2002 22:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJACOM>; Mon, 30 Sep 2002 22:14:12 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64012
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261448AbSJACOK>; Mon, 30 Sep 2002 22:14:10 -0400
Date: Mon, 30 Sep 2002 19:17:07 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>, Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, james <jdickens@ameritech.net>,
       Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <20020930130517.GA23933@suse.de>
Message-ID: <Pine.LNX.4.10.10209301158130.31864-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First an apology to Russell for bring him into this thread.

On Mon, 30 Sep 2002, Jens Axboe wrote:

> On Mon, Sep 30 2002, Alan Cox wrote:
> > On Mon, 2002-09-30 at 08:56, Jens Axboe wrote:
> > > 2.5 at least does not have the taskfile hang, because I killed taskfile
> > > io.
> > 
> > Thats not exactly a fix 8). 2.5 certainly has the others. Taskfile I/O
> 
> I didn't claim it was, I just don't want a user setting taskfile io to
> 'y' because he thinks its cool when we know its broken.
> 
> > is pretty low on my fix list. The fix isnt trivial because we set the
> > IRQ handler late - so the IRQ can beat us setting the handler, but
> > equally if we set it early we get to worry about all the old races in
> > 2.3.x
> 
> Where exactly is the race?

As soon as you complete read or writing the final byte in a pio state
diagram, the device can interrupt instantly!  I do mean instantly.


ide_startstop_t task_out_intr (ide_drive_t *drive)
{
        ide_hwif_t *hwif        = HWIF(drive);
        struct request *rq      = HWGROUP(drive)->rq;
        char *pBuf              = NULL;
        unsigned long flags;
        u8 stat;

        if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG),
                     DRIVE_READY, drive->bad_wstat)) {
                DTF("%s: WRITE attempting to recover last " \
                        "sector counter status=0x%02x\n",
                        drive->name, stat);
                rq->current_nr_sectors++;
                return DRIVER(drive)->error(drive, "task_out_intr", stat);
        }
        /*
         * Safe to update request for partial completions.
         * We have a good STATUS CHECK!!!
         */
        if (!rq->current_nr_sectors)
                if (!DRIVER(drive)->end_request(drive, 1))
                        return ide_stopped;
        if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
                 rq = HWGROUP(drive)->rq;
                pBuf = task_map_rq(rq, &flags);
                DTF("write: %p, rq->current_nr_sectors: %d\n",
                        pBuf, (int) rq->current_nr_sectors);
                taskfile_output_data(drive, pBuf, SECTOR_WORDS);
KABOOM! The RACE is on! (The handler start point)
                task_unmap_rq(rq, pBuf, &flags);
                rq->errors = 0;
                rq->current_nr_sectors--;
        }
        if (HWGROUP(drive)->handler == NULL)
                ide_set_handler(drive, &task_out_intr, WAIT_WORSTCASE, NULL);
Driver WINS!
        return ide_started;
}

If the device issues an interrupt to the host controller before we can arm
the handler we are dead.

void taskfile_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
{
        if (drive->bswap) {
                ata_bswap_data(buffer, wcount);
                HWIF(drive)->ata_output_data(drive, buffer, wcount);
KABOOM! The RACE is on! (The Second fake start point)
                ata_bswap_data(buffer, wcount);
        } else {
                HWIF(drive)->ata_output_data(drive, buffer, wcount);
KABOOM! The RACE is on! (The Second fake start point)
        }
}

void ata_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
{
        ide_hwif_t *hwif        = HWIF(drive);
        u8 io_32bit             = drive->io_32bit;

        if (io_32bit) {
                if (io_32bit & 2) {
                        unsigned long flags;
                        local_irq_save(flags);
                        ata_vlb_sync(drive, IDE_NSECTOR_REG);
                        hwif->OUTSL(IDE_DATA_REG, buffer, wcount);
                        local_irq_restore(flags);
                } else
                        hwif->OUTSL(IDE_DATA_REG, buffer, wcount);
        } else {
                hwif->OUTSW(IDE_DATA_REG, buffer, wcount<<1);
        }
KABOOM! The RACE is on! (The Real start point)
}


If we are having to lollygag in the kernel for a byteswap or a bounce
buffer (aka memcpy/free) we can/will loose the interrupt.  The old code
would push the handler early resulting in timeouts and double handlers
added.

Now the question is how to addresss the race.

At this point we have two paths each with bugs.
The old legacy path can allow for the wrong handler to be executed for a
given interrupt.  The old path can with the above bug can potentially crap
data.  Specifically wrong handle execution.

The new path can miss setting the handler in time.

It can be fixed and maybe the account process stuff is already present,
and we are at another communication delay but it shall be worked through
calmly, not like the past where nothing gets done and people just become
offended.

Cheers,


Andre Hedrick
LAD Storage Consulting Group



