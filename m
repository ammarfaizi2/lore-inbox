Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVATP76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVATP76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVATP7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:59:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:53130 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262160AbVATP41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:56:27 -0500
Subject: Re: 2.6.10-mm1 hang
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050119133136.7a1c0454.akpm@osdl.org>
References: <1106153215.3577.134.camel@dyn318077bld.beaverton.ibm.com>
	 <20050119133136.7a1c0454.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1106234814.3577.170.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Jan 2005 07:26:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see different behaviours on different architectures.

	i386 - machine hang
	Power5 ppc64 - only the process hang
	Power3 ppc64 - machine hang

I modified it to use spin_lock() instead of spin_lock_irq()  -
things are the way I was expecting. Only process hang, not
the system. 

You may be right on other CPUs stuck on IPI.

Thanks,
Badari

On Wed, 2005-01-19 at 13:31, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > I was playing with kexec+kdump and ran into this on 2.6.10-mm1.
> >  I have seen similar behaviour on 2.6.10. 
> > 
> >  I am using a 4-way P-III machine. I have a module which tries
> >  gets same spinlock twice. When I try to "insmod" this module,
> >  my system hangs. All my windows froze, no more new logins,
> >  console froze, doesn't respond to sysrq. I wasn't expecting
> >  a system hang. Why ? Ideas ?
> > 
> 
> Maybe all the other CPUs are stuck trying to send an IPI to this one?  An
> NMI watchdog trace would tell.
> 
> >  #include <linux/init.h>
> >  #include <asm/uaccess.h>
> >  #include <linux/spinlock.h>
> >  spinlock_t mylock = SPIN_LOCK_UNLOCKED;
> >  static int __init panic_init(void)
> >  {
> >          spin_lock_irq(&mylock);
> >          spin_lock_irq(&mylock);
> >         return 1;
> >  }
> 

