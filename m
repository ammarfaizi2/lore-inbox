Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVIGFtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVIGFtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 01:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVIGFtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 01:49:22 -0400
Received: from ozlabs.org ([203.10.76.45]:20177 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750726AbVIGFtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 01:49:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17182.32625.930500.874251@cargo.ozlabs.ibm.com>
Date: Wed, 7 Sep 2005 15:49:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Brian King <brking@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
In-Reply-To: <20050903193958.GB30579@colo.lackof.org>
References: <4200F2B2.3080306@us.ibm.com>
	<20050208200816.GA25292@kroah.com>
	<42B83B8D.9030901@us.ibm.com>
	<430B3CB4.1050105@us.ibm.com>
	<20050901160356.2a584975.akpm@osdl.org>
	<4318E6B3.7010901@us.ibm.com>
	<20050902224314.GB8463@colo.lackof.org>
	<17176.56354.363726.363290@cargo.ozlabs.ibm.com>
	<20050903000854.GC8463@colo.lackof.org>
	<431A33D0.1040807@us.ibm.com>
	<20050903193958.GB30579@colo.lackof.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler writes:

> Ok this is good example - I see what the problem is.
> You could use the following sequence too then:
> 	pci_block_user_cfg_access
> 		pci_save_state
> 		block_ucfg_access = 1
> 		mb()
> 		while (spin_is_locked(&pci_lock))
> 			relax_cpu();
> 
> Think this is sufficient?

Maybe, but it seems like a bad idea to me.  It's longer, it's less
obvious what's happening, and it precludes the sorts of optimization
that we do on ppc64 where a cpu that is waiting for a lock can tell
give its time slice to the cpu that is holding the lock (on systems
where the hypervisor time-slices multiple virtual cpus on one physical
cpu).

What's wrong with just doing spin_lock/spin_unlock?

Paul.


