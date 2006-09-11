Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWIKAe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWIKAe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 20:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWIKAe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 20:34:29 -0400
Received: from outbound-mail-27.bluehost.com ([67.138.240.193]:26792 "HELO
	outbound-mail-27.bluehost.com") by vger.kernel.org with SMTP
	id S964851AbWIKAe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 20:34:28 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 17:34:06 -0700
User-Agent: KMail/1.9.3
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org> <1157933531.31071.274.camel@localhost.localdomain>
In-Reply-To: <1157933531.31071.274.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101734.06839.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.169.58.76 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 10, 2006 5:12 pm, Benjamin Herrenschmidt wrote:
> Ok, so we have two different proposals here...
>
> Maybe we should cast a vote ? :)
>
>  * Option A:
>
>  - writel/readl are fully synchronous (minus mmiowb for spinlocks)
>  - we provide __writel/__readl with some barriers with relaxed
> ordering between memory and MMIO (though still _precise_ semantics,
> not arch specific)
>
>  * Option B:
>
>  - The driver decides at ioremap time wether it wants a fully ordered
> mapping or not using
>    a "special" version of ioremap (with flags ?)
>  - writel/readl() behave differently depending on the mapping
>  - __writel/__readl might exist but are architecture specific
> (ahem... still to be debated)
>
> The former seems easier to me to implement. The later might indeed be
> a bit easier for drivers writers, I'm not 100% convinced tho. The
> later means stuffing special tokens in the returned address from
> ioremap and testing for them in writel. However, the later is also
> what we need for write combining (at least for PowerPC, maybe for
> other archs, wether a mapping can write combine has to be decided by
> using flags in the page table, thus has to be done at ioremap time.
> (*)

Yeah, write combining is a good point.  After all these years we *still* 
don't have a good in-kernel interface for changing memory mapped 
attributes, so adding a 'flags' argument to ioremap might be a good 
idea (cached, uncached, write combine are the three variants I can 
think of off the top of my head).

But doing MMIO ordering this way seems somewhat expensive since it means 
extra checks in the readX/writeX routines, which are normally very 
fast.

So I guess I'm saying we should have both.
  - existing readX/writeX routines are defined to be strongly ordered
  - new MMIO accessors are added with weak semantics (not sure I like
    the __ naming though, driver authors will have to continually refer
    to documentation to figure out what they mean) along with new
    barrier macros to synchronize things appropriately
  - flags argument to ioremap for cached, uncached, write combine
    attributes (this implies some TLB flushing and other arch specific
    state flushing, also needed for proper PAT support)

Oh, and all MMIO accessors are *documented* with strongly defined 
semantics. :)

If we go this route though, can I request that we don't introduce any 
performance regressions in drivers currently using mmiowb()?  I.e. 
they'll be converted over to the new accessor routines when they become 
available along with the new barrier macros?

Thanks,
Jesse
