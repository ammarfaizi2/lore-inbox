Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRKSSW4>; Mon, 19 Nov 2001 13:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRKSSWr>; Mon, 19 Nov 2001 13:22:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59494 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S275990AbRKSSWa>; Mon, 19 Nov 2001 13:22:30 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33.0111190833440.8103-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 11:03:20 -0700
In-Reply-To: <Pine.LNX.4.33.0111190833440.8103-100000@penguin.transmeta.com>
Message-ID: <m1wv0m7i53.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> That's fine - if you have two threads modifying the same variable at the
> same time, you need to lock it.
> 
> That's not the case under discussion.
> 
> The case under discussion is gcc writing back values to a variable that
> NEVER HAD ANY VALIDITY, even in the single-threaded case. And it _is_
> single-threaded at that point, you only have other users that test the
> value, not change it.
> 
> That's not an optimization, that's just plain broken. It breaks even
> user-level applications that use sigatomic_t.
> 
> And note how gcc doesn't actually do it. I'm not saying that gcc is broken
> - I' saying that gcc is NOT broken, and we depend on it being not broken.

Linus I agree that gcc works.  And even if page->flags is written
to, with two separate write operations page->flags & PG_locked should
still be true.

However this case seems to violate code clarity.  If you can have
other users testing PG_locked it is non-intuitive that you can still
normally assign to page->flags.

Would it make sense to add a set_bits macro that is a just an
assignment except on extremely weird architectures or to work
around compiler bugs?  I'm just thinking it would make sense
to document that we depend on the compiler not writing some
strange intermediate values into the variable.

I can't imagine why a compiler ever would but it is remotely possible
a compiler but generate an instruction sequence like:
xorl flags, $0xFFFFFFFF
xorl flags, $0xFFFFFFFe

To flip the low bit.  I would be terribly surprised, and it would
certainly break sigatomic_t if it was a plain typedef, but stranger
things have happened.

Eric

