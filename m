Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSEQCVf>; Thu, 16 May 2002 22:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSEQCVe>; Thu, 16 May 2002 22:21:34 -0400
Received: from [202.135.142.194] ([202.135.142.194]:11271 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315282AbSEQCVd>; Thu, 16 May 2002 22:21:33 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ghozlane Toumi <ghoz@sympatico.ca>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: Your message of "Thu, 16 May 2002 12:27:55 -0400."
             <20020516162841.PYWL19243.tomts15-srv.bellnexxia.net@there> 
Date: Fri, 17 May 2002 12:25:05 +1000
Message-Id: <E178XQX-0000tw-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020516162841.PYWL19243.tomts15-srv.bellnexxia.net@there> you writ
e:
> Minor nit : any reason why you don't use  __stringify from 
> include/linux/stringify.h ?

Ignorance.  Mea culpa.  Linus, please apply.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/traps.c working-2.5.15-bug/arch/i386/kernel/traps.c
--- linux-2.5.15/arch/i386/kernel/traps.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.15-bug/arch/i386/kernel/traps.c	Fri May 17 12:23:06 2002
@@ -245,7 +245,7 @@
 {
 	unsigned short ud2;
 	unsigned short line;
-	char *file;
+	char *object, *func;
 	char c;
 	unsigned long eip;
 
@@ -262,11 +262,14 @@
 		goto no_bug;
 	if (__get_user(line, (unsigned short *)(eip + 2)))
 		goto bug;
-	if (__get_user(file, (char **)(eip + 4)) ||
-		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
-		file = "<bad filename>";
+	if (__get_user(object, (char **)(eip + 4)) ||
+		(unsigned long)object < PAGE_OFFSET || __get_user(c, object))
+		object = "<bad objectname>";
+	if (__get_user(func, (char **)(eip + 8)) ||
+		(unsigned long)func < PAGE_OFFSET || __get_user(c, func))
+		func = "<bad funcname>";
 
-	printk("kernel BUG at %s:%d!\n", file, line);
+	printk("kernel BUG at %s:%s:%d!\n", object, func, line);
 
 no_bug:
 	return;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/include/asm-i386/page.h working-2.5.15-bug/include/asm-i386/page.h
--- linux-2.5.15/include/asm-i386/page.h	Mon May  6 16:00:10 2002
+++ working-2.5.15-bug/include/asm-i386/page.h	Fri May 17 12:23:59 2002
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 #ifdef CONFIG_X86_USE_3DNOW
 
@@ -100,7 +101,10 @@
  __asm__ __volatile__(	"ud2\n"		\
 			"\t.word %c0\n"	\
 			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+			"\t.long %c2\n"	\
+			 : : "i" (__LINE__), \
+			"i" (__stringify(KBUILD_BASENAME)), \
+			"i" (__FUNCTION__))
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
