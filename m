Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWAHMOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWAHMOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbWAHMOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:14:37 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:10264 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751377AbWAHMOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:14:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=iqXRZ0GxO7/TVlSmjqXof4qTb2+Jyu7BYKFKgwOfoveyp7BBEoqnYGzBRAuUrVrsXHL/d+Rauh7EpYcBlo8xBi9U3E8BePyiICptlJZECpy03mvCIkU3hyTFflyQxLTlp78MQbowmAnSIe18ysPsSRFAwjGIeCI3Doz4E/4dUOs=
Date: Sun, 8 Jan 2006 15:31:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-ID: <20060108123132.GB9815@mipter.zuzino.mipt.ru>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru> <20060107154842.5832af75.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107154842.5832af75.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 03:48:42PM -0800, Andrew Morton wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >                  from arch/alpha/kernel/asm-offsets.c:9:
> > include/linux/ptrace.h: In function `ptrace_link':
> > include/linux/ptrace.h:100: error: dereferencing pointer to incomplete type
> > include/linux/ptrace.h: In function `ptrace_unlink':
> > include/linux/ptrace.h:105: error: dereferencing pointer to incomplete type
> > make[1]: *** [arch/alpha/kernel/asm-offsets.s] Error 1
>
> This is caused by the inclusion of user.h in kernel.h added by
> dump_thread-cleanup.patch.
>
> Fix:
>
> --- 25-alpha/include/linux/kernel.h~dump_thread-cleanup-fix	2006-01-07 15:46:50.000000000 -0800
> +++ 25-alpha-akpm/include/linux/kernel.h	2006-01-07 15:47:20.000000000 -0800
> @@ -13,7 +13,6 @@
>  #include <linux/types.h>
>  #include <linux/compiler.h>
>  #include <linux/bitops.h>
> -#include <linux/user.h>
>  #include <asm/byteorder.h>
>  #include <asm/bug.h>
>  
> @@ -48,6 +47,8 @@ extern int console_printk[];
>  #define default_console_loglevel (console_printk[3])
>  
>  struct completion;
> +struct pt_regs;
> +struct user;
>  
>  /**
>   * might_sleep - annotation for functions that can sleep
> @@ -124,7 +125,6 @@ extern int __kernel_text_address(unsigne
>  extern int kernel_text_address(unsigned long addr);
>  extern int session_of_pgrp(int pgrp);
>  
> -struct pt_regs;
>  extern void dump_thread(struct pt_regs *regs, struct user *dump);
>  
>  #ifdef CONFIG_PRINTK
> _

Yum. It also remove truckload of warnings from parisc build:

include/linux/kernel.h:128: warning: "struct user" declared inside parameter list
include/linux/kernel.h:128: warning: its scope is only this definition or declaration, which is probably not what you want

