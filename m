Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbRDEUjF>; Thu, 5 Apr 2001 16:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRDEUi5>; Thu, 5 Apr 2001 16:38:57 -0400
Received: from ns2.cypress.com ([157.95.67.5]:55432 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S132387AbRDEUin>;
	Thu, 5 Apr 2001 16:38:43 -0400
Message-ID: <3ACCD760.23E52033@cypress.com>
Date: Thu, 05 Apr 2001 15:36:48 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Config printk buffer size
In-Reply-To: <E14kxha-000366-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------D5CC5D3019889F6E04122D4B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D5CC5D3019889F6E04122D4B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> Looks ok to me but given the ability of the average kernel hacker to read
> help texts I;d rather it was a choice menu of say

OK, I guess I gave too much credit :)

This gives 4 options, 4K, 8K, 16K, and 32K.
4K is for the embedded guys, but they might want even less.
32K is enought for 9 RAID1 and RAID0 volumes.

64K seams like overkill too me. But if anyone wants/needs it,
I'll add it in. Same for smaller buffers.

Now to work on using a boot param, and reducing after
booting with dmesg. That'll take me a while I'm sure.

	-Thomas
--------------D5CC5D3019889F6E04122D4B
Content-Type: text/plain; charset=us-ascii;
 name="printk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="printk.patch"

diff -u --new-file --recursive linux-2.4.3-ac2.orig/Documentation/Configure.help linux-2.4.3-ac2/Documentation/Configure.help
--- linux-2.4.3-ac2.orig/Documentation/Configure.help	Wed Apr  4 15:22:43 2001
+++ linux-2.4.3-ac2/Documentation/Configure.help	Thu Apr  5 14:12:00 2001
@@ -15192,6 +15192,14 @@
   keys are documented in Documentation/sysrq.txt. Don't say Y unless
   you really know what this hack does.
 
+Printk buffer size
+CONFIG_PRINTK_BUF_LEN_4K
+  Printk buffer size in K bytes.
+  The 2.2.x kernels used a default of 8. The 2.4.x kernels
+  use a default of 16. Systems with many Software-RAID volumes
+  should increase since the md.o drivers have a lot of printk
+  output during boot.
+
 ISDN subsystem
 CONFIG_ISDN
   ISDN ("Integrated Services Digital Networks", called RNIS in France)
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/alpha/config.in linux-2.4.3-ac2/arch/alpha/config.in
--- linux-2.4.3-ac2.orig/arch/alpha/config.in	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/alpha/config.in	Thu Apr  5 10:53:07 2001
@@ -361,7 +361,11 @@
 fi
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
-
 bool 'Legacy kernel start address' CONFIG_ALPHA_LEGACY_START_ADDRESS
 
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/alpha/defconfig linux-2.4.3-ac2/arch/alpha/defconfig
--- linux-2.4.3-ac2.orig/arch/alpha/defconfig	Wed Apr  4 15:12:44 2001
+++ linux-2.4.3-ac2/arch/alpha/defconfig	Thu Apr  5 10:58:14 2001
@@ -635,3 +635,7 @@
 CONFIG_MATHEMU=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_ALPHA_LEGACY_START_ADDRESS=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/config.in linux-2.4.3-ac2/arch/arm/config.in
--- linux-2.4.3-ac2.orig/arch/arm/config.in	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/arm/config.in	Thu Apr  5 10:53:20 2001
@@ -414,6 +414,7 @@
 bool 'Verbose user fault messages' CONFIG_DEBUG_USER
 bool 'Include debugging information in kernel binary' CONFIG_DEBUG_INFO
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
 if [ "$CONFIG_CPU_26" = "y" ]; then
    bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE
 fi
