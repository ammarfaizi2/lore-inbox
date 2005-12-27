Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVL0NWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVL0NWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 08:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVL0NWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 08:22:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932297AbVL0NWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 08:22:37 -0500
Date: Tue, 27 Dec 2005 05:22:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: Re: [WTF?] sys_tas() on m32r
Message-Id: <20051227052214.0098e7bf.akpm@osdl.org>
In-Reply-To: <20051227.142739.599244061.takata.hirokazu@renesas.com>
References: <20051223061556.GR27946@ftp.linux.org.uk>
	<20051223055526.bc1a4044.akpm@osdl.org>
	<20051227.142739.599244061.takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata@linux-m32r.org> wrote:
>
> I tried the latter way as the following patch, but the result was not 
> so gratifying; some hangups/lockups or kernel panics happened unexpectedly.
> 
> Am I missing anything?
> Any more comments or suggestions will be greatly appreciated.
> 
> ...
> --- linux-2.6.15-rc7.orig/arch/m32r/kernel/sys_m32r.c	2005-12-27 10:33:05.301372856 +0900
> +++ linux-2.6.15-rc7/arch/m32r/kernel/sys_m32r.c	2005-12-27 10:33:10.222624712 +0900
> @@ -29,44 +29,31 @@
>  
>  /*
>   * sys_tas() - test-and-set
> - * linuxthreads testing version
>   */
> -#ifndef CONFIG_SMP
>  asmlinkage int sys_tas(int *addr)
>  {
>  	int oldval;
> -	unsigned long flags;
>  
>  	if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
>  		return -EFAULT;
> -	local_irq_save(flags);
> -	oldval = *addr;
> -	if (!oldval)
> -		*addr = 1;
> -	local_irq_restore(flags);
> -	return oldval;
> -}
> -#else /* CONFIG_SMP */
> -#include <linux/spinlock.h>
> -
> -static DEFINE_SPINLOCK(tas_lock);
> -
> -asmlinkage int sys_tas(int *addr)
> -{
> -	int oldval;
>  
> -	if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
> -		return -EFAULT;
> -
> -	_raw_spin_lock(&tas_lock);
> -	oldval = *addr;
> -	if (!oldval)
> -		*addr = 1;
> -	_raw_spin_unlock(&tas_lock);
> +	for ( ; ; ) {
> +		get_user(oldval, addr);

We need to check for -EFAULT here and fail the syscall if a fault was
detected.  Without this we'll certainly get lockups if the user passed a
bad address.  But this doesn't seem sufficient to eplain the problems which
you've observed.


