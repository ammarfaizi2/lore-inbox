Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWIAUVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWIAUVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 16:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWIAUVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 16:21:03 -0400
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:11687 "EHLO
	dell3.ogc.int") by vger.kernel.org with ESMTP id S1751160AbWIAUVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 16:21:01 -0400
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile
	error
From: Tom Tucker <tom@opengridcomputing.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rdreier@cisco.com>, Adrian Bunk <bunk@stusta.de>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060901130444.48f19457.akpm@osdl.org>
References: <20060901015818.42767813.akpm@osdl.org>
	 <20060901160023.GB18276@stusta.de> <20060901101340.962150cb.akpm@osdl.org>
	 <adak64nij8f.fsf@cisco.com> <20060901112312.5ff0dd8d.akpm@osdl.org>
	 <ada8xl3ics4.fsf@cisco.com>  <20060901130444.48f19457.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 15:20:59 -0500
Message-Id: <1157142059.22301.74.camel@trinity.ogc.int>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So to make sure I understand all this...

The purpose of these services is to provide a platform independent API
for reading and writing 16, 32 and 64b values to MMIO devices. The
rationale for needing these services is that there is currently no
platform independent API for efficiently reading and writing these
values to BE devices on MMIO PCI devices. Examples are the mthca and
amso1100 devices.

Two classes of service are needed, atomic services that are interrupt
safe and services that either don't require atomicity or are called with
a suitable lock already held.

Does the API look something like this?

void mmio_wr_be16(__be16 val, void __iomem *addr);
void mmio_wr_be32(__be32 val, void __iomem *addr);
void mmio_wr_be64(__be64 val, void __iomem *addr);

void mmio_atomic_wr_be16(__be16 val, void __iomem *addr);
void mmio_atomic_wr_be32(__be32 val, void __iomem *addr);
void mmio_atomic_wr_be64(__be64 val, void __iomem *addr);

__be16 mmio_rd_be16(void __iomem *addr);
__be32 mmio_rd_be32(void __iomem *addr);
__be64 mmio_rd_be64(void __iomem *addr);

__be16 mmio_atomic_wr_be16(void __iomem *addr);
__be32 mmio_atomic_wr_be32(void __iomem *addr);
__be64 mmio_atomic_wr_be64(void __iomem *addr);


On Fri, 2006-09-01 at 13:04 -0700, Andrew Morton wrote:
> On Fri, 01 Sep 2006 12:53:47 -0700
> Roland Dreier <rdreier@cisco.com> wrote:
> 
> >     Roland> My understanding is that __raw_writeq() is like writeq()
> >     Roland> except not strongly ordered and without the byte-swap on
> >     Roland> big-endian architectures.  The __raw_writeX() variants are
> >     Roland> convenient to avoid having to write inefficient code like
> >     Roland> writel(swab32(foo), ...) when talking to a PCI device that
> >     Roland> wants big-endian data.  Without the raw variant, you end
> >     Roland> up with a double swap on big-endian architectures.
> > 
> > Oh, I left one other thing out: writeq() and __raw_writeq() shold be
> > atomic in the sense that no other transactions should be able to get
> > onto the IO bus in the middle -- so implementing writeq() as two
> > writel()s in a row is not allowed
> > 
> >     Andrew> OK.  Can we please stop hacking around this in drivers and
> > 
> >     Andrew> a) work out what it's supposed to do
> > 
> >     Andrew> b) document that (Documentation/DocBook/deviceiobook.tmpl
> >     Andrew> or code comment or whatever)
> > 
> >     Andrew> c) tell arch maintainers?
> > 
> > Yes, I agree that's a good plan, especially the documentation part.
> > However I would argue that what's in drivers/infiniband/hw/mthca/mthca_doorbell.h 
> > is legitimate: the driver uses __raw_writeq() when it exists and uses
> > two __raw_writel()s properly serialized with a device-specific lock to
> > get exactly the atomicity it needs on 32-bit archs.
> 
> No, driver-specific workarounds are not legitimate, sorry.
> 
> The driver should simply fail to compile on architectures which do not
> implement __raw_writeq().
> 
> We can speed up the process by sending helpful emails to architecture
> maintainers, but they'll notice either way.
> 
> Let's fix it once, and in the correct place.
> 
> > It's an open question what drivers that don't actually need atomicity
> > but just want a convenient way to write 64 bits at time should do.
> 
> Well yeah.  We should sort out the design issues before implementing
> things ;)
> 


-- 
VGER BF report: H 0