@@ -427,4 +428,10 @@
       fi
    fi
 fi
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/a5k linux-2.4.3-ac2/arch/arm/def-configs/a5k
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/a5k	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/a5k	Thu Apr  5 11:09:28 2001
@@ -534,3 +534,7 @@
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_NO_PGT_CACHE=y
 CONFIG_DEBUG_LL=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/assabet linux-2.4.3-ac2/arch/arm/def-configs/assabet
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/assabet	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/assabet	Thu Apr  5 11:09:02 2001
@@ -567,3 +567,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/brutus linux-2.4.3-ac2/arch/arm/def-configs/brutus
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/brutus	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/brutus	Thu Apr  5 11:08:49 2001
@@ -294,3 +294,7 @@
 CONFIG_DEBUG_INFO=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/cerf linux-2.4.3-ac2/arch/arm/def-configs/cerf
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/cerf	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/cerf	Thu Apr  5 11:08:34 2001
@@ -432,3 +432,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/clps7500 linux-2.4.3-ac2/arch/arm/def-configs/clps7500
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/clps7500	Mon Sep 18 17:15:24 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/clps7500	Thu Apr  5 11:08:25 2001
@@ -488,3 +488,7 @@
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/ebsa110 linux-2.4.3-ac2/arch/arm/def-configs/ebsa110
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/ebsa110	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/ebsa110	Thu Apr  5 11:08:15 2001
@@ -503,3 +503,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/empeg linux-2.4.3-ac2/arch/arm/def-configs/empeg
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/empeg	Wed Oct 20 18:29:08 1999
+++ linux-2.4.3-ac2/arch/arm/def-configs/empeg	Thu Apr  5 11:08:02 2001
@@ -262,3 +262,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/footbridge linux-2.4.3-ac2/arch/arm/def-configs/footbridge
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/footbridge	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/footbridge	Thu Apr  5 11:06:55 2001
@@ -892,3 +892,7 @@
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_LL=y
 # CONFIG_DEBUG_DC21285_PORT is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/graphicsclient linux-2.4.3-ac2/arch/arm/def-configs/graphicsclient
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/graphicsclient	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/graphicsclient	Thu Apr  5 11:06:45 2001
@@ -542,3 +542,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/integrator linux-2.4.3-ac2/arch/arm/def-configs/integrator
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/integrator	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/integrator	Thu Apr  5 11:06:34 2001
@@ -509,3 +509,7 @@
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_LL=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/lart linux-2.4.3-ac2/arch/arm/def-configs/lart
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/lart	Mon Sep 18 17:15:24 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/lart	Thu Apr  5 11:06:10 2001
@@ -493,3 +493,7 @@
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_LL=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/lusl7200 linux-2.4.3-ac2/arch/arm/def-configs/lusl7200
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/lusl7200	Mon Jun 19 19:59:33 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/lusl7200	Thu Apr  5 11:05:58 2001
@@ -227,3 +227,7 @@
 CONFIG_DEBUG_INFO=y
 # CONFIG_MAGIC_SYSRQ is not set
 CONFIG_DEBUG_LL=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/neponset linux-2.4.3-ac2/arch/arm/def-configs/neponset
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/neponset	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/neponset	Thu Apr  5 11:05:48 2001
@@ -574,3 +574,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/pangolin linux-2.4.3-ac2/arch/arm/def-configs/pangolin
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/pangolin	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/pangolin	Thu Apr  5 11:05:35 2001
@@ -489,3 +489,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/rpc linux-2.4.3-ac2/arch/arm/def-configs/rpc
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/rpc	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/rpc	Thu Apr  5 11:05:25 2001
@@ -708,3 +708,7 @@
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_LL=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/shark linux-2.4.3-ac2/arch/arm/def-configs/shark
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/shark	Mon Sep 18 17:15:24 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/shark	Thu Apr  5 11:05:15 2001
@@ -653,3 +653,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 CONFIG_DEBUG_LL=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/sherman linux-2.4.3-ac2/arch/arm/def-configs/sherman
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/sherman	Mon Nov 27 19:07:59 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/sherman	Thu Apr  5 11:05:03 2001
@@ -208,3 +208,7 @@
 CONFIG_DEBUG_INFO=y
 # CONFIG_MAGIC_SYSRQ is not set
 CONFIG_DEBUG_LL=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/def-configs/victor linux-2.4.3-ac2/arch/arm/def-configs/victor
--- linux-2.4.3-ac2.orig/arch/arm/def-configs/victor	Mon Jun 19 19:59:33 2000
+++ linux-2.4.3-ac2/arch/arm/def-configs/victor	Thu Apr  5 11:04:48 2001
@@ -201,3 +201,7 @@
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/arm/defconfig linux-2.4.3-ac2/arch/arm/defconfig
--- linux-2.4.3-ac2.orig/arch/arm/defconfig	Mon Jun 19 19:59:33 2000
+++ linux-2.4.3-ac2/arch/arm/defconfig	Thu Apr  5 10:58:29 2001
@@ -720,3 +720,7 @@
 # CONFIG_DEBUG_INFO is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_LL is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/cris/config.in linux-2.4.3-ac2/arch/cris/config.in
