Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbSA2WIN>; Tue, 29 Jan 2002 17:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283003AbSA2WID>; Tue, 29 Jan 2002 17:08:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50958 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282978AbSA2WHs>; Tue, 29 Jan 2002 17:07:48 -0500
Date: Tue, 29 Jan 2002 14:07:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020129.134015.116353125.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0201291402270.1533-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, David S. Miller wrote:
>
> I like the changes too, but I'd like to see some numbers
> as well.

Absolutely. Even something as simplistic as "lmbench file re-read" changed
by 0.1% or something. I definitely believe in the scalability part (as
long as the different processes don't all touch the same mapping all the
time), so I'm more interested in the "what is the impact of the hash chain
lookup/walk vs the radix tree walk" kinds of numbers.

> My only concern is that it doesn't handle one particular
> case better than the ugly per-hashchain lock version.  When we're
> running through a file and the task doing this changes cpus.
> In that case we'll get a lock collision and the per-hashchain lock
> changes would at least potentially avoid that.

Well, I would put it the other way around: the advantage of the
per-mapping lock (as opposed to the per-hashchain one) is that for common
access patterns where one process walks the whole file, we get added
locality from the per-mapping approach. While the per-hashchain one tends
to take a _lot_ of different locks (module bucket behaviour, of course).

And locality is good - especially as we try to make processes have CPU
affinity anyway. So I'd expect the per-mapping lock to generally show
_nicer_ cache behaviour.

		Linus

