Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTHZEa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbTHZEa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:30:26 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:41227 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262571AbTHZEaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:30:17 -0400
Date: Tue, 26 Aug 2003 06:25:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] make log buffer length selectable
Message-ID: <20030826042550.GJ734@alpha.home.local>
References: <200308251148.h7PBmU8B027700@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308251148.h7PBmU8B027700@hera.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 04:48:30AM -0700, Marcelo Tosatti wrote:
> final:
> 
> - 2.4.22-rc4 was released as 2.4.22 with no changes.

Hi Marcelo,

as you requested, here is the log_buf_len patch for inclusion in 23-pre.

Cheers,
Willy


diff -urN wt10-pre3/Documentation/Configure.help wt10-pre3-log-buf-len/Documentation/Configure.help
--- wt10-pre3/Documentation/Configure.help	Wed Mar 19 09:58:25 2003
+++ wt10-pre3-log-buf-len/Documentation/Configure.help	Tue Mar 25 08:20:35 2003
@@ -25231,6 +25231,19 @@
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
diff -urN wt10-pre3/arch/i386/config.in wt10-pre3-log-buf-len/arch/i386/config.in
--- wt10-pre3/arch/i386/config.in	Wed Mar 19 09:58:25 2003
+++ wt10-pre3-log-buf-len/arch/i386/config.in	Tue Mar 25 08:25:12 2003
@@ -508,6 +508,8 @@
     string '   Initial kernel command line' CONFIG_CMDLINE "root=301 ro"
 fi
 
+int 'Kernel messages buffer length shift (0 = default)' CONFIG_LOG_BUF_SHIFT 0
+
 endmenu
 
 source lib/Config.in
diff -urN wt10-pre3/kernel/printk.c wt10-pre3-log-buf-len/kernel/printk.c
--- wt10-pre3/kernel/printk.c	Wed Mar 19 09:58:20 2003
+++ wt10-pre3-log-buf-len/kernel/printk.c	Tue Mar 25 08:14:55 2003
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
