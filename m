Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRDEAUA>; Wed, 4 Apr 2001 20:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130487AbRDEATw>; Wed, 4 Apr 2001 20:19:52 -0400
Received: from ns2.cypress.com ([157.95.67.5]:28587 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S129624AbRDEATo>;
	Wed, 4 Apr 2001 20:19:44 -0400
Message-ID: <3ACBB9B8.72792AAA@cypress.com>
Date: Wed, 04 Apr 2001 19:18:00 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Config printk buffer size
Content-Type: multipart/mixed;
 boundary="------------070CAA0D8AF1D98A14E6F8B4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070CAA0D8AF1D98A14E6F8B4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This should allow the printk buffer to be sized during config.
The default size is still 16K. It could use some checking to
insure power-of-2, but CML1 doesn't have a way to
do it that I see. All the architectures should be
covered, and all the default files also have it.

It gets added in the kernel hacking section.

Having 8 software raid volumes most of the kernel hardware
detection messages get lost. Having to edit kernel/printk.c
before/after every kernel change is a mess and easy to forget.

I'm gouing to work on a resizing buffer, that drops to 4K or
8K after dmesg is called with the right switch.

Patch against 2.4.3-ac2 since it has more arch supported.

The embedded systems like arm, might want to change
the default size to something smaller for their arch,
whiuch is easier with this patch.

	-Thomas
--------------070CAA0D8AF1D98A14E6F8B4
Content-Type: text/plain; charset=us-ascii;
 name="config-printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-printk.patch"

diff -u --new-file --recursive linux-2.4.3-ac2.orig/Documentation/Configure.help linux-2.4.3-ac2/Documentation/Configure.help
--- linux-2.4.3-ac2.orig/Documentation/Configure.help	Wed Apr  4 15:22:43 2001
+++ linux-2.4.3-ac2/Documentation/Configure.help	Wed Apr  4 16:06:09 2001
@@ -15191,7 +15191,13 @@
   send a BREAK and then within 5 seconds a command keypress. The
   keys are documented in Documentation/sysrq.txt. Don't say Y unless
   you really know what this hack does.
-
+Printk buffer size
+CONFIG_PRINTK_BUF_LEN
+  Printk buffer size in K bytes. This should be a power of 2.
+  The 2.2.x kernels used a default of 8. The 2.4.x kernels
+  use a default of 16. Systems with many Software-RAID volumes
+  should increase since the md.o drivers have a lot of printk
+  output during boot.
 ISDN subsystem
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/alpha/config.in linux-2.4.3-ac2/arch/alpha/config.in
--- linux-2.4.3-ac2.orig/arch/alpha/config.in	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/alpha/config.in	Wed Apr  4 16:06:39 2001
@@ -361,6 +361,7 @@
 fi
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 
 bool 'Legacy kernel start address' CONFIG_ALPHA_LEGACY_START_ADDRESS
 
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/alpha/defconfig linux-2.4.3-ac2/arch/alpha/defconfig
--- linux-2.4.3-ac2.orig/arch/alpha/defconfig	Wed Apr  4 15:12:44 2001
+++ linux-2.4.3-ac2/arch/alpha/defconfig	Wed Apr  4 15:36:53 2001
@@ -634,4 +634,5 @@
 #
 CONFIG_MATHEMU=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_ALPHA_LEGACY_START_ADDRESS=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/config.in linux-2.4.3-ac2/arch/arm/config.in
--- linux-2.4.3-ac2.orig/arch/arm/config.in	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/arm/config.in	Wed Apr  4 16:06:57 2001
@@ -414,6 +414,7 @@
 bool 'Verbose user fault messages' CONFIG_DEBUG_USER
 bool 'Include debugging information in kernel binary' CONFIG_DEBUG_INFO
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 if [ "$CONFIG_CPU_26" = "y" ]; then
    bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE
 fi
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/a5k linux-2.4.3-ac2/arch/arm/def-configs/a5k
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/a5k	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/a5k	Wed Apr  4 15:40:00 2001
@@ -532,5 +532,6 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_NO_PGT_CACHE=y
 CONFIG_DEBUG_LL=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/assabet linux-2.4.3-ac2/arch/arm/def-configs/assabet
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/assabet	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/assabet	Wed Apr  4 15:40:15 2001
@@ -566,4 +566,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/brutus linux-2.4.3-ac2/arch/arm/def-configs/brutus
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/brutus	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/brutus	Wed Apr  4 15:40:25 2001
@@ -293,4 +293,5 @@
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/cerf linux-2.4.3-ac2/arch/arm/def-configs/cerf
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/cerf	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/cerf	Wed Apr  4 15:40:35 2001
@@ -431,4 +431,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/clps7500 linux-2.4.3-ac2/arch/arm/def-configs/clps7500
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/clps7500	Mon Sep 18 17:15:24 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/clps7500	Wed Apr  4 15:40:43 2001
@@ -487,4 +487,5 @@
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/ebsa110 linux-2.4.3-ac2/arch/arm/def-configs/ebsa110
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/ebsa110	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/ebsa110	Wed Apr  4 15:40:54 2001
@@ -502,4 +502,5 @@
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/empeg linux-2.4.3-ac2/arch/arm/def-configs/empeg
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/empeg	Wed Oct 20 18:29:08 1999
+++ linux-2.4.3-ac2/arch/arm/def-configs/empeg	Wed Apr  4 15:41:02 2001
@@ -261,4 +261,5 @@
 CONFIG_DEBUG_USER_BACKTRACE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/footbridge linux-2.4.3-ac2/arch/arm/def-configs/footbridge
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/footbridge	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/footbridge	Wed Apr  4 15:41:16 2001
@@ -890,5 +890,6 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_DEBUG_LL=y
 # CONFIG_DEBUG_DC21285_PORT is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/graphicsclient linux-2.4.3-ac2/arch/arm/def-configs/graphicsclient
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/graphicsclient	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/graphicsclient	Wed Apr  4 15:41:26 2001
@@ -541,4 +541,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/integrator linux-2.4.3-ac2/arch/arm/def-configs/integrator
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/integrator	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/integrator	Wed Apr  4 15:41:50 2001
@@ -508,4 +508,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_DEBUG_LL=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/lart linux-2.4.3-ac2/arch/arm/def-configs/lart
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/lart	Mon Sep 18 17:15:24 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/lart	Wed Apr  4 15:42:12 2001
@@ -492,4 +492,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_DEBUG_LL=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/lusl7200 linux-2.4.3-ac2/arch/arm/def-configs/lusl7200
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/lusl7200	Mon Jun 19 19:59:33 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/lusl7200	Wed Apr  4 15:42:26 2001
@@ -226,4 +226,5 @@
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_DEBUG_LL=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/neponset linux-2.4.3-ac2/arch/arm/def-configs/neponset
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/neponset	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/neponset	Wed Apr  4 15:42:35 2001
@@ -573,4 +573,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/pangolin linux-2.4.3-ac2/arch/arm/def-configs/pangolin
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/pangolin	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/pangolin	Wed Apr  4 15:42:44 2001
@@ -488,4 +488,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/rpc linux-2.4.3-ac2/arch/arm/def-configs/rpc
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/rpc	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/rpc	Wed Apr  4 15:42:54 2001
@@ -707,4 +707,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_DEBUG_LL=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/shark linux-2.4.3-ac2/arch/arm/def-configs/shark
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/shark	Mon Sep 18 17:15:24 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/shark	Wed Apr  4 15:43:03 2001
@@ -652,4 +652,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_DEBUG_LL=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/sherman linux-2.4.3-ac2/arch/arm/def-configs/sherman
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/sherman	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/sherman	Wed Apr  4 15:43:16 2001
@@ -207,4 +207,5 @@
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 CONFIG_DEBUG_LL=y
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/victor linux-2.4.3-ac2/arch/arm/def-configs/victor
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/victor	Mon Jun 19 19:59:33 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/victor	Wed Apr  4 15:43:32 2001
@@ -200,4 +200,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/defconfig linux-2.4.3-ac2/arch/arm/defconfig
--- linux-2.4.3-ac2.orig/arch/arm/defconfig	Mon Jun 19 19:59:33 2000
+++ linux-2.4.3-ac2/arch/arm/defconfig	Wed Apr  4 15:39:43 2001
@@ -719,4 +719,5 @@
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
 # CONFIG_DEBUG_LL is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/cris/config.in linux-2.4.3-ac2/arch/cris/config.in
--- linux-2.4.3-ac2.orig/arch/cris/config.in	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/cris/config.in	Wed Apr  4 16:07:15 2001
@@ -223,4 +223,5 @@
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/cris/defconfig linux-2.4.3-ac2/arch/cris/defconfig
--- linux-2.4.3-ac2.orig/arch/cris/defconfig	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/cris/defconfig	Wed Apr  4 15:45:50 2001
@@ -472,3 +472,4 @@
 # Kernel hacking
 #
 # CONFIG_PROFILE is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/i386/config.in linux-2.4.3-ac2/arch/i386/config.in
--- linux-2.4.3-ac2.orig/arch/i386/config.in	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/i386/config.in	Wed Apr  4 16:07:42 2001
@@ -384,6 +384,7 @@
 
 bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
 bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
+ int '  Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/i386/defconfig linux-2.4.3-ac2/arch/i386/defconfig
--- linux-2.4.3-ac2.orig/arch/i386/defconfig	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/i386/defconfig	Wed Apr  4 15:45:34 2001
@@ -722,3 +722,4 @@
 #
 CONFIG_DEBUG_IOVIRT=y
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ia64/config.in linux-2.4.3-ac2/arch/ia64/config.in
--- linux-2.4.3-ac2.orig/arch/ia64/config.in	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/ia64/config.in	Wed Apr  4 16:07:55 2001
@@ -255,5 +255,5 @@
 bool 'Print possible IA64 hazards to console' CONFIG_IA64_PRINT_HAZARDS
 bool 'Enable new unwind support' CONFIG_IA64_NEW_UNWIND
 bool 'Disable VHPT' CONFIG_DISABLE_VHPT
-
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ia64/defconfig linux-2.4.3-ac2/arch/ia64/defconfig
--- linux-2.4.3-ac2.orig/arch/ia64/defconfig	Thu Jun 22 09:09:44 2000
+++ linux-2.4.3-ac2/arch/ia64/defconfig	Wed Apr  4 15:46:29 2001
@@ -276,3 +276,4 @@
 # CONFIG_IA64_DEBUG_IRQ is not set
 # CONFIG_IA64_PRINT_HAZARDS is not set
 # CONFIG_KDB is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/m68k/config.in linux-2.4.3-ac2/arch/m68k/config.in
--- linux-2.4.3-ac2.orig/arch/m68k/config.in	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/m68k/config.in	Wed Apr  4 16:08:13 2001
@@ -540,4 +540,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/m68k/defconfig linux-2.4.3-ac2/arch/m68k/defconfig
--- linux-2.4.3-ac2.orig/arch/m68k/defconfig	Mon Jun 19 14:56:08 2000
+++ linux-2.4.3-ac2/arch/m68k/defconfig	Wed Apr  4 15:47:12 2001
@@ -327,3 +327,4 @@
 # Kernel hacking
 #
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/config.in linux-2.4.3-ac2/arch/mips/config.in
--- linux-2.4.3-ac2.orig/arch/mips/config.in	Wed Apr  4 15:22:46 2001
+++ linux-2.4.3-ac2/arch/mips/config.in	Wed Apr  4 16:08:30 2001
@@ -400,4 +400,5 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig linux-2.4.3-ac2/arch/mips/defconfig
--- linux-2.4.3-ac2.orig/arch/mips/defconfig	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig	Wed Apr  4 15:47:59 2001
@@ -354,4 +354,4 @@
 #
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MIPS_FPE_MODULE is not set
-# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_MAGIC_SYSRQ is not setCONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-cobalt linux-2.4.3-ac2/arch/mips/defconfig-cobalt
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-cobalt	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-cobalt	Wed Apr  4 15:48:08 2001
@@ -596,3 +596,4 @@
 # CONFIG_CROSSCOMPILE is not set
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-ddb5476 linux-2.4.3-ac2/arch/mips/defconfig-ddb5476
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-ddb5476	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-ddb5476	Wed Apr  4 15:48:19 2001
@@ -539,3 +539,4 @@
 # CONFIG_LL_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-decstation linux-2.4.3-ac2/arch/mips/defconfig-decstation
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-decstation	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-decstation	Wed Apr  4 15:48:29 2001
@@ -328,3 +328,4 @@
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-ip22 linux-2.4.3-ac2/arch/mips/defconfig-ip22
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-ip22	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-ip22	Wed Apr  4 15:48:39 2001
@@ -355,3 +355,4 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-it8172 linux-2.4.3-ac2/arch/mips/defconfig-it8172
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-it8172	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-it8172	Wed Apr  4 15:48:49 2001
@@ -567,3 +567,4 @@
 # CONFIG_LL_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-orion linux-2.4.3-ac2/arch/mips/defconfig-orion
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-orion	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-orion	Wed Apr  4 15:48:57 2001
@@ -302,3 +302,4 @@
 #
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-rm200 linux-2.4.3-ac2/arch/mips/defconfig-rm200
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-rm200	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-rm200	Wed Apr  4 15:49:08 2001
@@ -363,3 +363,4 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/config.in linux-2.4.3-ac2/arch/mips64/config.in
--- linux-2.4.3-ac2.orig/arch/mips64/config.in	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/config.in	Wed Apr  4 16:08:43 2001
@@ -265,4 +265,5 @@
 fi
 bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/defconfig linux-2.4.3-ac2/arch/mips64/defconfig
--- linux-2.4.3-ac2.orig/arch/mips64/defconfig	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/defconfig	Wed Apr  4 15:49:48 2001
@@ -458,3 +458,4 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip22 linux-2.4.3-ac2/arch/mips64/defconfig-ip22
--- linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip22	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/defconfig-ip22	Wed Apr  4 15:49:57 2001
@@ -372,3 +372,4 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip27 linux-2.4.3-ac2/arch/mips64/defconfig-ip27
--- linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip27	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/defconfig-ip27	Wed Apr  4 15:50:06 2001
@@ -458,3 +458,4 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/parisc/config.common linux-2.4.3-ac2/arch/parisc/config.common
--- linux-2.4.3-ac2.orig/arch/parisc/config.common	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/parisc/config.common	Wed Apr  4 16:09:03 2001
@@ -156,4 +156,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/parisc/defconfig linux-2.4.3-ac2/arch/parisc/defconfig
--- linux-2.4.3-ac2.orig/arch/parisc/defconfig	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/parisc/defconfig	Wed Apr  4 15:50:38 2001
@@ -475,3 +475,4 @@
 # Kernel hacking
 #
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/config.in linux-2.4.3-ac2/arch/ppc/config.in
--- linux-2.4.3-ac2.orig/arch/ppc/config.in	Wed Apr  4 15:22:49 2001
+++ linux-2.4.3-ac2/arch/ppc/config.in	Wed Apr  4 16:09:19 2001
@@ -351,4 +351,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/IVMS8_defconfig linux-2.4.3-ac2/arch/ppc/configs/IVMS8_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/IVMS8_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/IVMS8_defconfig	Wed Apr  4 15:52:56 2001
@@ -450,3 +450,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/SM850_defconfig linux-2.4.3-ac2/arch/ppc/configs/SM850_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/SM850_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/SM850_defconfig	Wed Apr  4 15:53:59 2001
@@ -418,3 +418,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/SPD823TS_defconfig linux-2.4.3-ac2/arch/ppc/configs/SPD823TS_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/SPD823TS_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/SPD823TS_defconfig	Wed Apr  4 15:54:09 2001
@@ -414,3 +414,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/TQM823L_defconfig linux-2.4.3-ac2/arch/ppc/configs/TQM823L_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/TQM823L_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/TQM823L_defconfig	Wed Apr  4 15:54:16 2001
@@ -417,3 +417,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/TQM850L_defconfig linux-2.4.3-ac2/arch/ppc/configs/TQM850L_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/TQM850L_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/TQM850L_defconfig	Wed Apr  4 15:54:51 2001
@@ -417,3 +417,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/TQM860L_defconfig linux-2.4.3-ac2/arch/ppc/configs/TQM860L_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/TQM860L_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/TQM860L_defconfig	Wed Apr  4 15:55:06 2001
@@ -417,3 +417,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/apus_defconfig linux-2.4.3-ac2/arch/ppc/configs/apus_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/apus_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/apus_defconfig	Wed Apr  4 15:51:57 2001
@@ -598,3 +598,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/bseip_defconfig linux-2.4.3-ac2/arch/ppc/configs/bseip_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/bseip_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/bseip_defconfig	Wed Apr  4 15:52:15 2001
@@ -430,3 +430,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/common_defconfig linux-2.4.3-ac2/arch/ppc/configs/common_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/common_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/common_defconfig	Wed Apr  4 15:52:29 2001
@@ -838,3 +838,4 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/est8260_defconfig linux-2.4.3-ac2/arch/ppc/configs/est8260_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/est8260_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/est8260_defconfig	Wed Apr  4 15:52:36 2001
@@ -413,3 +413,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/ibmchrp_defconfig linux-2.4.3-ac2/arch/ppc/configs/ibmchrp_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/ibmchrp_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/ibmchrp_defconfig	Wed Apr  4 15:52:46 2001
@@ -634,3 +634,4 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/mbx_defconfig linux-2.4.3-ac2/arch/ppc/configs/mbx_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/mbx_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/mbx_defconfig	Wed Apr  4 15:53:09 2001
@@ -422,3 +422,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/oak_defconfig linux-2.4.3-ac2/arch/ppc/configs/oak_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/oak_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/oak_defconfig	Wed Apr  4 15:53:17 2001
@@ -393,3 +393,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/power3_defconfig linux-2.4.3-ac2/arch/ppc/configs/power3_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/power3_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/power3_defconfig	Wed Apr  4 15:53:27 2001
@@ -660,3 +660,4 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/rpxcllf_defconfig linux-2.4.3-ac2/arch/ppc/configs/rpxcllf_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/rpxcllf_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/rpxcllf_defconfig	Wed Apr  4 15:53:39 2001
@@ -429,3 +429,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/rpxlite_defconfig linux-2.4.3-ac2/arch/ppc/configs/rpxlite_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/rpxlite_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/rpxlite_defconfig	Wed Apr  4 15:53:50 2001
@@ -429,3 +429,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/walnut_defconfig linux-2.4.3-ac2/arch/ppc/configs/walnut_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/walnut_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/walnut_defconfig	Wed Apr  4 15:55:16 2001
@@ -396,3 +396,4 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/defconfig linux-2.4.3-ac2/arch/ppc/defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/defconfig	Wed Apr  4 15:51:24 2001
@@ -837,3 +837,5 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+CONFIG_PRINTK_BUF_LEN=16
+
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390/config.in linux-2.4.3-ac2/arch/s390/config.in
--- linux-2.4.3-ac2.orig/arch/s390/config.in	Tue Feb 13 16:13:43 2001
+++ linux-2.4.3-ac2/arch/s390/config.in	Wed Apr  4 16:09:38 2001
@@ -66,5 +66,6 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 # this does not work. bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
 
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390/defconfig linux-2.4.3-ac2/arch/s390/defconfig
--- linux-2.4.3-ac2.orig/arch/s390/defconfig	Wed Apr  4 15:22:50 2001
+++ linux-2.4.3-ac2/arch/s390/defconfig	Wed Apr  4 15:56:08 2001
@@ -218,3 +218,4 @@
 #
 # Kernel hacking
 #
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390x/config.in linux-2.4.3-ac2/arch/s390x/config.in
--- linux-2.4.3-ac2.orig/arch/s390x/config.in	Tue Feb 13 16:13:44 2001
+++ linux-2.4.3-ac2/arch/s390x/config.in	Wed Apr  4 16:09:49 2001
@@ -69,5 +69,6 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 # this does not work. bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
 
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390x/defconfig linux-2.4.3-ac2/arch/s390x/defconfig
--- linux-2.4.3-ac2.orig/arch/s390x/defconfig	Tue Feb 13 16:13:44 2001
+++ linux-2.4.3-ac2/arch/s390x/defconfig	Wed Apr  4 15:56:25 2001
@@ -217,3 +217,4 @@
 #
 # Kernel hacking
 #
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sh/config.in linux-2.4.3-ac2/arch/sh/config.in
--- linux-2.4.3-ac2.orig/arch/sh/config.in	Thu Jan  4 15:19:13 2001
+++ linux-2.4.3-ac2/arch/sh/config.in	Wed Apr  4 16:10:03 2001
@@ -265,4 +265,5 @@
    bool 'GDB Stub kernel debug' CONFIG_DEBUG_KERNEL_WITH_GDB_STUB
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sh/defconfig linux-2.4.3-ac2/arch/sh/defconfig
--- linux-2.4.3-ac2.orig/arch/sh/defconfig	Wed Aug  9 15:59:04 2000
+++ linux-2.4.3-ac2/arch/sh/defconfig	Wed Apr  4 15:58:27 2001
@@ -204,3 +204,4 @@
 CONFIG_DEBUG_KERNEL_WITH_GDB_STUB=y
 CONFIG_GDB_STUB_VBR=a0000000
 CONFIG_SH_EARLY_PRINTK=y
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc/config.in linux-2.4.3-ac2/arch/sparc/config.in
--- linux-2.4.3-ac2.orig/arch/sparc/config.in	Sun Feb 18 21:49:44 2001
+++ linux-2.4.3-ac2/arch/sparc/config.in	Wed Apr  4 16:10:14 2001
@@ -261,4 +261,5 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc/defconfig linux-2.4.3-ac2/arch/sparc/defconfig
--- linux-2.4.3-ac2.orig/arch/sparc/defconfig	Wed Apr  4 15:12:47 2001
+++ linux-2.4.3-ac2/arch/sparc/defconfig	Wed Apr  4 15:59:00 2001
@@ -381,3 +381,4 @@
 # Kernel hacking
 #
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc64/config.in linux-2.4.3-ac2/arch/sparc64/config.in
--- linux-2.4.3-ac2.orig/arch/sparc64/config.in	Wed Apr  4 15:22:51 2001
+++ linux-2.4.3-ac2/arch/sparc64/config.in	Wed Apr  4 16:10:23 2001
@@ -349,4 +349,5 @@
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 #bool 'ECache flush trap support at ta 0x72' CONFIG_EC_FLUSH_TRAP
+int 'Printk buffer size (in K bytes)' CONFIG_PRINTK_BUF_LEN 16
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc64/defconfig linux-2.4.3-ac2/arch/sparc64/defconfig
--- linux-2.4.3-ac2.orig/arch/sparc64/defconfig	Wed Apr  4 15:12:47 2001
+++ linux-2.4.3-ac2/arch/sparc64/defconfig	Wed Apr  4 15:59:18 2001
@@ -640,3 +640,5 @@
 # Kernel hacking
 #
 # CONFIG_MAGIC_SYSRQ is not set
+CONFIG_PRINTK_BUF_LEN=16
+
diff -u --new-file --recursive linux-2.4.3-ac2.orig/kernel/printk.c linux-2.4.3-ac2/kernel/printk.c
--- linux-2.4.3-ac2.orig/kernel/printk.c	Wed Apr  4 15:23:31 2001
+++ linux-2.4.3-ac2/kernel/printk.c	Wed Apr  4 16:01:28 2001
@@ -27,7 +27,7 @@
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+#define LOG_BUF_LEN (CONFIG_PRINTK_BUF_LEN*1024) /* This must be a power of two */
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
 /* printk's without a loglevel use this.. */

--------------070CAA0D8AF1D98A14E6F8B4--

