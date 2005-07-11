Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVGKMuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVGKMuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVGKMuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:50:50 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:50148 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261660AbVGKMuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:50:44 -0400
Date: Mon, 11 Jul 2005 14:48:44 +0200
From: Lennert Buytenhek <buytenh+lkml@liacs.nl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, ambx1@neo.rr.com
Cc: byjac@matfyz.cz, herbertb@cs.vu.nl
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from pci_set_power_state for D3hot->D0
Message-ID: <20050711144844.A16143@tin.liacs.nl>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050708183452.GB13445@tuxdriver.com>; from linville@tuxdriver.com on Fri, Jul 08, 2005 at 02:34:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:

> Some PCI devices lose all configuration (including BARs) when
> transitioning from D3hot->D0.  This leaves such a device in an
> inaccessible state.  The patch below causes the BARs to be restored
> when enabling such a device, so that its driver will be able to
> access it.

It might be useful to have this functionality exported to outside of
the generic PCI code.

There are a number of PCI boards that have their reset logic wired
up wrong and lose their config space info (BARs) when you reset them.
The Radisys ENP2611 PCI board is a good example -- it has its reset
logic wired in such a way that if you reset the (ARM-based) CPU on
the board, it also causes the 21555 nontransparent PCI bridge on the
board to be reset, which makes it lose all its primary config space
info (BARs, etc.)  The IXP1200 CPU-based PCI cards (now obsolete)
used to suffer from the same issue.

This is currently worked around in the driver, which caches all BAR
values when the module is first loaded, and detects when the card is
reset and then writes back all BARs manually.


--L
