Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVKWHXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVKWHXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 02:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbVKWHXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 02:23:41 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:39790 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030339AbVKWHXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 02:23:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cqSleU22MLNlr02iXOqx8UIln098faqE1FptAAxg2NIzvFBGnEXWyEt5X6sjipKTVd7i+RlHdrDzdmCxLmSP63mwycqu3bKbpJERTkMkKIjCseRVVdN9texXWAL81pYAi6C3oT1hUSbLbFdWOHSCnGvoQxzuWbNFslty+8t9Na0=
Date: Wed, 23 Nov 2005 16:23:32 +0900
From: Tejun Heo <htejun@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to use new blk_ordered
Message-ID: <20051123072332.GA6653@htj.dyndns.org>
References: <20051117153509.B89B4777@htj.dyndns.org> <20051117153509.061D8991@htj.dyndns.org> <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com> <437DEE35.9060901@gmail.com> <58cb370e0511180759u4cb50535gfd7b96100a0bd70f@mail.gmail.com> <20051122024401.GB10213@htj.dyndns.org> <58cb370e0511220036r6e61b509i3bc1f7ce90178b1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0511220036r6e61b509i3bc1f7ce90178b1d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 09:36:09AM +0100, Bartlomiej Zolnierkiewicz wrote:
[--snip--]
> >
> > Ordered requests are processed in the following order.
> >
> > 1. barrier bio reaches blk queue
> >
> > 2. barrier req queued in order
> >
> > 3. when barrier req reaches the head of the request queue, it gets
> >    interpreted into preflush-barrier-postflush requests sequence
> >    and queued.  ->prepare_flush_fn is called in this step.
> >
> > 4. When all three requests complete, the ordered sequence ends.
> >
> > Adding !drive->wcache test to idedisk_prepare_flush, which in turn
> > requires adding ->prepare_flush_fn error handling to blk ordered
> > handling, prevents flushes for barrier requests between step#1 and
> 
> Why for !drive->wcache flush can't be consider as successful
> like it was before these changes...
> 
> > step#3.  We can still have flush reqeuests between #3 and #4 after
> > wcache is turned off.
> 
> ditto
> 

I think we have two alternatives here - both have some problems.

1. make ->prepare_flush_fn return some code to tell blk layer skip
   the flush as the original code did.

This is what you're proposing, I guess.  The reason why I'm reluctant
to take this approach is that there still remains window of error
between #3 and #4.  The flush requests could already be prepared and
in the queue when ->wcache is turned off.  AFAICS, the original code
had the same problem, although the window was narrower.

2. complete flush commands successfully in execute_drive_cmd() if wcache
   is not enabled.

This approach fixes all cases but the implementation would be a bit
hackish.  execute_drive_cmd() will have to look at the command and
ide_disk->wcache to determine if a special command should be completed
successfully without actually executing it.  Maybe we can add a
per-HL-driver callback for that.

Bartlomiej, I'm not really sure about both of above approaches.  My
humble opinion is that benefits brought by both of above aren't worth
the added complexity.  The worst can happen is a few IDE command
failures caused by executing flush command on a wcache disabled drive.
And that would happen only when the user turns off wcache while
barrier sequence is *in progress*.

Hmmm... What do you think?  It's your call.  I'll do what you choose.

[--snip--]

> > I agree that it should go into ->release, but I am still a bit scared
> > about issuing commands in ->release (it might access some data
> > structure which might be gone by then).  Also, the correct order seems
> > to be 'turning off ordered' and then 'perform the last cache flush'.
> > So, how about adding blk_queue_ordered right above the last
> > ide_cacheflush_p() now and move both to ->release in a separate patch
> > for both IDE and SCSI?
> 
> Not needed, when ide-disk is fixed to call del_gendisk() after
> ide_cacheflush_p(), we can add blk_queue_orderer() before
> the latter and then everything should be OK.

Can you get the patch into the post-2.6.15 branch of linux-2.6-block
tree?

Thanks.  :-)

-- 
tejun
