Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWJKPUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWJKPUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 11:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWJKPUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 11:20:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:42897 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161075AbWJKPUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 11:20:20 -0400
Date: Wed, 11 Oct 2006 10:20:17 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: jschopp <jschopp@austin.ibm.com>, akpm@osdl.org, jeff@garzik.org,
       Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
Message-ID: <20061011152016.GU4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com> <20061010212324.GR4381@austin.ibm.com> <452C2AAA.5070001@austin.ibm.com> <452C4CE0.5010607@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452C4CE0.5010607@am.sony.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 06:46:08PM -0700, Geoff Levand wrote:
> > Linas Vepstas wrote:
> >> The current driver code performs 512 DMA mappns of a bunch of 
> >> 32-byte structures. This is silly, as they are all in contiguous 
> >> memory. Ths patch changes the code to DMA map the entie area
> >> with just one call.
> 
> Linas, 
> 
> Is the motivation for this change to improve performance by reducing the overhead
> of the mapping calls?  

Yes.

> If so, there may be some benefit for some systems.  Could
> you please elaborate?

I started writingthe patch thinking it will have some huge effect on
performance, based on a false assumption on how i/o was done on this
machine

*If* this were another pSeries system, then each call to 
pci_map_single() chews up an actual hardware "translation 
control entry" (TCE) that maps pci bus addresses into 
system RAM addresses. These are somewhat limited resources,
and so one shouldn't squander them.  Furthermore, I thouhght
TCE's have TLB's associated with them (similar to how virtual
memory page tables are backed by hardware page TLB's), of which 
there are even less of. I was thinking that TLB thrashing would 
have a big hit on performance. 

Turns out that there was no difference to performance at all, 
and a quick look at "cell_map_single()" in arch/powerpc/platforms/cell
made it clear why: there's no fancy i/o address mapping.

Thus, the patch has only mrginal benefit; I submit it only in the 
name of "its the right thing to do anyway".

--linas
