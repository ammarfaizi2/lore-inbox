Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992665AbWKAQqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992665AbWKAQqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946948AbWKAQqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:46:46 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:15768 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1946942AbWKAQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:46:45 -0500
Date: Wed, 1 Nov 2006 09:46:44 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: John Partridge <johnip@sgi.com>
Cc: Roland Dreier <rdreier@cisco.com>,
       "Richard B. Johnson" <jmodem@AbominableFirebug.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeff@garzik.org, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061101164643.GH11399@parisc-linux.org>
References: <adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org> <20061024.154347.77057163.davem@davemloft.net> <aday7r4a3d7.fsf@cisco.com> <adad588tijq.fsf@cisco.com> <20061031195312.GD5950@mellanox.co.il> <019301c6fd2c$044d7010$0732700a@djlaptop> <20061031204717.GG26964@parisc-linux.org> <ada4ptkt8y2.fsf@cisco.com> <4548CAE7.8010300@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4548CAE7.8010300@sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 10:27:19AM -0600, John Partridge wrote:
> Sorry, but I find this change a bit puzzling. The problem is particular to
> the PPB on the HCA and not Altix.

That's not true; it's more likely on Altix, but it's not unique.  *any*
PCI-PCI bridge can reorder pci config reads and writes.  Apparently the
normal PCI host bridge implementation avoids this problem by blocking
until the completion comes back.  If you put a quad-port tulip card into
an Altix, you could experience the same problem (but it would be
massively unlikely.  You'd probably have to bring up three interfaces,
saturate them with traffic, then bring up the fourth to see it.  And
even then it would be rare).

> I can't see anywhere that a PCI Config 
> Write
> is required to block until completion, it is the driver and the HCA ,not the
> Altix hardware that requires the Config Write to have completed before we
> leave mthca_reset()

There's several places in the PCI midlayer that require the config write
to have completed before we do a config read.  The MWI code relies on
this to see if the device supports MWI.  If it gets out of order, we'll
think that the device doesn't support MWI when it thinks it's been told
to use MWI.  Data corruption could result.

> Changing pci_write_config_xxx() will change the behavior
> for ALL drivers and the possibility of breaking something else. The fix was
> very low risk in mthca_reset(), changing the PCI code to fix this is much
> more onerous.

I really don't think so.  At worst you'll be changing the timing.
