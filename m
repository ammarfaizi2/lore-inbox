Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264135AbUKZUeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264135AbUKZUeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUKZUc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:32:26 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43431 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264113AbUKZUZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:25:14 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041125192016.GA1302@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101422088.27250.93.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 09:34:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 06:20, Pavel Machek wrote:
> Hi!
> 
> > > Your way of merging looks rather wrong.  Please submit changes against the
> > > current swsusp code that introduce one feature after another to bring it
> > > at the level you want.  You'll surely have to rewrok it a lot until all
> > > reviewers are happy.
> > 
> > I realise that it needs further cleanup; that's why I'm submitting it
> > now for comment and not asking 'please apply'. As to patching against
> > swsusp, I'm purposely not doing that. The reason is that suspend2 isn't
> > a bunch of incremental changes to swsusp. It has been redesigned from
> > the ground up and I'd have to pull swsusp to pieces and put it back
> > together to do the same things.
> >
> > I'm thus seeking to simply merge the existing code, let Pavel and others
> > get to the point where they're ready to say "Okay, we're satisfied that
> > suspend2 does everything swsusp does and more and better." Then we can
> > remove swsusp. This is the plan that was discussed with Pavel and Andrew
> > ages ago. I've just been slow to get there because I'm doing this
> > part-time voluntary.
> 
> hugang seems to show that it indeed is possible to incrementally turn
> swsusp into suspend2. I do not think Andrew really wanted it that way,
> and I thought of that as of neccessary evil.

With some changes, yes. But when you come to using extents or
abstracting the method of storage and implementing plugins, it will be
ground-up redesign. Of course you might not want to go that far.

> [Okay, at this point I'll understand when you'll put my picture as a
> texture to some doom3 monster and shoot me thousand times... Lot of
> work went into suspend2, but in the meantime lot of work went into
> swsusp1, too...]

Not at all. Perhaps I'm overstating the case or not spending enough time
looking at your code, but I don't actually think swsusp has changed a
lot in the two years since I started working on this. (Want my picture
now? :>)

> > > And most importantly for each patch explain exactly what feature it
> > > implements and why, etc..  "swsusp2" tells exactly nothing about the
> > > changed you do.
> > 
> > Okay. The changes include:
> > 
> > - Almost no BUG() statements. Wherever possible, if something goes
> > wrong, we back out and give the user a perfectly usable system back
> 
> Patrick did a lot of work in this area, and there are 10 BUGs() in
> swsusp just now. [And I do not think "no BUGs()" is a feature -- look
> at my comments, at one point you just ignored "can not happen
> condition". That's bad, it can hide real bugs.] I have no reports of
> swsusp1 going BUG() for users, and that's what counts.

Not sure what you're talking about with the 'can not happen condition'.
Regarding real reports, I agree.

> > - Speed: All I/O is asynchronous where possible and readahead used where
> > not. Routines everywhere optimised to get things done as fast as poss.
> > (Think low battery).
> 
> I fixed O(n^2) behaviour in swsusp1 (not yet in). I do not think that
> asynchronous I/O is does that much difference.

Oh, it makes a huge difference once you're not eating all the memory you
can. If I submit I/O one at a time, I do 1 or 2 MB/s. With asynchrounous
I/O, I can write 70MB/s and read 110MB/s with compression, 58|58 without
compression (that's the maximum throughput of the drive I'm using at the
moment). If I can streamline things a further, I should be able to lift
that write rate further, too.

> > - Reliability. I haven't run the tests for a while, but Michael Frank
> > produced a suite that was used to stress test the software (under 2.4)
> > while running 100s (1000s at least once) of cycles. There have been some
> > significant changes since then, but the software is essentially the
> > same.
> 
> Well, swsusp1 is getting a lot of testing too. Is the test-suite
> somewhere easily available?

I believe Michael is preparing a new version. I assume he'll put it on
https://developer.berlios.de/projects/lstress/ when he's done.

> > - Test bed: Around 10,000 downloads of the 1.0 patch, 2730 to date of
> > the 2.1.5 version I released 2 weeks ago.
> 
> Hmm, look at number of downloads of 2.6.9 kernel, I think I win here
> ;-)))). SuSE9.2 is actually shipping swsusp1 and advertising it as a
> feature. And it seems to work for people...

:> But not everyone who uses 2.6.9 uses swsusp. :>

> > - Swap file support
> > - Support for LVM/dm-crypt and siblings
> > - Support for having device drivers as modules (resume from an
> > initrd/initramfs)
> 
> Okay, you win these.

I don't want to have a competition, really. I just want to convince you
that I've done some worthwhile work :>

> > - Almost all memory allocations are order 0, making suspend more
> > reliable under load.
> 
> I'll have to fix this. Fortunately hugang already has a patch.
> 
> > - Designed to save as much of memory as possible rather than as little
> > (making the system more responsive post-resume).
> 
> hugang already has a patch, but I'm not 100% sure if I want it
> in. Yes, people seem to like this feature, but it complicates
> *design*, quite a lot.

It does. But if there were fundamental flaws in the approach, we would
have found them by now. Since you're using bio calls and not swap's own
read/write functions, you shouldn't have any problems.

> > - Support for SMP
> > - Support for preempt
> > - Support for 4GB highmem (hope to do 64GB soonish)
> 
> This works in swsusp1, too. Parts of SMP support need to be rewritten
> to assembly, but same is probably true for suspend2.

See separate comments - I think it can all stay as C.

> I'm not sure if there are still problems with swsusp1 refrigerator, if
> so add
> 
> - Suspend2 actually works under load
> 

Hopefully, we'll merge the refrigerator changes soon; then you can say
that for swsusp1 too.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

