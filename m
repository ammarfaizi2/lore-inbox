Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289118AbSAJBwq>; Wed, 9 Jan 2002 20:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289119AbSAJBwh>; Wed, 9 Jan 2002 20:52:37 -0500
Received: from rj.SGI.COM ([204.94.215.100]:28840 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289118AbSAJBwT>;
	Wed, 9 Jan 2002 20:52:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it 
In-Reply-To: Your message of "Wed, 09 Jan 2002 17:32:20 MDT."
             <3C3CD304.9070704@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Jan 2002 12:52:05 +1100
Message-ID: <25006.1010627525@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jan 2002 17:32:20 -0600, 
Corey Minyard <minyard@acm.org> wrote:
>I'm working on a function that uses zlib in the kernel, and I know of 
>other places zlib is used (ppp_deflate, jffs2, mcore).  I would expect 
>more users to come along.
>
>I would like to propose putting zlib in the lib directory and making it 
>optionally compile if it is needed.  It's pretty easy to move the files 
>around and make a few small changes to the code.  However, how do I 
>configure such a thing?  I could add something like:

I am assuming that you can satisfy hpa's concerns about using a single
version of zlib for everybody.  Also note that arch/ppc/boot/lib has
its own version of zlib which is quite different to the others.  First
make sure that you can build one version of zlib that works for
everybody.

Configuring and linking zlib is a problem.  lib/lib.a is an archive
which means that the linker will only include zlib from lib.a if some
other code refers to zlib.  That breaks when all users of zlib are in
modules and nothing in vmlinux refers to zlib, the zlib code is not
linked into the kernel and modules get unresolved errors.  Linking
lib.a into the affected modules is not the solution either, the modules
would pick up all the code from lib.a instead of using the code in the
kernel with undefined results.

The best option is to build zlib.o for the kernel (not module) and
store it in lib.a.  Compile zlib.o if any consumer of zlib has been
selected and add a dummy reference to zlib code in vmlinux to ensure
that zlib is pulled from the archive if anybody needs it, even if all
the consumers are in modules.  Some of the zlib symbols will need to be
exported, I will leave that to you.

This should do the trick, completely untested.  It assumes that zlib.h
has been moved to to include/linux and zlib.c to lib.  Against 2.4.17.

Index: 17.1/lib/Makefile
--- 17.1/lib/Makefile Tue, 18 Sep 2001 13:43:44 +1000 kaos (linux-2.4/j/28_Makefile 1.1.4.3.3.2 644)
+++ 17.1(w)/lib/Makefile Thu, 10 Jan 2002 12:26:18 +1100 kaos (linux-2.4/j/28_Makefile 1.1.4.3.3.2 644)
@@ -8,12 +8,13 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o zlib.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+obj-$(CONFIG_ZLIB) += zlib.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
Index: 17.1/init/main.c
--- 17.1/init/main.c Sat, 01 Dec 2001 11:29:21 +1100 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3.1.8 644)
+++ 17.1(w)/init/main.c Thu, 10 Jan 2002 12:24:49 +1100 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3.1.8 644)
@@ -269,6 +269,11 @@ static struct dev_name_struct {
 	{ NULL, 0 }
 };
 
+#ifdef CONFIG_ZLIB
+#include <linux/zlib.h>
+static void *dummy_zlib_reference __initdata = &deflate;
+#endif
+
 kdev_t __init name_to_kdev_t(char *line)
 {
 	int base = 0;
Index: 17.1/Makefile
--- 17.1/Makefile Sat, 22 Dec 2001 12:56:52 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40 644)
+++ 17.1(w)/Makefile Thu, 10 Jan 2002 12:42:09 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40 644)
@@ -124,6 +124,21 @@ NETWORKS	=net/network.o
 LIBS		=$(TOPDIR)/lib/lib.a
 SUBDIRS		=kernel drivers mm fs net ipc lib
 
+# FIXME: make CONFIG_ZLIB a CML2 derived rule later and remove all references to
+# zlib from this file.  There is no clean place to handle this in CML1.  KAO
+export CONFIG_ZLIB
+ifneq ($(subst n,,$(CONFIG_JFFS2)$(CONFIG_PPP_DEFLATE)),)
+  CONFIG_ZLIB := y
+endif
+# FIXME: Use this if ppc/boot has been changed to use the common zlib.
+# ifeq ($(ARCH),ppc)
+#   CONFIG_ZLIB := y
+# endif
+# Kludge because CONFIG_ZLIB is not in include/linux/autoconf.h in CML1.
+ifeq ($(CONFIG_ZLIB),y)
+  CFLAGS += -DCONFIG_ZLIB=1
+endif
+
 DRIVERS-n :=
 DRIVERS-y :=
 DRIVERS-m :=

