Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280787AbRKOJQ1>; Thu, 15 Nov 2001 04:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280790AbRKOJQQ>; Thu, 15 Nov 2001 04:16:16 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:44815 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280787AbRKOJQE>;
	Thu, 15 Nov 2001 04:16:04 -0500
Date: Thu, 15 Nov 2001 20:13:40 +1100
From: Anton Blanchard <anton@samba.org>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reiserfs gcc alias bug only on ppc32
Message-ID: <20011115201340.I22552@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The workaround in reiserfs for a gcc bug in some ppc32 compilers does
not affect the ppc64 compiler. A quick test to see stack usage for both
options shows:

gcc -O1
reiserfs_delete_solid_item: 976
reiserfs_rename: 960
reiserfs_cut_from_item: 880

gcc -O2
reiserfs_rename: 1008
reiserfs_delete_solid_item: 976
reiserfs_cut_from_item: 896

So there is no reason to compile reiserfs using -O1 on ppc64.

Anton


--- 2.4.15-pre4/fs/reiserfs/Makefile	Thu Nov 15 20:06:13 2001
+++ 2.4.15-pre4_work/fs/reiserfs/Makefile	Thu Nov 15 20:05:26 2001
@@ -13,13 +13,13 @@
 
 obj-m   := $(O_TARGET)
 
-# gcc -O2 (the kernel default)  is overaggressive on ppc when many inline
+# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
 # functions are used.  This causes the compiler to advance the stack
 # pointer out of the available stack space, corrupting kernel space,
-# and causing a panic. Since this behavior only affects ppc, this ifeq
+# and causing a panic. Since this behavior only affects ppc32, this ifeq
 # will work around it. If any other architecture displays this behavior,
 # add it here.
-ifeq ($(shell uname -m),ppc) 
+ifeq ($(CONFIG_PPC32),y)
 EXTRA_CFLAGS := -O1
 endif
 
