Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWCLRZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWCLRZV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWCLRZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:25:20 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:19394 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S1751647AbWCLRZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:25:19 -0500
Date: Sun, 12 Mar 2006 18:25:11 +0100
From: Petr Vandrovec <petr@vandrovec.name>
To: linux-kernel@vger.kernel.org
Cc: sam@ravenborg.org, kai@germaschewski.name
Subject: [PATCH] Do not rebuild full kernel tree again and again...
Message-ID: <20060312172511.GA17936@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I've returned back to the computer after month and half, and I've found that
I cannot reasonably build kernel - just repeating 'make' twice without doing any
change forced full rebuild of everything, which as far as I can tell is not 
intended behavior.  As I did not notice this being reported on the LKML, and
2.6.16-rc6 still suffers from this problem, here comes report + patch.

  Problem seems to be that new make includes FORCE prerequisite in $? - apparently
new make treats $? not as 'prerequisities newer than target', but as 
'prerequisities newer than target or missing'.  Due to this $(if) in make rules 
always succeeded as it always received at least 'FORCE', and 'FORCE'
is not an empty string.  So let's filter out 'FORCE' from $? - unless somebody
can confirm that make 3.81 is broken and unusable for kernel...
							Thanks,
								Petr Vandrovec


ppc:~# make -v
GNU Make 3.81rc1
Copyright (C) 2006  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

This program built for i486-pc-linux-gnu
ppc:~# dpkg -l make
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name            Version               Description
+++-===============-=====================-============================================
ii  make            3.80+3.81.rc1-1       The GNU version of the "make" utility.
ppc:~#

Signed-off-by:  Petr Vandrovec <petr@vandrovec.name>

diff -urdN linux/scripts/Kbuild.include linux/scripts/Kbuild.include
--- linux/scripts/Kbuild.include	2006-03-12 17:28:37.000000000 +0100
+++ linux/scripts/Kbuild.include	2006-03-12 17:55:53.000000000 +0100
@@ -79,7 +79,7 @@
 # >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
 # note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
 # 
-if_changed = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
+if_changed = $(if $(strip $(filter-out FORCE,$?) $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
 	@set -e; \
 	$(echo-cmd) \
 	$(cmd_$(1)); \
@@ -87,7 +87,7 @@
 
 # execute the command and also postprocess generated .d dependencies
 # file
-if_changed_dep = $(if $(strip $? $(filter-out FORCE $(wildcard $^),$^)\
+if_changed_dep = $(if $(strip $(filter-out FORCE,$? $(filter-out $(wildcard $^),$^))\
 	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),                  \
 	@set -e; \
 	$(echo-cmd) \
@@ -99,6 +99,6 @@
 # Usage: $(call if_changed_rule,foo)
 # will check if $(cmd_foo) changed, or any of the prequisites changed,
 # and if so will execute $(rule_foo)
-if_changed_rule = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
+if_changed_rule = $(if $(strip $(filter-out FORCE,$?) $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
 			@set -e; \
 			$(rule_$(1)))
