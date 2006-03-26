Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWCZV0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWCZV0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWCZV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:26:47 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14341 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932125AbWCZV0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:26:46 -0500
Date: Sun, 26 Mar 2006 23:26:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header infrastructure
Message-ID: <20060326212601.GA7088@mars.ravnborg.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <20060326065416.93d5ce68.mrmacman_g4@mac.com> <20060326200537.GA5012@mars.ravnborg.org> <1DF54B48-4541-4BA9-A71C-A64CE98B4964@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1DF54B48-4541-4BA9-A71C-A64CE98B4964@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 03:39:32PM -0500, Kyle Moffett wrote:
> On Mar 26, 2006, at 15:05:37, Sam Ravnborg wrote:
> >On Sun, Mar 26, 2006 at 06:54:16AM -0500, Kyle Moffett wrote:
> >>Create initial kernel ABI header infrastructure
> >>
> >>diff --git a/Makefile b/Makefile
> >>index af6210d..8e9045a 100644
> >>--- a/Makefile
> >>+++ b/Makefile
> >>@@ -787,13 +787,15 @@ ifneq ($(KBUILD_SRC),)
> >> 		/bin/false; \
> >> 	fi;
> >> 	$(Q)if [ ! -d include2 ]; then mkdir -p include2; fi;
> >>+	$(Q)if [ ! -d include2/kabi ]; then mkdir -p include2/kabi; fi;
> >> 	$(Q)ln -fsn $(srctree)/include/asm-$(ARCH) include2/asm
> >>+	$(Q)ln -fsn $(srctree)/include/kabi/arch-$(ARCH) include2/kabi/arch
> >
> >No - we do not want another symlink.
> >Create something like:
> >include/i386/kabi-asm/  <= i386 specific files
> >include/kabi/           <= general files
> >
> >Then we can do:
> >LINUXINCLUDE += -Iinclude/kabi-$(ARCH)
> >And the following would work like expected:
> >#include <kabi/foo.h>
> >#include <kabi-asm/foo.h>
> 
> Hmm, I see where you're going with this.  Thanks for the tip!
> 
> >But this leaves all existing users in the dark cold.  So a more  
> >involved approach could be to take the opposite approach. To  
> >dedicate an area for kernel only header files and make sure this  
> >directory is searched _before_ include/
> 
> I'm not entirely sure I understand this bit.  The idea behind this  
> kabi stuff is precisely to split out portions of the headers so that  
> both userspace and kernelspace can get at them; to designate specific  
> items as "userspace clean" by putting them in kabi; everything else  
> need not care at all, and all those headers would remain in include/ 
> linux where they are now.  No sense moving _everything_ in include/  
> around, we just want the parts that userspace needs too.
> 

There are today a great number of users of the existing kernel headers.
Introducing a new namespace for the userspace suers will leave them in a
dilemma where they have to support kernels before kabi, and kernels with
kabi. That alone will limit the acceptance of this.

So shifting to another approach where you take everything that we have
today and clean it up step by step will allow us in small steps to go
from current mess to a clean ernel ABI.
But we will not have this clean and virgin set of headers until a few
years ahead of us.

Keeping include/linux for the kernel ABI will allow us NOT to break
existing users and it will allow a stepwise apporach at the same time.
But what we make clean and virgin is the kernel specific stuff, not the
userspace specific stuff. In final result will be the same but shifting
focus to the kernel internal stuff allows us to do ti in incremental
steps that does NOT break userspace every and so often.
And we will only break external modules that does not use kbuild to
compile - and for hese I really do not care a whit.

Keeping the breakage minimal is the key point here.

	Sam
