Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTFGHVT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTFGHVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:21:19 -0400
Received: from mail009.syd.optusnet.com.au ([210.49.20.137]:7375 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262633AbTFGHVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:21:17 -0400
Date: Sat, 7 Jun 2003 17:33:21 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: [EVIL-PATCH] getting rid of lib/lib.a and breaking many archs in the processes (was Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols)
Message-ID: <20030607073321.GC1540@cancer>
References: <20030604153224.GF19929@gtf.org> <Pine.LNX.4.44.0306040838370.13753-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306040838370.13753-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 08:41:59AM -0700, Linus Torvalds wrote:
> On Wed, 4 Jun 2003, Jeff Garzik wrote:
> > Any opinions on moving it out of lib/lib.a?
>
> That makes sense. lib/lib.a wasn't ever _that_ sensible, since we only 
> really include object files in it that we know should be linked in. The 
> linker really does know less than the build system, and in this case that 
> seems to be causing a real bug.

This patch needs a couple of extra things before it drops it's evil status, and I'm not sure how to do them exactly.

Instead of going the lib/lib.a route (which I presume was used so that the linker could decide weather to go with arch specific functions or the generic lib/ ones) it leaves it up to the arch to sort it all out. This could be fair enough, as most (14/20) archs seem to implement their own dump_stack anyway. However, bust_spinlocks could be a problem as only i386, mips64, x86_64 and s390 specfically implement it.

Is it a good idea to make the archs themselves include the generic implementation if they don't do it themselves? Or is there a way to detect this in the build system (this would be more elegant, but I have no idea how to do it).

Evil patch that will probably break 16 archs from compiling follows:

diff -urN linux-2.5.70-bk11-orig/Makefile linux-2.5.70-bk11stew1/Makefile
--- linux-2.5.70-bk11-orig/Makefile	2003-06-06 23:55:42.000000000 +1000
+++ linux-2.5.70-bk11stew1/Makefile	2003-06-07 01:09:05.000000000 +1000
@@ -288,7 +288,7 @@
 core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
 drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
 net-y		:= $(patsubst %/, %/built-in.o, $(net-y))
-libs-y		:= $(patsubst %/, %/lib.a, $(libs-y))
+libs-y		:= $(patsubst %/, %/built-in.o, $(libs-y))
 
 ifdef include_config
 
diff -urN linux-2.5.70-bk11-orig/arch/i386/lib/Makefile linux-2.5.70-bk11stew1/arch/i386/lib/Makefile
--- linux-2.5.70-bk11-orig/arch/i386/lib/Makefile	2003-05-05 09:53:01.000000000 +1000
+++ linux-2.5.70-bk11stew1/arch/i386/lib/Makefile	2003-06-07 17:22:39.000000000 +1000
@@ -2,8 +2,6 @@
 # Makefile for i386-specific library files..
 #
 
-L_TARGET = lib.a
-
 obj-y = checksum.o delay.o \
 	usercopy.o getuser.o \
 	memcpy.o strstr.o
diff -urN linux-2.5.70-bk11-orig/lib/Makefile linux-2.5.70-bk11stew1/lib/Makefile
--- linux-2.5.70-bk11-orig/lib/Makefile	2003-06-02 23:28:32.000000000 +1000
+++ linux-2.5.70-bk11stew1/lib/Makefile	2003-06-07 17:21:44.000000000 +1000
@@ -6,10 +6,8 @@
 # unless it's something special (ie not a .c file).
 #
 
-L_TARGET := lib.a
-
 obj-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
-	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
+	 rbtree.o radix-tree.o \
 	 kobject.o idr.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o

