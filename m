Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRGXOfl>; Tue, 24 Jul 2001 10:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRGXOfb>; Tue, 24 Jul 2001 10:35:31 -0400
Received: from ns.caldera.de ([212.34.180.1]:5598 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263416AbRGXOfS>;
	Tue, 24 Jul 2001 10:35:18 -0400
Date: Tue, 24 Jul 2001 16:34:57 +0200
From: Christoph Hellwig <hch@caldera.de>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] optionally compile with framepointer
Message-ID: <20010724163457.A16942@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>, alan@redhat.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Alan,

almost every single debugging patch for Linux needs a kernel compiled
with frame pointers.  This patch ist intended to make this configurable
in the base kernel so different patches can shared this modification
nicely.  It is also very usefull for using something like mclinux's
crash tool on /dev/mem.

The patch (against 2.4.6-ac5) has the changes to the i386-specific
sempahore code that are needed to compile with frame pointers (from kdb),
the toplevel makefile change and an option in the i386 debugging menu
(which is also cleaned up to conform to the config.in style guides).

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


--- linux-2.4.6-ac5/Documentation/Configure.help.OL	Tue Jul 24 16:06:15 2001
+++ linux-2.4.6-ac5/Documentation/Configure.help	Tue Jul 24 16:10:41 2001
@@ -21997,6 +21997,11 @@
   the BUG call as well as the EIP and oops trace. This aids debugging but
   costs about 70-100K of memory.
 
+Compile the kernel with frame pointers
+CONFIG_FRAME_POINTER
+  Say Y here to compile your kernel here to have the frame pointer available
+  for additional debugging information.
+
 Include kgdb kernel debugger
 CONFIG_KGDB
   Include in-kernel hooks for kgdb, the Linux kernel source level debugger.
--- linux-2.4.6-ac5/Makefile.OL	Tue Jul 24 16:18:46 2001
+++ linux-2.4.6-ac5/Makefile	Tue Jul 24 16:19:07 2001
@@ -95,9 +95,13 @@
 CPPFLAGS := -D__KERNEL__ -I$(HPATH)
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  -fomit-frame-pointer -fno-strict-aliasing -fno-common
+	  -fno-strict-aliasing -fno-common
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
+ifneq ($(CONFIG_FRAME_POINTER),y)
+CFLAGS += -fomit-frame-pointer
+endif
+
 #
 # ROOT_DEV specifies the default root-device when making the image.
 # This can be either FLOPPY, CURRENT, /dev/xxxx or empty, in which case
--- linux-2.4.6/arch/i386/config.in.OL	Tue Jul 24 16:21:14 2001
+++ linux-2.4.6/arch/i386/config.in	Tue Jul 24 16:22:11 2001
@@ -395,15 +395,13 @@
 comment 'Kernel hacking'
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
-
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
-
-
-bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
-bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
-bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
-bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
-bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   bool '  Compile the kernel with frame pointers' CONFIG_FRAME_POINTER
+   bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
+   bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
+   bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
+   bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
 endmenu
--- linux-2.4.6-ac5/arch/i386/kernel/semaphore.c.OL	Tue Jul 24 16:03:50 2001
+++ linux-2.4.6-ac5/arch/i386/kernel/semaphore.c	Tue Jul 24 16:03:55 2001
@@ -182,6 +182,10 @@
 ".align 4\n"
 ".globl __down_failed\n"
 "__down_failed:\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"pushl %ebp\n\t"
+	"movl  %esp,%ebp\n\t"
+#endif
 	"pushl %eax\n\t"
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
@@ -189,6 +193,10 @@
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
 	"popl %eax\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"movl %ebp,%esp\n\t"
+	"popl %ebp\n\t"
+#endif
 	"ret"
 );
 
@@ -197,11 +205,19 @@
 ".align 4\n"
 ".globl __down_failed_interruptible\n"
 "__down_failed_interruptible:\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"pushl %ebp\n\t"
+	"movl  %esp,%ebp\n\t"
+#endif
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
 	"call __down_interruptible\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"movl %ebp,%esp\n\t"
+	"popl %ebp\n\t"
+#endif
 	"ret"
 );
 
@@ -210,11 +226,19 @@
 ".align 4\n"
 ".globl __down_failed_trylock\n"
 "__down_failed_trylock:\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"pushl %ebp\n\t"
+	"movl  %esp,%ebp\n\t"
+#endif
 	"pushl %edx\n\t"
 	"pushl %ecx\n\t"
 	"call __down_trylock\n\t"
 	"popl %ecx\n\t"
 	"popl %edx\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"movl %ebp,%esp\n\t"
+	"popl %ebp\n\t"
+#endif
 	"ret"
 );
