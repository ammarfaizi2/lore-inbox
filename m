Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbUKEQoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUKEQoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUKEQob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:44:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:28840 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262685AbUKEQoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:44:25 -0500
Date: Fri, 5 Nov 2004 09:44:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2.6.10-rc1] ppc32: Fixup <asm/time.h> includes
Message-ID: <20041105164424.GN13456@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-ppc/time.h has a slightly odd include list which means that
some files include <asm/time.h> and also hope to get others that they
really shouldn't be.  This makes <asm/time.h> use <linux/types.h>
(time_t) and <linux/rtc.h> (struct rtc_time) instead of
<linux/mc16818rtc.h>, and fixes up the fallout from the change.

Compile-tested on lite5200, walnut and defconfig, along with by-hand'ing
everything else that included <asm/time.h>.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.1/arch/ppc/boot/simple/mpc52xx_tty.c	2004-07-29 06:08:45 -07:00
+++ edited/arch/ppc/boot/simple/mpc52xx_tty.c	2004-11-05 09:14:00 -07:00
@@ -17,6 +17,7 @@
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 #include <asm/serial.h>
+#include <asm/io.h>
 #include <asm/time.h>
 
 #if MPC52xx_PF_CONSOLE_PORT == 0
--- 1.5/arch/ppc/syslib/mpc52xx_setup.c	2004-09-25 03:58:17 -07:00
+++ edited/arch/ppc/syslib/mpc52xx_setup.c	2004-11-05 09:14:00 -07:00
@@ -19,6 +19,7 @@
 
 #include <linux/config.h>
 
+#include <asm/io.h>
 #include <asm/time.h>
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
--- 1.10/arch/ppc/syslib/todc_time.c	2004-10-05 23:05:22 -07:00
+++ edited/arch/ppc/syslib/todc_time.c	2004-11-05 09:14:00 -07:00
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/bcd.h>
+#include <linux/mc146818rtc.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -47,8 +48,6 @@
  * 	 we set the 'R' bit before reading them, they basically stop counting.
  * 	 					--MAG
  */
-
-extern spinlock_t	rtc_lock;
 
 /*
  * 'todc_info' should be initialized in your *_setup.c file to
--- 1.13/include/asm-ppc/time.h	2003-09-26 16:31:59 -07:00
+++ edited/include/asm-ppc/time.h	2004-11-05 09:14:00 -07:00
@@ -10,7 +10,8 @@
 #define __ASM_TIME_H__
 
 #include <linux/config.h>
-#include <linux/mc146818rtc.h>
+#include <linux/types.h>
+#include <linux/rtc.h>
 #include <linux/threads.h>
 
 #include <asm/reg.h>

-- 
Tom Rini
http://gate.crashing.org/~trini/
