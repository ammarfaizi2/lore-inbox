Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVDAUaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVDAUaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVDAUai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:30:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:35537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262892AbVDAU1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:27:02 -0500
Date: Fri, 1 Apr 2005 12:26:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up kernel messages
Message-Id: <20050401122641.7c52eaab.akpm@osdl.org>
In-Reply-To: <20050401200851.GG15453@waste.org>
References: <20050401200851.GG15453@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> This patch tidies up those annoying kernel messages. A typical kernel
>  boot now looks like this:
> 
>  Loading Linux... Uncompressing kernel...
>  #
> 
>  See? Much nicer. This patch saves about 375k on my laptop config and
>  nearly 100k on minimal configs.
> 

heh.  Please take a look at
http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0709.html, see if
Graham did anything which you missed.

One problem was that

	printk("foo");

will still cause the string "foo\0" to appear in the kernel image.  That
was fixed in later gcc's, but it would be interesting to know which
compilers get it right.

> 
>  Index: af/include/linux/kernel.h
>  ===================================================================
>  --- af.orig/include/linux/kernel.h	2005-04-01 00:32:18.000000000 -0800
>  +++ af/include/linux/kernel.h	2005-04-01 10:38:43.000000000 -0800
>  @@ -115,10 +115,19 @@ extern int __kernel_text_address(unsigne
>   extern int kernel_text_address(unsigned long addr);
>   extern int session_of_pgrp(int pgrp);
>   
>  +#ifdef CONFIG_PRINTK
>   asmlinkage int vprintk(const char *fmt, va_list args)
>   	__attribute__ ((format (printf, 1, 0)));
>   asmlinkage int printk(const char * fmt, ...)
>   	__attribute__ ((format (printf, 1, 2)));
>  +#else
>  +static inline int vprintk(const char *s, va_list args)
>  +	__attribute__ ((format (printf, 1, 0)));
>  +static inline int vprintk(const char *s, va_list args) { return 0; }
>  +static inline int printk(const char *s, ...)
>  +	__attribute__ ((format (printf, 1, 2)));
>  +static inline int printk(const char *s, ...) { return 0; }
>  +#endif

Actually printk() is supposed to return the number of chars which it
printed.  So if someone is doing:

	while (len < 40)
		len += printk("something");

you've gone and made them lock up.

But I think the number of places where we examine the printk return value
is near zero.

