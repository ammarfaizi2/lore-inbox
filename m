Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWIAVdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWIAVdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWIAVd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:33:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750933AbWIAVdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:33:17 -0400
Date: Fri, 1 Sep 2006 14:26:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile
 error
Message-Id: <20060901142606.4f5c1152.akpm@osdl.org>
In-Reply-To: <adar6yvguvz.fsf@cisco.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org>
	<adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org>
	<ada8xl3ics4.fsf@cisco.com>
	<20060901130444.48f19457.akpm@osdl.org>
	<20060901204343.GA4979@flint.arm.linux.org.uk>
	<20060901135911.bc53d89a.akpm@osdl.org>
	<adar6yvguvz.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 14:05:36 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>     Andrew> If the hardware/driver absolutely requires that the 64-bit
>     Andrew> write be atomic on-the-bus then sure, the fix is to
>     Andrew> disable that driver on that architecture in Kconfig.
> 
>     Andrew> If, however, the atomicity requirement is a software thing
>     Andrew> (we need to be atomic against other CPU reads and writes)
>     Andrew> then that can be solved with locking, and we can design
>     Andrew> APIs for this which can be implemented efficiently on all
>     Andrew> architectures.
> 
> It seems that there are cases of both.  ipath needs actual 64-bit bus
> transactions to work properly.

If we define __raw_writeq() to be 64-bit-atomic-on-the-bus then an
appropriate solution for ipath would be to call __raw_writeq() directly. 
If the arch cannot implement __raw_write() then build error -> Kconfig fix.

>  mthca needs to make sure that if
> doorbell writes are split into two 32-bit halves, then no other writes
> go to the same MMIO page in between the halves.
> 
> What do you think the API would look like?  Something along the lines
> of mthca_doorbell.h, where we have macros for
> 
> DECLARE_WRITEQ_LOCK()
> INIT_WRITEQ_LOCK()
> GET_WRITEQ_LOCK()
> 
> which get stubbed out on architectures where writeq is already atomic,
> and then pass the lock into writeq()?
> 
> But then you probably need some Kconfig symbol to say if writeq() is
> really atomic or just software atomic (for ipath et al to depend on).
> 

It depends on how many other devices have (or are expected to have)
mthca-like requirements.  If the answer is "very few, maybe none" then
perhaps we don't need to go designing generic interfaces to support such
things.

As for interfaces, umm, something like

#ifdef CONFIG_ARCH_HAS_64BIT_ATOMIC_MMIO_WRITES

struct be64_port {
	void __iomem *addr;
};

static inline void atomic_be64_mmio_write(u64 v, struct be64_port *port)
{
	__raw_writeq(v, port->addr);
}

#define be64_port_init(port, addr)
	port->addr = addr;

#define be64_port_init_external_locking(port, addr, lockp)
	be64_port_init(port, addr)


#else


struct be64_port {
	void __iomem *addr;
	spinlock_t lock;
	spinlock_t *lockp;
};

static inline void atomic_be64_mmio_write(u64 v, struct be64_port *port)
{
	unsigned long flags;
	
	spin_lock_irqsave(port->lockp, flags);
	__raw_writel(...);
	__raw_writel(...);
	spin_unlock_irqrestore(port->lockp, flags);
}

#define be64_port_init(port, addr)
	spin_lock_init(&port->lock);
	port->lockp = &port->lock;
	port->addr = addr;

#define be64_port_init_external_locking(port, addr, lockp)
	port->lockp = lockp;
	port->addr = addr;

#endif

perhaps?

btw, 32-bit mthca_write64() is downright scary from an endianness POV.  I
guess it's right, but I wouldn't label it "obviously correct" ;)


-- 
VGER BF report: H 0
