Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276734AbRJHBLc>; Sun, 7 Oct 2001 21:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276736AbRJHBLN>; Sun, 7 Oct 2001 21:11:13 -0400
Received: from zok.SGI.COM ([204.94.215.101]:441 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276734AbRJHBLG>;
	Sun, 7 Oct 2001 21:11:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.11-pre5 
In-Reply-To: Your message of "Sun, 07 Oct 2001 22:49:09 +0200."
             <Pine.NEB.4.40.0110072235410.3783-200000@mimas.fachschaften.tu-muenchen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 11:11:15 +1000
Message-ID: <31815.1002503475@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001 22:49:09 +0200 (CEST), 
Adrian Bunk <bunk@fs.tum.de> wrote:
>I get the error below. Must likely there's a problem when you build a
>kernel without module support (my .config is attached).
>...
>gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o exec_domain.o exec_domain.c
>exec_domain.c: At top level:
>exec_domain.c:234: parse error before `this_object_must_be_defined_as_export_objs_in_the_Makefile'

My fault, Rules.make does not set EXPORT_SYMTAB for export-objs unless
the kernel is configured for modules.  The test for EXPORT_SYMTAB must
come after CONFIG_MODULES.  Against 2.4.11-pre5.

Index: 11-pre5.1/include/linux/module.h
--- 11-pre5.1/include/linux/module.h Mon, 08 Oct 2001 10:58:25 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6 644)
+++ 11-pre5.1(w)/include/linux/module.h Mon, 08 Oct 2001 11:08:09 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6 644)
@@ -348,19 +348,19 @@ extern struct module *module_list;
 #define EXPORT_SYMBOL_NOVERS(var)  error config_must_be_included_before_module
 #define EXPORT_SYMBOL_GPL(var)  error config_must_be_included_before_module
 
-#elif !defined(EXPORT_SYMTAB)
-
-#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
-#define EXPORT_SYMBOL(var)	   error this_object_must_be_defined_as_export_objs_in_the_Makefile
-#define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
-#define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
-
 #elif !defined(CONFIG_MODULES)
 
 #define __EXPORT_SYMBOL(sym,str)
 #define EXPORT_SYMBOL(var)
 #define EXPORT_SYMBOL_NOVERS(var)
 #define EXPORT_SYMBOL_GPL(var)
+
+#elif !defined(EXPORT_SYMTAB)
+
+#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL(var)	   error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
+#define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
 
 #else
 

