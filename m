Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWGYO3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWGYO3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWGYO3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:29:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:6107 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932362AbWGYO3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:29:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ONtVkWOckeWs4IpAQJabLz1MmBQQIFp/KbBWEypLfpqSpQBHn2uDj6pXoDrNhRrsJerKz/7zxpYrx9eVFkU3OG3izdCrIk6W1yk+z+ZkHMLKteQykdKZGUofQZEXbHs0eupzEnRL5UBoCdToM467gFb8bzM6QyiZEarysNlH/PM=
Message-ID: <f96157c40607250729i6f29eab3xc9987931421bb483@mail.gmail.com>
Date: Tue, 25 Jul 2006 14:29:33 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Re: i686 hang on boot in userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f96157c40607250727o685b8195i67da8c68123728f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f96157c40607250120s2554cbc6qbd7c42972b70f6de@mail.gmail.com>
	 <20060725080807.GF4044@suse.de>
	 <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com>
	 <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com>
	 <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
	 <20060725112955.GR4044@suse.de>
	 <f96157c40607250547m5af37b4gbab72a2764e7cb7c@mail.gmail.com>
	 <20060725125201.GT4044@suse.de> <20060725125854.GU4044@suse.de>
	 <f96157c40607250727o685b8195i67da8c68123728f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/06, gmu 2k6 <gmu2006@gmail.com> wrote:
