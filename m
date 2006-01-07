Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWAGXtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWAGXtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWAGXtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:49:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161072AbWAGXs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:48:59 -0500
Date: Sat, 7 Jan 2006 15:48:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-Id: <20060107154842.5832af75.akpm@osdl.org>
In-Reply-To: <20060107210646.GA26124@mipter.zuzino.mipt.ru>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<20060107210646.GA26124@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> alpha Just Broken (TM)
> ----------------------------------------------------------------------------
>   CC      arch/alpha/kernel/asm-offsets.s
> In file included from include/asm/user.h:5,
>                  from include/linux/user.h:1,
>                  from include/linux/kernel.h:16,
>                  from include/linux/spinlock.h:54,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
>                  from arch/alpha/kernel/asm-offsets.c:9:
> include/linux/ptrace.h: In function `ptrace_link':
> include/linux/ptrace.h:100: error: dereferencing pointer to incomplete type
> include/linux/ptrace.h: In function `ptrace_unlink':
> include/linux/ptrace.h:105: error: dereferencing pointer to incomplete type
> make[1]: *** [arch/alpha/kernel/asm-offsets.s] Error 1

This is caused by the inclusion of user.h in kernel.h added by
dump_thread-cleanup.patch.

Fix:

--- 25-alpha/include/linux/kernel.h~dump_thread-cleanup-fix	2006-01-07 15:46:50.000000000 -0800
+++ 25-alpha-akpm/include/linux/kernel.h	2006-01-07 15:47:20.000000000 -0800
@@ -13,7 +13,6 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
-#include <linux/user.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
 
@@ -48,6 +47,8 @@ extern int console_printk[];
 #define default_console_loglevel (console_printk[3])
 
 struct completion;
+struct pt_regs;
+struct user;
 
 /**
  * might_sleep - annotation for functions that can sleep
@@ -124,7 +125,6 @@ extern int __kernel_text_address(unsigne
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
-struct pt_regs;
 extern void dump_thread(struct pt_regs *regs, struct user *dump);
 
 #ifdef CONFIG_PRINTK
_

