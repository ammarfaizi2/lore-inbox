Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWHTNrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWHTNrv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 09:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWHTNru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 09:47:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:28053 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750785AbWHTNru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 09:47:50 -0400
X-Authenticated: #5039886
Date: Sun, 20 Aug 2006 15:47:45 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Return real errno from execve in ____call_usermodehelper
Message-ID: <20060820134745.GA11843@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <20060819011428.05ec2ae4.akpm@osdl.org> <20060819084233.GA25767@flint.arm.linux.org.uk> <200608201501.29296.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608201501.29296.arnd@arndb.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.20 15:01:28 +0200, Arnd Bergmann wrote:
> On Saturday 19 August 2006 10:42, Russell King wrote:
> > Maybe what we should be thinking of doing is changing execve() calls
> > to kernel_execve() which returns the error code.
> > 
> > This way, architectures are free to implement execve() whatever way
> > they wish - and if they're concerned about using errno, that's their
> > own implementation specific detail.
> 
> Sounds good, it means we could finally kill __KERNEL_SYSCALLS__ along
> with lib/errno.c.
> 
> I guess a fallback for those that haven't yet done kernel_execve could be
> 
> #ifdef CONFIG_ARCH_KERNEL_EXECVE
> extern int kernel_execve(const char *filename,
> 		char *const argv[], char *const envp[]);
> #else
> static inline int kernel_execve(const char *filename,
> 		char *const argv[], char *const envp[]);
> {
> 	int errno;
> 	mm_segment_t old_fs = get_fs();
> 	set_fs(KERNEL_DS);
> 	/* the kernel syscall macro modifies errno */
> 	execve(filename, argv, envp);
> 	set_fs(old_fs);
> 	return errno;
> }
> #endif
> 
> With that in place, we can remove the global errno right away, and the
> kernel syscalls for any architecture that implements its own kernel_execve.

How is execve() supposed to use the local errno? The kernel syscall
macro only "creates" a function, so you still need a global errno for
that code, don't you?

And I (because I'm clueless ;) wonder about the calls to set_fs(), why
do we need them? The current code does not seem to do them. Or is there
something special about kernel_execve that I'm missing? cscope and grep
didn't tell anything and Google had only a few useless results for
kernel_execve.

Björn
