Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVIHBPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVIHBPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVIHBPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:15:20 -0400
Received: from colo.lackof.org ([198.49.126.79]:46548 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S932615AbVIHBPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:15:18 -0400
Date: Wed, 7 Sep 2005 19:21:16 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, Brian King <brking@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com, matthew@wil.cx,
       benh@kernel.crashing.org, ak@muc.de, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
Message-ID: <20050908012116.GB2065@colo.lackof.org>
References: <20050901160356.2a584975.akpm@osdl.org> <4318E6B3.7010901@us.ibm.com> <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com> <20050903000854.GC8463@colo.lackof.org> <431A33D0.1040807@us.ibm.com> <20050903193958.GB30579@colo.lackof.org> <17182.32625.930500.874251@cargo.ozlabs.ibm.com> <20050907145818.GA25409@colo.lackof.org> <17183.27667.47675.454393@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17183.27667.47675.454393@cargo.ozlabs.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 08:39:15AM +1000, Paul Mackerras wrote:
> Grant Grundler writes:
> 
> > I would argue it more obvious. People looking at the code
> > are immediately going to realize it was a deliberate choice to
> > not use a spinlock.
> 
> It achieves exactly the same effect as spin_lock/spin_unlock, just
> more verbosely. :)

Not exactly identical. spin_try_lock() doesn't attempt to acquire
the lock and thus force exclusive access to the cacheline.
Other than that, I agree with you.

I don't see a problem with being verbose here since putting
a spinlock around something that's already atomic (assignment)
even caught Andrew's attention.


> > relax_cpu() doesn't do that?
> 
> No, how can it, when it doesn't get told which virtual cpu to yield
> to?  spin_lock knows which virtual cpu to yield to because we store
> that in the lock variable.

Ah ok. I was expecting relax_cpu() to just pick a "random" different one.
 :^)

> > it's not wrong - just misleading IMHO. There is no
> > "critical section" in that particular chunk of code.
> 
> Other code is using the lock to ensure the atomicity of a compound
> action, which involves the testing the flag and taking some action
> based on the value of the flag.  We take the lock to preserve that
> atomicity.  Locks are often used to make a set of compound actions
> atomic with respect to each other, which is what we're doing here.

Yes.
We agree this chunk only needs to wait until the lock is released.
Other critical sections need to acquire/release the lock.

> > If relax_cpu doesn't allow time-slice donation, then I guess
> > spinlock/unlock with only a comment inside it explain why
> > would be ok too.
> 
> Preferable, in fact. :)

Ok. I was just suggesting the alternative since
Andrew (correctly) questioned the use of a spinlock
and it didn't look right to me either.

thanks,
grant
