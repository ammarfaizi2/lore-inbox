Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWIKA0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWIKA0M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 20:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWIKA0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 20:26:12 -0400
Received: from outbound-mail-27.bluehost.com ([67.138.240.193]:48799 "HELO
	outbound-mail-27.bluehost.com") by vger.kernel.org with SMTP
	id S964850AbWIKA0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 20:26:11 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 17:25:48 -0700
User-Agent: KMail/1.9.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <1157916919.23085.24.camel@localhost.localdomain> <1157923513.31071.256.camel@localhost.localdomain>
In-Reply-To: <1157923513.31071.256.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101725.49234.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.169.58.76 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 10, 2006 2:25 pm, Benjamin Herrenschmidt wrote:
> I'm copying that from a private discussion I had. Please let me know
> if you have comments. This proposal includes some questions too so
> please answer :)
>
>
>  - writel/readl become totally ordered (including vs. memory).
> Basically x86-like. Expensive (very expensive even on some
> architectures) but also very safe.

This approach will minimize driver changes, and would imply the removal 
of some existing mmiowb() and wmb() macros.

> There might be room for one 
> exception here: ordering vs locks, in which case we either still
> require mmiowb() or use a "trick" consisting of having writel() set a
> flag in some per-cpu area and spin_unlock() do a barrier when this
> flag is set. Thus Q: Should it have ordered semantics vs. locks too
> or do we require mmiowb() still, though maybe
> a renamed version of it ? (That is, does it provide MMIO + memory
> ordering
> instead of just memory + MMIO and MMIO + MMIO ?). Remember that
> providing the
> second is already expensive, providing both is -very- expensive on
> some architectures. Or do we do neither (that is no MMIO + memory
> ordering) but
> also alleviate the need for mmiowb() with the trick I described in
> locks ?

If we accept this, I don't think we're much better off than we are 
currently (not that I have a problem with that).  That is, many drivers 
would still need to be fixed up.

>  - __writel/__readl are totally relaxed between mem and IO, though
> they still guarantee ordering between MMIO and MMIO. That guaranteed,
> on powerpc, can be acheived by putting most of the burden in
> __readl(), thus letting __writel() alone to still allow for write
> combining. We still need to verify wether those semantics are
> realistic on other out-of-order platforms. Jesse ?

Depends on what you mean by "ordered between MMIO and MMIO".  mmiowb() 
was initially introduced to allow ordering of writes between CPUs, and 
really didn't say anything about memory vs. I/O, so the semantics you 
describe here would also be different (and more expensive) than what we 
have now.

> Or do you guys prefer it to be -also- relaxed for MMIO + MMIO ? That
> would
> make thing a bit harder for platforms like PowerPC to use them as we
> would
> need to defined a specific mmio_to_mmio_barrier() for use with them.
> I don't
> think that's useful if we can always implement ordering between MMIO
> and MMIO
> and still allow for write combining on all plaforms.

This is what mmiowb() is supposed to be, though only for writes.  I.e. 
two writes from different CPUs may arrive out of order if you don't use 
mmiowb() carefully.  Do you also need a mmiorb() macro or just a 
stronger mmiob()?

>  - In order to provide explicit ordering with memory for the above,
> we introduce mem_to_io_barrier() and io_to_mem_barrier(). It's still
> unclear
> wether to include mmiowb() as an equivalent here, that is wether the
> spinlock
> case has to be special cased vs. io_to_mem_barrier(). I need to get
> Jesse input
> on that one.

mmiowb() could be written as io_to_io_write_barrier() if we wanted to be 
extra verbose.  AIUI it's the same thing as smb_wmb() but for MMIO 
space.

Jesse
