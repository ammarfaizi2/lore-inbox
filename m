Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUHJBpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUHJBpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHJBpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:45:09 -0400
Received: from zero.aec.at ([193.170.194.10]:58372 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267386AbUHJBo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:44:59 -0400
To: Brent Casavant <bcasavan@sgi.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] get_nodes mask miscalculation
References: <2rr7U-5xT-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 10 Aug 2004 03:44:52 +0200
In-Reply-To: <2rr7U-5xT-11@gated-at.bofh.it> (Brent Casavant's message of
 "Tue, 10 Aug 2004 00:50:07 +0200")
Message-ID: <m31xifu5pn.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Casavant <bcasavan@sgi.com> writes:

The idea behind this is was to make it behave like select.
And select passes highest valid value + 1. In this case
valid value is not the highest bit number, but the length
of the bitmap.

For some reason nobody except me seems to get it though,
probably because the description in the manpages is a bit confusing:

get_mempolicy(2): 

"maxnode is the maximum bit number plus one that can be stored into
nodemask."

I suppose this should be better described. For changing it 
it is too late unfortunately because the libnuma binaries
are already out in the wild.

> It appears there is a nodemask miscalculation in the get_nodes()
> function in mm/mempolicy.c.  This bug has two effects:
>
> 1. It is impossible to specify a length 1 nodemask.

Sure. You pass 2.

> 2. It is impossible to specify a nodemask containing the last node.

you pass number of nodes + 1.

> The following patch against 2.6.8-rc3 has been confirmed to solve
> both problems.

Problem is that you'll break all existing libnuma binaries 
which pass NUMA_MAX_NODES + 1. In your scheme the kernel
will access one bit beyond the bitmap that got passed,
and depending on its random value you may get a failure or not.

BTW there is a minor problem in the code that there isn't a upper
limit. When you pass 0 it currently iterates through all your memory
until it hits an EFAULT, which can be a bit slow. But that's easy to
fix.

-Andi


