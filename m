Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266918AbSK2BYI>; Thu, 28 Nov 2002 20:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266923AbSK2BXc>; Thu, 28 Nov 2002 20:23:32 -0500
Received: from dp.samba.org ([66.70.73.150]:26297 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266918AbSK2BWs>;
	Thu, 28 Nov 2002 20:22:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and table support 
In-reply-to: Your message of "Wed, 27 Nov 2002 22:44:24 -0800."
             <3DE5BB48.5090606@pacbell.net> 
Date: Fri, 29 Nov 2002 12:28:57 +1100
Message-Id: <20021129013010.485E12C2E3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DE5BB48.5090606@pacbell.net> you write:
> Rusty Russell wrote:
> > In message <3DE53EF6.4080303@pacbell.net> you write:
> > 
> >>One of the points being that the breakage comes from changing the
> >>format supported by modutils.  Restoring current functionality should
> >>IMO be high on the agenda .... USB has worked poorly in normal .configs
> >>for a while now, because of this.
> > 
> > 
> > Absolutely.  I sent the patch to put the USB etc. tables back in
> > (merged in .48 IIRC).
> 
> Hmm, with 2.5.50 and module-init-tools 0.8a two "modules.*map" files
> are created -- but they're empty.  That's with the latest 2.5 modutils
> 
>    http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> 
> So that's not quite working yet.

Yes, there's a patch in the NEWS file, which is referred to at the top
of the README file.  Did you apply it?  If not, apply the one below
(which doesn't delete the #include <linux/elf.h>, which broke
CONFIG_KALLSYMS=y).

Hope this helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module Table Support for module-init-tools depmod
Author: Rusty Russell
Status: Tested on 2.5.50

D: This patch adds a "__mod_XXX_table" symbol which is an alias to the
D: module table, rather than a pointer.  This makes it relatively
D: trivial to extract the table.  Previously, it required a pointer
D: dereference, which means the relocations must be applied, which is
D: why the old depmod needs so much of modutils (ie. it basically
D: links the whole module in order to find the table).
D:
D: The old depmod can still be invoked using "-F System.map" to
D: generate the tables (there'll be lots of other warnings, and it
D: will generate a completely bogus modules.dep, but the tables should
D: be OK.)

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.50/include/linux/module.h working-2.5.50-table/include/linux/module.h
--- linux-2.5.50/include/linux/module.h	Mon Nov 25 08:44:18 2002
+++ working-2.5.50-table/include/linux/module.h	Thu Nov 28 10:59:39 2002
@@ -14,6 +14,7 @@
 #include <linux/cache.h>
 #include <linux/kmod.h>
 #include <linux/elf.h>
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
