Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSIBCuq>; Sun, 1 Sep 2002 22:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSIBCuq>; Sun, 1 Sep 2002 22:50:46 -0400
Received: from dp.samba.org ([66.70.73.150]:15854 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316609AbSIBCup>;
	Sun, 1 Sep 2002 22:50:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix RELOC_HIDE miscompilation 
In-reply-to: Your message of "Sun, 01 Sep 2002 11:42:42 +0200."
             <20020901114242.21242@colin.muc.de> 
Date: Mon, 02 Sep 2002 12:11:28 +1000
Message-Id: <20020901215535.24D4C2C182@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020901114242.21242@colin.muc.de> you write:
> 
> [resend due to mailer problems]
> 
> RELOC_HIDE got miscompiled on gcc3.1/x86-64 in the access to softirq.c's per 
> cpu variables.  This patch fixes the problem.
> 
> Clearly to hide the relocation the addition needs to be done after the 
> value obfuscation, not before.
> 
> I don't know if it triggers on other architectures (x86-64 is especially 
> stressf here because it has negative kernel addresses), but seems like the 
> right thing to do.

Yes, agreed.  Linus, please apply.

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

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
