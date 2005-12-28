Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVL1AgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVL1AgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVL1AgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:36:22 -0500
Received: from mail.renesas.com ([202.234.163.13]:58251 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S932416AbVL1AgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:36:21 -0500
Date: Wed, 28 Dec 2005 09:36:17 +0900 (JST)
Message-Id: <20051228.093617.760319907.takata.hirokazu@renesas.com>
To: akpm@osdl.org
Cc: takata@linux-m32r.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [WTF?] sys_tas() on m32r
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20051227052214.0098e7bf.akpm@osdl.org>
References: <20051223055526.bc1a4044.akpm@osdl.org>
	<20051227.142739.599244061.takata.hirokazu@renesas.com>
	<20051227052214.0098e7bf.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'll report later.
I will be offline until Jan. 5, 2006.

-- Takata

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Dec 2005 05:22:14 -0800
> Hirokazu Takata <takata@linux-m32r.org> wrote:
> >
> > I tried the latter way as the following patch, but the result was not 
> > so gratifying; some hangups/lockups or kernel panics happened unexpectedly.
> > 
> > Am I missing anything?
> > Any more comments or suggestions will be greatly appreciated.
> > 
> > ...
> > --- linux-2.6.15-rc7.orig/arch/m32r/kernel/sys_m32r.c	2005-12-27 10:33:05.301372856 +0900
> > +++ linux-2.6.15-rc7/arch/m32r/kernel/sys_m32r.c	2005-12-27 10:33:10.222624712 +0900
> > @@ -29,44 +29,31 @@
> >  
> >  /*
> >   * sys_tas() - test-and-set
> > - * linuxthreads testing version
> >   */
> > -#ifndef CONFIG_SMP
> >  asmlinkage int sys_tas(int *addr)
> >  {
> >  	int oldval;
> > -	unsigned long flags;
> >  
> >  	if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
> >  		return -EFAULT;
> > -	local_irq_save(flags);
> > -	oldval = *addr;
> > -	if (!oldval)
> > -		*addr = 1;
> > -	local_irq_restore(flags);
> > -	return oldval;
> > -}
> > -#else /* CONFIG_SMP */
> > -#include <linux/spinlock.h>
> > -
> > -static DEFINE_SPINLOCK(tas_lock);
> > -
> > -asmlinkage int sys_tas(int *addr)
> > -{
> > -	int oldval;
> >  
> > -	if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
> > -		return -EFAULT;
> > -
> > -	_raw_spin_lock(&tas_lock);
> > -	oldval = *addr;
> > -	if (!oldval)
> > -		*addr = 1;
> > -	_raw_spin_unlock(&tas_lock);
> > +	for ( ; ; ) {
> > +		get_user(oldval, addr);
> 
> We need to check for -EFAULT here and fail the syscall if a fault was
> detected.  Without this we'll certainly get lockups if the user passed a
> bad address.  But this doesn't seem sufficient to eplain the problems which
> you've observed.
> 
> 
