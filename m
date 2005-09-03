Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVICTeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVICTeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 15:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVICTeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 15:34:05 -0400
Received: from colo.lackof.org ([198.49.126.79]:12161 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751229AbVICTeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 15:34:04 -0400
Date: Sat, 3 Sep 2005 13:39:58 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Brian King <brking@us.ibm.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
Message-ID: <20050903193958.GB30579@colo.lackof.org>
References: <4200F2B2.3080306@us.ibm.com> <20050208200816.GA25292@kroah.com> <42B83B8D.9030901@us.ibm.com> <430B3CB4.1050105@us.ibm.com> <20050901160356.2a584975.akpm@osdl.org> <4318E6B3.7010901@us.ibm.com> <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com> <20050903000854.GC8463@colo.lackof.org> <431A33D0.1040807@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431A33D0.1040807@us.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 06:37:52PM -0500, Brian King wrote:
...
> Without the locking, we introduce a race condition.
> 
> CPU 0                                           CPU 1
> 
> 					pci_block_user_cfg_access
> 						pci_save_state
> pci_read_user_config_space
> 	check block_ucfg_access
> 						set block_ucfg_access
> 					other code that puts the device
> 					in a state such that it cannot
> 					handle read config i/o, such as
> 					running BIST.
> 
> 	pci read config

Ok this is good example - I see what the problem is.
You could use the following sequence too then:
	pci_block_user_cfg_access
		pci_save_state
		block_ucfg_access = 1
		mb()
		while (spin_is_locked(&pci_lock))
			relax_cpu();

Think this is sufficient?

> Granted, for the specific usage scenario in ipr, where I am using this 
> to block config space over BIST, I use a pci config write to start BIST, 
> which would end up being a point of synchronization, but that seems a 
> bit non-obvious and limits how the patch can be used by others...

Yes, agreed.

grant
