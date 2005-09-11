Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVIKV3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVIKV3p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVIKV3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:29:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26076 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750923AbVIKV3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:29:45 -0400
Date: Sun, 11 Sep 2005 22:29:42 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050911212942.GK25261@ZenIV.linux.org.uk>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911170425.GA8049@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 07:04:25PM +0200, Sam Ravnborg wrote:
> prepare
>   +-prepare0
>      +-archprepare
>         +-prepare1
>            +-prepare2
>               +-prepare3
> 
> 
> prepare0 needs archprepare, but archprepare may need prepare1.
> So this should be OK on all architectures.
> And you can go back relying solely on prepare in um Makefile.

OK...  Once that goes in, I'm doing s/prepare1/archprepare/ in there.
Note that kern-offsets.c expects to find user_constants.h and symlinks
already in place - it assumes that all kernel headers are usable.
kern_constants.h is used only by userland glue, task.h and thread.h and
these, in turn, are used only by userland glue.

So ordering constraints are
	symlinks and user_constants.h are needed to get kernel headers usable
	kern_constants.h needs kernel headers
	kernel code needs kernel headers
	parts of userland glue need kern_constants.h

FWIW, we could rename user-offsets.c to asm-offsets.c and let the regular
mechanism take care of them (renaming user_constants.h at the same time,
obviously).  Critical part here is "kernel-offsets.c expects kernel headers
usable", everything else could be trivially dealt with...
 
Note that kern_constants.h must *NOT* go into include/asm-um - we need it
in userland glue which doesn't get include/ in its search path.  So reducing
the number of symlinks won't be trivial.  We could, in principle, move
kern_constants.h to e.g. include/asm-um/user/, include that in userland
glue search path and try to fight the rest, but that won't be fun.

One particulary nasty bit: we have both per-subarch headers in asm-um _and_
headers in there that do something and proceed to include corresponding
header from asm-<subarch>.  Currently we do that with
	include/asm-um/arch ----> include/asm-<subarch>
	include/asm-um/foo.h ---> include/asm-um/foo-<subarch>.h for
the first kind and
	#include <asm/arch/foo.h> in foo.h for the second one.

We also have arch/um/include/sysdep -> sysdep-<subarch>, but that's easier
to deal with...

Any ideas?

> > -$(ARCH_DIR)/kernel-offsets.h: $(ARCH_DIR)/kernel-offsets.s
> > +$(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/kernel-offsets.s
> >  	$(call filechk,gen-asm-offsets)
> 
> Same comment as above.

kernel-offsets.c might actually pick a stray dependency on version.h.
user-offsets.c comment applies, indeed.
