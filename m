Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWBFLUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWBFLUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWBFLUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:20:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8660 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750893AbWBFLUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:20:40 -0500
Date: Mon, 6 Feb 2006 11:59:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Rafael Wysocki <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206105954.GD3967@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041954.22484.nigel@suspend2.net> <20060204192924.GC3909@elf.ucw.cz> <200602061402.54486.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602061402.54486.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[Head straight down for j. if you hate long mails.]

> > Complexity in userspace: ungood.
> >
> > Complexity in kernel: doubleplusungood.
> >
> > It is not that hard to understand :-).
> 
> Heh. you'll soon be submitting patches to move interrupt handling and 
> scheduling to userspace then?

If I figure out how to do that with equivalent performance and without
excessive uglyness... yes.

[This has hidden assumption that we want to include *all* the features
suspend2 has. We could do it... but we probably do not want to.]

> a. Freezing processes, freeing memory and preparing the image.
...
> Freeing memory and preparing the image is significantly simpler for swsusp 
> at the moment because it doesn't support swap files, and doesn't

I do not see why I'd have to modify freezer for supporting swap
files. It is really unrelated part. If I want to support swap files,
I'll just bmap() them from userspace, then write to blockdevice
directly, like lilo or grub does.

b. missing?

> c. Compression and encryption.
...
> libraries or using cryptoapi functions via ioctls or such like. Making 
> such support optional and configurable would require further modification. 
> Using userspace libraries for compression and encryption would increase 
> the complexity of configuring uswsusp for a developer (extra packages to 
> download/configure/install), and create greater potential for support 
> issues for developers and distributions (uswusp gets blamed for any 
> problems in those libraries but can't do anything to fix them!).

Yes, that is how libraries work. Any userland application has these
"problems". uswsusp is clearly better here.

> d. Storage of the image.
> 
> As it currently stands, the interface between userspace and the kernel for 
> uswsusp looks clean and simple. This is mainly, however, because it only 
> supports writing to swap, and strictly synchronously.

...and it is going to stay that way.

> If you were going to match the functionality in suspend2, you would be 
> looking at adding support for (a) asynchronous I/O, (b) for ordinary 
> files, (c) for multiple swap devices (d) for swapfiles and (e) for the 
> varying blocksizes of filesystems. I assume uswsusp won't currently work 
> with swapfiles (as opposed to swap partitions) as it stands because I see 
> a check for !S_ISBLK(resume_device) in suspend.c::main.

(a) Reading image from kernel is memory-to-memory transfer --
i.e. extremely fast. There's nothing to be gained by asynchronous
I/O. (Write to disk can still be done asynchronous, kernel has
interfaces to do that). (b) is going to be solved by bmap. Maybe I'll
need some small changes for (c) and (d); don't see why (e) applies to me.

> userspace for getting the sector numbers of storage. Finally, you'd want 
> to use bio functions to submit the I/O, and a kernel routine to handle the 
> completion. Then you'd need some mechanism to wait for or check for 
> completion of I/O on a particular page or all pages. Of course you might 
> decide not to do async I/O because it's too complex, but then you'd take 
> the performance hit you currently have, and we wouldn't have an apples 
> with apples comparison.

Submit bios from userspace? Eeek? We have perfectly working async io
interface for userland, and BTW going async will not give you too much
of performance advantage here... 

> e. Atomic copy/restore.
> 
> This is currently achieved in kernelspace, as it is for Suspend2. It would 
> seem to be extremely unlikely that this could be implemented in
> userspace. 

No, this stays in kernel.

> f. User tuning and configuration.
...
> Suspend2 offers far more support for tuning and configuration via a proc 
> interface. Suspend2 implements an additional layer on top of the base proc 
> routines, which might be useful elsewhere in the kernel. This layer allows 
> additional entries to be created at very little cost, and avoid 
> duplicating code for each entry. This is an area of additional complexity 
> that Suspend2 has at the moment, but similar additions would be helpful in 
> the userspace program for the same reasons.

uswsusp wins here -- at least it does the config stuff in userspace.

> g. Writing a full image of memory.
> 
> Not possible in uswsusp right now. If the algorithm of Suspend2 was used 
> (wherein LRU pages are saved separately), support would need to be added 
> for marking which LRU pages should be in the atomic copy (because they 
> belong to the freezing process), and for reading and writing the sets of 
> pages separately.

I'm not sure if we want to save full image of memory. Saving most-used
caches only seems to work fairly well.

> h. Powering down.
> 
> uswsusp currently supports using the sys_reboot restart and power off 
> functions. There is no support for entering the ACPI S4 state, or for 
> suspending-to-ram instead of powering off. Adding these would require 
> additional ioctls and kernelspace functions, and the capability of 
> configuring which powerdown method to use.

Yes, we'll need ioctls to enter S3 and S4.

Do you actually support suspend-to-ram at end of suspend2? That is one
feature I'd like to play with.

> i. Status display.
...
> is required when updating the kernel). It has also created additional 
> complexity in that the code for doing the userui in the kernel didn't 
> really go away - it was just replaced by code to communicate with 
> userspace and get it to do the work. On the positive side, though,

As we do image writing in userspace, anyway, it does not mean
aditional interface to userspace for us.

> j. Summary.
> 
> At their cores, Suspend2 and uswsusp work in basically the same

Yes, basically. They'll be similar complexity in the end, differing
very much where the complexity is.

Currently suspend2 is 14K lines of code in kernel. Not sure how much
in userspace.

Current uswsusp is 3K lines of code in kernel, 1K lines of code in
userspace.

When we are done, we'll have perhaps 2.5K lines of code in kernel
(in-kernel swap writing support goes away), and maybe 20K lines in
userspace.

That may not seem like a big difference to you, but it really is. It
keeps complexity out-of-kernel.

> It seems most likely that uswsusp would never match the current Suspend2 in 
> terms of functionality, or would take a very long time to get there. 
> Support for implementing a full image of memory will likely never happen, 
> and asynchronous I/O would be unlikely too. If the flexibility in how to 
> compress/encrypt and write the image that Suspend2 currently has were to 
> be implemented in uswsusp, it would require a modular architecture along 
> the lines of the one that has been rejected in the Modules support thread. 

It was rejected *for kernel*. Putting it in userspace is okay.

									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
