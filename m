Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271715AbTGRCEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271716AbTGRCEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:04:31 -0400
Received: from dp.samba.org ([66.70.73.150]:41606 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271715AbTGRCEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:04:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, rth@twiddle.net
Subject: [PATCH] Re-xmit: make gcc 3.3 eliminate unused static functions
Date: Fri, 18 Jul 2003 12:18:30 +1000
Message-Id: <20030718021916.48EFB2C28E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags to allow gcc to elimiante unused static functions.  My
default build doesn't have any, but if you turn off eg. CONFIG_PROC_FS
you get them.

Name: Eliminate Unused Functions
Author: Rusty Russell
Status: Tested on 2.5.70-bk16

D: GCC 3.3 has the ability to eliminate unused static functions.  This includes
D: code like this:
D:
D: static int unusedfunc(void) { ... };
D: int otherfunc(void)
D: {
D:         (void)unusedfunc;
D: ...
D: 
D: This means that macros can suppress the "unused" warning on functions
D: without preventing the function elimination.  This should allow us to
D: remove a number of #ifdefs around unused functions.
D:
D: Unfortunately, this elimination is only performed if
D: -finline-functions is used.  In order to prevent GCC automatically
D: inlining anything, we also specify "--param max-inline-insns-auto=0".
D:
D: Earlier compilers don't understand this parameter, so we test for
D: it at build time.
D:
D: Results:
D:   gcc 3.3 without patch:
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:17 vmlinux
D:   gcc 3.3 with patch:
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:58 vmlinux
D:   gcc 3.3 without patch (small unused function added):
D:       -rwxrwxr-x    1 rusty    rusty     5115195 Jun 13 10:14 vmlinux
D:   gcc 3.3 with patch (small unused function added):
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 10:15 vmlinux

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.70-bk16-check_region/Makefile working-2.5.70-bk16-check_region-inline/Makefile
--- working-2.5.70-bk16-check_region/Makefile	2003-06-12 09:57:39.000000000 +1000
+++ working-2.5.70-bk16-check_region-inline/Makefile	2003-06-12 21:34:40.000000000 +1000
@@ -213,10 +213,12 @@ CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
+# Needs gcc 3.3 or above to understand max-inline-insns-auto.
+INLINE_OPTS	:= $(shell $(CC) -o /non/existent/file -c --param max-inline-insns-auto=0 -xc /dev/null 2>&1 | grep /non/existent/file >/dev/null && echo -finline-functions --param max-inline-insns-auto=0)
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  	   -fno-strict-aliasing -fno-common
+	  	   $(INLINE_OPTS) -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
