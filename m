Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVIFEmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVIFEmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVIFEmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:42:15 -0400
Received: from colo.lackof.org ([198.49.126.79]:34989 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S932393AbVIFEmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:42:15 -0400
Date: Mon, 5 Sep 2005 22:48:09 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Brian King <brking@us.ibm.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
Message-ID: <20050906044809.GA19347@colo.lackof.org>
References: <42B83B8D.9030901@us.ibm.com> <430B3CB4.1050105@us.ibm.com> <20050901160356.2a584975.akpm@osdl.org> <4318E6B3.7010901@us.ibm.com> <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com> <20050903000854.GC8463@colo.lackof.org> <431A33D0.1040807@us.ibm.com> <20050903193958.GB30579@colo.lackof.org> <431C8EF8.7020702@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431C8EF8.7020702@us.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 01:31:20PM -0500, Brian King wrote:
> That should work also. Here is an updated patch.
...

The code looks good...but it got me thinking.

...
> +void pci_block_user_cfg_access(struct pci_dev *dev)
> +{
> +	pci_save_state(dev);
> +	dev->block_ucfg_access = 1;
> +	mb();
> +	while (spin_is_locked(&pci_lock))
> +		cpu_relax();
> +}
> +EXPORT_SYMBOL_GPL(pci_block_user_cfg_access);
> +
> +/**
> + * pci_unblock_user_cfg_access - Unblock userspace PCI config reads/writes
> + * @dev:	pci device struct
> + *
> + * This function allows userspace PCI config accesses to resume.
> + **/
> +void pci_unblock_user_cfg_access(struct pci_dev *dev)
> +{
> +	dev->block_ucfg_access = 0;
> +}

Shouldn't pci_unblock_user_cfg_access() have a similar construct
as pci_block_user_cfg_access()?

I'm thinking we don't want to pull the rug out from under someone
who is accessing the saved state, right?
Or does something else guarantee that?

It wasn't obvious from this diff alone.

thanks,
grant
