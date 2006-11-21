Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934213AbWKUHyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934213AbWKUHyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934281AbWKUHyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:54:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:26544 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S934213AbWKUHyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:54:51 -0500
Date: Mon, 20 Nov 2006 23:54:31 -0800
From: Greg KH <gregkh@suse.de>
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       kernel-discuss@handhelds.org
Subject: Re: Where did find_bus() go in 2.6.18?
Message-ID: <20061121075431.GA30604@suse.de>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <20061120001212.GA28427@suse.de> <1148526308.20061120161322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148526308.20061120161322@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 04:13:22PM +0200, Paul Sokolovsky wrote:
> Hello Greg,
> 
> Monday, November 20, 2006, 2:12:12 AM, you wrote:
> 
> > On Mon, Nov 20, 2006 at 12:45:51AM +0100, Jiri Slaby wrote:
> >> Paul Sokolovsky wrote:
> >> >   But alas, the commit message is not as good as some others are, and
> >> > doesn't mention what should be used instead. So, if find_bus() is
> >> > "unused", what should be used instead?
> >> 
> >> You should probably mention what for?
> 
> > Exactly.  It was removed because no one was using it, and I couldn't
> > think of a reason why it would be needed.
> 
>   So, I assume the answer to my question is "No replacement. Ability
> to query bus set in the kernel was just removed, period." That's to
> which conclusion I came myself after studying 2.6.18 source and patch
> from 2.6.17.

Yes, it was removed because no one was using it, and no one could think
of any reason why it would be needed at the time.

> [Uninteresting specific case]
> 
>   Ok, so the situation is following: we have a kind of multi-layered
> driver here. Lowest level is a w1_slave bus driver, talking to a
> specific chip and providing low-level API for accessing data in terms
> of this chip (or chip class) notions. Above it, we have higher-level
> driver which interprets data from the low-level one, converting it to
> a standard device-independent form, plus possibly does some other
> minor things, like providing feedback indication on these data.
> (Forgot to say that this is battery driver.)
> 
>   So, just in case if some reader of this has quick suggestion of
> merging these drivers into one, thanks, but they do different things,
> and we want to keep them nicely decoupled. But now issue of how these
> drivers talk between themselves raises, and that's exactly the grief
> point.
> 
>   High-level driver used to find w1 bus by name, then enumerate
> devices on the bus, to find compatible device on it, then hooks into
> that device and its driver.

Ick, why not just export the pointer to the devices?

>   So, you see the issue: we cannot enumerate devices on w1 bus. (And
> yes, w1_bus_type is not exported).
> 
>   Sure, the source is up:
> http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/drivers/misc/h2200_battery.c?rev=1.20&content-type=text/x-cvsweb-markup
> 
> 
> [Trends thoughts]
> 
>   But note that I don't really ask mainline kernel developers how to
> fix this driver - I would actually be ashamed to do so, as I myself a
> (newbie) kernel hacker. So, the question stays the same, though I
> probably reformulate it a bit stronger now: how it came that ability
> to query buses (at all) was removed from 2.6.18?

See above.

>   As it was before, it was clear that LDM consists of multiple layers,
> and each layer offers consistent and complete set of operations on it,
> like adding new object on this layer, removing, adding child, removing
> child, *and* query objects on this level or among childs. I may miss
> some accidental gaps in that picture of course, but it still was an
> integral, complete design paradigm offering full dynamicity and
> introspection.

Hm, I've never heard the driver model be called a "complete design
paradigm" in the past.  I've heard it called a lot of real nasty things
though :)

>   And suddenly - oops, in 2.6.18 we lose ability to query the highest
> level of hierarchy, namely bus set. And on what criterion? "unused".

<snip>

Please go read Documenation/stable_api_nonsense.txt for why the
in-kernel apis always change.  It's how Linux works.

>   Suddenly, concrete building of LDM appears to be shaking. And reasonable
> question here is: is this a trend? What we will lose next - ability to
> query/enumerate devices on bus? How much time it will take until
> someone submit patch like "You know, I had a look at this
> device vs drivers matching in LDM. You know, I found that in 90% it's
> one-to-one mapping. You know, I think that rest 10% are just doing
> something wrong. You know, let's don't care about them. Here's a
> patch to match compile-time by C symbols. Oh no, wait, I have a patch
> in preparation which kills device vs drivers distinction at all,
> leading us to ol' good dirty monolithic 'drivers'." And it may be the
> case that even designers of LDM will look at the code after all
> those previous "cleanups" applied, and would agree that such patch
> comes as pretty natural succession.

It might just come to that if things evolve that way, who really knows.

>   Thanks for following my mental movie ;-). It's not a pure rhetoric
> though, I indeed would like to know the answer - are all those
> structures in LDM are big guys' games only? And would it better for small
> guys to be as KISS as stupid, err..., possible? ;-)

Please, get your code into the main kernel tree so that we can see it
and know how the driver core is being used.

> > Also, any reason why your drivers aren't in the mainline kernel yet?  It
> > would have kept something like this from happening a while ago.  And, it
> > will also help out with the recent driver core changes that are being
> > planned and are starting to show up in the -mm tree.  If your stuff is
> > in the kernel, then I'll do the work for you, otherwise, you all are on
> > your own :(
> 
>   One reason is of course because it's not that easy to get something
> into mainline. ;-)

Why do you feel this way?  Is it a proceedural thing?  A technical
thing?  A time thing?

We want to make it as easy as possible to get code into the tree, please
submit it and be persistant to get it there.

> Another one is that we have great deal of code made by
> different people over different periods of time, and we need to do
> internal cleanup first.

That's the way the kernel works, nothing new here.

> And for example, as new people do it, and
> learn the entire codebase, they find that some things are done,
> well, so to say, above the ground level. And they start to worry if
> that was right in the first place, and would it be now possible to get
> this somebody's code into mainline, or its better to keep doing
> homework and reapply the KISS paradigm. It is also a bit of ethical
> problem, as gentlemen who made such implementations, were apparently
> experienced developers to come up with such solutions, but no longer
> around/have resources to lobby for such code themselves, and newcomers
> would likely get only frustration from trying to do that, especially
> if they see there *is* at least an abstract possibility to do it in
> some other, more mundane way. And yet they can't readily do that local
> paradigm shift, as well, they don't have enough experience to undo
> what gurus did previously, plus the whole Linux-on-PDA community is
> too short on people to spend time flip-flopping each other's work.

Evolve things over time in the main tree, like the main tree works.
Again, this is nothing different from the rest of the kernel.

>   All above has little to do with mainline kernel, of course, and not
> its problem in any way. Just another entry into your sociological
> survey "Why people don't submit code upstream." ;-)

No, I really think you are somehow feeling that once the code is in
mainline it can't be ever changed.  That's just not true...

thanks,

greg k-h
