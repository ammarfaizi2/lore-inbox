Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbUKYFCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbUKYFCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 00:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUKYFCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 00:02:47 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:54453 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262973AbUKYFCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 00:02:44 -0500
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1101323621.2811.24.camel@laptop.fenrus.org>
References: <1101314988.1714.194.camel@mulgrave> 
	<1101323621.2811.24.camel@laptop.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Nov 2004 22:27:38 -0600
Message-Id: <1101356864.4007.35.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 13:13, Arjan van de Ven wrote:
> while I agree with 100Hz for slower cpus, I rather have a config option for it so people
> (and distros) can select it independent of the exact cpu type they want to compile a kernel for

How about this then?

James

===== arch/i386/Kconfig 1.134 vs edited =====
--- 1.134/arch/i386/Kconfig	2004-10-21 20:35:11 -05:00
+++ edited/arch/i386/Kconfig	2004-11-24 20:56:53 -06:00
@@ -330,6 +330,14 @@
 
 endchoice
 
+config X86_HZ
+       int "Clock Tick Rate"
+       default 1000 if !(M386 || M486 || M586 || M586TSC || M586MMX)	
+       default 100 if (M386 || M486 || M586 || M586TSC || M586MMX)	
+       help
+	  Select the kernel clock tick rate in interrupts per second.
+	  Slower processors should choose 100; everything else 1000.
+
 config X86_GENERIC
        bool "Generic x86 support"
        help
===== include/asm-i386/param.h 1.6 vs edited =====
--- 1.6/include/asm-i386/param.h	2004-06-24 03:55:46 -05:00
+++ edited/include/asm-i386/param.h	2004-11-24 20:56:18 -06:00
@@ -1,8 +1,10 @@
 #ifndef _ASMi386_PARAM_H
 #define _ASMi386_PARAM_H
 
+#include <linux/config.h>
+
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		(CONFIG_X86_HZ)
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
 #endif

