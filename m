Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758519AbWLBTpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758519AbWLBTpm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162484AbWLBTpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:45:42 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:48545 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1759471AbWLBTpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:45:41 -0500
From: Daniel Drake <dsd@gentoo.org>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Cc: miraze@web.de
Subject: [PATCH] kbuild: Write astest files to $(KBUILD_EXTMOD) directory
Message-Id: <20061202194544.D9F057B40A0@zog.reactivated.net>
Date: Sat,  2 Dec 2006 19:45:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The astest code in 2.6.19 causes problems for Gentoo and other distributions
building external kernel modules in sandboxes. kbuild has generally been
pretty good at not violating the sandbox for quite a while, I hope we can
keep it that way.

Right now it writes to a temporary astest file in the current directory
(i.e. /usr/src/linux), this is because it is found that writing to /dev/null
is not safe because as deletes its output file on failure.

To clarify what a sandbox is: Gentoo's package system compiles the package
in /var/tmp/portage and while that package is building it restricts writes
to parts of the filesystem outside of /var/tmp/portage and /tmp. If the
external module tries to write to another location on the real filesystem such
as /usr/src/linux, the build is aborted due to sandbox violation.

This patch prefixes the astest file path with the KBUILD_EXTMOD path if
an external kernel module is being built. The behaviour in other situations
is unmodified.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux-2.6.19/scripts/Kbuild.include
===================================================================
--- linux-2.6.19.orig/scripts/Kbuild.include
+++ linux-2.6.19/scripts/Kbuild.include
@@ -66,9 +66,11 @@ as-option = $(shell if $(CC) $(CFLAGS) $
 # as-instr
 # Usage: cflags-y += $(call as-instr, instr, option1, option2)
 
-as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o astest$$$$.out ; \
+as-instr = $(shell if echo -e "$(1)" | $(AS) >/dev/null 2>&1 -W -Z -o \
+		   $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)astest$$$$.out ; \
 		   then echo "$(2)"; else echo "$(3)"; fi; \
-	           rm -f astest$$$$.out)
+	           rm -f \
+		   $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)astest$$$$.out)
 
 # cc-option
 # Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
