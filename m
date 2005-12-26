Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVLZRZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVLZRZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 12:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVLZRZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 12:25:48 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:1756 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932067AbVLZRZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 12:25:48 -0500
Date: Mon, 26 Dec 2005 12:25:29 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SLAB - have index_of bug at compile time.
In-Reply-To: <43B01BD7.3040209@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0512261209060.9622@gandalf.stny.rr.com>
References: <43B01BD7.3040209@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Dec 2005, Manfred Spraul wrote:

> Steven wrote:
>
> >So I'm going through ever line of code and examining it
> >thoroughly, when I find something that could be improved
> >
> Try to find a kfree implementation that doesn't need virt_to_page().
> This is a big restriction of the current implementation: It's in the hot
> path, but the operation is only fast on simple systems, not on numa
> systems without a big memory map.
> And it makes it impossible to use vmalloc memory as the basis for slabs,
> or to use slab for io memory.
>

Unfortunately, that virt_to_page helps make kmalloc and kfree more
efficient.  Since it allows the use of the mem_map pages that map to the
used memory to be used for storing information about the slab.

So removing virt_to_page means you need to store the information relative
to the memory that is mapped.  Thus you need to allocate more than is
needed.

Your question refers to only kfree, which would not really be that
difficult to remove the virt_to_page, since that would just need the extra
memory _for each allocation_.  But then you mention vmalloc and numa,
where it is the generic use of virt_to_page through out slab.c that is the
issue.  I counted 14 direct uses of virt_to_page in slab.c (2.6.15-rc5).
Now you need to find a way to store the information of the off slab
descriptors and for slabs that are more than one page.

Changing the use of virt_to_page would probably hurt those that can use
it, and the changes would not be accepted because of that.  Unless you can
keep the same speed and memory efficiency of those "simple systems".

Now, maybe NUMA and vmalloc might be a good reason to start a new
allocation system along side of slab?

-- Steve

