Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUKZV4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUKZV4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbUKZTws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:52:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36803 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262298AbUKZT3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:54 -0500
Date: Fri, 26 Nov 2004 01:39:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
Subject: Re: Suspend 2 merge
Message-ID: <20041126003944.GR2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <20041124132839.GA13145@infradead.org> <1101329104.3425.40.camel@desktop.cunninghams> <20041125192016.GA1302@elf.ucw.cz> <1101422088.27250.93.camel@desktop.cunninghams> <20041125232200.GG2711@elf.ucw.cz> <1101426416.27250.147.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101426416.27250.147.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd prefer not to get plugins and abstract storage. I'm not sure about
> > extents, but as soon as I can get rid of order-8 allocations, things
> > should be ok.
> 
> Don't you need more than that? Unless things have changed, you still
> spend most of your time eating memory so that you only have a few megs
> (well, maybe a little more) to write to disk. If you do reduce the
> amount of memory you eat, then you need to work to make the I/O
> faster.

I'm not *that* concerned about speed. Getting rid of order-8 is
for preventing "sorry, not enough RAM to suspend to disk".

> > Okay, 58MB/sec is better than 1MB/sec. I do not think I want the
> > complexity neccessary to get me 70MB/sec.
> 
> Fair enough for you, but not everyone can say that. At the end of the
> day, I'm not writing this code just for me to use, though. Many of the
> features I've added have been added for the benefit of other people; I
> assume you'd do the same. Most laptops can't do 58MB/s, so the
> difference is much bigger. (My original laptop hard drive did 17/s; with
> compression I think it achieved something close to double that,
> depending on the data being compressed, of course).

I do have too fast machines around me. But notice that compression
only does factor-2 speedup. If we wanted to make whole kernel uglier,
we could probably achieve factor-2 speedup for any benchmark... just
it would be bad idea.


> > In some ways, suspend2 is two years ahead of rest of kernel:
> > * you have interactive debugging
> > * file compression
> > * nice splash screen
> > * plugin interface for transparent network support
> > 
> > Unfortunately, we do not want compression done like that. It would
> > make sense to do compressed-LVM or something like that (that way
> > everyone would get the benefit), but it does not make sense to have it
> > just for suspend2. And we do not want the rest of features, too,
> > unless they work for the rest of kernel.
> 
> The cryptoapi provides support for both compression and encryption. I'd
> happily make use of that, but we still need a way for the user to choose
> what compression/encryption they want and configure it. I'm not at all
> adverse to the idea of shifting the lzf compression support into being a
> cryptoapi plugin. That shouldn't be hard to do precisely because I have
> the plugin system :>.

Actually I'd like to see lzf done at LVM level; that way it is usefull
for people not doing suspend, too, and we should not need plugin
infrastructure in suspend2 (LVM provides us with that service).

> > You did wonderfull work -- you shown what is possible with
> > suspend2. Now we just need to scale it back to what is practical. It
> > needs not only to work, it also needs to be nice, simple, and easy to
> > maintain.
> 
> I think it is practical. Apart from the bootsplash support, I don't
> think I have added any feature because I thought "Hey, this looks like a
> fun thing to try.". Every feature has been added because it makes
> suspend faster, more reliable, more user friendly, more versatile or the
> like. If we want Linux to get adopted by desktop users, it needs to

I believe you need to say "no" way more often. One user is not enough
to justify feature in mainline kernel, and any number of users should
not be enough to make GZIP compression supported by suspend2.

> have
> these features. Making it harder to use by forcing people to reboot to
> change a parameter or forcing them to do an ls in /dev with obscure
> parameters (to get the major and minor numbers) when they already know
> they want /dev/sda1 isn't user friendly. Obviously user friendliness is 
> more important to me than to you. That's fine, but let's agree to differ
> and let the software be more helpful rather than less.

Yes, I care about linux being developer-friendly. If it is not
user-friendly, distributions will solve it. If it is not
developer-friendly, it is dead.

> > > It does. But if there were fundamental flaws in the approach, we would
> > > have found them by now. Since you're using bio calls and not swap's own
> > > read/write functions, you shouldn't have any problems.
> > 
> > I believe it has at least one pretty bad flaw: it has hooks all over
> > the place and will be nightmare to maintain. Puting suspend hooks into
> > memory allocation is not nice.
> 
> That's a big statement.
> 
> "Hooks all over the place" was a phrase first used to refer to the
> attempts at making freezing more reliable. That's irrelevant now with
> the simplified three stages to freezing. The hooks are the same as for
> swsusp1 there.
> 
> The hooks you've seen in the rest of the kernel are generally only
> further supplements to the freezing, so that swsusp should probably have
> them too.
> 
> The hooks in the memory management are minimal and wrapped in
> unlikely(), so they shouldn't really be a problem in the normal flow
> of

Yes, they are unlikely(); but still they are hooks into memory
managment. They are at least ugly as hell. And no swsusp1 does not
this particular set of hooks, and does not need to patch sysrq-S.

> things. While suspend is running, they serve a good and necessary
> purpose. Using high level routines, we can't guarantee that new slab

They are neccessary because of two-stages LRU saving... I'm trying to
argue "two-stages LRU saving is wrong"...

> > swsusp1 is pretty self-contained. As long as drivers stop the DMA and
> > NMI does nothing wrong, atomic snapshot will indeed be atomic.
> > 
> > Can you list conditions neccessary for suspend2 to work? 
> 
> Not really sure what you mean. At the moment, the main hinderance to it
> working properly is driver model support (USB, DRI, as said previously).
> That forces us to have a userspace script to compile as modules and
> stop/unload support around kernel call. Given that these things are
> done, and that suspend is able to get enough memory to do it's work
> (almost never a problem), suspend should always work.

No, assume driver problems are solved.

For swsusp2, you need drivers to stop the DMA, NMI not interfering,
sync may not happen after you have saved LRU, memory may not be
alocated from slab after you have saved LRU. (something else? This
needs to be written down somewhere, and all kernel hackers will need
to be carefull not to break these rules. Do you see why it wories me?)

swsusp1 is more self-contained. As long as drivers stop the DMA and
NMI does nothing wrong, atomic snapshot will indeed be atomic.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
