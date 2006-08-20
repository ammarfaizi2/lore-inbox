Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWHTNBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWHTNBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 09:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWHTNBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 09:01:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:24281 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750764AbWHTNBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 09:01:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Return real errno from execve in ____call_usermodehelper
Date: Sun, 20 Aug 2006 15:01:28 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <20060819011428.05ec2ae4.akpm@osdl.org> <20060819084233.GA25767@flint.arm.linux.org.uk>
In-Reply-To: <20060819084233.GA25767@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608201501.29296.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 10:42, Russell King wrote:
> Maybe what we should be thinking of doing is changing execve() calls
> to kernel_execve() which returns the error code.
> 
> This way, architectures are free to implement execve() whatever way
> they wish - and if they're concerned about using errno, that's their
> own implementation specific detail.

Sounds good, it means we could finally kill __KERNEL_SYSCALLS__ along
with lib/errno.c.

I guess a fallback for those that haven't yet done kernel_execve could be

#ifdef CONFIG_ARCH_KERNEL_EXECVE
extern int kernel_execve(const char *filename,
		char *const argv[], char *const envp[]);
#else
static inline int kernel_execve(const char *filename,
		char *const argv[], char *const envp[]);
{
	int errno;
	mm_segment_t old_fs = get_fs();
	set_fs(KERNEL_DS);
	/* the kernel syscall macro modifies errno */
	execve(filename, argv, envp);
	set_fs(old_fs);
	return errno;
}
#endif

With that in place, we can remove the global errno right away, and the
kernel syscalls for any architecture that implements its own kernel_execve.

	Arnd <><
