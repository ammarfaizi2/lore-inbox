Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264007AbUKZUH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbUKZUH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUKZUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:05:59 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262597AbUKZTec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:34:32 -0500
Date: Thu, 25 Nov 2004 20:20:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041125192016.GA1302@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101329104.3425.40.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Your way of merging looks rather wrong.  Please submit changes against the
> > current swsusp code that introduce one feature after another to bring it
> > at the level you want.  You'll surely have to rewrok it a lot until all
> > reviewers are happy.
> 
> I realise that it needs further cleanup; that's why I'm submitting it
> now for comment and not asking 'please apply'. As to patching against
> swsusp, I'm purposely not doing that. The reason is that suspend2 isn't
> a bunch of incremental changes to swsusp. It has been redesigned from
> the ground up and I'd have to pull swsusp to pieces and put it back
> together to do the same things.
>
> I'm thus seeking to simply merge the existing code, let Pavel and others
> get to the point where they're ready to say "Okay, we're satisfied that
> suspend2 does everything swsusp does and more and better." Then we can
> remove swsusp. This is the plan that was discussed with Pavel and Andrew
> ages ago. I've just been slow to get there because I'm doing this
> part-time voluntary.

hugang seems to show that it indeed is possible to incrementally turn
swsusp into suspend2. I do not think Andrew really wanted it that way,
and I thought of that as of neccessary evil.

[Okay, at this point I'll understand when you'll put my picture as a
texture to some doom3 monster and shoot me thousand times... Lot of
work went into suspend2, but in the meantime lot of work went into
swsusp1, too...]

> > And most importantly for each patch explain exactly what feature it
> > implements and why, etc..  "swsusp2" tells exactly nothing about the
> > changed you do.
> 
> Okay. The changes include:
> 
> - Almost no BUG() statements. Wherever possible, if something goes
> wrong, we back out and give the user a perfectly usable system back

Patrick did a lot of work in this area, and there are 10 BUGs() in
swsusp just now. [And I do not think "no BUGs()" is a feature -- look
at my comments, at one point you just ignored "can not happen
condition". That's bad, it can hide real bugs.] I have no reports of
swsusp1 going BUG() for users, and that's what counts.

> - Speed: All I/O is asynchronous where possible and readahead used where
> not. Routines everywhere optimised to get things done as fast as poss.
> (Think low battery).

I fixed O(n^2) behaviour in swsusp1 (not yet in). I do not think that
asynchronous I/O is does that much difference.

> - Reliability. I haven't run the tests for a while, but Michael Frank
> produced a suite that was used to stress test the software (under 2.4)
> while running 100s (1000s at least once) of cycles. There have been some
> significant changes since then, but the software is essentially the
> same.

Well, swsusp1 is getting a lot of testing too. Is the test-suite
somewhere easily available?

> - Test bed: Around 10,000 downloads of the 1.0 patch, 2730 to date of
> the 2.1.5 version I released 2 weeks ago.

Hmm, look at number of downloads of 2.6.9 kernel, I think I win here
;-)))). SuSE9.2 is actually shipping swsusp1 and advertising it as a
feature. And it seems to work for people...

> - Swap file support
> - Support for LVM/dm-crypt and siblings
> - Support for having device drivers as modules (resume from an
> initrd/initramfs)

Okay, you win these.

> - Almost all memory allocations are order 0, making suspend more
> reliable under load.

I'll have to fix this. Fortunately hugang already has a patch.

> - Designed to save as much of memory as possible rather than as little
> (making the system more responsive post-resume).

hugang already has a patch, but I'm not 100% sure if I want it
in. Yes, people seem to like this feature, but it complicates
*design*, quite a lot.

> - Support for SMP
> - Support for preempt
> - Support for 4GB highmem (hope to do 64GB soonish)

This works in swsusp1, too. Parts of SMP support need to be rewritten
to assembly, but same is probably true for suspend2.

I'm not sure if there are still problems with swsusp1 refrigerator, if
so add

- Suspend2 actually works under load

to the list.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
