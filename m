Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWIAULQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWIAULQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 16:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbWIAULQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 16:11:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751873AbWIAULP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 16:11:15 -0400
Date: Fri, 1 Sep 2006 13:04:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Adrian Bunk <bunk@stusta.de>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile
 error
Message-Id: <20060901130444.48f19457.akpm@osdl.org>
In-Reply-To: <ada8xl3ics4.fsf@cisco.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org>
	<adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org>
	<ada8xl3ics4.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 12:53:47 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>     Roland> My understanding is that __raw_writeq() is like writeq()
>     Roland> except not strongly ordered and without the byte-swap on
>     Roland> big-endian architectures.  The __raw_writeX() variants are
>     Roland> convenient to avoid having to write inefficient code like
>     Roland> writel(swab32(foo), ...) when talking to a PCI device that
>     Roland> wants big-endian data.  Without the raw variant, you end
>     Roland> up with a double swap on big-endian architectures.
> 
> Oh, I left one other thing out: writeq() and __raw_writeq() shold be
> atomic in the sense that no other transactions should be able to get
> onto the IO bus in the middle -- so implementing writeq() as two
> writel()s in a row is not allowed
> 
>     Andrew> OK.  Can we please stop hacking around this in drivers and
> 
>     Andrew> a) work out what it's supposed to do
> 
>     Andrew> b) document that (Documentation/DocBook/deviceiobook.tmpl
>     Andrew> or code comment or whatever)
> 
>     Andrew> c) tell arch maintainers?
> 
> Yes, I agree that's a good plan, especially the documentation part.
> However I would argue that what's in drivers/infiniband/hw/mthca/mthca_doorbell.h 
> is legitimate: the driver uses __raw_writeq() when it exists and uses
> two __raw_writel()s properly serialized with a device-specific lock to
> get exactly the atomicity it needs on 32-bit archs.

No, driver-specific workarounds are not legitimate, sorry.

The driver should simply fail to compile on architectures which do not
implement __raw_writeq().

We can speed up the process by sending helpful emails to architecture
maintainers, but they'll notice either way.

Let's fix it once, and in the correct place.

> It's an open question what drivers that don't actually need atomicity
> but just want a convenient way to write 64 bits at time should do.

Well yeah.  We should sort out the design issues before implementing
things ;)

