Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVD3L0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVD3L0s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 07:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVD3L0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 07:26:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:59803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261199AbVD3L0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 07:26:44 -0400
Date: Sat, 30 Apr 2005 04:26:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
Message-Id: <20050430042614.7858e4fa.akpm@osdl.org>
In-Reply-To: <1114859458.872.26.camel@localhost.localdomain>
References: <20050429231653.32d2f091.akpm@osdl.org>
	<1114859458.872.26.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
> > - We're still miles away from 2.6.12.  Lots of patches here, plus my
> >   collection of bugs-post-2.6.11 is vast.  I'll start working through them
> >   again after 2.6.12-rc4 is available to testers.
> > 
> 
> Something is bad with my init process, so with debug patch below I'm
> getting:
> do_page_fault: force_sig_info SIGSEV to 1, addr ffffe018, eip b7fe576a
> do_page_fault: force_sig_info SIGSEV to 1, addr ffffe018, eip b7fe576a
> do_page_fault: force_sig_info SIGSEV to 1, addr ffffe018, eip b7fe576a
> do_page_fault: force_sig_info SIGSEV to 1, addr ffffe018, eip b7fe576a
> 
> continuing forever. 0xffffe018 is inside the vsyscall page so could be
> related but the eip should be there too in that case I think...
> You have any candidates? I've failed to find any.

Nope.  The easiest way to identify this is to grab broken-out.tar.gz, the
series file and use quilt to do a bisection search.  Ten compiles max.

If you're not interested in that, please share the .config.

> Index: mm/arch/i386/mm/fault.c
> ===================================================================
> --- mm.orig/arch/i386/mm/fault.c	2005-04-30 12:49:17.000000000 +0200
> +++ mm/arch/i386/mm/fault.c	2005-04-30 12:56:31.000000000 +0200
> @@ -391,6 +391,8 @@
>  		info.si_errno = 0;
>  		/* info.si_code has been set above */
>  		info.si_addr = (void __user *)address;
> +		printk("%s: force_sig_info SIGSEV to %d, addr %lx, eip %lx\n",
> +				__FUNCTION__, tsk->pid, address, regs->eip);
>  		force_sig_info(SIGSEGV, &info, tsk);
>  		return;
>  	}
> 
> 
> Also, this brought me to trying to find what has changed between the
> versions which appears a little tricky.

Well announce.txt tells you what was added and what was removed.

> Do you think it would be
> possible to set up your scripts that currently notify the author of a
> patch about the inclusion to CC something like mm-commits list.

Certainly could.  I'll ask davem about getting a list set up.

> That way people can audit patches that have got in before the tarball is
> released, it is easy to see what has gone in and when.
