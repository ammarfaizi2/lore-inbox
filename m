Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318338AbSHEI1G>; Mon, 5 Aug 2002 04:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318339AbSHEI1G>; Mon, 5 Aug 2002 04:27:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55291 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318338AbSHEI1G>; Mon, 5 Aug 2002 04:27:06 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028535126.1572.48.camel@ldb>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk> 
	<1028493814.26332.9.camel@ldb> 
	<1028505732.15495.38.camel@irongate.swansea.linux.org.uk> 
	<1028535126.1572.48.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 10:49:14 +0100
Message-Id: <1028540954.16550.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 09:12, Luca Barbieri wrote:
> So I'm only replacing the lock; addl $0,0(%%esp) with the Xfence
> instructions which are more efficient.

The original code has rmb not doing any kind of CPU operation, and wmb
likewise. (Quoting 2.4 and 2.5.29 here)

You don't need stronger barriers except on the Pentium Pro or the
Winchip because of the guarantees already made by the processor and by
the PCI interface.

The only case you need a store fence with non buggy/weird processors is
when you do non temporal stores. In that situation the barriers are
still not needed because the non temporal using functions already have
their own sfence instructions and need them.


#define mb()    __asm__ __volatile__ ("lock; addl $0,0(%%esp)":
:"memory")
#define rmb()   mb()

#ifdef CONFIG_X86_OOSTORE
#define wmb()   __asm__ __volatile__ ("lock; addl $0,0(%%esp)": :
:"memory")
#else
#define wmb()   __asm__ __volatile__ ("": : :"memory")
#endif


For the PPro a lock addl is the most efficient one I know of for working
around the store order errata. If you want to optimise it further then
the winchip appears to be fractionally faster using an rdmsr() but that
impacts registers so wants more profiling



