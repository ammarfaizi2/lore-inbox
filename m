Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSETBmT>; Sun, 19 May 2002 21:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315689AbSETBmS>; Sun, 19 May 2002 21:42:18 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62470
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315628AbSETBmR> convert rfc822-to-8bit; Sun, 19 May 2002 21:42:17 -0400
Date: Sun, 19 May 2002 18:41:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE PIO write Fix #2
In-Reply-To: <3CE558E1.3319E3E8@gmx.net>
Message-ID: <Pine.LNX.4.10.10205191826310.8582-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gunther,

If you isolate that single section of code you are correct!
However taking into the entire state diagram handler, you are wrong.

Your issue of BUSY_STAT is addressed long before we even consider
transferring a sector.  Additionally since we exit the state diagram after
the last interrupt and check status we have met the requirements.
DRIVE_READY exclusive to BUSY_STAT.

Also note, my code base properly attempts to rewind the one whole sector
on a media failure, this works since it is single sector transfers.
Also note it is perfectly safe for partial completions and updating to the
upper layers.

/*
 * Handler for command with PIO data-out phase WRITE
 */
ide_startstop_t task_out_intr (ide_drive_t *drive)
{
        byte stat               = INB(drive, IDE_STATUS_REG);
        struct request *rq      = HWGROUP(drive)->rq;
        char *pBuf              = NULL;
        unsigned long flags;

        if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat)) {
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
//              rq->current_nr_sectors--;
                taskfile_output_data(drive, pBuf, SECTOR_WORDS);
                task_unmap_rq(rq, pBuf, &flags);
                rq->errors = 0;
                rq->current_nr_sectors--;
        }
        if (HWGROUP(drive)->handler == NULL)
                ide_set_handler(drive, &task_out_intr, WAIT_CMD, NULL);
        return ide_started;
}

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS Gunther, my apology for the contents in the last email we transacted.

On Fri, 17 May 2002, Gunther Mayer wrote:

> Martin Dalecki wrote:
> 
> > U¿ytkownik Linus Torvalds napisa³:
> > > In article <3CE0D6DE.8090407@evision-ventures.com>,
> > > Martin Dalecki  <dalecki@evision-ventures.com> wrote:
> > >
> > >>>--- linux-2.5.15/drivers/ide/ide-taskfile.c.orig     Fri May 10 11:49:35 2002
> > >>>+++ linux-2.5.15/drivers/ide/ide-taskfile.c  Tue May 14 10:40:43 2002
> > >>>@@ -606,7 +606,7 @@
> > >>>             if (!ide_end_request(drive, rq, 1))
> > >>>                     return ide_stopped;
> > >>>
> > >>>-    if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
> > >>>+    if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
> > >>
> > >
> > > Well, that's definitely an improvement - the original code makes no
> > > sense at all, since it's doing a bitwise xor on two bits that are not
> > > the same, and then uses that as a boolean value.
> > >
> > > Your change at least makes it use the bitwise xor on properly logical
> > > values, making the bitwise xor work as a _logical_ xor.
> > >
> > > Although at that point I'd just get rid of the xor, and replace it by
> > > the "!=" operation - which is equivalent on logical ops.
> > >
> > >
> > >>>             pBuf = ide_map_rq(rq, &flags);
> > >>>             DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
> > >>
> > >>
> > >>Hmm. There is something else that smells in the above, since the XOR operator
> > >>doesn't seem to be proper. Why shouldn't we get DRQ_STAT at all on short
> > >>request? Could you perhaps just try to replace it with an OR?
> > >
> > >
> > > The XOR operation is a valid op, if you just use it on valid values,
> > > which the patch does seem to make it do.
> > >
> > > I don't know whether the logic is _correct_ after that, but at least
> > > there is some remote chance that it might make sense.
> > >
> > >               Linus
> >
> > As far as I can see the patch makes sense. It is just exposing a problem
> > which was hidden before.
> 
> The original code:
>  a)    if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
> is being compared to these expressions:
>  b) logical equ. if ((rq->current_nr_sectors==1) || ((stat & DRQ_STAT)!=0)) {   (me)
>  c) not eqival.  if ((rq->current_nr_sectors==1) ^  ((stat & DRQ_STAT)!=0)) {  (tomita)
>  d) same as c    if ((rq->current_nr_sectors==1) != ((stat & DRQ_STAT)!=0)) {  (linus)
> 
> Note: DRQ_STAT will be set when this routine is entered per "PIO Out protocol spec".
> 
> c+d will deadlock.
>     (it will _not_ send the last sector)
> 
> a+b will send the last sector to the drive when it isn't ready to receive.
>     (Although most of the time it _will_ be ready when we enter this routine)
> 
> So:
>    if( (stat & DRQ_STAT) && !(stat & BSY_STAT)) {
> should be correct.
> 
> The original intent for a) was probably:
> check DRQ only on the _first_ sector we transfer as
> shown in "ATA-4 PIO data out command protocol", which would translate to:
> e) if ( !(rq->are_we_transferring_the_first_sector_just_now) || ((stat & DRQ_STAT)!=0)) {
> 
> -
> Gunther
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

