Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWHGVC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWHGVC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWHGVC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:02:28 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:43189 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932273AbWHGVC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:02:28 -0400
Date: Mon, 7 Aug 2006 23:02:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] kbuild fixes for 2.6.18
Message-ID: <20060807210209.GA14327@mars.ravnborg.org>
References: <20060807192708.GA12937@mars.ravnborg.org> <20060807204241.GA11510@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807204241.GA11510@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 01:42:41PM -0700, Greg KH wrote:
> On Mon, Aug 07, 2006 at 09:27:09PM +0200, Sam Ravnborg wrote:
> > Hi Greg.
> > Please apply to 2.6.18.
> > 
> > Pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-2.6.18.git
> 
> Thanks, pulled and pushed out.
> 
> Oh, I just got a few reports of 2.6.18-rc3 not building with external
> trees very well, and something like the following would be required:
> 
> --- linux-2.6.17/arch/sh/Makefile-dist        2006-08-07 20:42:33.000000000 +0200
> +++ linux-2.6.17/arch/sh/Makefile     2006-08-07 21:08:26.000000000 +0200
> @@ -173,7 +173,7 @@
>  archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
> 
>  PHONY += maketools FORCE
> -maketools:  include/linux/version.h FORCE
> +maketools: $(objtree)/include/linux/version.h FORCE
> 
> for all instances of the version.h file.
This looks bogus.
Current directory is $(objtree) so prefixing with $(objtree) should not
be needed and doing so will confuse make. make will not know that
$(objtree)/include/linux/version.h and include/linux/version.h is the
same file.

And the version.h dependency is anyway not needed. kbuild guarantee the
version.h is created when the commands for archprepare are executed.

So for sh I would expect the following is a better fix:

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index e467a45..ed1c865 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -172,8 +172,8 @@ include/asm-sh/.mach: $(wildcard include
 
 archprepare: maketools include/asm-sh/.cpu include/asm-sh/.mach
 
-PHONY += maketools FORCE
-maketools:  include/linux/version.h FORCE
+PHONY += maketools
+maketools:  FORCE
 	$(Q)$(MAKE) $(build)=arch/sh/tools include/asm-sh/machtypes.h
 
 all: zImage


arm should have a similar fix - thats the only other archtecture that
reference version.h in the arch specific kbuild (Makefile) files.

> 
> Was this fixed in -rc4 and I should update the SuSE kernel to it (well,
> I'll do that anyway later today...), or is this something that you did
> not know about?
Have not seen the reports - may have overlookd them at lkml.
Been on vacation a few days so ctrl-d was used to read most of my
lkml mails.

	Sam
