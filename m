Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbUKZVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUKZVlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbUKZVjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:39:48 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:47538 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263960AbUKZVha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:37:30 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041125232200.GG2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101426416.27250.147.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 10:46:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 10:22, Pavel Machek wrote:
> I'd prefer not to get plugins and abstract storage. I'm not sure about
> extents, but as soon as I can get rid of order-8 allocations, things
> should be ok.

Don't you need more than that? Unless things have changed, you still
spend most of your time eating memory so that you only have a few megs
(well, maybe a little more) to write to disk. If you do reduce the
amount of memory you eat, then you need to work to make the I/O faster.

> > > [Okay, at this point I'll understand when you'll put my picture as a
> > > texture to some doom3 monster and shoot me thousand times... Lot of
> > > work went into suspend2, but in the meantime lot of work went into
> > > swsusp1, too...]
> > 
> > Not at all. Perhaps I'm overstating the case or not spending enough time
> > looking at your code, but I don't actually think swsusp has changed a
> > lot in the two years since I started working on this. (Want my picture
> > now? :>)
> 
> Well, it was rewriten by Patrick so it actually looks okay, and it
> started to work for users...

:> Okay.

> > > > - Speed: All I/O is asynchronous where possible and readahead used where
> > > > not. Routines everywhere optimised to get things done as fast as poss.
> > > > (Think low battery).
> > > 
> > > I fixed O(n^2) behaviour in swsusp1 (not yet in). I do not think that
> > > asynchronous I/O is does that much difference.
> > 
> > Oh, it makes a huge difference once you're not eating all the memory you
> > can. If I submit I/O one at a time, I do 1 or 2 MB/s. With asynchrounous
> > I/O, I can write 70MB/s and read 110MB/s with compression, 58|58 without
> > compression (that's the maximum throughput of the drive I'm using at the
> > moment). If I can streamline things a further, I should be able to lift
> > that write rate further, too.
> 
> Okay, 58MB/sec is better than 1MB/sec. I do not think I want the
> complexity neccessary to get me 70MB/sec.

Fair enough for you, but not everyone can say that. At the end of the
day, I'm not writing this code just for me to use, though. Many of the
features I've added have been added for the benefit of other people; I
assume you'd do the same. Most laptops can't do 58MB/s, so the
difference is much bigger. (My original laptop hard drive did 17/s; with
compression I think it achieved something close to double that,
depending on the data being compressed, of course).

> In some ways, suspend2 is two years ahead of rest of kernel:
> * you have interactive debugging
> * file compression
> * nice splash screen
> * plugin interface for transparent network support
> 
> Unfortunately, we do not want compression done like that. It would
> make sense to do compressed-LVM or something like that (that way
> everyone would get the benefit), but it does not make sense to have it
> just for suspend2. And we do not want the rest of features, too,
> unless they work for the rest of kernel.

The cryptoapi provides support for both compression and encryption. I'd
happily make use of that, but we still need a way for the user to choose
what compression/encryption they want and configure it. I'm not at all
adverse to the idea of shifting the lzf compression support into being a
cryptoapi plugin. That shouldn't be hard to do precisely because I have
the plugin system :>.

> > > > - Test bed: Around 10,000 downloads of the 1.0 patch, 2730 to date of
> > > > the 2.1.5 version I released 2 weeks ago.
> > > 
> > > Hmm, look at number of downloads of 2.6.9 kernel, I think I win here
> > > ;-)))). SuSE9.2 is actually shipping swsusp1 and advertising it as a
> > > feature. And it seems to work for people...
> > 
> > :> But not everyone who uses 2.6.9 uses swsusp. :>
> 
> But they should ;-).

I'll beg to differ there :>

> > > > - Swap file support
> > > > - Support for LVM/dm-crypt and siblings
> > > > - Support for having device drivers as modules (resume from an
> > > > initrd/initramfs)
> > > 
> > > Okay, you win these.
> > 
> > I don't want to have a competition, really. I just want to convince you
> > that I've done some worthwhile work :>
> 
> You did wonderfull work -- you shown what is possible with
> suspend2. Now we just need to scale it back to what is practical. It
> needs not only to work, it also needs to be nice, simple, and easy to
> maintain.

I think it is practical. Apart from the bootsplash support, I don't
think I have added any feature because I thought "Hey, this looks like a
fun thing to try.". Every feature has been added because it makes
suspend faster, more reliable, more user friendly, more versatile or the
like. If we want Linux to get adopted by desktop users, it needs to have
these features. Making it harder to use by forcing people to reboot to
change a parameter or forcing them to do an ls in /dev with obscure
parameters (to get the major and minor numbers) when they already know
they want /dev/sda1 isn't user friendly. Obviously user friendliness is 
more important to me than to you. That's fine, but let's agree to differ
and let the software be more helpful rather than less.

> > > > - Designed to save as much of memory as possible rather than as little
> > > > (making the system more responsive post-resume).
> > > 
> > > hugang already has a patch, but I'm not 100% sure if I want it
> > > in. Yes, people seem to like this feature, but it complicates
> > > *design*, quite a lot.
> > 
> > It does. But if there were fundamental flaws in the approach, we would
> > have found them by now. Since you're using bio calls and not swap's own
> > read/write functions, you shouldn't have any problems.
> 
> I believe it has at least one pretty bad flaw: it has hooks all over
> the place and will be nightmare to maintain. Puting suspend hooks into
> memory allocation is not nice.

That's a big statement.

"Hooks all over the place" was a phrase first used to refer to the
attempts at making freezing more reliable. That's irrelevant now with
the simplified three stages to freezing. The hooks are the same as for
swsusp1 there.

The hooks you've seen in the rest of the kernel are generally only
further supplements to the freezing, so that swsusp should probably have
them too.

The hooks in the memory management are minimal and wrapped in
unlikely(), so they shouldn't really be a problem in the normal flow of
things. While suspend is running, they serve a good and necessary
purpose. Using high level routines, we can't guarantee that new slab
pages, for example, aren't allocated while we're writing the LRU pages.
If you can't be sure of that and don't want to satisfy allocations from
a memory pool, you'll need to recheck that your saving all the pages
after writing LRU. And if you do that, you might need to allocate more
memory for the metadata, which might mean freeing an LRU page or two,
which will make your image inconsistent. A memory pool is a simple and
effective solution to that issue: we know exactly what pages may be
allocated when we do our atomic copy, and we copy them without having to
figure out which ones were actually used.

> swsusp1 is pretty self-contained. As long as drivers stop the DMA and
> NMI does nothing wrong, atomic snapshot will indeed be atomic.
> 
> Can you list conditions neccessary for suspend2 to work? 

Not really sure what you mean. At the moment, the main hinderance to it
working properly is driver model support (USB, DRI, as said previously).
That forces us to have a userspace script to compile as modules and
stop/unload support around kernel call. Given that these things are
done, and that suspend is able to get enough memory to do it's work
(almost never a problem), suspend should always work.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

