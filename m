Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSIAJic>; Sun, 1 Sep 2002 05:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSIAJic>; Sun, 1 Sep 2002 05:38:32 -0400
Received: from colin.muc.de ([193.149.48.1]:62731 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S315437AbSIAJib>;
	Sun, 1 Sep 2002 05:38:31 -0400
Message-ID: <20020901114242.21242@colin.muc.de>
Date: Sun, 1 Sep 2002 11:42:42 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Paul.Russell@rustcorp.com.au
Subject: [PATCH] Fix RELOC_HIDE miscompilation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[resend due to mailer problems]

RELOC_HIDE got miscompiled on gcc3.1/x86-64 in the access to softirq.c's per 
cpu variables.  This patch fixes the problem.

Clearly to hide the relocation the addition needs to be done after the 
value obfuscation, not before.

I don't know if it triggers on other architectures (x86-64 is especially 
stressf here because it has negative kernel addresses), but seems like the 
right thing to do.

Also does the arithmetic in unsigned long to avoid undue assumptions of the 
comp for pointers.

-Andi

--- linux/include/linux/compiler.h-o	Sun Apr 14 21:18:44 2002
+++ linux/include/linux/compiler.h	Sun Sep  1 02:52:31 2002
@@ -16,7 +16,7 @@
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
 #define RELOC_HIDE(ptr, off)					\
-  ({ __typeof__(ptr) __ptr;					\
-    __asm__ ("" : "=g"(__ptr) : "0"((void *)(ptr) + (off)));	\
-    __ptr; })
+  ({ unsigned long __ptr;					\
+    __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
+    (typeof(ptr)) (__ptr + (off)); })
 #endif /* __LINUX_COMPILER_H */
