Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWGYNNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWGYNNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWGYNNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 09:13:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:23833 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751397AbWGYNNJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 09:13:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ll0hdII272b+hrjRPLc3w6BhFUOYUmDvZq8ZCujZS1RRmM8ZhYpQXOnR/pwQxjobqSMmjuslCoCpkgW0nF5Xzb/k0v123f06vzhjH0Ze2jCbT1EuGKqYtPxcSTVVAZg361ku9d4OzfUm8RSLJl4cuO5ShHrMshJZ/53ELrRRgrw=
Message-ID: <f96157c40607250613taf77f0ex6fd386e25e2f42e7@mail.gmail.com>
Date: Tue, 25 Jul 2006 15:13:07 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: Re: i686 hang on boot in userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060725125201.GT4044@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060725074107.GA4044@suse.de> <20060725080002.GD4044@suse.de>
	 <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com>
	 <20060725080807.GF4044@suse.de>
	 <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com>
	 <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com>
	 <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com>
	 <20060725112955.GR4044@suse.de>
	 <f96157c40607250547m5af37b4gbab72a2764e7cb7c@mail.gmail.com>
	 <20060725125201.GT4044@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, so I can stop searching for a terminal app (HyperTerminal was
not installed
on this Windows box) and escape the 20°C which feel like winter when it is
35°C outside.

I will test the 2nd patch and let you know.

On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Jul 25 2006, gmu 2k6 wrote:
> > On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> > >On Tue, Jul 25 2006, gmu 2k6 wrote:
> > >> ok, let's nail it to 2.6.17-git5 instead as it survived git status
> > >> compared to -git6
> > >> which seems to have correctly booted by accident the lastime. timing
> > >issues
> > >> I guess.
> > >
> > >I will try and reproduce it here now. It seems to be in between commit
> > >271f18f102c789f59644bb6c53a69da1df72b2f4 and commit
> > >dd67d051529387f6e44d22d1d5540ef281965fdd where the first one could also
> > >be bad.
> > >
> > >I'm assuming that acf421755593f7d7bd9352d57eda796c6eb4fa43 should be
> > >good, so you can try and verify that
> > >dd67d051529387f6e44d22d1d5540ef281965fdd is bad and bisect between the
> > >two. It's only about 6 commits, so should be quick enough to do.
> >
> > 1) no luck with remote serial console
> > 2) netconsole does not work although connecting to the listener with netcat
> > and
> > sending strings works
> > I'm gonna try via physical rs232 9pins and see how that works.
> > afterwards I will try to bisect the revisions you mentioned.
> >
> > btw, the issue seems to come and go as I managed to boot log into a .17-git6
> > kernel or is timing-dependent.
>
> I can reproduce it, you don't have to spend more time on bisecting or
> testing. This should fix it:
>
> diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> index 1c4df22..1eac041 100644
> --- a/drivers/block/cciss.c
> +++ b/drivers/block/cciss.c
> @@ -1238,6 +1238,7 @@ static void cciss_softirq_done(struct re
>        CommandList_struct *cmd = rq->completion_data;
>        ctlr_info_t *h = hba[cmd->ctlr];
>        unsigned long flags;
> +       request_queue_t *q;
>        u64bit temp64;
>        int i, ddir;
>
> @@ -1260,10 +1261,13 @@ #ifdef CCISS_DEBUG
>        printk("Done with %p\n", rq);
>  #endif                         /* CCISS_DEBUG */
>
> +       q = rq->q;
> +
>        add_disk_randomness(rq->rq_disk);
>        spin_lock_irqsave(&h->lock, flags);
>        end_that_request_last(rq, rq->errors);
>        cmd_free(h, cmd, 1);
> +       blk_start_queue(q);
>        spin_unlock_irqrestore(&h->lock, flags);
>  }
>
>
> A better fix would rework the start_queue logic entirely in the driver,
> but the above should get you running for now. I'll take a further look.
>
> --
> Jens Axboe
>
>