--- linux-2.4.3-ac2.orig/arch/cris/config.in	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/cris/config.in	Thu Apr  5 10:53:32 2001
@@ -223,4 +223,10 @@
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/cris/defconfig linux-2.4.3-ac2/arch/cris/defconfig
--- linux-2.4.3-ac2.orig/arch/cris/defconfig	Wed Apr  4 15:22:44 2001
+++ linux-2.4.3-ac2/arch/cris/defconfig	Thu Apr  5 10:58:42 2001
@@ -472,3 +472,7 @@
 # Kernel hacking
 #
 # CONFIG_PROFILE is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/i386/config.in linux-2.4.3-ac2/arch/i386/config.in
--- linux-2.4.3-ac2.orig/arch/i386/config.in	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/i386/config.in	Thu Apr  5 10:53:51 2001
@@ -384,9 +384,15 @@
 
 bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
 bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
-bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
+bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
+
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/i386/defconfig linux-2.4.3-ac2/arch/i386/defconfig
--- linux-2.4.3-ac2.orig/arch/i386/defconfig	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/i386/defconfig	Thu Apr  5 10:58:55 2001
@@ -722,3 +722,7 @@
 #
 CONFIG_DEBUG_IOVIRT=y
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ia64/config.in linux-2.4.3-ac2/arch/ia64/config.in
--- linux-2.4.3-ac2.orig/arch/ia64/config.in	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/ia64/config.in	Thu Apr  5 10:54:01 2001
@@ -256,4 +256,9 @@
 bool 'Enable new unwind support' CONFIG_IA64_NEW_UNWIND
 bool 'Disable VHPT' CONFIG_DISABLE_VHPT
 
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ia64/defconfig linux-2.4.3-ac2/arch/ia64/defconfig
--- linux-2.4.3-ac2.orig/arch/ia64/defconfig	Thu Jun 22 09:09:44 2000
+++ linux-2.4.3-ac2/arch/ia64/defconfig	Thu Apr  5 10:59:07 2001
@@ -276,3 +276,7 @@
 # CONFIG_IA64_DEBUG_IRQ is not set
 # CONFIG_IA64_PRINT_HAZARDS is not set
 # CONFIG_KDB is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/m68k/config.in linux-2.4.3-ac2/arch/m68k/config.in
--- linux-2.4.3-ac2.orig/arch/m68k/config.in	Wed Apr  4 15:22:45 2001
+++ linux-2.4.3-ac2/arch/m68k/config.in	Thu Apr  5 10:54:13 2001
@@ -540,4 +540,10 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/m68k/defconfig linux-2.4.3-ac2/arch/m68k/defconfig
--- linux-2.4.3-ac2.orig/arch/m68k/defconfig	Mon Jun 19 14:56:08 2000
+++ linux-2.4.3-ac2/arch/m68k/defconfig	Thu Apr  5 10:59:19 2001
@@ -327,3 +327,7 @@
 # Kernel hacking
 #
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/config.in linux-2.4.3-ac2/arch/mips/config.in
--- linux-2.4.3-ac2.orig/arch/mips/config.in	Wed Apr  4 15:22:46 2001
+++ linux-2.4.3-ac2/arch/mips/config.in	Thu Apr  5 10:54:33 2001
@@ -400,4 +400,10 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig linux-2.4.3-ac2/arch/mips/defconfig
--- linux-2.4.3-ac2.orig/arch/mips/defconfig	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig	Thu Apr  5 11:00:15 2001
@@ -355,3 +355,7 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-cobalt linux-2.4.3-ac2/arch/mips/defconfig-cobalt
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-cobalt	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-cobalt	Thu Apr  5 11:00:31 2001
@@ -596,3 +596,7 @@
 # CONFIG_CROSSCOMPILE is not set
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-ddb5476 linux-2.4.3-ac2/arch/mips/defconfig-ddb5476
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-ddb5476	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-ddb5476	Thu Apr  5 11:00:43 2001
@@ -539,3 +539,7 @@
 # CONFIG_LL_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-decstation linux-2.4.3-ac2/arch/mips/defconfig-decstation
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-decstation	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-decstation	Thu Apr  5 11:00:59 2001
@@ -328,3 +328,7 @@
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-ip22 linux-2.4.3-ac2/arch/mips/defconfig-ip22
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-ip22	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-ip22	Thu Apr  5 11:01:09 2001
@@ -355,3 +355,7 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-it8172 linux-2.4.3-ac2/arch/mips/defconfig-it8172
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-it8172	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-it8172	Thu Apr  5 11:01:29 2001
@@ -567,3 +567,7 @@
 # CONFIG_LL_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-orion linux-2.4.3-ac2/arch/mips/defconfig-orion
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-orion	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-orion	Thu Apr  5 11:01:39 2001
@@ -302,3 +302,7 @@
 #
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips/defconfig-rm200 linux-2.4.3-ac2/arch/mips/defconfig-rm200
--- linux-2.4.3-ac2.orig/arch/mips/defconfig-rm200	Wed Apr  4 15:22:47 2001
+++ linux-2.4.3-ac2/arch/mips/defconfig-rm200	Thu Apr  5 11:01:48 2001
@@ -363,3 +363,7 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_MIPS_FPE_MODULE is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/config.in linux-2.4.3-ac2/arch/mips64/config.in
--- linux-2.4.3-ac2.orig/arch/mips64/config.in	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/config.in	Thu Apr  5 10:54:24 2001
@@ -265,4 +265,10 @@
 fi
 bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/defconfig linux-2.4.3-ac2/arch/mips64/defconfig
