Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbWAFX4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWAFX4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWAFX4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:56:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60174 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932674AbWAFX4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:56:21 -0500
Date: Sat, 7 Jan 2006 00:56:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
Message-ID: <20060106235601.GA26268@mars.ravnborg.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136543914.2940.11.camel@laptopd505.fenrus.org> <43BEA672.4010309@pobox.com> <20060106184841.GA13917@mars.ravnborg.org> <1136574052.2940.68.camel@laptopd505.fenrus.org> <43BEBEE1.6060500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BEBEE1.6060500@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 02:02:57PM -0500, Jeff Garzik wrote:
> Arjan van de Ven wrote:
> >>Also why should we care so much for multi directory modules?
> >
> >
> >I suspect Jeff didn't mean it like that, but instead assumed that
> >multi-directory would be harder so that starting with single-directory
> >would be a good start...

The tricky part is to handle prerequisites correct.
I have made a very hackish version now and some observations.

- It is not easy to honour CFLAGS_<file.o> flags. And they will become
  used for all files
- If a single file is touched gcc will build all the source for the
  module. Not what you expect when touching a single file in fs/xfs/*
- needed to pass -nodefaultlibs to gcc to avoid linker errors - dunno
  why but it complained that it could not find -lgcc_s otherwise
- Gcc 3.4.4 at least compile the files individually, so not much seems
  gained.

Here is the changes so far...
This is not all all working, but I can compile xfs as a module with
this. But it recompiles everytime.

Do we really want this when it has the drawback that touching a single
file causes all of a module to be built?
It could be a <schrudder> CONFIG option....

	Sam


diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c33e62b..aceab6b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -281,16 +281,20 @@ endif
 #    <composite-object>-objs := <list of .o files>
 #  or
 #    <composite-object>-y    := <list of .o files>
-link_multi_deps =                     \
-$(filter $(addprefix $(obj)/,         \
-$($(subst $(obj)/,,$(@:.o=-objs)))    \
-$($(subst $(obj)/,,$(@:.o=-y)))), $^)
+find-src = $(foreach f, $1, $(wildcard $(f:.o=.c))) \
+           $(foreach f, $1, $(wildcard $(f:.o=.S)))
+
+link_multi_deps =  $(addprefix $(obj)/,         \
+                   $($(subst $(obj)/,,$(@:.o=-objs)))    \
+                   $($(subst $(obj)/,,$(@:.o=-y))))
  
 quiet_cmd_link_multi-y = LD      $@
 cmd_link_multi-y = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps)
 
 quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) $(LDFLAGS_MODULE) -o $@ $(link_multi_deps)
+#cmd_link_multi-m = $(LD) $(ld_flags) $(LDFLAGS_MODULE) -o $@ $(link_multi_deps)
+cmd_link_multi-m = $(CC) -v -nodefaultlibs $(c_flags)  -Wl,-r -Wl,-melf_x86_64\
+                   -o $@ $(call find-src, $(link_multi_deps))
 
 # We would rather have a list of rules like
 # 	foo.o: $(foo-objs)
@@ -299,13 +303,12 @@ cmd_link_multi-m = $(LD) $(ld_flags) $(L
 $(multi-used-y) : %.o: $(multi-objs-y) FORCE
 	$(call if_changed,link_multi-y)
 
-$(multi-used-m) : %.o: $(multi-objs-m) FORCE
+$(multi-used-m) : % : $(call find-src,$(multi-objs-m)) FORCE
 	$(call if_changed,link_multi-m)
 	@{ echo $(@:.o=.ko); echo $(link_multi_deps); } > $(MODVERDIR)/$(@F:.o=.mod)
 
 targets += $(multi-used-y) $(multi-used-m)
 
-
 # Descending
 # ---------------------------------------------------------------------------
 


