Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTFMAD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 20:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTFMAD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 20:03:58 -0400
Received: from dp.samba.org ([66.70.73.150]:53716 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265069AbTFMAD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 20:03:57 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
Date: Fri, 13 Jun 2003 10:17:05 +1000
Message-Id: <20030613001743.8952F2C23B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In discussions with akpm: it'd be nice to discard unused functions
(think CONFIG_PROC_FS=n) without needing to #ifdef around them.

Feedback welcome,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

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
D: Results (all with gcc 3.3)
D:   Without patch:
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:17 vmlinux
D:   With patch:
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 09:58 vmlinux
D:   Without patch (small unused function added):
D:       -rwxrwxr-x    1 rusty    rusty     5115195 Jun 13 10:14 vmlinux
D:   With patch (small unused function added):
D:       -rwxrwxr-x    1 rusty    rusty     5115166 Jun 13 10:15 vmlinux

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.70-bk16-check_region/Makefile working-2.5.70-bk16-check_region-inline/Makefile
--- working-2.5.70-bk16-check_region/Makefile	2003-06-12 09:57:39.000000000 +1000
+++ working-2.5.70-bk16-check_region-inline/Makefile	2003-06-12 21:34:40.000000000 +1000
@@ -213,10 +213,13 @@ CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
+# Needs gcc 3.3 or above to understand max-inline-insns-auto.
+INLINE_OPTS	:= $(shell $(CC) -o /non/existent/file -c --param max-inline-insns-auto=0 -xc /dev/null 2>&1 | grep /non/existent/file >/dev/null && echo -finline-functions --param max-inline-insns-auto=0)
 
+-finline-functions --param max-inline-insns-auto=0
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
 CFLAGS 		:= $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  	   -fno-strict-aliasing -fno-common
+	  	   $(INLINE_OPTS) -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