--- linux-2.4.3-ac2.orig/arch/mips64/defconfig	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/defconfig	Thu Apr  5 10:59:34 2001
@@ -458,3 +458,7 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip22 linux-2.4.3-ac2/arch/mips64/defconfig-ip22
--- linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip22	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/defconfig-ip22	Thu Apr  5 10:59:47 2001
@@ -372,3 +372,7 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip27 linux-2.4.3-ac2/arch/mips64/defconfig-ip27
--- linux-2.4.3-ac2.orig/arch/mips64/defconfig-ip27	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/mips64/defconfig-ip27	Thu Apr  5 10:59:58 2001
@@ -458,3 +458,7 @@
 CONFIG_CROSSCOMPILE=y
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/parisc/config.common linux-2.4.3-ac2/arch/parisc/config.common
--- linux-2.4.3-ac2.orig/arch/parisc/config.common	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/parisc/config.common	Thu Apr  5 10:52:53 2001
@@ -156,4 +156,10 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/parisc/defconfig linux-2.4.3-ac2/arch/parisc/defconfig
--- linux-2.4.3-ac2.orig/arch/parisc/defconfig	Wed Apr  4 15:22:48 2001
+++ linux-2.4.3-ac2/arch/parisc/defconfig	Thu Apr  5 11:02:00 2001
@@ -475,3 +475,7 @@
 # Kernel hacking
 #
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/config.in linux-2.4.3-ac2/arch/ppc/config.in
--- linux-2.4.3-ac2.orig/arch/ppc/config.in	Wed Apr  4 15:22:49 2001
+++ linux-2.4.3-ac2/arch/ppc/config.in	Thu Apr  5 10:54:46 2001
@@ -351,4 +351,10 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/IVMS8_defconfig linux-2.4.3-ac2/arch/ppc/configs/IVMS8_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/IVMS8_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/IVMS8_defconfig	Thu Apr  5 11:12:18 2001
@@ -450,3 +450,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/SM850_defconfig linux-2.4.3-ac2/arch/ppc/configs/SM850_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/SM850_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/SM850_defconfig	Thu Apr  5 11:13:43 2001
@@ -418,3 +418,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/SPD823TS_defconfig linux-2.4.3-ac2/arch/ppc/configs/SPD823TS_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/SPD823TS_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/SPD823TS_defconfig	Thu Apr  5 11:13:54 2001
@@ -414,3 +414,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/TQM823L_defconfig linux-2.4.3-ac2/arch/ppc/configs/TQM823L_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/TQM823L_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/TQM823L_defconfig	Thu Apr  5 11:14:03 2001
@@ -417,3 +417,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/TQM850L_defconfig linux-2.4.3-ac2/arch/ppc/configs/TQM850L_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/TQM850L_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/TQM850L_defconfig	Thu Apr  5 11:14:13 2001
@@ -417,3 +417,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/TQM860L_defconfig linux-2.4.3-ac2/arch/ppc/configs/TQM860L_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/TQM860L_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/TQM860L_defconfig	Thu Apr  5 11:14:37 2001
@@ -417,3 +417,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/apus_defconfig linux-2.4.3-ac2/arch/ppc/configs/apus_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/apus_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/apus_defconfig	Thu Apr  5 11:11:28 2001
@@ -598,3 +598,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/bseip_defconfig linux-2.4.3-ac2/arch/ppc/configs/bseip_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/bseip_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/bseip_defconfig	Thu Apr  5 11:11:38 2001
@@ -430,3 +430,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/common_defconfig linux-2.4.3-ac2/arch/ppc/configs/common_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/common_defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/common_defconfig	Thu Apr  5 11:11:49 2001
@@ -838,3 +838,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/est8260_defconfig linux-2.4.3-ac2/arch/ppc/configs/est8260_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/est8260_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/est8260_defconfig	Thu Apr  5 11:11:59 2001
@@ -413,3 +413,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/ibmchrp_defconfig linux-2.4.3-ac2/arch/ppc/configs/ibmchrp_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/ibmchrp_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/ibmchrp_defconfig	Thu Apr  5 11:12:08 2001
@@ -634,3 +634,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/mbx_defconfig linux-2.4.3-ac2/arch/ppc/configs/mbx_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/mbx_defconfig	Mon Jan 22 17:41:14 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/mbx_defconfig	Thu Apr  5 11:12:27 2001
@@ -422,3 +422,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/oak_defconfig linux-2.4.3-ac2/arch/ppc/configs/oak_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/oak_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/oak_defconfig	Thu Apr  5 11:12:41 2001
@@ -393,3 +393,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/power3_defconfig linux-2.4.3-ac2/arch/ppc/configs/power3_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/power3_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/power3_defconfig	Thu Apr  5 11:13:13 2001
@@ -660,3 +660,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/rpxcllf_defconfig linux-2.4.3-ac2/arch/ppc/configs/rpxcllf_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/rpxcllf_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/rpxcllf_defconfig	Thu Apr  5 11:13:22 2001
@@ -429,3 +429,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/rpxlite_defconfig linux-2.4.3-ac2/arch/ppc/configs/rpxlite_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/rpxlite_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/rpxlite_defconfig	Thu Apr  5 11:13:32 2001
@@ -429,3 +429,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/configs/walnut_defconfig linux-2.4.3-ac2/arch/ppc/configs/walnut_defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/configs/walnut_defconfig	Mon Jan 22 17:41:15 2001
+++ linux-2.4.3-ac2/arch/ppc/configs/walnut_defconfig	Thu Apr  5 11:14:23 2001
@@ -396,3 +396,7 @@
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/ppc/defconfig linux-2.4.3-ac2/arch/ppc/defconfig
--- linux-2.4.3-ac2.orig/arch/ppc/defconfig	Wed Apr  4 15:12:46 2001
+++ linux-2.4.3-ac2/arch/ppc/defconfig	Thu Apr  5 11:02:15 2001
@@ -837,3 +837,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_KGDB is not set
 CONFIG_XMON=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390/config.in linux-2.4.3-ac2/arch/s390/config.in
