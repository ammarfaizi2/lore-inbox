Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280627AbRKSTLR>; Mon, 19 Nov 2001 14:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280628AbRKSTLK>; Mon, 19 Nov 2001 14:11:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10510 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280627AbRKSTKJ>; Mon, 19 Nov 2001 14:10:09 -0500
Date: Mon, 19 Nov 2001 11:04:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <m1wv0m7i53.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0111191057580.8281-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Nov 2001, Eric W. Biederman wrote:
>
> However this case seems to violate code clarity.  If you can have
> other users testing PG_locked it is non-intuitive that you can still
> normally assign to page->flags.

This is 100% true, and I actually want to fix it.

The ugliness is actually a historical remnant - we do it with a simple
store simply because at the time we add a page to the page cache, we
historically were the only users of that page. Nobody else could get
access to it, because it didn't exist on any lists.

These days, the LRU queue exists before the page is added to the swap
cache, which means that other people actually _can_ see the page, and the
historical "initialize page flags" is no longer touching a purely private
field.

> Would it make sense to add a set_bits macro that is a just an
> assignment except on extremely weird architectures or to work
> around compiler bugs?  I'm just thinking it would make sense
> to document that we depend on the compiler not writing some
> strange intermediate values into the variable.

The thing is, "__add_to_page_cache()" really shouldn't touch the page
flags AT ALL, not with a "set_bits()" macro, and not with anything else
either for that matter. It's actually clearing flags that have meaning,
and the callers these days have to undo some of the work that it does (ie
see how try_to_swap_out() ends up having to mark the page dirty again,
only because __add_to_page_cache() cleared the dirty bit that it shouldn't
know anything at all about).

So the real fix for this particular case is to move the bit
setting/clearing into those callers that actually _want_ to set the bits,
some of which actually do have exclusive access to the page.

That doesn't change the fact that other parts of the kernel still assume
that the setting of a pointer or status field is atomic, for example, and
then use the memory barrier macros to force memory ordering (both for gcc
and for the CPU at runtime).

			Linus

