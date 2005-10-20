Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbVJTDXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbVJTDXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 23:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbVJTDXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 23:23:50 -0400
Received: from ozlabs.org ([203.10.76.45]:28614 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751720AbVJTDXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 23:23:49 -0400
Date: Thu, 20 Oct 2005 13:23:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel@lists.sourceforge.net, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix Kconfig performance bug
Message-ID: <20051020032342.GA11273@localhost.localdomain>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	kbuild-devel@lists.sourceforge.net, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kconfig performance bug

Roman, I'm pretty sure this patch is correct, but obviously someone
more familiar with the kconfig code should check it over.  If it's ok
(i.e. it makes no change in external behaviour), please apply.

When doing its recursive dependency check, scripts/kconfig/conf uses
the flag SYMBOL_CHECK_DONE to avoid rechecking a symbol it has already
checked.  However, that flag is only set at the top level, so if a
symbol is first encountered as a dependency of another symbol it will
be rechecked every time it is encountered until it's encountered at
the top level.

This patch adjusts the flag setting so that each symbol will only be
checked once, regardless of whether it is first encountered at the top
level, or while recursing down from another symbol.  On complex
configurations, this vastly speeds up scripts/kconfig/conf.  The
config in the powerpc merge tree is particularly bad: this patch
reduces the time for 'scripts/kconfig/conf -o arch/powerpc/Kconfig' by
a factor of 40 on a G5.  That's even including the time to print the
config, so the speedup in the actual checking is more likely 2 or 3
orders of magnitude.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/scripts/kconfig/symbol.c
===================================================================
--- working-2.6.orig/scripts/kconfig/symbol.c	2005-10-20 12:40:45.000000000 +1000
+++ working-2.6/scripts/kconfig/symbol.c	2005-10-20 12:41:43.000000000 +1000
@@ -758,6 +758,8 @@
 out:
 	if (sym2)
 		printf(" %s", sym->name);
+	else
+		sym->flags |= SYMBOL_CHECK_DONE;
 	sym->flags &= ~SYMBOL_CHECK;
 	return sym2;
 }
Index: working-2.6/scripts/kconfig/zconf.y
===================================================================
--- working-2.6.orig/scripts/kconfig/zconf.y	2005-10-20 12:40:45.000000000 +1000
+++ working-2.6/scripts/kconfig/zconf.y	2005-10-20 12:41:43.000000000 +1000
@@ -495,10 +495,9 @@
 		exit(1);
 	menu_finalize(&rootmenu);
 	for_all_symbols(i, sym) {
+/* 		fprintf(stderr, "Checking %s...\n", sym->name); */
                 if (!(sym->flags & SYMBOL_CHECKED) && sym_check_deps(sym))
                         printf("\n");
-		else
-			sym->flags |= SYMBOL_CHECK_DONE;
         }
 
 	sym_change_count = 1;
Index: working-2.6/scripts/kconfig/zconf.tab.c_shipped
===================================================================
--- working-2.6.orig/scripts/kconfig/zconf.tab.c_shipped	2005-10-12 17:10:16.000000000 +1000
+++ working-2.6/scripts/kconfig/zconf.tab.c_shipped	2005-10-20 13:01:50.000000000 +1000
@@ -1935,8 +1935,6 @@
 	for_all_symbols(i, sym) {
                 if (!(sym->flags & SYMBOL_CHECKED) && sym_check_deps(sym))
                         printf("\n");
-		else
-			sym->flags |= SYMBOL_CHECK_DONE;
         }
 
 	sym_change_count = 1;


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
