Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTIWBi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 21:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTIWBi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 21:38:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20358
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262794AbTIWBir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 21:38:47 -0400
Date: Mon, 22 Sep 2003 21:48:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: log-buf-len dynamic
Message-ID: <20030922194833.GA2732@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm rejecting on the log-buf-len feature in 2.4.23pre5, the code in
mainline is worthless for any distributor, shipping another rpm package
just for the bufsize would be way overkill.

Please backout the below (extracted from bkcvs) and apply this one
instead:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22aa1/00_log-buf-len-1

BTW, not sure why but bkcvs on kernel.org is still stuck at 23pre4, I
hope it's not a malfunction and just a normal delay. For now I've to use
a mixture between bkcvs and patches.

---------------------
PatchSet 3787 
Date: 2003/08/26 19:28:13
Author: willy
Branch: HEAD
Tag: (none) 
Log:
[PATCH] make log buffer length selectable

On Mon, Aug 25, 2003 at 04:48:30AM -0700, Marcelo Tosatti wrote:
> final:
>
> - 2.4.22-rc4 was released as 2.4.22 with no changes.

Hi Marcelo,

as you requested, here is the log_buf_len patch for inclusion in 23-pre.

Cheers,
Willy

BKrev: 3f4ba6bdLGpAZvSSSz7LVia3xLNP6g

Members: 
	ChangeSet:1.3787->1.3788 
	Documentation/Configure.help:1.220->1.221 
	arch/i386/config.in:1.47->1.48 
	kernel/printk.c:1.12->1.13 

Index: linux-2.4/Documentation/Configure.help
diff -u linux-2.4/Documentation/Configure.help:1.220 linux-2.4/Documentation/Configure.help:1.221
--- linux-2.4/Documentation/Configure.help:1.220	Tue Aug 26 15:38:45 2003
+++ linux-2.4/Documentation/Configure.help	Tue Aug 26 20:28:13 2003
@@ -25102,6 +25102,19 @@
   output to the second serial port on these devices.  Saying N will
   cause the debug messages to appear on the first serial port.
 
