Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWGZE6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWGZE6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 00:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWGZE6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 00:58:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60237 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030384AbWGZE6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 00:58:30 -0400
Date: Tue, 25 Jul 2006 17:19:45 +0200
From: Jens Axboe <axboe@suse.de>
To: gmu 2k6 <gmu2006@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
Message-ID: <20060725151945.GY4044@suse.de>
References: <20060725080002.GD4044@suse.de> <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com> <20060725080807.GF4044@suse.de> <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com> <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com> <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com> <20060725112955.GR4044@suse.de> <f96157c40607250547m5af37b4gbab72a2764e7cb7c@mail.gmail.com> <20060725125201.GT4044@suse.de> <f96157c40607250750n5aa08856jbe792b0e66fb814b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96157c40607250750n5aa08856jbe792b0e66fb814b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25 2006, gmu 2k6 wrote:
> On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> >On Tue, Jul 25 2006, gmu 2k6 wrote:
> >> On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> >> >On Tue, Jul 25 2006, gmu 2k6 wrote:
> >> >> ok, let's nail it to 2.6.17-git5 instead as it survived git status
> >> >> compared to -git6
> >> >> which seems to have correctly booted by accident the lastime. timing
> >> >issues
> >> >> I guess.
> >> >
> >> >I will try and reproduce it here now. It seems to be in between commit
> >> >271f18f102c789f59644bb6c53a69da1df72b2f4 and commit
> >> >dd67d051529387f6e44d22d1d5540ef281965fdd where the first one could also
> >> >be bad.
> >> >
> >> >I'm assuming that acf421755593f7d7bd9352d57eda796c6eb4fa43 should be
> >> >good, so you can try and verify that
> >> >dd67d051529387f6e44d22d1d5540ef281965fdd is bad and bisect between the
> >> >two. It's only about 6 commits, so should be quick enough to do.
> >>
> >> 1) no luck with remote serial console
> >> 2) netconsole does not work although connecting to the listener with 
> >netcat
> >> and
> >> sending strings works
> >> I'm gonna try via physical rs232 9pins and see how that works.
> >> afterwards I will try to bisect the revisions you mentioned.
> >>
> >> btw, the issue seems to come and go as I managed to boot log into a 
> >.17-git6
> >> kernel or is timing-dependent.
> >
> >I can reproduce it, you don't have to spend more time on bisecting or
> >testing. This should fix it:
> >
> >diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> >index 1c4df22..1eac041 100644
> >--- a/drivers/block/cciss.c
> >+++ b/drivers/block/cciss.c
> >@@ -1238,6 +1238,7 @@ static void cciss_softirq_done(struct re
> >        CommandList_struct *cmd = rq->completion_data;
> >        ctlr_info_t *h = hba[cmd->ctlr];
> >        unsigned long flags;
> >+       request_queue_t *q;
> >        u64bit temp64;
> >        int i, ddir;
> >
> >@@ -1260,10 +1261,13 @@ #ifdef CCISS_DEBUG
> >        printk("Done with %p\n", rq);
> > #endif                         /* CCISS_DEBUG */
> >
> >+       q = rq->q;
> >+
> >        add_disk_randomness(rq->rq_disk);
> >        spin_lock_irqsave(&h->lock, flags);
> >        end_that_request_last(rq, rq->errors);
> >        cmd_free(h, cmd, 1);
> >+       blk_start_queue(q);
> >        spin_unlock_irqrestore(&h->lock, flags);
> > }
> >
> >
> >A better fix would rework the start_queue logic entirely in the driver,
> >but the above should get you running for now. I'll take a further look.
> 
> this four-liner seems to fix it:
> - I can boot
> - log in
> - git-status works
> - svn up works
> 
> as my last mail said the 2nd patch with the new function introduced
> did hang cciss
> on driver init before printing any drive info.

The problem with the 4-liner is that it potentially starves some arrays
(in theory). I'll retry the full fix.

> btw, I assume you have systems with SmartArray 6* at your disposal to
> test, right?
> I mean SuSE should have some as a distro vendor.

I do, I have several right here next to me.

-- 
Jens Axboe

