Return-Path: <linux-kernel-owner+w=401wt.eu-S965350AbXAKJdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965350AbXAKJdZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 04:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbXAKJdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 04:33:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34556 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965350AbXAKJdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 04:33:23 -0500
Date: Thu, 11 Jan 2007 09:33:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: jeff@garzik.org, shemminger@osdl.org, csnook@redhat.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
Message-ID: <20070111093316.GC3141@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
	shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
References: <20070111004226.GD2624@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111004226.GD2624@osprey.hogchain.net>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <asm/page.h>

Why do you need this one?

> +#include <asm/system.h>

Shouldn't be needed aswell.

> +#include <asm/checksum.h>

<net/checksum.h>, please.

> +	spin_lock_init(&adapter->stats_lock);
> +	spin_lock_init(&adapter->tx_lock);
> +	spin_lock_init(&adapter->mb_lock);
> +	spin_lock_init(&adapter->vl_lock);
> +	spin_lock_init(&adapter->mii_lock);

Do you really need that many locks?

> +static inline void atl1_irq_enable(struct atl1_adapter *adapter)
> +{
> +	if (likely(0 == atomic_dec_and_test(&adapter->irq_sem)))
> +		atl1_write32(&adapter->hw, REG_IMR, IMR_NORMAL_MASK);
> +}

We normally prefer atomic_dec_and_test(&adapter->irq_sem) == 0 or
just !atomic_dec_and_test(&adapter->irq_sem).

Also all these little helpers should probably not be marked inline
so gcc can decide on it's own merit which static function to inline.

> +static int atl1_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +{
> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +	case SIOCGMIIREG:
> +	case SIOCSMIIREG:
> +		return atl1_mii_ioctl(netdev, ifr, cmd);
> +	case SIOCETHTOOL:
> +		atl1_set_ethtool_ops(netdev);

ethtool doesn't use the ioctl path anymore at all.

> +static int atl1_open(struct net_device *netdev)
> +{
> +	struct atl1_adapter *adapter = netdev_priv(netdev);
> +	int err;
> +
> +	/* allocate transmit descriptors */
> +	if ((err = atl1_setup_ring_resources(adapter)))
> +		return err;
> +	if ((err = atl1_up(adapter)))
> +		goto err_up;

Preffered style for this is:

	err = atl1_setup_ring_resources(adapter);
	if (err)
		return err;
	err = atl1_up(adapter);
	if (err)
		goto err_up;

(also applies in various other places)

