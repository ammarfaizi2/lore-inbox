Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272191AbRIQPxW>; Mon, 17 Sep 2001 11:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273659AbRIQPxD>; Mon, 17 Sep 2001 11:53:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42507 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273658AbRIQPwz>; Mon, 17 Sep 2001 11:52:55 -0400
Date: Mon, 17 Sep 2001 08:51:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: <ast@domdv.de>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010917173555.460c8ea3.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0109170846050.8847-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Stephan von Krawczynski wrote:
>
> - cpu load goes pretty high (11-12 according to xosview)during several
> occasions, upto the point where you cannot even move the mouse. Compared to an
> once tested ac-version it is not _that_ nice. I have some problems cat'ing
> /proc/meminfo, too. I takes sometimes pretty long (minutes).

It's not really CPU load - the loadaverage in Linux (and some other UNIXes
too) also accounts for disk wait.

> - the meminfo shows me great difference to former versions in the balancing of
> inact_dirty and active. This pre10 tends to have a _lot_ more inact_dirty pages
> than active (compared to pre9 and before) in my test. I guess this is intended
> by this (used-once) patch. So take this as a hint, that your work performs as
> expected.

No, I think they are related, and bad. I suspect it just means that pages
really do not get elevated to the active list, and it's probably _too_
unwilling to activate pages. That's bad too - it means that the inactive
list is the one solely responsible for working set changes, and the VM
won't bother with any other pages. Which also leads to bad results..

That's always the downside with having multiple lists of any kind - if the
balance between the lists is bad, performance will be bad. Historically,
the active list was the big one, and the other ones mostly didn't matter,
which makes the balancing issue much less noticeable.

[ This is also the very same problem we used to have with buffer cache
  pages vs mapped pages vs other caches ]

The fix may be to just make the inactive lists not do aging at all.

		Linus

