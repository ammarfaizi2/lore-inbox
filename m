Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVINQsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVINQsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVINQsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:48:36 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:54535 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030265AbVINQsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:48:35 -0400
Date: Wed, 14 Sep 2005 12:47:44 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       torvalds@osdl.org, akpm@osdl.org, ink@jurassic.park.msu.ru,
       kaos@sgi.com, greg@kroah.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, ambx1@neo.rr.com
Subject: Re: [patch 2.6.14-rc1] pci: only call pci_restore_bars at boot
Message-ID: <20050914164742.GD16667@tuxdriver.com>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
	torvalds@osdl.org, akpm@osdl.org, ink@jurassic.park.msu.ru,
	kaos@sgi.com, greg@kroah.com, rmk+lkml@arm.linux.org.uk,
	matthew@wil.cx, grundler@parisc-linux.org, ambx1@neo.rr.com
References: <09142005095242.32027@bilbo.tuxdriver.com> <43283CDC.3070603@pobox.com> <20050914.092650.99910742.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914.092650.99910742.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 09:26:50AM -0700, David S. Miller wrote:
> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Wed, 14 Sep 2005 11:08:12 -0400
> 
> > This seems like it will break a lot of stuff that -does- need the BARs 
> > restored when resuming from D3.
> 
> I wasn't going to say anything about this ia64 workaround,
> but yes I have to agree with Jeff, this change starts to
> lose the whole point of the original change.

Those cases are handled by the driver calling pci_restore_state after
calling pci_set_power_state(..., PCI_D0).

The only time need_restore is actually needed is when the device is
first accessed after boot (signified by PCI_UNKNOWN).  When PCI drivers
load, they typically call pci_enable_device before doing anything else.
pci_enable_device calls pci_set_power_state(..., PCI_D0), which exposes
the device to potentially become uninitialized if it had previously
been left in PCI_D3hot.  Any other time pci_set_power_state(..., PCI_D0)
is called, drivers know to call (and can call) pci_restore_state
afterwards.

If not calling pci_restore_bars from pci_set_power_state during normal
transitions from PCI_D3hot was a problem, it would have been a problem
long before the pci_restore_bars patch came along in 2.6.14-rc1. :-)

John
-- 
John W. Linville
linville@tuxdriver.com
