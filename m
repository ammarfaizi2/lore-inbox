Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVAaK4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVAaK4C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 05:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVAaK4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 05:56:01 -0500
Received: from science.horizon.com ([192.35.100.1]:47658 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261853AbVAaKzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 05:55:39 -0500
Date: 31 Jan 2005 10:55:38 -0000
Message-ID: <20050131105538.9149.qmail@science.horizon.com>
From: linux@horizon.com
To: nigelenki@comcast.net
Subject: Re: Patch 4/6  randomize the stack pointer
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not compromise, if possible?  256M of randomization, but move the
> split up to 3.5/0.5 gig, if possible.  I seem to recall seeing an option
> (though I think it was UML) to do 3.5/0.5 before; and I'm used to "a
> little worse" meaning "microbenches say it's worse, but you won't notice
> it," so perhaps this would be a good compromise.  How well tuned can
> 3G/1G be?  Come on, 1G is just a big friggin' even number.

Ah, grasshopper, so much you have to learn...
In particular, prople these days are more likely to want to move the
split DOWN rather than UP.

First point: it is important that the split happens at an "even" boundary
for the highest-level page table.  This makes it as simple as possible to
copy the shared global pages into each process' page tables.

On typical x86, each table is 1024 entries long, so the top table maps
4G/1024 = 4M sections.

However, with PAE (Physical Address Extensions), a 32-bit page table
entry is no longer enough to hold the 36-bit physical address.  Instead,
the entries are 64 bits long, so only 512 fit into a page.  With a
4K page and 18 more bits from page tables, two levels will map only
30 bits of the 32-bit virtual address space.  So Intel added a small,
4-entry third-level page table.

With PAE, you are indeed limited to 1G boundaries.  (Unless you want to
seriously overhaul mm setup and teardown.)


Secondly, remember that, unless you want to pay a performance penalty
for enabling one of the highmem options, you have to fit ALL of physical
memory, PLUS memory-mapped IO (say around 128M) into the kernel's portion
of the address space.  512M of kernel space isn't enough unless you have
less than 512M (like 384M) of memory to keep track of.

That is getting less common, *especially* on servers.  (Which are
presumably an important target audience for buffer overflow defenses.)


Indeed, if you have a lot of RAM and you don't have a big database that
needs tons of virtual address space, it's usually worth moving the
split DOWN.


Now, what about the case where you have gobs of RAM and need a highmem
option anyway?  Well, there's a limit to what you can use high mem for.
Application memory and page cache, yes.  Kernel data structures, no.
You can't use it for dcache or inodes or network sockets or page
tables or the struct page array.

And the mem_map array of struct pages (on x86, it's 32 bytes per page,
or 1/128 of physical memory; 32M for a 4G machine) is a fixed overhead
that's subtracted before you even start.  Fully-populated 64G x86
machines need 512M of mem_map, and the remaining space isn't enough to
really run well in.

If you crunch kernel lowmem too tightly, that becomes the
performance-limiting resource.


Anyway, the split between user and kernel address space is mandated
by:
- Kernel space wants to be as bit as physical RAM if possible, or not
  more than 10x smaller if not.
- User space really depends on the application, but larger than 2-3x
  physical memory is pointless, as trying to actually use it all will
  swap you to death.

So for 1G of physical RAM, 3G:1G is pretty close to perfect.  It was
NOT pulled out of a hat.  Depending on your applications, you may be
able to get away with a smaller user virtual address space, which could
allow you to work with more RAM without needing to slow the kernel with
highmem code.



You'll find another discussion of the issues at
http://kerneltrap.org/node/2450
http://lwn.net/Articles/75174/

Finally, could I suggest a little more humility when addressing the
assembled linux-kernel developers?  I've seen Linus have to eat his
words a time or two, and I know I can't do as well.
http://marc.theaimsgroup.com/?m=91723854823435
