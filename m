Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSEPIFP>; Thu, 16 May 2002 04:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSEPIFO>; Thu, 16 May 2002 04:05:14 -0400
Received: from [202.135.142.194] ([202.135.142.194]:51470 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314448AbSEPIFN>; Thu, 16 May 2002 04:05:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix BUG macro
Date: Thu, 16 May 2002 18:08:43 +1000
Message-Id: <E178GJX-0005J5-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces filename with object name.  Sure, it's not as canonical, but
it means that ccache works across different directories (at the
moment, ccache gets almost no caceh hits when you compile in a
different dir).

Thanks to Stephen Rothwell for the inspiration,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.15/include/asm-i386/page.h working-2.5.15-rcu/include/asm-i386/page.h
--- linux-2.5.15/include/asm-i386/page.h	Wed May 15 19:53:25 2002
+++ working-2.5.15-rcu/include/asm-i386/page.h	Thu May 16 17:34:47 2002
@@ -96,11 +96,16 @@
  */
 
 #if 1	/* Set to zero for a slightly smaller kernel */
+#define __STRINGIZE2(x) #x
+#define __STRINGIZE(x) __STRINGIZE2(x)
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
 			"\t.word %c0\n"	\
 			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+			"\t.long %c2\n"	\
+			 : : "i" (__LINE__), \
+			"i" (__STRINGIZE(KBUILD_BASENAME)), \
+			"i" (__FUNCTION__))
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/traps.c working-2.5.15-rcu/arch/i386/kernel/traps.c
--- linux-2.5.15/arch/i386/kernel/traps.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.15-rcu/arch/i386/kernel/traps.c	Thu May 16 17:43:28 2002
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
