Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTBIRVL>; Sun, 9 Feb 2003 12:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTBIRVL>; Sun, 9 Feb 2003 12:21:11 -0500
Received: from f90.law15.hotmail.com ([64.4.23.90]:41743 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267308AbTBIRVJ>;
	Sun, 9 Feb 2003 12:21:09 -0500
X-Originating-IP: [81.79.20.160]
From: "Jason Algol" <slashdotcommacolon@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: cosmetic patch to linux kernel 
Date: Sun, 09 Feb 2003 17:30:47 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F90bqCbkSFGMrbmaMxb00019091@hotmail.com>
X-OriginalArrivalTime: 09 Feb 2003 17:30:47.0483 (UTC) FILETIME=[FB81F0B0:01C2D060]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello, UAC_NOPRINT is on by default, i think that sucks :)

who should i moan at to get it changed?

i made this patch (very quick) to make an option out of it, do you think 
marcelo would check it in (if i made it tidier, or whatever)? or would my 
best bet be to just ask someone to change it?

Thanks!

[ please cc me on replies, non-subscriber ]

diff --minimal -Nur linux-2.4.20-orig/arch/alpha/config.in 
linux-2.4.20/arch/alpha/config.in
--- linux-2.4.20-orig/arch/alpha/config.in      2002-11-28 
23:53:08.000000000 +0000
+++ linux-2.4.20/arch/alpha/config.in   2003-02-09 16:49:54.000000000 +0000
@@ -415,6 +415,7 @@
    tristate '  Kernel FP software completion' CONFIG_MATHEMU
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
+   bool '  Set UAC_NOPRINT off by default' CONFIG_NO_NOISY_TRAPS
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Read-write spinlock debugging' CONFIG_DEBUG_RWLOCK
    bool '  Semaphore debugging' CONFIG_DEBUG_SEMAPHORE
diff --minimal -Nur linux-2.4.20-orig/arch/alpha/defconfig 
linux-2.4.20/arch/alpha/defconfig
--- linux-2.4.20-orig/arch/alpha/defconfig      2003-02-09 
16:59:03.000000000 +0000
+++ linux-2.4.20/arch/alpha/defconfig   2003-02-09 16:50:04.000000000 +0000
@@ -795,6 +795,7 @@
CONFIG_MATHEMU=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
+CONFIG_NO_NOISY_TRAPS=n

#
# XFS addons
diff --minimal -Nur linux-2.4.20-orig/arch/alpha/kernel/Makefile 
linux-2.4.20/arch/alpha/kernel/Makefile
--- linux-2.4.20-orig/arch/alpha/kernel/Makefile        2001-08-12 
18:51:41.000000000 +0100
+++ linux-2.4.20/arch/alpha/kernel/Makefile     2003-02-09 
16:50:55.000000000 +0000
@@ -100,6 +100,10 @@

endif # GENERIC

+ifdef CONFIG_NO_NOISY_TRAPS
+CFLAGS   += -DNO_NOISY_TRAPS
+endif
+
all: kernel.o head.o

asm_offsets: check_asm
diff --minimal -Nur linux-2.4.20-orig/arch/alpha/kernel/traps.c 
linux-2.4.20/arch/alpha/kernel/traps.c
--- linux-2.4.20-orig/arch/alpha/kernel/traps.c 2003-02-09 
16:59:03.000000000 +0000
+++ linux-2.4.20/arch/alpha/kernel/traps.c      2003-02-09 
16:53:31.000000000 +0000
@@ -24,6 +24,11 @@

#include "proto.h"

+#ifdef NO_NOISY_TRAPS
+#undef UAC_NOPRINT
+#define UAC_NOPRINT 0
+#endif
+
/* data/code implementing a work-around for some SRMs which
    mishandle opDEC faults
*/
diff --minimal -Nur linux-2.4.20-orig/Documentation/Configure.help 
linux-2.4.20/Documentation/Configure.help
--- linux-2.4.20-orig/Documentation/Configure.help      2003-02-09 
16:59:03.000000000 +0000
+++ linux-2.4.20/Documentation/Configure.help   2003-02-09 
16:51:07.000000000 +0000
@@ -20652,6 +20652,19 @@
   keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
   unless you really know what this hack does.

+Set UAC_NOPRINT off by Default
+CONFIG_NO_NOISY_TRAPS
+  If you say Y here, the kernel will not fill your logs with debug
+  messages when memory accesses are not naturally aligned. If you
+  are seeing lots of messages spamming the console like
+
+  X(26738): unaligned trap at 000000012004b6f0: 00000001401b20ca 28 1
+
+  and dont like them, select Y. This is purely a cosmetic fix.
+
+  see http://www.alphalinux.org/faq/FAQ-1.html for more information.
+
+
Kernel Debugging support
CONFIG_KDB
   This option provides a built-in kernel debugger.  The built-in
diff --minimal -Nur linux-2.4.20-orig/include/asm-alpha/sysinfo.h 
linux-2.4.20/include/asm-alpha/sysinfo.h
--- linux-2.4.20-orig/include/asm-alpha/sysinfo.h       1999-03-22 
04:53:46.000000000 +0000
+++ linux-2.4.20/include/asm-alpha/sysinfo.h    2003-02-09 
16:51:40.000000000 +0000
@@ -22,7 +22,7 @@
#define SSIN_UACPROC                   6

#define UAC_BITMASK                    7
-#define UAC_NOPRINT                    1
+#define UAC_NOPRINT                     1
#define UAC_NOFIX                      2
#define UAC_SIGBUS                     4


_________________________________________________________________
Express yourself with cool emoticons http://messenger.msn.co.uk

