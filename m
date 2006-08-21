Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWHUPMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWHUPMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWHUPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:12:32 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:14064 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422681AbWHUPMb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:12:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Date: Mon, 21 Aug 2006 17:12:17 +0200
User-Agent: KMail/1.9.1
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <200608201913.39989.arnd@arndb.de> <17641.30.670343.779791@cargo.ozlabs.ibm.com>
In-Reply-To: <17641.30.670343.779791@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608211712.17780.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 August 2006 02:36, Paul Mackerras wrote:
> > Iit turned out most of the architectures that already implement
> > their own execve() call instead of using the _syscall3 function
> > for it end up passing the return value of sys_execve down, 
> > instead of setting errno.
> 
> I really don't like having an "errno" variable in the kernel.  What if
> two processes are doing an execve concurrently?

The point is that we have two different schemes in the kernel that
conflict:

alpha, arm{,26}, ia64, parisc, powerpc and x86_64 pass the error
code from execve, all others pass -1 and set the global errno.

So the caller does not really have a chance to get the correct error
value at all. Bjoern's first patch changed one caller from looking
at the return value to looking at errno in case of an error, which
shifts the problem to other architectures.

My patch makes the errno variable local to execve, which slightly
helps, and makes it easier to get it right completely right
by doing the same as powerpc or parisc.

Now, we could do a truely evil involving a nested function, like

#include <asm/bug.h>
#include <asm/uaccess.h>
#define __KERNEL_SYSCALLS__
#include <linux/unistd.h>
int kernel_execve(const char *filename, char *const argv[], char *const envp[])
{
	mm_segment_t fs = get_fs();
	int errno;
	int ret;
	_syscall3(int,execve,const char *,file,char *const*,argv,char *const*,envp)
	WARN_ON(segment_eq(fs, USER_DS));
	ret = execve(filename, argv, envp);
	if (ret)
		ret = -errno;
	return ret;
}

That would solve the problem of races on the errno variable,
but set a bad example to other hackers.

> Anyway, your patch returns the (positive) errno value here:
> 
> > +     WARN_ON(segment_eq(fs, USER_DS));
> > +     ret = execve(filename, (char **)argv, (char **)envp);
> > +     if (ret)
> > +             ret = errno;
> > +
> > +     return ret;
> 
> but here we are testing for a negative value to mean error:
> 
> > -     if (execve("/sbin/shutdown", argv, envp) < 0) {
> > +     if (kernel_execve("/sbin/shutdown", argv, envp) < 0) {

Yes, Chase Venters already noticed that bug. If obviously needs
to be 'ret = -errno;'.

	Arnd <><
