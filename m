Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbULPVRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbULPVRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbULPVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:17:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262030AbULPVR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:17:29 -0500
Date: Thu, 16 Dec 2004 22:17:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill IN_STRING_C (fwd)
Message-ID: <20041216211723.GQ12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc3-mm1.

With -ffreestanding it shouldn't even cause any problems in case we'd 
one day drop the -fno-unit-at-a-time (which caused the problems Andi 
dobserved on X86_64).

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 7 Nov 2004 15:24:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill IN_STRING_C

Hi Andi,

some months ago, you invented a IN_STRING_C with the following comment:

<--  snip  -->

gcc 3.4 optimizes sprintf(foo,"%s",string) into strcpy.  

Unfortunately that isn't seen by the inliner and linux/i386 has no 
out-of-line strcpy so you end up with a linker error.

This patch adds out of line copies for most string functions to avoid 
this.
...

<--  snip  -->


I tried 2.6.10-rc1-mm3 with gcc 3.4.2 and the patch below and didn't 
observe the problems you described.


Can you still reproduce this problem?
If not, I'll suggest to apply the patch below which saves a few kB in 
lib/string.o .



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/asm-i386/string.h.old	2004-11-07 13:27:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/asm-i386/string.h	2004-11-07 13:28:47.000000000 +0100
@@ -25,7 +25,6 @@
 
 /* AK: in fact I bet it would be better to move this stuff all out of line.
  */
-#if !defined(IN_STRING_C)
 
 #define __HAVE_ARCH_STRCPY
 static inline char * strcpy(char * dest,const char *src)
@@ -180,8 +179,6 @@
 return __res;
 }
 
-#endif
-
 #define __HAVE_ARCH_STRLEN
 static inline size_t strlen(const char * s)
 {
--- linux-2.6.10-rc1-mm3-full/lib/string.c.old	2004-11-07 13:29:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/lib/string.c	2004-11-07 13:29:05.000000000 +0100
@@ -19,8 +19,6 @@
  * -  Kissed strtok() goodbye
  */
 
-#define IN_STRING_C 1
- 
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

