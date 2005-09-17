Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVIQGhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVIQGhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVIQGhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:37:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750964AbVIQGhY (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:37:24 -0400
Date: Fri, 16 Sep 2005 23:36:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: nickpiggin@yahoo.com.au, rmk+lkml@arm.linux.org.uk,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
Message-Id: <20050916233628.0fd948f0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0509170300030.3743@scrub.home>
References: <43283825.7070309@yahoo.com.au>
	<4328387E.6050701@yahoo.com.au>
	<Pine.LNX.4.61.0509141814220.3743@scrub.home>
	<43285374.3020806@yahoo.com.au>
	<Pine.LNX.4.61.0509141906040.3728@scrub.home>
	<20050914230049.F30746@flint.arm.linux.org.uk>
	<Pine.LNX.4.61.0509150010100.3728@scrub.home>
	<20050914232106.H30746@flint.arm.linux.org.uk>
	<4328D39C.2040500@yahoo.com.au>
	<Pine.LNX.4.61.0509170300030.3743@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Hi,
> 
> On Thu, 15 Sep 2005, Nick Piggin wrote:
> 
> > Roman: any ideas about what you would prefer? You'll notice
> > atomic_inc_not_zero replaces rcuref_inc_lf, which is used several times
> > in the VFS.
> 
> In the larger picture I'm not completely happy with these scalibilty 
> patches, as they add extra overhead at the lower end. On a UP system in 
> general nothing beats:
> 
> 	spin_lock();
> 	if (*ptr)
> 		ptr += 1;
> 	spin_unlock();
> 
> The main problem is here that the atomic functions are used in two basic 
> situation:
> 
> 1) interrupt synchronization
> 2) multiprocessor synchronization
> 
> The atomic functions have to assume both, but on UP systems it often is 
> a lot cheaper if they don't have to synchronize with interrupts. So 
> replacing a spinlock with a few atomic operations can hurt UP performance.
> 

Nope.  On uniprocessor systems, atomic_foo() doesn't actually do the
buslocked atomic thing.

#ifdef CONFIG_SMP
#define LOCK "lock ; "
#else
#define LOCK ""
#endif

On x86, at least.  Other architectures can do the same thing if they have
an atomic-wrt-IRQs add and sub.

