Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVKVCoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVKVCoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVKVCoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:44:12 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:24208 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964877AbVKVCoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:44:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=V/Q7/p5fWlgEfJdRyOwnUuOKHeZSLm2VDH7QOMB+tn1DVIrcsHNdEd4hTA+BOwYsmi5CbQ9FJPnhVq0/IGDqg3N4CvvX4gLUe5I4E1onV2TXEnsvCalMZtpdUwdYZ2vjeCGRzzKImbBby1VEFGrphfMf6xfvc/NDZKvHJAwb1zk=
Date: Tue, 22 Nov 2005 11:44:01 +0900
From: Tejun Heo <htejun@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to use new blk_ordered
Message-ID: <20051122024401.GB10213@htj.dyndns.org>
References: <20051117153509.B89B4777@htj.dyndns.org> <20051117153509.061D8991@htj.dyndns.org> <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com> <437DEE35.9060901@gmail.com> <58cb370e0511180759u4cb50535gfd7b96100a0bd70f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511180759u4cb50535gfd7b96100a0bd70f@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 04:59:28PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 11/18/05, Tejun Heo <htejun@gmail.com> wrote:
> > Hello, Bartlomiej.
> >
> > Bartlomiej Zolnierkiewicz wrote:
> > > On 11/17/05, Tejun Heo <htejun@gmail.com> wrote:
> > >
> > > I fail to see how the partial completions (good + bad sectors)
> > > are done in your new scheme, please explain.
> > >
> >
> > It doesn't.  I've noted this way back when I posted this patchset the
> > second time.
> 
> This should be noted in the patch description not in the announcement.

Will add it to patch description.

> 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111795127124020&w=2
> >
> > Rationales
> >
> > * The actual barrier IO request is issued as a part of ordered sequence.
> >   When any part of this sequence fails (any of leading flush, barrier IO
> > or post flush), the whole sequence should be considered to have failed.
> >
> > e.g. if leading flush fails, there's no point in reporting partial or
> > full success of barrier IO.  Ditto for tailing flush.  We can special
> > case when only part of barrier IO fails and report partial barrier
> > success, but 1. benefits are doubtful  2. even if it's implemented, it
> > wouldn't work (see next rationale)
> >
> > * Barrier requests are not mergeable.  ie. Each barrier bio is turned
> > into one barrier request and partially completing the request doesn't
> > result in any successfully completed bio.
> 
> However your flush request can fail on the sector _completely_
> unrelated to the barrier request so in this case old code worked
> differently.  Anyway I'm fine with this change (previous logic was
> too complicated).

Hmmm... Ordered sequence should fail even when flush request fails on
a completely unrelated to the barrier request.  The barrier request
must make sure that all requests issued prior to it have made to the
physical medium successfully.

Anyways, you're right in that it acts differently from the original
code and it should be noted in the patch description.  I'll update the
patch description.

> 
> > * SCSI doesn't handle partial completion of barrier IOs.
> >
> > >
> > >>-
> > >>-static int idedisk_prepare_flush(request_queue_t *q, struct request *rq)
> > >>-{
> > >>-       ide_drive_t *drive = q->queuedata;
> > >>-
> > >>-       if (!drive->wcache)
> > >>-               return 0;
> > >
> > >
> > > What does happen if somebody disables drive->wcache later?
> > >
> >
> > Thanks for pointing out.  I've moved ordered configuration into
> > write_cache such that ordered is reconfigured when write_cache changes.
> > There can be in-flight barrier requests which are inconsistent with the
> > newly updated setting, but 1. it's not too unfair to assume that user is
> > responsible for that synchronization 2. the original implementation had
> > the same issue 3. the consequence is not catastrophic.
> 
> The consequence could be increased number of bugreports about
> failed IDE commands which wasn't the case with !drive->wcache check
> in place - please leave as it was.

Ordered requests are processed in the following order.

1. barrier bio reaches blk queue

2. barrier req queued in order

3. when barrier req reaches the head of the request queue, it gets
   interpreted into preflush-barrier-postflush requests sequence
   and queued.  ->prepare_flush_fn is called in this step.

4. When all three requests complete, the ordered sequence ends.

Adding !drive->wcache test to idedisk_prepare_flush, which in turn
requires adding ->prepare_flush_fn error handling to blk ordered
handling, prevents flushes for barrier requests between step#1 and
step#3.  We can still have flush reqeuests between #3 and #4 after
wcache is turned off.

Please also note that any of above happens only if a user turns off
->wcache setting while a fs is actively performing a barrier.

I'm not sure the benefit justifies added complexity.  Do you still
think adding ->wcache test is necessary?

> 
> > >> static void ide_cacheflush_p(ide_drive_t *drive)
> > >>@@ -1034,6 +993,8 @@ static int ide_disk_remove(struct device
> > >>        struct ide_disk_obj *idkp = drive->driver_data;
> > >>        struct gendisk *g = idkp->disk;
> > >>
> > >>+       blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE, NULL, 0);
> > >>+
> > >
> > >
> > > Shouldn't this be done in ide_disk_release()?
> >
> > Hmmm... The thing is that, AFAIK, requests are not supposed to be issued
> > after ->remove is called (->remove is called only on module unload
> > unless hardware is hot-unplugged and HL driver cannot be unloaded while
> > it's still opened).  I think that's why both sd and ide-disk issue the
> > last cache flush in ->remove callbacks but not in ->release.
> 
> Are you sure?  I think that only calling del_gendisk() assures you
> that there won't be outstanding fs requests?
> 
> I have also noticed bug in ide_disk_remove() - ide_cacheflush_p()
> should be called after del_gendisk() - I will fix it later.
> 
> BTW Nowadays you can dynamically dettach/attach driver from/to
> device using sysfs interface.

I agree that it should go into ->release, but I am still a bit scared
about issuing commands in ->release (it might access some data
structure which might be gone by then).  Also, the correct order seems
to be 'turning off ordered' and then 'perform the last cache flush'.
So, how about adding blk_queue_ordered right above the last
ide_cacheflush_p() now and move both to ->release in a separate patch
for both IDE and SCSI?

Thanks.

-- 
tejun
