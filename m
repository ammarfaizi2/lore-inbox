Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUFIVtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUFIVtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUFIVtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:49:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31406 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265993AbUFIVtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:49:15 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Wed, 9 Jun 2004 23:52:18 +0200
User-Agent: KMail/1.5.3
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <200406041814.35003.bzolnier@elka.pw.edu.pl> <20040605091853.GA13641@suse.de>
In-Reply-To: <20040605091853.GA13641@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406092352.18470.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ end of flaming + new technical arguments, please read ]

On Saturday 05 of June 2004 11:18, Jens Axboe wrote:
> On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > Yep, you prefer to increase my work load instead.
> > >
> > > If you think that any change to the ide base is increasing your work
> > > load, then yes. Otherwise no.
> >
> > No, only the messy ones.
> >
> > > > > That you need to queue pre/post flushes to support barriers is a
> > > > > _driver implementation detail_ in my opinion. You don't want to
> > > > > even advertise
> > > >
> > > > It is implementation braindamage IMO (but I'll buy it if rest is OK).
> > >
> > > Well feel free to pull a rabbit out of your hat and suggest something
> > > else that works for barriers. It's mind boggling that nothing so far
> > > has come out of t13 to address this, I guess data integrity isn't high
> > > on their list.
> > >
> > > So in short, either shut up or put up.
> >
> > Yeah, this the hardest part.  I'll see what can be done.
> >
> > > > > that to upper layers. I will move a little of that into the block
> > > > > layer, if only because SATA will need it as well.
> > > > >
> > > > > As for REQ_DRIVE_TASK and ide_get_error_location(), well hell I do
> > > > > take patches! If there's something you consider broken, damnit send
> > > > > a patch
> > > >
> > > > It is _your_ job to do it properly.
> > >
> > > I _am_ doing it properly. If you think otherwise, then I suggest you
> > > show in code what you want changed. If you think it's my job to keep
> > > changing the code based on unclear suggestions, then you are sadly
> > > mistaken.
> >
> > Suggestions were clear, you've chosen to ignore them wishing that
> > I will correct the patch or that you will push patch upstream anyway.
>
> And you seem to think that an IDE maintainers listing provides you with
> a magical wand that says what goes and doesn't. You might want to check
> if that hat is fits too tightly.  Generally, I'd like folks to help out.

Sure, you don't need my ACK, that's obvious - you need it from Linus/Andrew.

> And generally, I like people to provide code comments that are to the
> point - or, even better, show what they mean with a patch. If you have
> no technical arguments except saying 'crap', then don't expect me to put
> much value into your comments.

I don't think this is true but I'll try to be more 'technical' from now on.

> > > > There are no double standards, 'IDE crap embargo' holds for everyone.
> > >
> > > Like it or not, but ide code needs changing to support barriers one way
> >
> > Rule is simple "no more crappola in IDE" and I don't care what your
> > patch does if this rule is violated.
>
> I'm really sick of having this debate, it's a complete waste of time.
> I'm not looking for your approval or anything in that order, and since

I hope that people doing block layer changes won't get the same attitude.

> we don't agree all the points in solving this problem, there's no point
> in continuing.

I tried to redo IDE part but discovered nasty design problem, more below.

> > > or the other. If there's some part of the implementation you don't
> > > like, then I suggest you show why. Since we appear to have reached a
> >
> > Damn, I showed it few times.  You seem to contradict yourself.
>
> A few of the points. Your main argument on the pre/post flush business
> makes zero sense still, and that seems to be the heart of your
> 'crappola' argument.
>
> I already said that I can move the business of queueing post/pre flushes
> into the block core instead. You seem to the very way of using pre/post
> flushes to provide barriers, and to that I can only say tough shit.
> Unless you can pull a rabbit out of your hat and suggest something
> better, then your 'crappola' argument holds absolutely no grounds
> whatsoever. The pre/post flush approach has worked successfully, it's
> been tested extensively, and it works. Your pipe dreams of absolutely no
> substance need no further comments.

It currently works this way:

	pre flush (whole disk cache) + write + post flush (whole disk cache)

This is private to IDE code, higher layers do not know about it.

	write + flush (whole disk cache)

Is sufficient because you can failed sector number and see if it belongs
to your write request.  Pre flush can't help you in any way with previous
requests because they were already ACK-ed to higher layers.

Please correct me if I'm missing something.

> > > discussion dead lock, I suggest you do so by showing a patch changing
> > > eg the ide_get_error_location() stuff. Sadly you could have done this
> > > roughly 10 times in the same time frame that you have written these
> > > emails.
> >
> > Are you trying to trick me into doing your task?
>
> I don't know why you keep thinking this is my job to complete this
> project 100% on my own?! There's a general problem that needs solving,
> and I would hope that others would be willing to help out where needed.
> I would encourage people to help out if they care about the issue.

Please note that barrier patches are a new feature not a bugfix as
you can always disable write cache unless buggy firmware/disk but in
this case you can't be sure if they don't lie about flushes too.

Yes, thats suck for performance but you can instead get drives which
expire their caches (most do?) and UPS (they are really cheap nowadays).

;-)

I like the idea of flush barriers but I see more and more problems
to do it sanely.

> I'm not going to comment further on your mails in this thread, unless
> they have substantial technical comment. Your 'crap' arguments so far
> have been largely unsubstantiated, and as such they don't accomplish
> much except waste time.

OK.  I tried to rewrite IDE part and discovered this:

+int ide_end_request (ide_drive_t *drive, int uptodate, int nr_sectors)
+{
+	struct request *rq;
+	unsigned long flags;
+	int ret = 1;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	rq = HWGROUP(drive)->rq;
+
+	if (!nr_sectors)
+		nr_sectors = rq->hard_cur_sectors;
+
+	if (!blk_barrier_rq(rq))
+		ret = __ide_end_request(drive, rq, uptodate, nr_sectors);
+	else {

It seems that __ide_end_request() and thus end_that_request_first()
is called only once for the real_rq request - it breaks partial completions
which are by IDE PIO code (-> it breaks IDE PIO).

I don't see an easy way to fix it because if we do partial completions
we'll ACK some bios to higher layers before doing flush.

Fixing IDE not to do partial completions is also not easy
(I'm doing it slowly).

+		struct request *flush_rq = &HWGROUP(drive)->wrq;
+
+		flush_rq->nr_sectors -= nr_sectors;
+		if (!flush_rq->nr_sectors) {
+			ide_queue_flush_cmd(drive, rq, 1);
+			ret = 0;
+		}
+	}

BTW are you aware of two (minor?) corner cases of the current implementation?

- you can't have journal on a separate device
  (pre and post flushes will only flush device storing journal not data)

- if you more than > 1 filesystem on the disk (quite likely scenario) it
  can happen that barrier (flush) will fail for sector for file from the
  other fs and later barrier for this other fs will succeed

[ If you see any mistakes in my comments please correct them.
  I tried to be as accurate as possible. ]

Thanks,
Bartlomiej

