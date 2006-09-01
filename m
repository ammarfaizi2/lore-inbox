Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWIAVF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWIAVF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWIAVF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:05:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750892AbWIAVF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:05:58 -0400
Date: Fri, 1 Sep 2006 13:59:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Roland Dreier <rdreier@cisco.com>, Adrian Bunk <bunk@stusta.de>,
       Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile
 error
Message-Id: <20060901135911.bc53d89a.akpm@osdl.org>
In-Reply-To: <20060901204343.GA4979@flint.arm.linux.org.uk>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org>
	<adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org>
	<ada8xl3ics4.fsf@cisco.com>
	<20060901130444.48f19457.akpm@osdl.org>
	<20060901204343.GA4979@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 21:43:43 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, Sep 01, 2006 at 01:04:44PM -0700, Andrew Morton wrote:
> > On Fri, 01 Sep 2006 12:53:47 -0700
> > Roland Dreier <rdreier@cisco.com> wrote:
> > > Yes, I agree that's a good plan, especially the documentation part.
> > > However I would argue that what's in drivers/infiniband/hw/mthca/mthca_doorbell.h 
> > > is legitimate: the driver uses __raw_writeq() when it exists and uses
> > > two __raw_writel()s properly serialized with a device-specific lock to
> > > get exactly the atomicity it needs on 32-bit archs.
> > 
> > No, driver-specific workarounds are not legitimate, sorry.
> > 
> > The driver should simply fail to compile on architectures which do not
> > implement __raw_writeq().
> 
> So, what you're basically saying is that on architectures which can _NOT_
> implement an atomic __raw_writeq(), certain drivers simply will not be
> available?

If the driver *requires* an atomic __raw_writeq(), then yes.  The driver
cannot work correctly on that machine.

If, however, there is some way in which we can make the hardware work on
that machine (say, with other locking) then we got the __raw_writeq()
interface design (whatever that is) wrong.

IOW, the best way of tackling this is to work out what we're trying to do,
design an interface, then implement it.

Doing funny workarounds within individual drivers isn't the way to address
this.  In fact it's an indication that something is wrong.

> > We can speed up the process by sending helpful emails to architecture
> > maintainers, but they'll notice either way.
> 
> I think you're completely wrong in the context of the message you're
> replying to - it's talking about an _atomic_ 64-bit write.
> 
> Sure, if you want a _non-atomic_ 64-bit write then that's possible,
> but many 32-bit architectures can't do a 64-bit atomic IO write and
> that isn't something they can "fix".

If the hardware/driver absolutely requires that the 64-bit write be atomic
on-the-bus then sure, the fix is to disable that driver on that
architecture in Kconfig.

If, however, the atomicity requirement is a software thing (we need to be
atomic against other CPU reads and writes) then that can be solved with
locking, and we can design APIs for this which can be implemented
efficiently on all architectures.


-- 
VGER BF report: H 0
