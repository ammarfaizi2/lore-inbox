Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWH1CRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWH1CRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 22:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWH1CRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 22:17:16 -0400
Received: from xenotime.net ([66.160.160.81]:63973 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932356AbWH1CRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 22:17:15 -0400
Date: Sun, 27 Aug 2006 19:20:30 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: Re: [PATCH 2/7] rename the provided execve functions to
 kernel_execve
Message-Id: <20060827192030.633cf467.rdunlap@xenotime.net>
In-Reply-To: <20060827215636.091665000@klappe.arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
	<20060827215636.091665000@klappe.arndb.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 23:47:36 +0200 Arnd Bergmann wrote:

> --- linux-cg.orig/drivers/sbus/char/envctrl.c	2006-08-27 23:36:36.000000000 +0200
> +++ linux-cg/drivers/sbus/char/envctrl.c	2006-08-27 23:36:42.000000000 +0200
> @@ -19,9 +19,6 @@
>   *              Daniele Bellucci <bellucda@tiscali.it>
>   */
>  
> -#define __KERNEL_SYSCALLS__
> -static int errno;
> -
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/kthread.h>
> @@ -982,7 +979,7 @@
>  
>  	inprog = 1;
>  	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
> -	if (0 > execve("/sbin/shutdown", argv, envp)) {
> +	if (0 > kernel_execve("/sbin/shutdown", argv, envp)) {
>  		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
>  		inprog = 0;  /* unlikely to succeed, but we could try again */
>  	}

Linux just educated the git mailing list (yesterday) about ordering
of comparisons, so while here, please change the order inside the if()
to be like the others:
	if (kernel_execv(...) < 0)


> Index: linux-cg/include/linux/syscalls.h
> ===================================================================
> --- linux-cg.orig/include/linux/syscalls.h	2006-08-27 23:36:36.000000000 +0200
> +++ linux-cg/include/linux/syscalls.h	2006-08-27 23:36:42.000000000 +0200
> @@ -597,4 +597,6 @@
>  asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
>  				    size_t len);
>  
> +int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
> +
>  #endif

Question:
All other syscalls (in syscalls.h) return long or unsigned long
or ssize_t etc.  I.e., none of them return int.  Does this one
return int because it's strictly an inside-the-kernel "syscall",
not exposed to userspace?


---
~Randy
