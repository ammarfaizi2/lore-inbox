Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbTHSXjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbTHSXjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:39:21 -0400
Received: from zero.aec.at ([193.170.194.10]:39174 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261520AbTHSXjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:39:20 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.0-test3-bk7] x86-64 UP_IOAPIC panic caused by
 cpumask_t conversion
From: Andi Kleen <ak@muc.de>
Date: Wed, 20 Aug 2003 01:39:10 +0200
In-Reply-To: <mnCB.1md.29@gated-at.bofh.it> (Mikael Pettersson's message of
 "Wed, 20 Aug 2003 01:00:21 +0200")
Message-ID: <m3y8xpqktd.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <mnCB.1md.29@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> --- linux-2.6.0-test3-bk7/include/linux/cpumask.h.~1~	2003-08-19 23:48:50.000000000 +0200
> +++ linux-2.6.0-test3-bk7/include/linux/cpumask.h	2003-08-20 00:07:17.000000000 +0200
> @@ -21,7 +21,7 @@
>  typedef unsigned long cpumask_t;
>  #endif
>  
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_SMP) || defined(CONFIG_X86_IO_APIC)
>  #if NR_CPUS > BITS_PER_LONG
>  #include <asm-generic/cpumask_array.h>
>  #else
>
> Since NR_CPUS==1 this makes UP_IOAPIC use cpumask_arith.h,
> which is what the code used before the cpumask_t conversion.
> With this change, the box boots Ok again.

Nasty.

But why does i386/UP work?

>
> (I believe this is the correct thing to do, except having
> CONFIG_X86_IO_APIC in generic code isn't quite right.)

Better would be to undo the cpumask_t changes in io_apic.c
and go back to unsigned long masks there again.

Obviously a cpu mask is not the right data structure to manage APICs

Another way would be to do whatever i386 does to avoid the problem.
The IO-APIC code is unfortunately quite out of date/unsynced compared to i386,
maybe it just needs some bug fix ported over. I will check that later.

-Andi 
