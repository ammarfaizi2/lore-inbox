Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTAYVsR>; Sat, 25 Jan 2003 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262384AbTAYVsQ>; Sat, 25 Jan 2003 16:48:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43792 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262289AbTAYVsP>;
	Sat, 25 Jan 2003 16:48:15 -0500
Date: Sat, 25 Jan 2003 22:56:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] [PATCH] new modversions implementation
Message-ID: <20030125215637.GA3571@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0301251229120.6749-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301251229120.6749-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 12:44:39PM -0600, Kai Germaschewski wrote:

Just some small nit-picking..

	Sam

diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c   Sat Jan 25 12:25:07 2003
+++ b/kernel/module.c   Sat Jan 25 12:25:07 2003

+       kernel_gpl_symbols.num_syms = (__stop___ksymtab_gpl
+                                      - __start___ksymtab_gpl);

The member "num_syms" says something about number of symbols,
but is contains the syms_size. Misleading name.
I can see this was also the case before, but confused me a bit.

+               | $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)         \
+               | grep __ver                                                  \
+               | sed 's/\#define __ver_\([^    ]*\)[   ]*\([^  ]*\)/__crc_\1 =
+0x\2 ;/g' \

A genksyms replacement should do all the three steps above?

+cmd_link_multi-m = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@
+$(filter $(addprefix $(obj)/,$($(subst $(obj)/,,$(@:.o=-objs))) $($(subst
+$(obj)/,,$(@:.o=-y)))),$^)

The comment
#
# Rule to link composite objects
#

Could tell a bit more:
#
# Rule to link composite objects
#   Listed in kbuild makefiles with:
#   <composite object>-objs := <list of .o files>
#   or
#   <composite object>-y := <list of .o files>
#

+cmd_link_module = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE) -o $@ $<
+init/vermagic.o

How about 
ld_modflags = $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_MODULE)

+
+# Don't rebuilt vermagic.o unless we actually are in the init/ dir
+ifneq ($(obj),init)
+init/vermagic.o: ;
+endif

The above magic does not look safe to me when utilising parrallel builds.
At least init/vermagic.o needs to be in the prepare: rule.

+$(multi-used-m) : %.o: $(multi-objs-m) FORCE

I cannot see the need for the "%.o". The "%" is not used - or have
I misunderstood the usage of the above construction?

+       $(touch-module)

Add comment:
+       $(touch-module)	# Record update in .tmp_versions/path/to/module.ko

 quiet_cmd_link_multi-m = LD [M]  $@
-quiet_cmd_link_single-m = LD [M]  $@
+quiet_cmd_link_module = LD [M]  $@

Inconsistent naming, I would like the old naming back for consistency.

	Sam
