Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423624AbWJaUrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423624AbWJaUrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423625AbWJaUrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:47:19 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:38892 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1423623AbWJaUrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:47:18 -0500
Date: Tue, 31 Oct 2006 13:47:17 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeff@garzik.org, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061031204717.GG26964@parisc-linux.org>
References: <20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org> <20061024.154347.77057163.davem@davemloft.net> <aday7r4a3d7.fsf@cisco.com> <adad588tijq.fsf@cisco.com> <20061031195312.GD5950@mellanox.co.il> <019301c6fd2c$044d7010$0732700a@djlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019301c6fd2c$044d7010$0732700a@djlaptop>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 03:34:47PM -0500, Richard B. Johnson wrote:
> If you write to the PCI bus and then you read the result, the read 
> __might__ be the
> read that flushes any posted writes rather than the read of device 

Config space writes aren't posted, they're delayed.  So, for example,
you can do the config write on the primary bus, then it hits a bridge on
its way to the destination device.  The bridge is entitled (obviously,
it's unlikely to) drop it, and then the config read can pass by the
config write.

I'm beginning to think Michael Tsirkin has the only solution to this
-- architectures need to check that their hardware blocks until the
config write completion has occurred (and if not, simulate that it has
in software).

