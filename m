Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSFQOaV>; Mon, 17 Jun 2002 10:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSFQOaU>; Mon, 17 Jun 2002 10:30:20 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:58319 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314080AbSFQOaP>; Mon, 17 Jun 2002 10:30:15 -0400
Date: Mon, 17 Jun 2002 09:30:13 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 broke modversions
In-Reply-To: <200206171232.OAA00172@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0206170925160.22308-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Mikael Pettersson wrote:

> Something in the 2.5.22 Makefile/Rule.make changes broke
> modversions on my P4 box. For some reason, a number of
> exporting objects, including arch/i386/kernel/i386_ksyms,
> weren't given -D__GENKSYMS__ at genksym-time, with the
> effect that the resulting .ver files became empty, and the
> kernel exported the symbols with unexpanded _R__ver_ suffixes.

You're right, thanks for the report. The fix is appended ;)

> Modversions worked in 2.5.21. I didn't see anything obvious
> in patch-2.5.22 what could explain this, but I did notice a
> tendency of touching files as a means of maintaining dependencies.
> This may not actually work, unless you have a slow CPU or a
> file system with millisecond or better st_mtime resolution --
> most only maintain whole-second resolution st_mtimes.
> (My modversions fix in the 2.4.0-test series, which moved the
> modversions.h creation/update to a separate rule after make dep,
> was due to this very problem.)

I'm using touch in one place, as an optimization. For all I can see it
should be fine unless you run more than one complete build per second ;)

(Whenever a .ver file is updated, include/linux/modversions.h is touched,
 so that during the build make only needs to check the timestamp
 of modversions.h instead of all the individual .ver files - do you see a
 problem with that?)

--Kai

===== Rules.make 1.59 vs edited =====
--- 1.59/Rules.make	Mon Jun 10 21:59:33 2002
+++ edited/Rules.make	Mon Jun 17 09:24:34 2002
@@ -131,9 +131,9 @@
 	genksyms_smp_prefix := 
 endif
 
-$(MODVERDIR)/$(real-objs-y:.o=.ver): modkern_cflags := $(CFLAGS_KERNEL)
-$(MODVERDIR)/$(real-objs-m:.o=.ver): modkern_cflags := $(CFLAGS_MODULE)
-$(MODVERDIR)/$(export-objs:.o=.ver): export_flags   := -D__GENKSYMS__
+$(addprefix $(MODVERDIR)/,$(real-objs-y:.o=.ver)): modkern_cflags := $(CFLAGS_KERNEL)
+$(addprefix $(MODVERDIR)/,$(real-objs-m:.o=.ver)): modkern_cflags := $(CFLAGS_MODULE)
+$(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver)): export_flags   := -D__GENKSYMS__
 
 c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \

