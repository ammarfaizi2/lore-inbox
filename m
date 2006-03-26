Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWCZUGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWCZUGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWCZUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:06:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:57358 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751533AbWCZUGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:06:42 -0500
Date: Sun, 26 Mar 2006 22:05:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Message-ID: <20060326200537.GA5012@mars.ravnborg.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326065416.93d5ce68.mrmacman_g4@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 06:54:16AM -0500, Kyle Moffett wrote:
> Create initial kernel ABI header infrastructure
> 
> 
> diff --git a/Makefile b/Makefile
> index af6210d..8e9045a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -787,13 +787,15 @@ ifneq ($(KBUILD_SRC),)
>  		/bin/false; \
>  	fi;
>  	$(Q)if [ ! -d include2 ]; then mkdir -p include2; fi;
> +	$(Q)if [ ! -d include2/kabi ]; then mkdir -p include2/kabi; fi;
>  	$(Q)ln -fsn $(srctree)/include/asm-$(ARCH) include2/asm
> +	$(Q)ln -fsn $(srctree)/include/kabi/arch-$(ARCH) include2/kabi/arch


No - we do not want another symlink.
Create something like:
include/i386/kabi-asm/  <= i386 specific files
include/kabi/           <= general files

Then we can do:
LINUXINCLUDE += -Iinclude/kabi-$(ARCH)
And the following would work like expected:
#include <kabi/foo.h>
#include <kabi-asm/foo.h>


But this leaves all existing users in the dark cold.
So a more involved approach could be to tkae the opposite approach.
To dedicate an area for kernel only header files and make sure this
directory is searched _before_ include/

We could do something like
kinclude/linux/         <= generic kernel include headers
kinclude/$(arch)/asm/   <= arch specific include headers

Then adding to the top-level Makefile:
LINUXINCLUDE := -Ikinclude -Ikinclude/$(ARCH)
LINUXINCLUDE += ...

would actually cut it.
Then we would not hurt existing users since they continue to use
include/linux/* + include/asm/*
And we could migrate one by one to the kernel clean part.

In other words - a solution that keeps backwards compatibility.
A solution that distingush hard between what is the ABI and
what is kernel stuff.
And a namespace that is not in use today.

And we have so many users of include/linux today. They do not need
a _kabi_ prefix so let it go.

	Sam
