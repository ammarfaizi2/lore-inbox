Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTIQUve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTIQUve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:51:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:2479 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262647AbTIQUvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:51:33 -0400
Date: Wed, 17 Sep 2003 13:50:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <richard.brunner@amd.com>
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
In-Reply-To: <20030917202100.GC4723@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Sep 2003, Andi Kleen wrote:
> 
> Also when the fault address is equal EIP we don't check.

And this is a good example of something that can break.

The fault address is a linear address after segment translation. The EIP 
is _before_ segment translation.

You don't translate the EIP with the CS base.

Which means that the two can match even if they have nothing to do with 
each other. It will happen in vm86 mode and in things like wine. So that 
check is broken.

Also, for the same reason, you won't fix up prefetches in wine.

Also, you do things like comparing pointers for less/greater than, and at
least some versions of gcc has done that wrong - using signed comparisons.  
Which leaves you potentially open to denial-of-service attacks if somebody
generates a long list of prefixes around the 0x80000000 mark and the size
check doesn't catch them.

In short, this is harder than you seem to think. And right now you _do_ do 
the wrong things for Wine, and I think that not only should that be fixed, 
it should be made athlon-specific so that any other potential bugs won't 
impact people that it shouldn't impact.

See?

		Linus

