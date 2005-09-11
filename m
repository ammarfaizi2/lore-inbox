Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVIKWBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVIKWBk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVIKWBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:01:40 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:60039 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750983AbVIKWBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:01:40 -0400
Date: Mon, 12 Sep 2005 00:03:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050911220328.GE2177@mars.ravnborg.org>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org> <20050911212942.GK25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911212942.GK25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> OK...  Once that goes in, I'm doing s/prepare1/archprepare/ in there.
> Note that kern-offsets.c expects to find user_constants.h and symlinks
> already in place - it assumes that all kernel headers are usable.
> kern_constants.h is used only by userland glue, task.h and thread.h and
> these, in turn, are used only by userland glue.

Sent to Linus, assume it will be merged soon.

> 
> So ordering constraints are
> 	symlinks and user_constants.h are needed to get kernel headers usable
> 	kern_constants.h needs kernel headers
> 	kernel code needs kernel headers
> 	parts of userland glue need kern_constants.h
> 
> FWIW, we could rename user-offsets.c to asm-offsets.c and let the regular
> mechanism take care of them (renaming user_constants.h at the same time,
> obviously).  Critical part here is "kernel-offsets.c expects kernel headers
> usable", everything else could be trivially dealt with...

No. For once the flags to gcc differs for userland and kernelland.
Of the two candidates only kern_constants.h could be dealt with by
the generic support.

> Note that kern_constants.h must *NOT* go into include/asm-um - we need it
> in userland glue which doesn't get include/ in its search path.
And this killed the idea of using the generic support - not a big deal
anyway.


> So reducing
> the number of symlinks won't be trivial.  We could, in principle, move
> kern_constants.h to e.g. include/asm-um/user/, include that in userland
> glue search path and try to fight the rest, but that won't be fun.
> 
> One particulary nasty bit: we have both per-subarch headers in asm-um _and_
> headers in there that do something and proceed to include corresponding
> header from asm-<subarch>.  Currently we do that with
> 	include/asm-um/arch ----> include/asm-<subarch>
This just shows how horribly broken the symlink scheme is in the first
place.

If the kernel had used a scheme like the following everything could be
solved by a few -I statements:

include/i386/asm/<what we have in include/asm-i386 today>
include/ia64/asm/<what we have in include/asm-ia64 today>
etc.

Then to use ia64 we would just use:
-Iinclude/ia64

And in um land we could do exactly the same with no ugly symlinks.

> 	include/asm-um/foo.h ---> include/asm-um/foo-<subarch>.h for
> the first kind and
> 	#include <asm/arch/foo.h> in foo.h for the second one.
> 
> We also have arch/um/include/sysdep -> sysdep-<subarch>, but that's easier
> to deal with...
Here we should do like this:
arch/um/include/<subarch>/sysdep/<files from sysdep-<subarch>>
Again no ugly symlinks needed.

Another benefir that is often overlooked.
With kbuild checking the compileflags everything 'just works' when we
change sub-arch. No need to make clean etc.


I know this is a lot of renaming and I have not seen a really good
argument to convince Linus to rename include/asm-<arch>.
But for um I see no big dela doing the renaming, especially since most
of currect code should work out-of-the-box even with the changes
introduced.

	Sam
