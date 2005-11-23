Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbVKWImW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbVKWImW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVKWImW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:42:22 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:31920 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1030370AbVKWImV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:42:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k5VqrEcGnMyrOmnuKrzWUrCZi7luItiWyj3uRsSP05o0l/44h5RP4h7aWbQmzoUCgE5hBKRvRPlR0eEWnSvAwnm+SDTh7DyByOY8NRosVTgYKc3FqBpGczYzJkmMXaajaBA0Fo0yNQ8hmu+lDOY79qG945k/DfAdSXqh67ysneQ=
Message-ID: <58cb370e0511230040k6bc53862xac35979eaf1f0634@mail.gmail.com>
Date: Wed, 23 Nov 2005 09:40:17 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to use new blk_ordered
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051123072332.GA6653@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <20051117153509.061D8991@htj.dyndns.org>
	 <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com>
	 <437DEE35.9060901@gmail.com>
	 <58cb370e0511180759u4cb50535gfd7b96100a0bd70f@mail.gmail.com>
	 <20051122024401.GB10213@htj.dyndns.org>
	 <58cb370e0511220036r6e61b509i3bc1f7ce90178b1d@mail.gmail.com>
	 <20051123072332.GA6653@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Tejun Heo <htejun@gmail.com> wrote:
> On Tue, Nov 22, 2005 at 09:36:09AM +0100, Bartlomiej Zolnierkiewicz wrote:
> [--snip--]
> > >
> > > Ordered requests are processed in the following order.
> > >
> > > 1. barrier bio reaches blk queue
> > >
> > > 2. barrier req queued in order
> > >
> > > 3. when barrier req reaches the head of the request queue, it gets
> > >    interpreted into preflush-barrier-postflush requests sequence
> > >    and queued.  ->prepare_flush_fn is called in this step.
> > >
> > > 4. When all three requests complete, the ordered sequence ends.
> > >
> > > Adding !drive->wcache test to idedisk_prepare_flush, which in turn
> > > requires adding ->prepare_flush_fn error handling to blk ordered
> > > handling, prevents flushes for barrier requests between step#1 and
> >
> > Why for !drive->wcache flush can't be consider as successful
> > like it was before these changes...
> >
> > > step#3.  We can still have flush reqeuests between #3 and #4 after
> > > wcache is turned off.
> >
> > ditto
> >
>
> I think we have two alternatives here - both have some problems.
>
> 1. make ->prepare_flush_fn return some code to tell blk layer skip
>    the flush as the original code did.
>
> This is what you're proposing, I guess.  The reason why I'm reluctant
> to take this approach is that there still remains window of error
> between #3 and #4.  The flush requests could already be prepared and
> in the queue when ->wcache is turned off.  AFAICS, the original code
> had the same problem, although the window was narrower.
>
> 2. complete flush commands successfully in execute_drive_cmd() if wcache
>    is not enabled.
>
> This approach fixes all cases but the implementation would be a bit
> hackish.  execute_drive_cmd() will have to look at the command and
> ide_disk->wcache to determine if a special command should be completed
> successfully without actually executing it.  Maybe we can add a
> per-HL-driver callback for that.
>
> Bartlomiej, I'm not really sure about both of above approaches.  My
> humble opinion is that benefits brought by both of above aren't worth
> the added complexity.  The worst can happen is a few IDE command
> failures caused by executing flush command on a wcache disabled drive.
> And that would happen only when the user turns off wcache while
> barrier sequence is *in progress*.
>
> Hmmm... What do you think?  It's your call.  I'll do what you choose.

Hmm... both solutions sucks.  After second thought I agree with you
w.r.t to original changes (just remember to document them in the patch
description).

Bartlomiej
