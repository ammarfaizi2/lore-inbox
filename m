Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTKTUyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 15:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTKTUyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 15:54:31 -0500
Received: from users.ccur.com ([208.248.32.211]:46057 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S262092AbTKTUy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 15:54:29 -0500
Date: Thu, 20 Nov 2003 15:54:25 -0500
From: Joe Korty <joe.korty@ccur.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test9-mm4-lockmeter-preemption
Message-ID: <20031120205424.GA5912@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11/20/2003: base is 2.6.0-test9-mm4
 o Fix lockmeter under preemption (i386 only)
 o Fix compile warnings in kernel/lockmeter.c

Joe

diff -ura base/arch/i386/Kconfig new/arch/i386/Kconfig
--- base/arch/i386/Kconfig	2003-11-20 14:47:30.000000000 -0500
+++ new/arch/i386/Kconfig	2003-11-20 15:01:21.000000000 -0500
@@ -1300,7 +1300,7 @@
 	  
 config LOCKMETER
 	bool "Kernel lock metering"
-	depends on SMP && !PREEMPT
+	depends on SMP
 	help
 	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
 	  but allows you to see various statistics using the lockstat command.
diff -ura base/include/asm-i386/spinlock.h new/include/asm-i386/spinlock.h
--- base/include/asm-i386/spinlock.h	2003-11-20 14:47:30.000000000 -0500
+++ new/include/asm-i386/spinlock.h	2003-11-20 15:14:20.000000000 -0500
@@ -270,10 +270,12 @@
 	return 0;
 
 slow_path:
+	preempt_disable();
 	_metered_spin_lock(lock);
 	if (atomic_dec_and_test(atomic))
 		return 1;
 	_metered_spin_unlock(lock);
+	preempt_enable();
 	return 0;
 }
 
diff -ura base/kernel/lockmeter.c new/kernel/lockmeter.c
--- base/kernel/lockmeter.c	2003-11-20 14:47:30.000000000 -0500
+++ new/kernel/lockmeter.c	2003-11-20 15:20:20.000000000 -0500
@@ -23,6 +23,7 @@
 #include <linux/vmalloc.h>
 #include <linux/spinlock.h>
 #include <linux/utsname.h>
+#include <linux/module.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
