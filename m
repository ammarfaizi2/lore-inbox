Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318780AbSHSNDI>; Mon, 19 Aug 2002 09:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318830AbSHSNDI>; Mon, 19 Aug 2002 09:03:08 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:5773 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S318780AbSHSNDI>;
	Mon, 19 Aug 2002 09:03:08 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI MMIO flushing, write-combining etc
References: <m3d6sjele5.fsf@defiant.pm.waw.pl>
	<1029496355.31514.44.camel@irongate.swansea.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Aug 2002 13:57:29 +0200
In-Reply-To: <1029496355.31514.44.camel@irongate.swansea.linux.org.uk>
Message-ID: <m3y9b3qcwm.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I understand writes to PR1 can be reordered, merged, and delayed.
> > What should I do to flush the write buffers? I understand reading from
> > PR1 would do. Would reading from NPR2 flush PR1 write buffers?
> > Would writing to NPR2 flush them?
> 
> That one I can't actually remember.

Ok. What PCI spec 2.1 says is, basically, that we don't need to worry about
such things. Writes can't be reordered - all the reads and writes are
in CPU (or any other PCI master) order, exactly as on ISA.
Writes can be merged on prefetchable region (so we don't necessarily want
to mark I/O MMIO as prefetchable, if the hardware doesn't like merging).

All writes can be posted, and they are flushed before a read initiated
by the same master (i.e. CPU) reaches the same PCI target (so it's enough
to readl() any region, either I/O or MMIO). Looks like we only need to
flush posted writes when there are specific timing requirements (something
like writel(reset); sleep 100 ns, writel(no_reset) - or when we want to be
sure that, say, card interrupts are off when we do something critical
elsewhere).
-- 
Krzysztof Halasa
Network Administrator
