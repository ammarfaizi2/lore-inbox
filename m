Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLWJz5>; Sat, 23 Dec 2000 04:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLWJzs>; Sat, 23 Dec 2000 04:55:48 -0500
Received: from [210.77.38.126] ([210.77.38.126]:29447 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S129260AbQLWJze>; Sat, 23 Dec 2000 04:55:34 -0500
Date: Thu, 23 Dec 1999 17:24:43 +0800
From: michael chen <linux-kernel@vger.kernel.org>
X-Mailer: The Bat! (v1.48) UNREG / CD5BF9353B3B7091
Reply-To: Michael Chen <michaelc@turbolinux.com.cn>
Organization: linux kernel mailing list
X-Priority: 3 (Normal)
Message-ID: <4015029078.19991223172443@turbolinux.com.cn>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: About Celeron processor memory barrier problem
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
        I found that when I compiled the 2.4 kernel with the option
    of Pentium III or Pentium 4 on a Celeron's PC, it could cause  the
    system hang at very beginning boot stage, and I found the problem
    is cause by the fact that Intel Celeron doesn't have a real memory
    barrier,but when you choose the Pentium III option, the kernel
    assume the processor has a real memory barrier.
    Here is a patch to fix it:

    Merry Christmas :)
    Michael Chen

diff -Nur linux/include/asm-i386/system.h linux.new/include/asm-i386/system.h
--- linux/include/asm-i386/system.h     Mon Dec 11 19:26:39 2000
+++ linux.new/include/asm-i386/system.h Sat Dec 23 16:06:01 2000
@@ -274,7 +274,14 @@
 #ifndef CONFIG_X86_XMM
 #define mb()   __asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
-#define mb()   __asm__ __volatile__ ("sfence": : :"memory")
+#define mb()  do { \
+       if ( cpu_has_xmm ) { \
+               asm volatile("sfence": : :"memory"); \
+       } \
+       else { \
+               asm volatile("lock; addl $0,0(%%esp)": : :"memory"); \
+       } \
+} while (0)                                                            
 #endif
 #define rmb()  mb()
 #define wmb()  __asm__ __volatile__ ("": : :"memory")
diff -Nur linux/include/linux/tqueue.h linux.new/include/linux/tqueue.h
--- linux/include/linux/tqueue.h        Sat Dec 23 16:16:44 2000
+++ linux.new/include/linux/tqueue.h    Sat Dec 23 16:06:01 2000
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <asm/bitops.h>
 #include <asm/system.h>
+#include <asm/processor.h>
 
 /*
  * New proposed "bottom half" handlers:
diff -Nur linux/include/asm-i386/system.h linux.new/include/asm-i386/system.h
--- linux/include/asm-i386/system.h     Mon Dec 11 19:26:39 2000
+++ linux.new/include/asm-i386/system.h Sat Dec 23 16:06:01 2000
@@ -274,7 +274,14 @@
 #ifndef CONFIG_X86_XMM
 #define mb()   __asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
-#define mb()   __asm__ __volatile__ ("sfence": : :"memory")
+#define mb()  do { \
+       if ( cpu_has_xmm ) { \
+               asm volatile("sfence": : :"memory"); \
+       } \
+       else { \
+               asm volatile("lock; addl $0,0(%%esp)": : :"memory"); \
+       } \
+} while (0)                                                            
 #endif
 #define rmb()  mb()
 #define wmb()  __asm__ __volatile__ ("": : :"memory")
diff -Nur linux/include/linux/tqueue.h linux.new/include/linux/tqueue.h
--- linux/include/linux/tqueue.h        Sat Dec 23 16:16:44 2000
+++ linux.new/include/linux/tqueue.h    Sat Dec 23 16:06:01 2000
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <asm/bitops.h>
 #include <asm/system.h>
+#include <asm/processor.h>
 
 /*
  * New proposed "bottom half" handlers:


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
