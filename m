Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVIGWjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVIGWjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVIGWjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:39:22 -0400
Received: from ozlabs.org ([203.10.76.45]:36750 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751318AbVIGWjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:39:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17183.27667.47675.454393@cargo.ozlabs.ibm.com>
Date: Thu, 8 Sep 2005 08:39:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Brian King <brking@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
In-Reply-To: <20050907145818.GA25409@colo.lackof.org>
References: <42B83B8D.9030901@us.ibm.com>
	<430B3CB4.1050105@us.ibm.com>
	<20050901160356.2a584975.akpm@osdl.org>
	<4318E6B3.7010901@us.ibm.com>
	<20050902224314.GB8463@colo.lackof.org>
	<17176.56354.363726.363290@cargo.ozlabs.ibm.com>
	<20050903000854.GC8463@colo.lackof.org>
	<431A33D0.1040807@us.ibm.com>
	<20050903193958.GB30579@colo.lackof.org>
	<17182.32625.930500.874251@cargo.ozlabs.ibm.com>
	<20050907145818.GA25409@colo.lackof.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler writes:

> I would argue it more obvious. People looking at the code
> are immediately going to realize it was a deliberate choice to
> not use a spinlock.

It achieves exactly the same effect as spin_lock/spin_unlock, just
more verbosely. :)

> > and it precludes the sorts of optimization
> > that we do on ppc64 where a cpu that is waiting for a lock can tell
> > give its time slice to the cpu that is holding the lock (on systems
> > where the hypervisor time-slices multiple virtual cpus on one physical
> > cpu).
> 
> relax_cpu() doesn't do that?

No, how can it, when it doesn't get told which virtual cpu to yield
to?  spin_lock knows which virtual cpu to yield to because we store
that in the lock variable.

> > What's wrong with just doing spin_lock/spin_unlock?
> 
> it's not wrong - just misleading IMHO. There is no
> "critical section" in that particular chunk of code.

Other code is using the lock to ensure the atomicity of a compound
action, which involves the testing the flag and taking some action
based on the value of the flag.  We take the lock to preserve that
atomicity.  Locks are often used to make a set of compound actions
atomic with respect to each other, which is what we're doing here.

> If relax_cpu doesn't allow time-slice donation, then I guess
> spinlock/unlock with only a comment inside it explain why
> would be ok too.

Preferable, in fact. :)

Paul.