+Kernel log buffer length shift
+CONFIG_LOG_BUF_SHIFT
+  The kernel log buffer has a fixed size of :
+      64 kB (2^16) on MULTIQUAD and IA64,
+     128 kB (2^17) on S390
+      32 kB (2^15) on SMP systems
+      16 kB (2^14) on UP systems
+
+  You have the ability to change this size with this paramter which
+  fixes the bit shift of to get the buffer length (which must be a
+  power of 2). Eg: a value of 16 sets the buffer to 64 kB (2^16).
+  The default value of 0 uses standard values above.
+
 Disable pgtable cache
 CONFIG_NO_PGT_CACHE
   Normally the kernel maintains a `quicklist' of preallocated
Index: linux-2.4/arch/i386/config.in
diff -u linux-2.4/arch/i386/config.in:1.47 linux-2.4/arch/i386/config.in:1.48
--- linux-2.4/arch/i386/config.in:1.47	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/i386/config.in	Tue Aug 26 20:28:13 2003
@@ -477,6 +477,8 @@
    bool '  Compile the kernel with frame pointers' CONFIG_FRAME_POINTER
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/kernel/printk.c
diff -u linux-2.4/kernel/printk.c:1.12 linux-2.4/kernel/printk.c:1.13
--- linux-2.4/kernel/printk.c:1.12	Fri Jun 27 20:41:53 2003
+++ linux-2.4/kernel/printk.c	Tue Aug 26 20:28:13 2003
@@ -29,6 +29,7 @@
 
 #include <asm/uaccess.h>
 
+#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT - 0 == 0)
 #if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390)
@@ -37,6 +38,9 @@
 #define LOG_BUF_LEN	(32768)
 #else	
 #define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+#endif
+#else /* CONFIG_LOG_BUF_SHIFT */
+#define LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
 #endif
 
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
---------------------
PatchSet 3862 
Date: 2003/08/30 15:32:03
Author: willy
Branch: HEAD
Tag: (none) 
Log:
[PATCH] Fix log buffer length issues

On Fri, Aug 29, 2003 at 01:14:19PM -0300, Marcelo Tosatti wrote:
> I'm waiting for your selectable log buffer lengh fixes :)

OK, Marcelo, here comes my proposed fix. Tom, does it look better for you ?
BTW, Tom, I found the exact reason for the line which irritated you :
#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT - 0 == 0)

it was because because I was worried about CONFIG_LOG_BUG_SHIFT being defined
to the empty string (a simple #define CONFIG_LOG_BUG_SHIFT is enough), as I
remember it happened to me when working on it. But there's no reason here for
this to happen, otherwise we would have far worse problems with values extracted
from .config, so I fixed it.

I added the config line to all archs. I used copy paste, so either I broke them
all, either none. I'll start a compilation on my alpha while I'm on the way
home, to check. I you have questions, please do ask.

Cheers,
Willy

BKrev: 3f50b563j2T0yJ7uwm8xVJWuE9qDnQ

Members: 
	ChangeSet:1.3862->1.3863 
	arch/alpha/config.in:1.28->1.29 
	arch/arm/config.in:1.24->1.25 
	arch/cris/config.in:1.18->1.19 
	arch/ia64/config.in:1.21->1.22 
	arch/m68k/config.in:1.21->1.22 
	arch/mips/config-shared.in:1.7->1.8 
	arch/parisc/config.in:1.10->1.11 
	arch/ppc/config.in:1.37->1.38 
	arch/ppc64/config.in:1.11->1.12 
	arch/s390/config.in:1.13->1.14 
	arch/s390x/config.in:1.13->1.14 
	arch/sh/config.in:1.14->1.15 
	arch/sh64/config.in:1.7->1.8 
	arch/sparc/config.in:1.19->1.20 
	arch/sparc64/config.in:1.30->1.31 
	arch/x86_64/config.in:1.10->1.11 
	kernel/printk.c:1.13->1.14 

Index: linux-2.4/arch/alpha/config.in
diff -u linux-2.4/arch/alpha/config.in:1.28 linux-2.4/arch/alpha/config.in:1.29
--- linux-2.4/arch/alpha/config.in:1.28	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/alpha/config.in	Sat Aug 30 16:32:03 2003
@@ -454,6 +454,8 @@
    define_tristate CONFIG_MATHEMU y
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/arm/config.in
diff -u linux-2.4/arch/arm/config.in:1.24 linux-2.4/arch/arm/config.in:1.25
--- linux-2.4/arch/arm/config.in:1.24	Thu Jul  3 00:06:54 2003
+++ linux-2.4/arch/arm/config.in	Sat Aug 30 16:32:03 2003
@@ -730,6 +730,9 @@
 dep_bool '  Kernel low-level debugging functions' CONFIG_DEBUG_LL $CONFIG_DEBUG_KERNEL
 dep_bool '    Kernel low-level debugging messages via footbridge serial port' CONFIG_DEBUG_DC21285_PORT $CONFIG_DEBUG_LL $CONFIG_FOOTBRIDGE
 dep_bool '    Kernel low-level debugging messages via UART2' CONFIG_DEBUG_CLPS711X_UART2 $CONFIG_DEBUG_LL $CONFIG_ARCH_CLPS711X
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/cris/config.in
diff -u linux-2.4/arch/cris/config.in:1.18 linux-2.4/arch/cris/config.in:1.19
--- linux-2.4/arch/cris/config.in:1.18	Mon Jul 21 14:43:23 2003
+++ linux-2.4/arch/cris/config.in	Sat Aug 30 16:32:03 2003
@@ -272,6 +272,8 @@
   int '  Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 source crypto/Config.in
 source lib/Config.in
 endmenu
Index: linux-2.4/arch/ia64/config.in
diff -u linux-2.4/arch/ia64/config.in:1.21 linux-2.4/arch/ia64/config.in:1.22
--- linux-2.4/arch/ia64/config.in:1.21	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/ia64/config.in	Sat Aug 30 16:32:03 2003
@@ -294,4 +294,6 @@
    bool '  Turn on irq debug checks (slow!)' CONFIG_IA64_DEBUG_IRQ
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
Index: linux-2.4/arch/m68k/config.in
diff -u linux-2.4/arch/m68k/config.in:1.21 linux-2.4/arch/m68k/config.in:1.22
--- linux-2.4/arch/m68k/config.in:1.21	Sat Aug 30 15:58:36 2003
+++ linux-2.4/arch/m68k/config.in	Sat Aug 30 16:32:03 2003
@@ -556,6 +556,8 @@
    bool '  Verbose BUG() reporting' CONFIG_DEBUG_BUGVERBOSE
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/mips/config-shared.in
diff -u linux-2.4/arch/mips/config-shared.in:1.7 linux-2.4/arch/mips/config-shared.in:1.8
--- linux-2.4/arch/mips/config-shared.in:1.7	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/mips/config-shared.in	Sat Aug 30 16:32:03 2003
@@ -1042,6 +1042,9 @@
 else
    int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/parisc/config.in
diff -u linux-2.4/arch/parisc/config.in:1.10 linux-2.4/arch/parisc/config.in:1.11
--- linux-2.4/arch/parisc/config.in:1.10	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/parisc/config.in	Sat Aug 30 16:32:03 2003
@@ -198,6 +198,9 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/ppc/config.in
diff -u linux-2.4/arch/ppc/config.in:1.37 linux-2.4/arch/ppc/config.in:1.38
--- linux-2.4/arch/ppc/config.in:1.37	Sat Aug 30 15:49:01 2003
+++ linux-2.4/arch/ppc/config.in	Sat Aug 30 16:32:03 2003
@@ -563,4 +563,7 @@
 if [ "$CONFIG_GEN550" = "y" ]; then
   bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
 fi
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
Index: linux-2.4/arch/ppc64/config.in
diff -u linux-2.4/arch/ppc64/config.in:1.11 linux-2.4/arch/ppc64/config.in:1.12
--- linux-2.4/arch/ppc64/config.in:1.11	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/ppc64/config.in	Sat Aug 30 16:32:03 2003
@@ -263,4 +263,7 @@
    dep_bool '  LKCD RLE compression' CONFIG_DUMP_COMPRESS_RLE $CONFIG_DUMP
    dep_bool '  LKCD GZIP compression' CONFIG_DUMP_COMPRESS_GZIP $CONFIG_DUMP
 fi
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
Index: linux-2.4/arch/s390/config.in
diff -u linux-2.4/arch/s390/config.in:1.13 linux-2.4/arch/s390/config.in:1.14
--- linux-2.4/arch/s390/config.in:1.13	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/s390/config.in	Sat Aug 30 16:32:03 2003
@@ -80,6 +80,9 @@
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/s390x/config.in
diff -u linux-2.4/arch/s390x/config.in:1.13 linux-2.4/arch/s390x/config.in:1.14
--- linux-2.4/arch/s390x/config.in:1.13	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/s390x/config.in	Sat Aug 30 16:32:03 2003
@@ -84,6 +84,9 @@
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/sh/config.in
diff -u linux-2.4/arch/sh/config.in:1.14 linux-2.4/arch/sh/config.in:1.15
--- linux-2.4/arch/sh/config.in:1.14	Mon Jul 21 14:43:23 2003
+++ linux-2.4/arch/sh/config.in	Sat Aug 30 16:32:03 2003
@@ -465,6 +465,9 @@
           8 CONFIG_KGDB_DEFBITS_8"	8
    endmenu
 fi
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/sh64/config.in
diff -u linux-2.4/arch/sh64/config.in:1.7 linux-2.4/arch/sh64/config.in:1.8
--- linux-2.4/arch/sh64/config.in:1.7	Mon Jul 21 14:43:23 2003
+++ linux-2.4/arch/sh64/config.in	Sat Aug 30 16:32:03 2003
@@ -301,6 +301,8 @@
 bool "Debug: audit page tables on return from syscall/exception/interrupt" CONFIG_SH64_PAGE_TABLE_AUDIT
 dep_bool "Debug: report TLB fill/purge activity through /proc/tlb" CONFIG_SH64_PROC_TLB $CONFIG_PROC_FS
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source lib/Config.in
Index: linux-2.4/arch/sparc/config.in
diff -u linux-2.4/arch/sparc/config.in:1.19 linux-2.4/arch/sparc/config.in:1.20
--- linux-2.4/arch/sparc/config.in:1.19	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/sparc/config.in	Sat Aug 30 16:32:03 2003
@@ -277,6 +277,8 @@
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/sparc64/config.in
diff -u linux-2.4/arch/sparc64/config.in:1.30 linux-2.4/arch/sparc64/config.in:1.31
--- linux-2.4/arch/sparc64/config.in:1.30	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/sparc64/config.in	Sat Aug 30 16:32:03 2003
@@ -311,6 +311,8 @@
    define_bool CONFIG_MCOUNT y
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source crypto/Config.in
Index: linux-2.4/arch/x86_64/config.in
diff -u linux-2.4/arch/x86_64/config.in:1.10 linux-2.4/arch/x86_64/config.in:1.11
--- linux-2.4/arch/x86_64/config.in:1.10	Mon Aug 25 23:24:46 2003
+++ linux-2.4/arch/x86_64/config.in	Sat Aug 30 16:32:03 2003
@@ -245,6 +245,9 @@
    bool '  IOMMU leak tracing' CONFIG_IOMMU_LEAK
    bool '  Probalistic stack overflow check' CONFIG_DEBUG_STACKOVERFLOW
 fi
+
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source lib/Config.in
Index: linux-2.4/kernel/printk.c
diff -u linux-2.4/kernel/printk.c:1.13 linux-2.4/kernel/printk.c:1.14
--- linux-2.4/kernel/printk.c:1.13	Tue Aug 26 20:28:13 2003
+++ linux-2.4/kernel/printk.c	Sat Aug 30 16:32:03 2003
@@ -29,7 +29,7 @@
 
 #include <asm/uaccess.h>
 
-#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT - 0 == 0)
+#if !defined(CONFIG_LOG_BUF_SHIFT) || (CONFIG_LOG_BUF_SHIFT == 0)
 #if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
 #define LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390)

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
