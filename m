Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268710AbUJVXSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268710AbUJVXSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268399AbUJVXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:17:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:14755 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268379AbUJVXKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:13 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <20041022230900.GA27093@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 22 Oct 2004 16:09:31 -0700
Message-Id: <10984865712136@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2000.6.1, 2004/10/20 15:38:19-07:00, greg@kroah.com

kobject: add CONFIG_DEBUG_KOBJECT

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/Kconfig.debug |    7 +++++++
 lib/Makefile      |    6 +++++-
 lib/kobject.c     |    4 +---
 3 files changed, 13 insertions(+), 4 deletions(-)


diff -Nru a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug	2004-10-22 16:00:44 -07:00
+++ b/lib/Kconfig.debug	2004-10-22 16:00:44 -07:00
@@ -64,6 +64,13 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config DEBUG_KOBJECT
+	bool "kobject debugging"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, some extra kobject debugging messages will be sent
+	  to the syslog. 
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM && (X86 || PPC32 || MIPS || SPARC32)
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	2004-10-22 16:00:44 -07:00
+++ b/lib/Makefile	2004-10-22 16:00:44 -07:00
@@ -2,11 +2,15 @@
 # Makefile for some libs needed in the kernel.
 #
 
-
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
 	 bitmap.o extable.o kobject_uevent.o
+
+ifeq ($(CONFIG_DEBUG_KOBJECT),y)
+CFLAGS_kobject.o += -DDEBUG
+CFLAGS_kobject_uevent.o += -DDEBUG
+endif
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-10-22 16:00:44 -07:00
+++ b/lib/kobject.c	2004-10-22 16:00:44 -07:00
@@ -10,8 +10,6 @@
  * about using the kobject interface.
  */
 
-#undef DEBUG
-
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/module.h>
@@ -123,7 +121,7 @@
  */
 void kobject_init(struct kobject * kobj)
 {
- 	kref_init(&kobj->kref);
+	kref_init(&kobj->kref);
 	INIT_LIST_HEAD(&kobj->entry);
 	kobj->kset = kset_get(kobj->kset);
 }