> On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> > On Tue, Jul 25 2006, Jens Axboe wrote:
> > > On Tue, Jul 25 2006, gmu 2k6 wrote:
> > > > On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> > > > >On Tue, Jul 25 2006, gmu 2k6 wrote:
> > > > >> ok, let's nail it to 2.6.17-git5 instead as it survived git status
> > > > >> compared to -git6
> > > > >> which seems to have correctly booted by accident the lastime. timing
> > > > >issues
> > > > >> I guess.
> > > > >
> > > > >I will try and reproduce it here now. It seems to be in between commit
> > > > >271f18f102c789f59644bb6c53a69da1df72b2f4 and commit
> > > > >dd67d051529387f6e44d22d1d5540ef281965fdd where the first one could also
> > > > >be bad.
> > > > >
> > > > >I'm assuming that acf421755593f7d7bd9352d57eda796c6eb4fa43 should be
> > > > >good, so you can try and verify that
> > > > >dd67d051529387f6e44d22d1d5540ef281965fdd is bad and bisect between the
> > > > >two. It's only about 6 commits, so should be quick enough to do.
> > > >
> > > > 1) no luck with remote serial console
> > > > 2) netconsole does not work although connecting to the listener with netcat
> > > > and
> > > > sending strings works
> > > > I'm gonna try via physical rs232 9pins and see how that works.
> > > > afterwards I will try to bisect the revisions you mentioned.
> > > >
> > > > btw, the issue seems to come and go as I managed to boot log into a .17-git6
> > > > kernel or is timing-dependent.
> > >
> > > I can reproduce it, you don't have to spend more time on bisecting or
> > > testing. This should fix it:
> > >
> > > diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> > > index 1c4df22..1eac041 100644
> > > --- a/drivers/block/cciss.c
> > > +++ b/drivers/block/cciss.c
> > > @@ -1238,6 +1238,7 @@ static void cciss_softirq_done(struct re
> > >       CommandList_struct *cmd = rq->completion_data;
> > >       ctlr_info_t *h = hba[cmd->ctlr];
> > >       unsigned long flags;
> > > +     request_queue_t *q;
> > >       u64bit temp64;
> > >       int i, ddir;
> > >
> > > @@ -1260,10 +1261,13 @@ #ifdef CCISS_DEBUG
> > >       printk("Done with %p\n", rq);
> > >  #endif                               /* CCISS_DEBUG */
> > >
> > > +     q = rq->q;
> > > +
> > >       add_disk_randomness(rq->rq_disk);
> > >       spin_lock_irqsave(&h->lock, flags);
> > >       end_that_request_last(rq, rq->errors);
> > >       cmd_free(h, cmd, 1);
> > > +     blk_start_queue(q);
> > >       spin_unlock_irqrestore(&h->lock, flags);
> > >  }
> > >
> > >
> > > A better fix would rework the start_queue logic entirely in the driver,
> > > but the above should get you running for now. I'll take a further look.
> >
> > Something like this matches the current logic better. It's not very good
> > from a cpu efficiency point of view, but it's better than what is there
> > now since at least it's not in hard irq context.
> >
> > Not tested yet, will do so right now.
> >
> > diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> > index 1c4df22..a9e0510 100644
> > --- a/drivers/block/cciss.c
> > +++ b/drivers/block/cciss.c
> > @@ -1233,6 +1233,50 @@ static inline void complete_buffers(stru
> >         }
> >  }
> >
> > +static void cciss_check_queues(ctlr_info_t *h)
> > +{
> > +       int start_queue = h->next_to_run;
> > +       int i;
> > +
> > +       /* check to see if we have maxed out the number of commands that can
> > +        * be placed on the queue.  If so then exit.  We do this check here
> > +        * in case the interrupt we serviced was from an ioctl and did not
> > +        * free any new commands.
> > +        */
> > +       if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
> > +               return;
> > +
> > +       /* We have room on the queue for more commands.  Now we need to queue
> > +        * them up.  We will also keep track of the next queue to run so
> > +        * that every queue gets a chance to be started first.
> > +        */
> > +       for (i = 0; i < h->highest_lun + 1; i++) {
> > +               int curr_queue = (start_queue + i) % (h->highest_lun + 1);
> > +               /* make sure the disk has been added and the drive is real
> > +                * because this can be called from the middle of init_one.
> > +                */
> > +               if (!(h->drv[curr_queue].queue) || !(h->drv[curr_queue].heads))
> > +                       continue;
> > +               blk_start_queue(h->gendisk[curr_queue]->queue);
> > +
> > +               /* check to see if we have maxed out the number of commands
> > +                * that can be placed on the queue.
> > +                */
> > +               if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS) {
> > +                       if (curr_queue == start_queue) {
> > +                               h->next_to_run =
> > +                                   (start_queue + 1) % (h->highest_lun + 1);
> > +                               break;
> > +                       } else {
> > +                               h->next_to_run = curr_queue;
> > +                               break;
> > +                       }
> > +               } else {
> > +                       curr_queue = (curr_queue + 1) % (h->highest_lun + 1);
> > +               }
> > +       }
> > +}
> > +
> >  static void cciss_softirq_done(struct request *rq)
> >  {
> >         CommandList_struct *cmd = rq->completion_data;
> > @@ -1264,6 +1308,7 @@ #endif                            /* CCISS_DEBUG */
> >         spin_lock_irqsave(&h->lock, flags);
> >         end_that_request_last(rq, rq->errors);
> >         cmd_free(h, cmd, 1);
> > +       cciss_check_queues(h);
> >         spin_unlock_irqrestore(&h->lock, flags);
> >  }
> >
> > @@ -2528,8 +2573,6 @@ static irqreturn_t do_cciss_intr(int irq
> >         CommandList_struct *c;
> >         unsigned long flags;
> >         __u32 a, a1, a2;
> > -       int j;
> > -       int start_queue = h->next_to_run;
> >
> >         if (interrupt_not_for_us(h))
> >                 return IRQ_NONE;
> > @@ -2588,45 +2631,6 @@ #                                endif
> >                 }
> >         }
> >
> > -       /* check to see if we have maxed out the number of commands that can
> > -        * be placed on the queue.  If so then exit.  We do this check here
> > -        * in case the interrupt we serviced was from an ioctl and did not
> > -        * free any new commands.
> > -        */
> > -       if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
> > -               goto cleanup;
> > -
> > -       /* We have room on the queue for more commands.  Now we need to queue
> > -        * them up.  We will also keep track of the next queue to run so
> > -        * that every queue gets a chance to be started first.
> > -        */
> > -       for (j = 0; j < h->highest_lun + 1; j++) {
> > -               int curr_queue = (start_queue + j) % (h->highest_lun + 1);
> > -               /* make sure the disk has been added and the drive is real
> > -                * because this can be called from the middle of init_one.
> > -                */
> > -               if (!(h->drv[curr_queue].queue) || !(h->drv[curr_queue].heads))
> > -                       continue;
> > -               blk_start_queue(h->gendisk[curr_queue]->queue);
> > -
> > -               /* check to see if we have maxed out the number of commands
> > -                * that can be placed on the queue.
> > -                */
> > -               if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS) {
> > -                       if (curr_queue == start_queue) {
> > -                               h->next_to_run =
> > -                                   (start_queue + 1) % (h->highest_lun + 1);
> > -                               goto cleanup;
> > -                       } else {
> > -                               h->next_to_run = curr_queue;
> > -                               goto cleanup;
> > -                       }
> > -               } else {
> > -                       curr_queue = (curr_queue + 1) % (h->highest_lun + 1);
> > -               }
> > -       }
> > -
> > -      cleanup:
> >         spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);
> >         return IRQ_HANDLED;
> >  }
>
> this makes the cciss init hang.

I've patched Linus' trunk/HEAD with it, btw.
