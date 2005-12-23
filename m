Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbVLWN4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbVLWN4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 08:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVLWN4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 08:56:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030516AbVLWN4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 08:56:09 -0500
Date: Fri, 23 Dec 2005 05:55:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Hirokazu Takata <takata@linux-m32r.org>
Subject: Re: [WTF?] sys_tas() on m32r
Message-Id: <20051223055526.bc1a4044.akpm@osdl.org>
In-Reply-To: <20051223061556.GR27946@ftp.linux.org.uk>
References: <20051223061556.GR27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> asmlinkage int sys_tas(int *addr)
> {
>         int oldval;
>         unsigned long flags;
> 
>         if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
>                 return -EFAULT;
>         local_irq_save(flags);
>         oldval = *addr;
>         if (!oldval)
>                 *addr = 1;
>         local_irq_restore(flags);
>         return oldval;
> }
> in arch/m32r/kernel/sys_m32r.c.  Trivial oops *AND* ability to trigger
> IO with interrupts disabled.

Yeah.  I pointed this out to Takata in October last year and then promptly
forgot about it.  It's rather amazing that this code (which appears to be in
live use in linuxthreads) hasn't generated oopses.

The problem is that touching *addr will generate an oops if that page isn't
paged in.  If we convert it to use get_user() then that's an improvement,
but we must not run get_user() under spinlock or local_irq_disable().

The safe-and-slow way to do this is to pin the page with get_user_pages().

A smarter way to do it is to do something similar to filemap_copy_from_user():

	for ( ; ; ) {
		get_user(c, addr);
		inc_preempt_count();
		if (get_user(oldval, addr)) {
			dec_preempt_count();
			continue;
		}
		if (!oldval && put_user(1, addr)) {
			dec_preempt_count();
			continue;
		}
		dec_preempt_count();
		break;
	}

ie: try to fault the page in with get_user(), then switch into atomic mode
and try the memory access.  If the page isn't there any more, get_user()
and put_user() will return -EFAULT without entering the pagefault handler
(the in_atomic() test in do_page_fault()) so we can just retry the pagein. 



The above all assumes CONFIG_MMU.  I guess sys_tas() as it stands is OK if
!CONFIG_MMU.
