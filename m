Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRJEBVU>; Thu, 4 Oct 2001 21:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277297AbRJEBVM>; Thu, 4 Oct 2001 21:21:12 -0400
Received: from dot.cygnus.com ([205.180.230.224]:1540 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S277294AbRJEBVE>;
	Thu, 4 Oct 2001 21:21:04 -0400
Date: Thu, 4 Oct 2001 18:21:24 -0700
From: Richard Henderson <rth@dot.cygnus.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.11-pre3: fix ev67 configury
Message-ID: <20011004182124.A796@dot.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Jay Estabrook:

(1) Make sure EV6 is defined when EV67 is defined.  Cleans up some ifdefs.
(2) Make sure EV67 is defined for appropriate platforms so that the ev67
    right arch/alpha/lib/ code is pulled in.


r~


diff -rup 2.4.10-dist/arch/alpha/config.in 2.4.10/arch/alpha/config.in
--- 2.4.10-dist/arch/alpha/config.in	Sun Aug 12 10:51:41 2001
+++ 2.4.10/arch/alpha/config.in	Thu Oct  4 17:03:32 2001
@@ -142,15 +142,18 @@ if [ "$CONFIG_ALPHA_DP264" = "y" -o "$CO
 then
 	define_bool CONFIG_ALPHA_EV6 y
 	define_bool CONFIG_ALPHA_TSUNAMI y
+	bool 'EV67 (or later) CPU (speed > 600MHz)?' CONFIG_ALPHA_EV67
 fi
 if [ "$CONFIG_ALPHA_SHARK" = "y" ]
 then
+	define_bool CONFIG_ALPHA_EV6 y
 	define_bool CONFIG_ALPHA_EV67 y
 	define_bool CONFIG_ALPHA_TSUNAMI y
 fi
 if [ "$CONFIG_ALPHA_WILDFIRE" = "y" -o "$CONFIG_ALPHA_TITAN" = "y" ]
 then
-        define_bool CONFIG_ALPHA_EV6 y
+	define_bool CONFIG_ALPHA_EV6 y
+	define_bool CONFIG_ALPHA_EV67 y
 fi
 if [ "$CONFIG_ALPHA_RAWHIDE" = "y" ]
 then
@@ -170,6 +173,7 @@ if [ "$CONFIG_ALPHA_NAUTILUS" = "y" ]
 then
 	define_bool CONFIG_ALPHA_IRONGATE y
 	define_bool CONFIG_ALPHA_EV6 y
+	define_bool CONFIG_ALPHA_EV67 y
 fi
 
 if [ "$CONFIG_ALPHA_JENSEN" = "y" -o "$CONFIG_ALPHA_MIKASA" = "y" \
diff -rup 2.4.10-dist/include/asm-alpha/cache.h 2.4.10/include/asm-alpha/cache.h
--- 2.4.10-dist/include/asm-alpha/cache.h	Sun Aug 12 10:38:47 2001
+++ 2.4.10/include/asm-alpha/cache.h	Thu Oct  4 16:12:04 2001
@@ -7,7 +7,7 @@
 #include <linux/config.h>
 
 /* Bytes per L1 (data) cache line. */
-#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
+#if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_EV6)
 # define L1_CACHE_BYTES     64
 # define L1_CACHE_SHIFT     6
 #else
diff -rup 2.4.10-dist/include/asm-alpha/pgtable.h 2.4.10/include/asm-alpha/pgtable.h
--- 2.4.10-dist/include/asm-alpha/pgtable.h	Thu Sep 13 15:21:32 2001
+++ 2.4.10/include/asm-alpha/pgtable.h	Thu Oct  4 16:12:05 2001
@@ -178,8 +178,7 @@ extern unsigned long __zero_page(void);
 #error "EV6-only feature in a generic kernel"
 #endif
 #if defined(CONFIG_ALPHA_GENERIC) || \
-    ((defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)) && \
-     !defined(USE_48_BIT_KSEG))
+    (defined(CONFIG_ALPHA_EV6) && !defined(USE_48_BIT_KSEG))
 #define PHYS_TWIDDLE(phys) \
   ((((phys) & 0xc0000000000UL) == 0x40000000000UL) \
   ? ((phys) ^= 0xc0000000000UL) : (phys))
diff -rup 2.4.10-dist/include/asm-alpha/system.h 2.4.10/include/asm-alpha/system.h
--- 2.4.10-dist/include/asm-alpha/system.h	Sun Aug 12 10:38:47 2001
+++ 2.4.10/include/asm-alpha/system.h	Thu Oct  4 16:12:04 2001
@@ -192,7 +192,7 @@ enum implver_enum {
 #ifdef CONFIG_ALPHA_EV5
 #define implver() IMPLVER_EV5
 #endif
-#if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
+#if defined(CONFIG_ALPHA_EV6)
 #define implver() IMPLVER_EV6
 #endif
 #endif
