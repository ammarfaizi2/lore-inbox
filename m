Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316426AbSEXOnW>; Fri, 24 May 2002 10:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSEXOnV>; Fri, 24 May 2002 10:43:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316426AbSEXOnV>; Fri, 24 May 2002 10:43:21 -0400
Date: Fri, 24 May 2002 07:43:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524071657.GI21164@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0205240737400.26171-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:
>
> Negative dentries should be only temporary entities, for example between
> the allocation of the dentry and the create of the inode, they shouldn't
> be left around waiting the vm to collect them.

Wrong. Negative dentries are very useful for caching negative lookups:
look at the average startup sequence of any program linked with glibc, and
depending on your setup you will notice how it tries to open a _lot_ of a
files that do not exist (the "depending on your setup" comes from the fact
that it depends on things like how quickly it finds your "locale" setup
from its locale path - you may have one of the setups that puts it in the
first location glibc searches etc).

If you don't cache those negative lookups, you will do a low-level
filesystem lookup for each of those failures, which is _expensive_.

However, you're right that it probably doesn't help to do this after
"unlink()" - it's probably only worth doing when actually doing a
"lookup()" that fails.

		Linus


