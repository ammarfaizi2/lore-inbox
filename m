Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWELV2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWELV2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWELV2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:28:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750803AbWELV17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:27:59 -0400
Date: Fri, 12 May 2006 14:27:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <20060512205804.GD17120@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0605121409250.3866@g5.osdl.org>
References: <20060511151456.GD3755@harddisk-recovery.com>
 <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
 <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
 <1147456038.3769.39.camel@mulgrave.il.steeleye.com>
 <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org> <20060512205804.GD17120@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Russell King wrote:
>
> On Fri, May 12, 2006 at 01:50:46PM -0700, Linus Torvalds wrote:
> > 
> > No, you introduced a regression. This isn't the SCSI layer being evil, 
> > this is the "regressions aren't acceptable".
> 
> No - I introduced a correct fix.

Not so. 

You introduced a commit that fixed one thing, and broke another thing.

This is not rocket science, Russell. This is how programming works. There 
are dependencies on behaviour, and if you change behaviour, it can fix one 
problem while breaking another one, because different sides depend on 
different semantics.

Real complexity is in linkages and communication. Surprise, surprise.

The _real_ broken ends up being elsewhere. It might just be a 
communication error (two different subsystems got the wrong idea because 
of bad communication about how something _should_ be used), but it migth 
also be some bad design.

But saying that the two one-liners were the "correct fix" is premature 
just because they fixed the symptoms for _you_.

> It seems that fixing simple bugs cause other bugs, and that means we're
> heading into a maintainability nightmare.

That's just stupid, Russell.

You DID NOT FIX A SIMPLE BUG.

You made a change, that on the face of it _looked_ like a simple fix for a 
simple bug. It wasn't. No amount of you saying so makes it so. It broke 
something else, and suddenly what you claim was a simple and clear bug-fix 
obviously isn't.

Ergo, it ended up not being "fixing simple bugs" at all.

> No idea I'm afraid, and since I've had a _really_ extremely shitty couple
> of days I'm not about to start going to look for it.

Right. You're pissy. That's fine. But you having a shitty couple of days 
doesn't mean you need to take it out on everybody else. Especially not 
when people actually offered to help, and asked for details on exactly 
what the problem that _you_ tracked was.

You depend on the exact same infrastructure that SCSI depends on. SCSI has 
different expectations of that infrastructure than you do. Arguably, there 
are more SCSI users out there than MMC users, so when you claim that it's 
SCSI's fault, you're being biased. It's equally possible that the fault 
was in the MMC layer all along, and that the MMC layers use of the 
structure was the thing that caused the oops for the MMC later.

Since you didn't bother to even point to the oopses or the patch that 
caused then now, you aren't actually giving any reason to believe that 
your view of the situation is the only right one. 

So you havign a hissy-fit actually makes it harder for people to even help 
you. James already said

	"If Russell and Jens can tell me what they're trying to do I'll 
	 see if there's another way to do it."

but you didn't, you just started ranting.

See? Not very useful, is it?

> > Really, the added ref-count should be gotten by whoever holds on to the 
> > thing, and it sounds like it's the hotplug event that caused this and 
> > should have held on to its hotplug reference.
> 
> ... which would be the genhd layer - it's keeping the driverfs_dev
> around so that the genhd layer can generate hotplug events using it
> at mount/umount time.  Thanks for just re-confirming my original fix
> and that it's SCSI which is the real problem. 8)

No. You want your fix to be the correct one, but the fact is, it may well 
not be that at all. Maybe - once we look at what the oops is - we find 
that it really _is_ the MMC layer that just doesn't follow the assumptions 
that the device layer was doing.

I said "sounds like". And without help, we can't much help you. And being 
pissy about it, will just make everybody more sure that it's the MMC 
layer.

Reference counts aren't always simple. Exactly because you can get a 
"recursive" reference count, where a device holds on to its reference 
count just by account of existing - and that is a BUG, because such a 
reference count will obviously never go down to zero.

Now, not going down to zero will certainly hide any problems that come 
from the object being released early, because it will _never_ be released. 
And it sounds like this is actually what your patch _really_ caused. The 
oops went away, but perhaps at the cost of a leak?

And hey, maybe your patch was proper, and the bug really _is_ in the SCSI 
layer. In which case we get back to that message from James that you 
ignored.

			Linus