--- linux-2.4.3-ac2.orig/arch/s390/config.in	Tue Feb 13 16:13:43 2001
+++ linux-2.4.3-ac2/arch/s390/config.in	Thu Apr  5 10:54:56 2001
@@ -66,5 +66,11 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 # this does not work. bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
 
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390/defconfig linux-2.4.3-ac2/arch/s390/defconfig
--- linux-2.4.3-ac2.orig/arch/s390/defconfig	Wed Apr  4 15:22:50 2001
+++ linux-2.4.3-ac2/arch/s390/defconfig	Thu Apr  5 11:02:28 2001
@@ -218,3 +218,7 @@
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390x/config.in linux-2.4.3-ac2/arch/s390x/config.in
--- linux-2.4.3-ac2.orig/arch/s390x/config.in	Tue Feb 13 16:13:44 2001
+++ linux-2.4.3-ac2/arch/s390x/config.in	Thu Apr  5 10:55:15 2001
@@ -69,5 +69,11 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 # this does not work. bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
 
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/s390x/defconfig linux-2.4.3-ac2/arch/s390x/defconfig
--- linux-2.4.3-ac2.orig/arch/s390x/defconfig	Tue Feb 13 16:13:44 2001
+++ linux-2.4.3-ac2/arch/s390x/defconfig	Thu Apr  5 11:02:38 2001
@@ -217,3 +217,7 @@
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sh/config.in linux-2.4.3-ac2/arch/sh/config.in
--- linux-2.4.3-ac2.orig/arch/sh/config.in	Thu Jan  4 15:19:13 2001
+++ linux-2.4.3-ac2/arch/sh/config.in	Thu Apr  5 10:55:27 2001
@@ -265,4 +265,10 @@
    bool 'GDB Stub kernel debug' CONFIG_DEBUG_KERNEL_WITH_GDB_STUB
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sh/defconfig linux-2.4.3-ac2/arch/sh/defconfig
--- linux-2.4.3-ac2.orig/arch/sh/defconfig	Wed Aug  9 15:59:04 2000
+++ linux-2.4.3-ac2/arch/sh/defconfig	Thu Apr  5 11:02:51 2001
@@ -204,3 +204,7 @@
 CONFIG_DEBUG_KERNEL_WITH_GDB_STUB=y
 CONFIG_GDB_STUB_VBR=a0000000
 CONFIG_SH_EARLY_PRINTK=y
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc/config.in linux-2.4.3-ac2/arch/sparc/config.in
--- linux-2.4.3-ac2.orig/arch/sparc/config.in	Sun Feb 18 21:49:44 2001
+++ linux-2.4.3-ac2/arch/sparc/config.in	Thu Apr  5 10:55:35 2001
@@ -261,4 +261,10 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc/defconfig linux-2.4.3-ac2/arch/sparc/defconfig
--- linux-2.4.3-ac2.orig/arch/sparc/defconfig	Wed Apr  4 15:12:47 2001
+++ linux-2.4.3-ac2/arch/sparc/defconfig	Thu Apr  5 11:03:01 2001
@@ -381,3 +381,7 @@
 # Kernel hacking
 #
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc64/config.in linux-2.4.3-ac2/arch/sparc64/config.in
--- linux-2.4.3-ac2.orig/arch/sparc64/config.in	Wed Apr  4 15:22:51 2001
+++ linux-2.4.3-ac2/arch/sparc64/config.in	Thu Apr  5 10:55:46 2001
@@ -349,4 +349,10 @@
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 #bool 'ECache flush trap support at ta 0x72' CONFIG_EC_FLUSH_TRAP
+
+choice 'Printk buffer size (in K bytes)' \
+	"4K			CONFIG_PRINTK_BUF_LEN_4K \
+	 8K			CONFIG_PRINTK_BUF_LEN_8K \
+	 16K			CONFIG_PRINTK_BUF_LEN_16K \
+	 32K			CONFIG_PRINTK_BUF_LEN_32K" 16K
 endmenu
