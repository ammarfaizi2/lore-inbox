Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752195AbWKAXEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbWKAXEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbWKAXEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:04:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7617
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752195AbWKAXEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:04:13 -0500
Date: Wed, 01 Nov 2006 15:04:18 -0800 (PST)
Message-Id: <20061101.150418.26278280.davem@davemloft.net>
To: johnip@sgi.com
Cc: rdreier@cisco.com, matthew@wil.cx, jmodem@AbominableFirebug.com,
       mst@mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeff@garzik.org, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Ordering between PCI config space writes and MMIO reads?
From: David Miller <davem@davemloft.net>
In-Reply-To: <4548CAE7.8010300@sgi.com>
References: <20061031204717.GG26964@parisc-linux.org>
	<ada4ptkt8y2.fsf@cisco.com>
	<4548CAE7.8010300@sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Partridge <johnip@sgi.com>
Date: Wed, 01 Nov 2006 10:27:19 -0600

> Sorry, but I find this change a bit puzzling. The problem is
> particular to the PPB on the HCA and not Altix. I can't see anywhere
> that a PCI Config Write is required to block until completion, it is
> the driver and the HCA ,not the Altix hardware that requires the
> Config Write to have completed before we leave mthca_reset()
> Changing pci_write_config_xxx() will change the behavior for ALL
> drivers and the possibility of breaking something else. The fix was
> very low risk in mthca_reset(), changing the PCI code to fix this is
> much more onerous.

The issue is that something as simple as:

	val = pci_read_config(REG);
	val |= bit;
	pci_write_config(REG, val);
	newval = pci_read_config(REG);
	BUG_ON(!(newval & bit));

is not guarenteed by PCI (aparently).

I see no valid reason why every PCI device driver should
be troubled with this lunacy and the ordering should thus
be ensured by the PCI layer.

It just so happens to take care of the original driver
issue too :-)
