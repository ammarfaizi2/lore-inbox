Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbSIZEbM>; Thu, 26 Sep 2002 00:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSIZEbM>; Thu, 26 Sep 2002 00:31:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44305 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262177AbSIZEbK>; Thu, 26 Sep 2002 00:31:10 -0400
Date: Wed, 25 Sep 2002 21:37:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/4] prepare_to_wait/finish_wait sleep/wakeup API
In-Reply-To: <20020925.212459.118951005.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209252133280.1451-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, David S. Miller wrote:
> 
> I don't want to say that your changes cannot be made to work,
> but it's been one of my understandings all these years that
> the fact that the task itself controls it's presence on the
> wait queue is what allows many races to be handled properly and
> cleanly.

No, the important part is that the process adds itself and marks itself as
sleeping _before_ doing the test. The "marks itself as sleeping" part is 
the really important one.

The "removes itself" was/is really just a matter of being able to handle 
loops more efficiently (which is probably a case of optimizing for the 
wrong thing, since the common case is to wait for just _one_ event, 
especially since we made the herd behaviour go away with the exclusive 
stuff).

The "removes itself" thing was also something I thought was cleaner (have 
the same entity do both add and remove), but I certainly buy into the CPU 
lock bouncing arguments against it, so..

> For example, the ordering of the test and add/remove from
> the wait queue is pretty important.

The test and add yes. Remove no, since remove is always done after we know 
we're waking up.

		Linus

