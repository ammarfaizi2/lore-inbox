Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263955AbUKZV3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263955AbUKZV3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUKZVYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:24:31 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:50598 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264078AbUKZUSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:18:53 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041126003944.GR2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams>
	 <20041126003944.GR2711@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101455756.4343.106.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 20:08:31 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 11:39, Pavel Machek wrote:
> Hi!
> 
> > > I'd prefer not to get plugins and abstract storage. I'm not sure about
> > > extents, but as soon as I can get rid of order-8 allocations, things
> > > should be ok.
> > 
> > Don't you need more than that? Unless things have changed, you still
> > spend most of your time eating memory so that you only have a few megs
> > (well, maybe a little more) to write to disk. If you do reduce the
> > amount of memory you eat, then you need to work to make the I/O
> > faster.
> 
> I'm not *that* concerned about speed. Getting rid of order-8 is
> for preventing "sorry, not enough RAM to suspend to disk".

Priority wise, I agree. But given that the order 8 issue is dealt with,
speed is important. Particularly when your power just went out and your
UPS battery is running down.

> > > Okay, 58MB/sec is better than 1MB/sec. I do not think I want the
> > > complexity neccessary to get me 70MB/sec.
> > 
> > Fair enough for you, but not everyone can say that. At the end of the
> > day, I'm not writing this code just for me to use, though. Many of the
> > features I've added have been added for the benefit of other people; I
> > assume you'd do the same. Most laptops can't do 58MB/s, so the
> > difference is much bigger. (My original laptop hard drive did 17/s; with
> > compression I think it achieved something close to double that,
> > depending on the data being compressed, of course).
> 
> I do have too fast machines around me. But notice that compression
> only does factor-2 speedup. If we wanted to make whole kernel uglier,
> we could probably achieve factor-2 speedup for any benchmark... just
> it would be bad idea.

Again, when you're running on limited time, twice as fast is still twice
as fast.

> > > In some ways, suspend2 is two years ahead of rest of kernel:
> > > * you have interactive debugging
> > > * file compression
> > > * nice splash screen
> > > * plugin interface for transparent network support
> > > 
> > > Unfortunately, we do not want compression done like that. It would
> > > make sense to do compressed-LVM or something like that (that way
> > > everyone would get the benefit), but it does not make sense to have it
> > > just for suspend2. And we do not want the rest of features, too,
> > > unless they work for the rest of kernel.
> > 
> > The cryptoapi provides support for both compression and encryption. I'd
> > happily make use of that, but we still need a way for the user to choose
> > what compression/encryption they want and configure it. I'm not at all
> > adverse to the idea of shifting the lzf compression support into being a
> > cryptoapi plugin. That shouldn't be hard to do precisely because I have
> > the plugin system :>.
> 
> Actually I'd like to see lzf done at LVM level; that way it is usefull
> for people not doing suspend, too, and we should not need plugin
> infrastructure in suspend2 (LVM provides us with that service).

That ignores that the vast majority of people don't use LVM at the
moment. Perhaps you could argue that they should. The other thing is,
I'm trying not to make assumptions about how we're writing the image,
either. If you want to pipe your image over a network to some server,
you should be able to, and not have to implement compression again in
the writer for that.

> > > You did wonderfull work -- you shown what is possible with
> > > suspend2. Now we just need to scale it back to what is practical. It
> > > needs not only to work, it also needs to be nice, simple, and easy to
> > > maintain.
> > 
> > I think it is practical. Apart from the bootsplash support, I don't
> > think I have added any feature because I thought "Hey, this looks like a
> > fun thing to try.". Every feature has been added because it makes
> > suspend faster, more reliable, more user friendly, more versatile or the
> > like. If we want Linux to get adopted by desktop users, it needs to
> 
> I believe you need to say "no" way more often. One user is not enough
> to justify feature in mainline kernel, and any number of users should
> not be enough to make GZIP compression supported by suspend2.

Okay. Let's say I drop GZIP. I've just asked on the suspend list for
good reasons not to do it. I'll be surprised if I get any :> (And I'll
ask for proof that they get a higher throughput with GZIP then with
LZF!).

I still think the plugin system is useful. It made adding LZF
compression and DM support really easy, and also means work can be done
on a generic file writer without needing to pull out all of the
swapwriter code. It also made making suspend modular far easier, which
in turn means you don't have to have the memory in use all the time,
when you only really want it the functionality ready to go when you want
to power down.

