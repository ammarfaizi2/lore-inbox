Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSK1CW7>; Wed, 27 Nov 2002 21:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSK1CW7>; Wed, 27 Nov 2002 21:22:59 -0500
Received: from dp.samba.org ([66.70.73.150]:15797 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265097AbSK1CW5>;
	Wed, 27 Nov 2002 21:22:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: rth@twiddle.net, jfbeam@bluetronic.net,
       "Adam J. Richter" <adam@freya.yggdrasil.com>,
       SL Baur <steve@kbuxd.necst.nec.co.jp>,
       Petr Vandrovec <vandrove@vc.cvut.cz>, Chris Cheney <ccheney@debian.org>,
       David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       torvalds@transmeta.com
Subject: [RELEASE] module-init-tools 0.8
Date: Thu, 28 Nov 2002 13:28:49 +1100
Message-Id: <20021128023017.91FAC2C250@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Linus, please apply patch! ]

	http://www.[cc].kernel.org/pub/linux/kernel/people/rusty/modules

(Source RPM untested, but not markedly different from previous one).

This release needs depmod again, which should help speed for those of
you with 1300 modules.  A replacement depmod is provided, since the
previous one gets rightfully confused by 2.5.47+ kernels.  You will
require a small kernel patch to 2.5.50 (below) for PCI and USB tables
to work.

Also included is modules.conf2modprobe.conf, which is fairly
simplistic but should get most people up and running.  This will be
enhanced as new features go into the new modprobe.

Some dummy options are implemented, and "modprobe -c" is implemented
too, which should help Mandrake and RedHat's init scripts deal with
the change.

Many thanks to those who provided patches, bug reports, and copies of
their init scripts.  Your feedback is greatly appreciated!

Please report any bugs to rusty@rustcorp.com.au.

Thanks!
Rusty.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.50/include/linux/module.h working-2.5.50-table/include/linux/module.h
--- linux-2.5.50/include/linux/module.h	Mon Nov 25 08:44:18 2002
+++ working-2.5.50-table/include/linux/module.h	Thu Nov 28 10:59:39 2002
@@ -14,7 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/cache.h>
 #include <linux/kmod.h>
-#include <linux/elf.h>
+#include <linux/stringify.h>
 
 #include <asm/module.h>
 #include <asm/uaccess.h> /* For struct exception_table_entry */
@@ -40,11 +40,14 @@ struct kernel_symbol
 
 #ifdef MODULE
 
-#define MODULE_GENERIC_TABLE(gtype,name)	\
-static const unsigned long __module_##gtype##_size \
-  __attribute__ ((unused)) = sizeof(struct gtype##_id); \
-static const struct gtype##_id * __module_##gtype##_table \
-  __attribute__ ((unused)) = name
+/* For replacement modutils, use an alias not a pointer. */
+#define MODULE_GENERIC_TABLE(gtype,name)			\
+static const unsigned long __module_##gtype##_size		\
+  __attribute__ ((unused)) = sizeof(struct gtype##_id);		\
+static const struct gtype##_id * __module_##gtype##_table	\
+  __attribute__ ((unused)) = name;				\
+extern const struct gtype##_id __mod_##gtype##_table		\
+  __attribute__ ((unused, alias(__stringify(name))))
 
 /* This is magically filled in by the linker, but THIS_MODULE must be
    a constant so it works in initializers. */
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
