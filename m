Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRCGEE6>; Tue, 6 Mar 2001 23:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCGEEj>; Tue, 6 Mar 2001 23:04:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:63498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130008AbRCGEE2>; Tue, 6 Mar 2001 23:04:28 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Hashing and directories
Date: 6 Mar 2001 20:03:39 -0800
Organization: Transmeta Corporation
Message-ID: <984bur$lqq$1@penguin.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0103012103140.754-100000@penguin.homenet> <20010302095608.G15061@atrey.karlin.mff.cuni.cz> <20010307013729.A7184@pcep-jamie.cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010307013729.A7184@pcep-jamie.cern.ch>,
Jamie Lokier  <lk@tantalophile.demon.co.uk> wrote:
>Pavel Machek wrote:
>> > the space allowed for arguments is not a userland issue, it is a kernel
>> > limit defined by MAX_ARG_PAGES in binfmts.h, so one could tweak it if one
>> > wanted to without breaking any userland.
>> 
>> Which is exactly what I done on my system. 2MB for command line is
>> very nice.
>
>Mine too (until recently).  A proper patch to remove the limit, and copy
>the args into swappable memory as they go (to avoid DoS) would be nicer,
>but a quick change to MAX_ARG_PAGES seemed so much easier :-)

You can't just change MAX_ARG_PAGES. The space for the array is
allocated on the stack, and you'll just overflow the stack if you start
upping it a lot.

The long-term solution for this is to create the new VM space for the
new process early, and add it to the list of mm_struct's that the
swapper knows about, and then just get rid of the pages[MAX_ARG_PAGES]
array completely and instead just populate the new VM directly.  That
way the destination is swappable etc, and you can also remove the
"put_dirty_page()" loop later on, as the pages will already be in their
right places. 

It's definitely not a one-liner, but if somebody really feels strongly
about this, then I can tell already that the above is the only way to do
it sanely.

		Linus
