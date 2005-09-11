Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVIKRCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVIKRCn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVIKRCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:02:43 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:31556 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751096AbVIKRCm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:02:42 -0400
Date: Sun, 11 Sep 2005 19:04:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050911170425.GA8049@mars.ravnborg.org>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911154550.GJ25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > What happens:
> > > 	a) silentconfig expects to have include/linux in build tree already
> > > created.  Normally that happens earlier, but only by accident.  We need to
> > > force that somehow and the way I'd done it is almost certainly wrong - it
> > > should be in top-level makefile, to start with.  Suggestions?
> > 
> > We could stick a `mkdir -p include/linux` command just before executing
> > $(Q)$(MAKE) $(build)=scripts/kconfig silentoldconfig
> > 
> > It should do the trick - no?
> 
> AFAICS that would do it and it would make sense - silentoldconfig really
> relies on it being there, so it's either a dependency or just forcing it
> to be there.  Either would do and it certainly belongs to top-level Makefile.
I will include this in next patch series. This is a fix so it should be
ok for post monday.

> > > 	b) kernel-offsets.h needs symlinks already in place.  prepare1 does
> > > everything we need, so that dependency is probably the right thing (the second
> > > chunk).
> > 
> > I will try to take a closer look at this tonight.
What I have done in my tree is to set up following dependency tree in
the top-lvel Makefile:

prepare
  +-prepare0
     +-archprepare
        +-prepare1
           +-prepare2
              +-prepare3


prepare0 needs archprepare, but archprepare may need prepare1.
So this should be OK on all architectures.
And you can go back relying solely on prepare in um Makefile.


> > As always my head starts spinning when I look at the arch/um/Makefile
> > but I will see what I can do.
> > If I can simplify it and introduce full dependency checks it would be
> > really nice. 
...
> No need.  We really need only two generated files - constants from
> UML host userland and constants from UML kernel itself.  That's it.
> 
> And these are needed since we have two parts of UML code - built with
> kernel and userland headers resp. (basically, normal kernel code and
> glue to UML host userland).  Since headers really do not mix, we have
> to use extracted constants in pretty much the same way we have to
> do that for assembler bits.  So there you go...
It certainly look much much better than anything I could come up with.
You should persuade Jeff and Paolo to test and include this.

A few notes..
  
>  define filechk_gen-asm-offsets
>          (set -e; \
> -         echo "#ifndef __ASM_OFFSETS_H__"; \
> -         echo "#define __ASM_OFFSETS_H__"; \
>           echo "/*"; \
>           echo " * DO NOT MODIFY."; \
>           echo " *"; \
> @@ -208,8 +199,7 @@
>           echo " */"; \
>           echo ""; \
>           sed -ne "/^->/{s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}"; \
> -         echo ""; \
> -         echo "#endif" )
> +         echo ""; )
>  endef
>  
>  include/linux/autoconf.h : include/linux/version.h
> @@ -220,49 +210,18 @@
>  $(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
>  	$(CC) $(USER_CFLAGS) -S -o $@ $<

This part could be moved to a Kbuild file so we have access to
full kbuild functionality - and thus anebling full dependency check
on user-offset.c
  
> -$(ARCH_DIR)/user-offsets.h: $(ARCH_DIR)/user-offsets.s
> +$(ARCH_DIR)/include/user_constants.h: $(ARCH_DIR)/user-offsets.s
>  	$(call filechk,gen-asm-offsets)
filechk is only relevant if there is a risk that user_constants.h is
rebuild but there is no changes in output file. We do this for version.h
but I do not see any big need for it here.
  
> -$(ARCH_DIR)/kernel-offsets.h: $(ARCH_DIR)/kernel-offsets.s
> +$(ARCH_DIR)/include/kern_constants.h: $(ARCH_DIR)/kernel-offsets.s
>  	$(call filechk,gen-asm-offsets)

Same comment as above.

	Sam
