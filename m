Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbVIBXLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbVIBXLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbVIBXLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:11:14 -0400
Received: from ozlabs.org ([203.10.76.45]:21916 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161112AbVIBXLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:11:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17176.56354.363726.363290@cargo.ozlabs.ibm.com>
Date: Sat, 3 Sep 2005 09:11:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Brian King <brking@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
In-Reply-To: <20050902224314.GB8463@colo.lackof.org>
References: <41FF9C78.2040100@us.ibm.com>
	<20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
	<41FFBDC9.2010206@us.ibm.com>
	<20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
	<4200F2B2.3080306@us.ibm.com>
	<20050208200816.GA25292@kroah.com>
	<42B83B8D.9030901@us.ibm.com>
	<430B3CB4.1050105@us.ibm.com>
	<20050901160356.2a584975.akpm@osdl.org>
	<4318E6B3.7010901@us.ibm.com>
	<20050902224314.GB8463@colo.lackof.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler writes:

> On Fri, Sep 02, 2005 at 06:56:35PM -0500, Brian King wrote:
> > Andrew Morton wrote:
> > >Brian King <brking@us.ibm.com> wrote:
> > >
> > >>+void pci_block_user_cfg_access(struct pci_dev *dev)
> > >>+{
> > >>+	unsigned long flags;
> > >>+
> > >>+	pci_save_state(dev);
> > >>+	spin_lock_irqsave(&pci_lock, flags);
> > >>+	dev->block_ucfg_access = 1;
> > >>+	spin_unlock_irqrestore(&pci_lock, flags);
> > >
> > >
> > >Are you sure the locking in here is meaningful?  All it will really do is
> > >give you a couple of barriers.
> > 
> > Actually, it is meaningful. It synchronizes the blocking of pci config 
> > accesses with other pci config accesses that may be going on when this 
> > function is called. Without the locking, the API cannot guarantee that 
> > no further user initiated PCI config accesses will be initiated after 
> > this function is called.
> 
> I don't have the impression you understood what Andrew wrote.
> dev->block_ucfg_access = 1 is essentially an atomic operation.
> AFAIK, Use of the pci_lock doesn't solve any race conditions that mb()
> wouldn't solve.

Think about it.  Taking the lock ensures that we don't do the
assignment (dev->block_ucfg_access = 1) while any other cpu has the
pci_lock.  In other words, the reason for taking the lock is so that
we wait until nobody else is doing an access, not to make others wait.

> If you had:
> 	spin_lock_irqsave(&pci_lock, flags);
> 	pci_save_state(dev);
> 	dev->block_ucfg_access = 1;
> 	spin_unlock_irqrestore(&pci_lock, flags);
> 
> Then I could buy your arguement since the flag now implies
> we need to atomically save state and set the flag.

That's probably a good thing to do to.

Paul.