diff -u --new-file --recursive linux-2.4.3-ac2.orig/arch/sparc64/defconfig linux-2.4.3-ac2/arch/sparc64/defconfig
--- linux-2.4.3-ac2.orig/arch/sparc64/defconfig	Wed Apr  4 15:12:47 2001
+++ linux-2.4.3-ac2/arch/sparc64/defconfig	Thu Apr  5 11:03:16 2001
@@ -640,3 +640,7 @@
 # Kernel hacking
 #
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_PRINTK_BUF_LEN_4K is not set
+# CONFIG_PRINTK_BUF_LEN_8K is not set
+CONFIG_PRINTK_BUF_LEN_16K=y
+# CONFIG_PRINTK_BUF_LEN_32K is not set
diff -u --new-file --recursive linux-2.4.3-ac2.orig/kernel/printk.c linux-2.4.3-ac2/kernel/printk.c
--- linux-2.4.3-ac2.orig/kernel/printk.c	Wed Apr  4 15:23:31 2001
+++ linux-2.4.3-ac2/kernel/printk.c	Thu Apr  5 11:26:29 2001
@@ -27,7 +27,24 @@
 
 #include <asm/uaccess.h>
 
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+
+#ifdef CONFIG_PRINTK_BUF_LEN_4K
+  #define CONFIG_PRINTK_BUF_LEN 4
+#endif
+#ifdef CONFIG_PRINTK_BUF_LEN_8K
+  #define CONFIG_PRINTK_BUF_LEN 8
+#endif
+#ifdef CONFIG_PRINTK_BUF_LEN_16K
+  #define CONFIG_PRINTK_BUF_LEN 16
+#endif
+#ifdef CONFIG_PRINTK_BUF_LEN_32K
+  #define CONFIG_PRINTK_BUF_LEN 32
+#endif
+#ifndef CONFIG_PRINTK_BUF_LEN
+  #define CONFIG_PRINTK_BUF_LEN 16
+#endif
+
+#define LOG_BUF_LEN (CONFIG_PRINTK_BUF_LEN*1024) /* This must be a power of two */
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
 /* printk's without a loglevel use this.. */

--------------D5CC5D3019889F6E04122D4B--

