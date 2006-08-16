Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWHPJmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWHPJmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWHPJmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:42:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24291 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751076AbWHPJmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:42:43 -0400
Date: Wed, 16 Aug 2006 10:42:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060816094224.GA12606@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20060814110359.GA27704@2ka.mipt.ru> <200608152221.22883.arnd@arndb.de> <20060816053545.GB22921@2ka.mipt.ru> <20060816084808.GA7366@infradead.org> <20060816090028.GA25476@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816090028.GA25476@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 01:00:31PM +0400, Evgeniy Polyakov wrote:
> On Wed, Aug 16, 2006 at 09:48:08AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> > > Doesn't alloc_pages() automatically switches to alloc_pages_node() or
> > > alloc_pages_current()?
> > 
> > That's not what's wanted.  If you have a slow interconnect you always want
> > to allocate memory on the node the network device is attached to.
> 
> There is drawback here - if data was allocated on CPU wheere NIC is
> "closer" and then processed on different CPU it will cost more than 
> in case where buffer was allocated on CPU where it will be processed.
> 
> But from other point of view, most of the adapters preallocate set of
> skbs, and with msi-x help there will be a possibility to bind irq and
> processing to the CPU where data was origianlly allocated.

The case we've benchmarked (spidernet) is the common preallocated case.
For allocate on demand I'd expect the slab allocator to get things right.
We do have the irq on the right node, not through MSI but due to the odd
interreupt architecture of the Cell blades.

> So I would like to know how to determine which node should be used for
> allocation. Changes of __get_user_pages() to alloc_pages_node() are
> trivial.

The patches I have add the node field to struct net_device and use it.
It's set via alloc_netdev_node, a function I add and for the normal case
of PCI adapters the node arguments comes from pcibus_to_node().  It's
arguable we should add a alloc_foodeve_pdev variant that hids that detail,
but I'm not entirely sure about whether it's worth the effort.
