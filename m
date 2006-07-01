Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWGAJRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWGAJRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWGAJRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:17:00 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:11792 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S932469AbWGAJRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:17:00 -0400
Date: Sat, 1 Jul 2006 04:16:56 -0500 (CDT)
Message-Id: <200607010916.k619GuxT005076@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [KBUILD] allow any PHONY in if_changed_dep
To: Sam Ravnborg <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While all the if_changed family filter $(PHONY) from the list of newer
files, if_changed_dep was only filtering FORCE from the list of all
dependents.  This resulted in forced recompile every time.

Signed-off-by: Milton Miller <miltonm@bga.com>

--- 

Sam,

I have been working on some cleanups in arch/powerpc/boot/Makefile,
switching to if_changed and friends.  There are rules to copy headers
from the kernel environment to the boot environment, applying slight
cleanups.

Currently a subset of the c files depend on the headers, and there is
a manual dependency on the headers.  I was trying to get if_changed_dep
to depend only on the headers actually used, but copy all needed headers
before compiling any C files in the zImage code.  

Does the following patch look ok to you?   It removes all PHONY targets
from the list of all dependents, not just FORCE.  I'm thinking the clause
is to catch files haven't been generated and therefore are not newer but
are still required.  If you want to build every time you can just call cmd.

milton

Two excerpts from the proposed makefile follow:

> -$(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
> -#$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
> +linuxheader := zlib.h zconf.h zutil.h
> 
> [ $(obj-boot): %.o: %.c ]
>
> +$(obj-boot):  COPYHEADERS
> +COPYHEADERS:	$(addprefix $(obj)/,$(linuxheader) $(zlibheader))
> +PHONY	+= COPYHEADERS


Index: kernel/scripts/Kbuild.include
===================================================================
--- kernel.orig/scripts/Kbuild.include	2006-07-01 00:58:38.926249877 -0500
+++ kernel/scripts/Kbuild.include	2006-07-01 01:02:00.909937514 -0500
@@ -131,7 +131,7 @@ if_changed = $(if $(strip $(filter-out $
 # execute the command and also postprocess generated .d dependencies
 # file
 if_changed_dep = $(if $(strip $(filter-out $(PHONY),$?)  \
-		$(filter-out FORCE $(wildcard $^),$^)    \
+		$(filter-out $(PHONY) $(wildcard $^),$^)    \
 	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),     \
 	@set -e; \
 	$(echo-cmd) $(cmd_$(1)); \
