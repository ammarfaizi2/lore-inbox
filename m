Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbVCEQtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVCEQtJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVCEQtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:49:08 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:25992 "EHLO
	chaos.sr.unh.edu") by vger.kernel.org with ESMTP id S263077AbVCEQhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:37:40 -0500
Date: Sat, 5 Mar 2005 11:36:23 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Adrian Bunk <bunk@stusta.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>,
       <keenanpepper@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
In-Reply-To: <20050305153638.GD6373@stusta.de>
Message-ID: <Pine.LNX.4.44.0503051108300.20560-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2005, Adrian Bunk wrote:

> This warning sounds like a good plan (but it won't let many objects stay 
> inside lib-y).

The patch is simple (except that the warning it throws looks rather ugly), 
see appended.

However, I spoke too soon. There actually is a legitimate use for 
EXPORT_SYMBOL() in a lib-y object, e.g. lib/dump_stack.c. This provides a 
default implementation for dump_stack(). Most archs provide their own 
implementation (and EXPORT_SYMBOL() it), and in this case we definitely 
want the default version in lib to be thrown away, including its 
EXPORT_SYMBOL. So the appended patch throws false positives and thus can 
not be applied.

Still, many files in lib-y "should" be moved to obj-y. Then again, the 
clear cases (e.g. ctype, vsnprintf) are getting used in the static kernel 
image, so they get linked in anyway, moving them from lib-y to obj-y 
doesn't make any difference whatsoever.

The interesting cases are more of the crc32 type -- some people may not 
use this at all, so they want the space savings. Moving all of those into 
obj-y unconditionally creates unnecessary bloat. Actually, crc32 already 
did the right thing -- a config option. That would work for parser.o, too, 
just make the filesystems which need it "select CONFIG_PARSER".

I think there are basically three cases of objects in lib-y:

o functions we clearly use anyway, e.g. vsprintf.o.
  these should be always available, also for modules (pretty much every
  module uses printk, right?)
  So these should be in obj-y, however since they always get used in the
  kernel, too, independent of the .config, in practice there's no 
  difference to them being in lib-y.
o "weak" implementations, which may be overwritten by a arch-specific
  implementation.
  These need to be in lib-y for this mechanism to work.
o Marginal cases like crc32.o, parser.o, bitmap.o
  There are real world cases out there where these functions will never be 
  used, so just compiling them into the kernel because one day there may 
  be a module which wants to use them does cause some bloat. Making them
  config options and have every module which needs them mention them in
  Kconfig causes some bloat on the source side.
  It's a trade-off. In my tree (current -bk), parser.o symbols are
  referenced by procfs, i.e. 99.9% of all builds will pull it in anyway.
  So putting it into obj-y is a good solution, IMO. (Do I hear the 
  embedded people cry?)
  I guess in -mm this changed, which may justify going to CONFIG_PARSER
  (along the lines of CONFIG_CRC32) way. Then again, .text of
  parser.o is 0x373 bytes on my x86_64 system. Not a whole lot to
  lose when it's compiled in unconditionally. (And it's used among others 
  by ext2 and ext3, so chances are, you need it anyway)
 

--Kai

===== include/linux/module.h 1.92 vs edited =====
--- 1.92/include/linux/module.h	2005-01-10 14:28:15 -05:00
+++ edited/include/linux/module.h	2005-03-05 10:49:05 -05:00
@@ -200,10 +200,18 @@
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #define EXPORT_SYMBOL(sym)					\
+        __EXPORT_SYMBOL_WARN					\
 	__EXPORT_SYMBOL(sym, "")
 
 #define EXPORT_SYMBOL_GPL(sym)					\
+        __EXPORT_SYMBOL_WARN					\
 	__EXPORT_SYMBOL(sym, "_gpl")
+
+#ifdef KBUILD_LIB
+#define __EXPORT_SYMBOL_WARN DO_NOT_USE_EXPORT_SYMBOL_IN_LIBRARY_FILES;
+#else
+#define __EXPORT_SYMBOL_WARN
+#endif
 
 #endif
 
===== scripts/Makefile.build 1.53 vs edited =====
--- 1.53/scripts/Makefile.build	2004-12-28 18:15:17 -05:00
+++ edited/scripts/Makefile.build	2005-03-05 10:34:44 -05:00
@@ -105,6 +105,8 @@
 $(real-objs-m:.o=.s)  : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.lst): modkern_cflags := $(CFLAGS_MODULE)
 
+$(lib-y)              : lib_cflags := -DKBUILD_LIB
+
 $(real-objs-m)        : quiet_modtag := [M]
 $(real-objs-m:.o=.i)  : quiet_modtag := [M]
 $(real-objs-m:.o=.s)  : quiet_modtag := [M]
===== scripts/Makefile.lib 1.27 vs edited =====
--- 1.27/scripts/Makefile.lib	2004-10-26 18:06:46 -04:00
+++ edited/scripts/Makefile.lib	2005-03-05 10:33:38 -05:00
@@ -126,7 +126,7 @@
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
-		 $(__c_flags) $(modkern_cflags) \
+		 $(__c_flags) $(modkern_cflags) $(lib_cflags) \
 		 $(basename_flags) $(modname_flags)
 
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \

