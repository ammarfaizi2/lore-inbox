Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTAZCVt>; Sat, 25 Jan 2003 21:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbTAZCVt>; Sat, 25 Jan 2003 21:21:49 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52678 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265457AbTAZCVr>; Sat, 25 Jan 2003 21:21:47 -0500
Date: Sat, 25 Jan 2003 20:30:44 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] [PATCH] new modversions implementation
In-Reply-To: <20030125215637.GA3571@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0301252025350.6749-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Sam Ravnborg wrote:

> diff -Nru a/kernel/module.c b/kernel/module.c
> --- a/kernel/module.c   Sat Jan 25 12:25:07 2003
> +++ b/kernel/module.c   Sat Jan 25 12:25:07 2003
> 
> +       kernel_gpl_symbols.num_syms = (__stop___ksymtab_gpl
> +                                      - __start___ksymtab_gpl);
> 
> The member "num_syms" says something about number of symbols,
> but is contains the syms_size. Misleading name.
> I can see this was also the case before, but confused me a bit.

Look at the definition of __{start,stop}__ksymtab and recall C pointer 
arithmetics ;) (i.e. if I understood your comment right)

> 
> +               | $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)         \
> +               | grep __ver                                                  \
> +               | sed 's/\#define __ver_\([^    ]*\)[   ]*\([^  ]*\)/__crc_\1 =
> +0x\2 ;/g' \
> 
> A genksyms replacement should do all the three steps above?

Yes, I think at some point I should take a look at patching genksyms so 
that the post-processing above is not necessary anymore. However, it 
doesn't hurt much, performance-wise.

> +cmd_link_multi-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@
> +$(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs))) $($(subst
> +$(obj)/,,$(@:.o=-y)))),$^)
> 
> The comment
> #
> # Rule to link composite objects
> #
> 
> Could tell a bit more:
> #
> # Rule to link composite objects
> #   Listed in kbuild makefiles with:
> #   <composite object>-objs := <list of .o files>
> #   or
> #   <composite object>-y := <list of .o files>
> #

Sure, send a patch ;)

> +$(multi-used-m) : %.o: $(multi-objs-m) FORCE
> 
> I cannot see the need for the "%.o". The "%" is not used - or have
> I misunderstood the usage of the above construction?

It's not really necessary, but it still gives a hint that we're building
.o files. It should reallyyyy be %.o: $(%-objs), only that make doesn't
like that.

>  quiet_cmd_link_multi-m = LD [M]  $@
> -quiet_cmd_link_single-m = LD [M]  $@
> +quiet_cmd_link_module = LD [M]  $@
> 
> Inconsistent naming, I would like the old naming back for consistency.

No, cmd_link_module links single- and multi-part modules (.o->.ko) now, 
that's why it got the more generic name.

--Kai


