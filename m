Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUIPOkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUIPOkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIPOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:37:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:14004 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268105AbUIPOeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:34:06 -0400
Date: Thu, 16 Sep 2004 07:33:22 -0700
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 merge: New exports.
Message-ID: <20040916143322.GB32352@kroah.com>
References: <1095333619.3327.189.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095333619.3327.189.camel@laptop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 09:20:19PM +1000, Nigel Cunningham wrote:
> 
> This patch adds exports for functions used by suspend2. Needed, of
> course, when suspend is compiled as modules.

Why even allow suspend as a module?  It seems like a pretty core chunk
of code that should be present all the time.

> diff -ruN linux-2.6.9-rc1/fs/buffer.c software-suspend-linux-2.6.9-rc1-rev3/fs/buffer.c
> --- linux-2.6.9-rc1/fs/buffer.c	2004-09-07 21:58:52.000000000 +1000
> +++ software-suspend-linux-2.6.9-rc1-rev3/fs/buffer.c	2004-09-09 19:36:24.000000000 +1000
> @@ -2916,7 +2975,7 @@
>   *
>   * try_to_free_buffers() is non-blocking.
>   */
> -static inline int buffer_busy(struct buffer_head *bh)
> +inline int buffer_busy(struct buffer_head *bh)
>  {
>  	return atomic_read(&bh->b_count) |
>  		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));

Why this change?  buffer_busy() is not exported now.

> diff -ruN linux-2.6.9-rc1/fs/ioctl.c software-suspend-linux-2.6.9-rc1-rev3/fs/ioctl.c
> --- linux-2.6.9-rc1/fs/ioctl.c	2004-09-07 21:58:53.000000000 +1000
> +++ software-suspend-linux-2.6.9-rc1-rev3/fs/ioctl.c	2004-09-09 19:36:24.000000000 +1000
> @@ -138,8 +138,7 @@
>  
>  /*
>   * Platforms implementing 32 bit compatibility ioctl handlers in
> - * modules need this exported
> + * modules need this exported. So does Suspend2 (when made as
> + * modules), so the export_symbol is now unconditional.
>   */
> -#ifdef CONFIG_COMPAT
>  EXPORT_SYMBOL(sys_ioctl);
> -#endif

What ioctls does suspend2 call?  That seems very strange.

> diff -ruN linux-2.6.9-rc1/kernel/panic.c software-suspend-linux-2.6.9-rc1-rev3/kernel/panic.c
> --- linux-2.6.9-rc1/kernel/panic.c	2004-09-07 21:59:00.000000000 +1000
> +++ software-suspend-linux-2.6.9-rc1-rev3/kernel/panic.c	2004-09-09 19:36:24.000000000 +1000
> @@ -18,12 +18,14 @@
>  #include <linux/sysrq.h>
>  #include <linux/syscalls.h>
>  #include <linux/interrupt.h>
> +#include <linux/suspend.h>
>  #include <linux/nmi.h>
>  
>  int panic_timeout;
>  int panic_on_oops;
>  int tainted;
>  
> +EXPORT_SYMBOL(tainted);
>  EXPORT_SYMBOL(panic_timeout);
>  
>  struct notifier_block *panic_notifier_list;

Why is the include needed here just to export a symbol (nevermind the
fact that we should never export tainted in the first place.)

thanks,

greg k-h
