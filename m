Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbUKZXx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUKZXx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUKZTlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:41:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262458AbUKZT2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:12 -0500
Date: Fri, 26 Nov 2004 00:22:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041125232200.GG2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101422088.27250.93.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm thus seeking to simply merge the existing code, let Pavel and others
> > > get to the point where they're ready to say "Okay, we're satisfied that
> > > suspend2 does everything swsusp does and more and better." Then we can
> > > remove swsusp. This is the plan that was discussed with Pavel and Andrew
> > > ages ago. I've just been slow to get there because I'm doing this
> > > part-time voluntary.
> > 
> > hugang seems to show that it indeed is possible to incrementally turn
> > swsusp into suspend2. I do not think Andrew really wanted it that way,
> > and I thought of that as of neccessary evil.
> 
> With some changes, yes. But when you come to using extents or
> abstracting the method of storage and implementing plugins, it will be
> ground-up redesign. Of course you might not want to go that far.

I'd prefer not to get plugins and abstract storage. I'm not sure about
extents, but as soon as I can get rid of order-8 allocations, things
should be ok.

> > [Okay, at this point I'll understand when you'll put my picture as a
> > texture to some doom3 monster and shoot me thousand times... Lot of
> > work went into suspend2, but in the meantime lot of work went into
> > swsusp1, too...]
> 
> Not at all. Perhaps I'm overstating the case or not spending enough time
> looking at your code, but I don't actually think swsusp has changed a
> lot in the two years since I started working on this. (Want my picture
> now? :>)

Well, it was rewriten by Patrick so it actually looks okay, and it
started to work for users...

> > > - Speed: All I/O is asynchronous where possible and readahead used where
> > > not. Routines everywhere optimised to get things done as fast as poss.
> > > (Think low battery).
> > 
> > I fixed O(n^2) behaviour in swsusp1 (not yet in). I do not think that
> > asynchronous I/O is does that much difference.
> 
> Oh, it makes a huge difference once you're not eating all the memory you
> can. If I submit I/O one at a time, I do 1 or 2 MB/s. With asynchrounous
> I/O, I can write 70MB/s and read 110MB/s with compression, 58|58 without
> compression (that's the maximum throughput of the drive I'm using at the
> moment). If I can streamline things a further, I should be able to lift
> that write rate further, too.

Okay, 58MB/sec is better than 1MB/sec. I do not think I want the
complexity neccessary to get me 70MB/sec.

In some ways, suspend2 is two years ahead of rest of kernel:
* you have interactive debugging
* file compression
* nice splash screen
* plugin interface for transparent network support

Unfortunately, we do not want compression done like that. It would
make sense to do compressed-LVM or something like that (that way
everyone would get the benefit), but it does not make sense to have it
just for suspend2. And we do not want the rest of features, too,
unless they work for the rest of kernel.

> > > - Test bed: Around 10,000 downloads of the 1.0 patch, 2730 to date of
> > > the 2.1.5 version I released 2 weeks ago.
> > 
> > Hmm, look at number of downloads of 2.6.9 kernel, I think I win here
> > ;-)))). SuSE9.2 is actually shipping swsusp1 and advertising it as a
> > feature. And it seems to work for people...
> 
> :> But not everyone who uses 2.6.9 uses swsusp. :>

But they should ;-).

> > > - Swap file support
> > > - Support for LVM/dm-crypt and siblings
> > > - Support for having device drivers as modules (resume from an
> > > initrd/initramfs)
> > 
> > Okay, you win these.
> 
> I don't want to have a competition, really. I just want to convince you
> that I've done some worthwhile work :>

You did wonderfull work -- you shown what is possible with
suspend2. Now we just need to scale it back to what is practical. It
needs not only to work, it also needs to be nice, simple, and easy to
maintain.

> > > - Designed to save as much of memory as possible rather than as little
> > > (making the system more responsive post-resume).
> > 
> > hugang already has a patch, but I'm not 100% sure if I want it
> > in. Yes, people seem to like this feature, but it complicates
> > *design*, quite a lot.
> 
> It does. But if there were fundamental flaws in the approach, we would
> have found them by now. Since you're using bio calls and not swap's own
> read/write functions, you shouldn't have any problems.

I believe it has at least one pretty bad flaw: it has hooks all over
the place and will be nightmare to maintain. Puting suspend hooks into
memory allocation is not nice.

swsusp1 is pretty self-contained. As long as drivers stop the DMA and
NMI does nothing wrong, atomic snapshot will indeed be atomic.

Can you list conditions neccessary for suspend2 to work? 

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
