Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJJFrS>; Wed, 10 Oct 2001 01:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274851AbRJJFrH>; Wed, 10 Oct 2001 01:47:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7186 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273255AbRJJFq6>; Wed, 10 Oct 2001 01:46:58 -0400
Date: Tue, 9 Oct 2001 22:46:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <3BC3D9ED.6050901@wipro.com>
Message-ID: <Pine.LNX.4.33.0110092236210.1305-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Oct 2001, BALBIR SINGH wrote:
> >
> >And THAT is the hard part. Doing lookup without locks ends up being
> >pretty much worthless, because you need the locks for the removal
> >anyway, at which point the whole thing looks pretty moot.
>
> What about cases like the pci device list or any other such list. Sometimes
> you do not care if somebody added something, while you were looking through
> the list as long as you do not get illegal addresses or data.
> Wouldn't this be very useful there? Most of these lists come up
> at system startup and change rearly, but we look through them often.

It's not about "change rarely". You cannot use a non-locking lookup if
they _ever_ remove anything.

I can't think of many lists like that. The PCI lists certainly are both
add/remove: cardbus bridges and hotplug-PCI means that they are not just
purely "enumerate at bootup".

Sure, maybe there are _some_ things that don't need to ever be removed,
but I can't think of any interesting data structure off-hand. Truly static
stuff tends to be allocated in an array that is sized once - array lookups
are much faster than traversing a linked list anyway.

So the linked list approach tends to make sense for things that _aren't_
just static, but I don't know of anything that only grows and grows. In
fact, that would sound like a horrible memory leak to me if we had
something like that. Even slow growth is bad if you want up-times measured
in years.

Now, in all fairness I can imagine hacky lock-less removals too. To get
them to work, you have to (a) change the "next" pointer to point to the
next->next (and have some serialization between removals, but removals
only, to make sure you don't have next->next also going away from you) and
(b) leave the old "next" pointer (and thus the data structure) around
until you can _prove_ that nobody is looking anything up any more, and
that the now-defunct data structure can truly be removed.

However, apart from locking, there aren't all that many ways to "prove"
that non-use. You could probably do it with interesting atomic sequence
numbers etc, although by the time you generate atomic sequence numbers
your lookup is already getting heavier - to the point where locking
probably isn't so bad an idea any more.

		Linus

