Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263666AbUKZV4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUKZV4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUKZTwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:52:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36803 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262388AbUKZT34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:56 -0500
Date: Fri, 26 Nov 2004 13:38:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041126123847.GD1028@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams> <20041126003944.GR2711@elf.ucw.cz> <1101455756.4343.106.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101455756.4343.106.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Don't you need more than that? Unless things have changed, you still
> > > spend most of your time eating memory so that you only have a few megs
> > > (well, maybe a little more) to write to disk. If you do reduce the
> > > amount of memory you eat, then you need to work to make the I/O
> > > faster.
> > 
> > I'm not *that* concerned about speed. Getting rid of order-8 is
> > for preventing "sorry, not enough RAM to suspend to disk".
> 
> Priority wise, I agree. But given that the order 8 issue is dealt with,
> speed is important. Particularly when your power just went out and your
> UPS battery is running down.

....

> Again, when you're running on limited time, twice as fast is still twice
> as fast.

My machine suspends in 7 seconds, and that's swsusp1. According to
your numbers, suspend2 should suspend it in 1 second and LZE
compressed should be .5 second.

I'd say "who cares". 7 seconds seems like fast enough for me. And I'm
*not* going to add 2000 lines of code for 500msec speedup during
suspend.

> > Actually I'd like to see lzf done at LVM level; that way it is usefull
> > for people not doing suspend, too, and we should not need plugin
> > infrastructure in suspend2 (LVM provides us with that service).
> 
> That ignores that the vast majority of people don't use LVM at the
> moment. Perhaps you could argue that they should. The other thing is,
> I'm trying not to make assumptions about how we're writing the image,
> either. If you want to pipe your image over a network to some server,
> you should be able to, and not have to implement compression again in
> the writer for that.

Suspend-over-network is obscure-enough
feature. Compressed-suspend-over-network is even worse.

BTW my feeling is that if you want to do suspend-over-network, you
should just modify nbd to work with suspend2 and stop adding
special-purpose code to suspend.

> > I believe you need to say "no" way more often. One user is not enough
> > to justify feature in mainline kernel, and any number of users should
> > not be enough to make GZIP compression supported by suspend2.
> 
> Okay. Let's say I drop GZIP. I've just asked on the suspend list for
> good reasons not to do it. I'll be surprised if I get any :> (And I'll
> ask for proof that they get a higher throughput with GZIP then with
> LZF!).
> 
> I still think the plugin system is useful. It made adding LZF
> compression and DM support really easy, and also means work can be done
> on a generic file writer without needing to pull out all of the
> swapwriter code. It also made making suspend modular far easier, which
> in turn means you don't have to have the memory in use all the time,
> when you only really want it the functionality ready to go when you want
> to power down.


> > Yes, they are unlikely(); but still they are hooks into memory
> > managment. They are at least ugly as hell. And no swsusp1 does not
> > this particular set of hooks, and does not need to patch sysrq-S.
> 
> How is ugly defined here? Can you give me an example that does the same
> thing, but which you consider less ugly?
> 
>         if (unlikely(test_suspend_state(SUSPEND_USE_MEMORY_POOL))) {
>                 suspend2_free_pool_pages(page, order);
>                 return;
>         }
> 
> I nearly launched into a flame war, but I'll try to be more gracious
> than that.

Memory managment should have no knowledge of suspend2... Imagine every
subsystem sprinkling hooks such as this one...

We'd have 

	if (unlikely(scsi_is_recovering_from_problem()))
		scsi_free_pool_pages();
	else if (usb_is_unhealthy())
		usb_recover()
	else if (unlikely(test_suspend_state(SUSPEND_USE_MEMORY_POOL))) {
                suspend2_free_pool_pages(page, order);
                return;
        }

and every one hacking memory managment would know about scsi, usb, and
suspend2. That's not reasonable way to go.

> > > things. While suspend is running, they serve a good and necessary
> > > purpose. Using high level routines, we can't guarantee that new slab
> > 
> > They are neccessary because of two-stages LRU saving... I'm trying to
> > argue "two-stages LRU saving is wrong"...
> 
> I know you are. What I'm not sure about is whether you believe that the
> user should never have the option of saving a full image of their
> memory, or whether you think there's a better way to do it.

If LRU saving can be done in 300 lines of code with no impact on
generic code... that's okay. In the current form it is way too complex
to merge.

> > For swsusp2, you need drivers to stop the DMA, NMI not interfering,
> > sync may not happen after you have saved LRU, memory may not be
> > alocated from slab after you have saved LRU. (something else? This
> > needs to be written down somewhere, and all kernel hackers will need
> > to be carefull not to break these rules. Do you see why it wories me?)
> > 
> > swsusp1 is more self-contained. As long as drivers stop the DMA and
> > NMI does nothing wrong, atomic snapshot will indeed be atomic.
> 
> Syncing may not happen after we've done the atomic copy, but since it is
> already done when freezing processes, there shouldn't be any dirty data
> to sync anyway... except for the syslog data from our printks.

??? syslogd is stopped, it can't write anything.

> The LRU pages can't change, but this shouldn't be a problem because all
> userspace threads and most of kernel space, including kswapd, kjournald
> and so on is stopped. The only guys who need to worry about this are the
> MM guys, and so long as the scanning continues to run via a process, the
> buddy allocator or a timer (interrupts aren't an option, are they?),
> that activity will be paused during suspend without them having to add a
> single line of code.

Actually swsusp1 does not need to stop timers, so you have few lines
of code added.

> If bio page I/O was changed to interact with the LRU, we might be in
> trouble.
> 
> Slab _can_ be allocated while we're saving the LRU, but the allocations
> need to come from pages that we know will be included in the atomic
> copy. This happens transparently (page allocator), so other kernel
> hackers don't need to worry about any of these issues. If we use the
> memory pool idea, everything else that needs to run can run just like
> normal, without any suspend specific changes. (You might be being

Why do you need to allocate from special pool? After LRU is saved, you
should write all used kernel pages. Slab are kernel pages, so I do not
see why you need to modify it.

> In short, there are no rules that "all kernel hackers" will need to be
> careful not to break. The main thing constraint added is that we need to
> be able to stop all changes to the LRU.

Ok, so the "all kernel hackers" rule is "do not change LRU while
suspend2 is going on".
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