> > > I believe it has at least one pretty bad flaw: it has hooks all over
> > > the place and will be nightmare to maintain. Puting suspend hooks into
> > > memory allocation is not nice.
> > 
> > That's a big statement.
> > 
> > "Hooks all over the place" was a phrase first used to refer to the
> > attempts at making freezing more reliable. That's irrelevant now with
> > the simplified three stages to freezing. The hooks are the same as for
> > swsusp1 there.
> > 
> > The hooks you've seen in the rest of the kernel are generally only
> > further supplements to the freezing, so that swsusp should probably have
> > them too.
> > 
> > The hooks in the memory management are minimal and wrapped in
> > unlikely(), so they shouldn't really be a problem in the normal flow
> > of
> 
> Yes, they are unlikely(); but still they are hooks into memory
> managment. They are at least ugly as hell. And no swsusp1 does not
> this particular set of hooks, and does not need to patch sysrq-S.

How is ugly defined here? Can you give me an example that does the same
thing, but which you consider less ugly?

        if (unlikely(test_suspend_state(SUSPEND_USE_MEMORY_POOL))) {
                suspend2_free_pool_pages(page, order);
                return;
        }

I nearly launched into a flame war, but I'll try to be more gracious
than that.

> > things. While suspend is running, they serve a good and necessary
> > purpose. Using high level routines, we can't guarantee that new slab
> 
> They are neccessary because of two-stages LRU saving... I'm trying to
> argue "two-stages LRU saving is wrong"...

I know you are. What I'm not sure about is whether you believe that the
user should never have the option of saving a full image of their
memory, or whether you think there's a better way to do it.

> > > swsusp1 is pretty self-contained. As long as drivers stop the DMA and
> > > NMI does nothing wrong, atomic snapshot will indeed be atomic.
> > > 
> > > Can you list conditions neccessary for suspend2 to work? 
> > 
> > Not really sure what you mean. At the moment, the main hinderance to it
> > working properly is driver model support (USB, DRI, as said previously).
> > That forces us to have a userspace script to compile as modules and
> > stop/unload support around kernel call. Given that these things are
> > done, and that suspend is able to get enough memory to do it's work
> > (almost never a problem), suspend should always work.
> 
> No, assume driver problems are solved.

Okay.

> For swsusp2, you need drivers to stop the DMA, NMI not interfering,
> sync may not happen after you have saved LRU, memory may not be
> alocated from slab after you have saved LRU. (something else? This
> needs to be written down somewhere, and all kernel hackers will need
> to be carefull not to break these rules. Do you see why it wories me?)
> 
> swsusp1 is more self-contained. As long as drivers stop the DMA and
> NMI does nothing wrong, atomic snapshot will indeed be atomic.

Syncing may not happen after we've done the atomic copy, but since it is
already done when freezing processes, there shouldn't be any dirty data
to sync anyway... except for the syslog data from our printks.

The LRU pages can't change, but this shouldn't be a problem because all
userspace threads and most of kernel space, including kswapd, kjournald
and so on is stopped. The only guys who need to worry about this are the
MM guys, and so long as the scanning continues to run via a process, the
buddy allocator or a timer (interrupts aren't an option, are they?),
that activity will be paused during suspend without them having to add a
single line of code.

If bio page I/O was changed to interact with the LRU, we might be in
trouble.

Slab _can_ be allocated while we're saving the LRU, but the allocations
need to come from pages that we know will be included in the atomic
copy. This happens transparently (page allocator), so other kernel
hackers don't need to worry about any of these issues. If we use the
memory pool idea, everything else that needs to run can run just like
normal, without any suspend specific changes. (You might be being
confused here by those printks in the slab get-a-new-page code; I guess
I forgot to write at the top of that patch that the printks are only
there while I'm seeking to determine whether suspend is the cause of
some occasional slab corruption I've been seeing. I'm trying to
determine whether the pages I see the oops at are ones allocated while
writing the image, or not. Unfortunately, it happens so infrequently
that I am taking a long time to see.

DMA only needs to be stopped when the drivers are quiesced, which is not
a suspend2 specific requirement.

The NMI watchdog turned out not to be a problem at all.

In short, there are no rules that "all kernel hackers" will need to be
careful not to break. The main thing constraint added is that we need to
be able to stop all changes to the LRU.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

