Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWHUAhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWHUAhD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWHUAhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:37:02 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:13788 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932392AbWHUAhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:37:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17641.30.670343.779791@cargo.ozlabs.ibm.com>
Date: Mon, 21 Aug 2006 10:36:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
In-Reply-To: <200608201913.39989.arnd@arndb.de>
References: <20060819073031.GA25711@atjola.homenet>
	<200608201501.29296.arnd@arndb.de>
	<20060820134745.GA11843@atjola.homenet>
	<200608201913.39989.arnd@arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> Iit turned out most of the architectures that already implement
> their own execve() call instead of using the _syscall3 function
> for it end up passing the return value of sys_execve down, 
> instead of setting errno.

I really don't like having an "errno" variable in the kernel.  What if
two processes are doing an execve concurrently?

Anyway, your patch returns the (positive) errno value here:

> +	WARN_ON(segment_eq(fs, USER_DS));
> +	ret = execve(filename, (char **)argv, (char **)envp);
> +	if (ret)
> +		ret = errno;
> +
> +	return ret;

but here we are testing for a negative value to mean error:

> -	if (execve("/sbin/shutdown", argv, envp) < 0) {
> +	if (kernel_execve("/sbin/shutdown", argv, envp) < 0) {

Paul.
