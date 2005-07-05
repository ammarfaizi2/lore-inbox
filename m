Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVGEVqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVGEVqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVGEVqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:46:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261953AbVGEVao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:30:44 -0400
Date: Tue, 5 Jul 2005 14:29:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Provide better printk() support for SMP machines
Message-Id: <20050705142958.4075c5a7.akpm@osdl.org>
In-Reply-To: <1491.1120594224@warthog.cambridge.redhat.com>
References: <1491.1120594224@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
>  The attached patch prevents oopses interleaving with characters from other
>  printks on other machines by only zapping the locks if the oops is happening
>  on the machine holding the lock.

(s/machine/CPU/)

hm, I guess it adds a theoretical deadlock if some other CPU is in the
middle of printk and is trying to take some_lock and this CPU takes an oops
while holding some_lock.  Probably that's an acceptable tradeoff though.

>  --- linux-2.6.12-mm1/kernel/printk.c	2005-06-22 13:54:08.000000000 +0100
>  +++ linux-2.6.12-mm1-cachefs-wander/kernel/printk.c	2005-06-22 13:57:02.000000000 +0100
>  @@ -514,6 +514,9 @@ asmlinkage int printk(const char *fmt, .
>   	return r;
>   }
>   
>  +/* cpu currently holding logbuf_lock */
>  +static volatile int printk_cpu = -1;
>  +

Does this guy really need to be volatile?  Coud we use atomic_t and lose
that wmb()?

>   asmlinkage int vprintk(const char *fmt, va_list args)
>   {
>   	unsigned long flags;
>  @@ -522,11 +525,15 @@ asmlinkage int vprintk(const char *fmt, 
>   	static char printk_buf[1024];
>   	static int log_level_unknown = 1;
>   
>  -	if (unlikely(oops_in_progress))
>  +	if (unlikely(oops_in_progress) && printk_cpu == smp_processor_id())
>  +		/* If a crash is occurring during printk() on this CPU,
>  +		 * make sure we can't deadlock */

Methinks this should be raw_smp_processor_id().
