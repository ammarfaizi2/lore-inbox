Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVKRGpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVKRGpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 01:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVKRGpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 01:45:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41349
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932555AbVKRGpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 01:45:41 -0500
Date: Thu, 17 Nov 2005 22:45:16 -0800 (PST)
Message-Id: <20051117.224516.118147408.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: hugh@veritas.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <437D6AD0.5080909@yahoo.com.au>
References: <Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com>
	<20051117.155230.25121238.davem@davemloft.net>
	<437D6AD0.5080909@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Fri, 18 Nov 2005 16:46:56 +1100

> I think for 2.6.15, yes. We [read: I :(] was too hasty in removing
> this completely. However I think it would not be unresonable to spit
> out a warning, and remove it in 2.6.??

I am so convinced that handling COW faults on VM_RESERVED is
unnecessary, that I think it's prudent to spit out a warning
for MAP_PRIVATE+VM_RESERVED and changing it to MAP_SHARED
to complete the mmap() call.

I bet every single application still works.

And we'll have none of this rediculious complex crap handling COW
pages in VM_RESERVED areas, which I believe is seriously more
complicated than what we started with before any of the VM_RESERVED
changed went into 2.6.15.  In fact, we might as well go back to the
2.6.14 stuff instead.  I do not see the second half of Hugh's patches
as progress, it's a severe regression to even 2.6.14

Doing a get_user_pages() on a VM_UNPAGED area, that's sane, and
we know exactly what makes use of that.  COW faults on VM_UNPAGED
areas, that's not sane, and we don't know of a single instance
which correctly needs that behavior.

MAP_SHARED mappings of reserved pages shared between driver, device,
and userspace is common and understandable.  But MAP_PRIVATE mappings
of such things?  Please show me an example of something legitimately
using that, and not doing so by mistake.  I will drop all of my
arguments once I see that :-)

Because, frankly, a lot of these COW on VM_UNPAGED patches seemingly
are derived from studying the MM and a few drivers and saying "oh yes,
that's _possible_" but that is far from being enough to justify this
complexity.  We really need to see real usage, that makes sense.
All the cases I've investigated in userspace are "they really want
MAP_SHARED" or "they didn't need PROT_WRITE in the first place".
