Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWHPIsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWHPIsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWHPIsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:48:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35976 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751013AbWHPIsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:48:22 -0400
Date: Wed, 16 Aug 2006 09:48:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060816084808.GA7366@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20060814110359.GA27704@2ka.mipt.ru> <200608152221.22883.arnd@arndb.de> <20060816053545.GB22921@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816053545.GB22921@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 09:35:46AM +0400, Evgeniy Polyakov wrote:
> On Tue, Aug 15, 2006 at 10:21:22PM +0200, Arnd Bergmann (arnd@arndb.de) wrote:
> > Am Monday 14 August 2006 13:04 schrieb Evgeniy Polyakov:
> > > ?* full per CPU allocation and freeing (objects are never freed on
> > > ????????different CPU)
> > 
> > Many of your data structures are per cpu, but your underlying allocations
> > are all using regular kzalloc/__get_free_page/__get_free_pages functions.
> > Shouldn't these be converted to calls to kmalloc_node and alloc_pages_node
> > in order to get better locality on NUMA systems?
> >
> > OTOH, we have recently experimented with doing the dev_alloc_skb calls
> > with affinity to the NUMA node that holds the actual network adapter, and
> > got significant improvements on the Cell blade server. That of course
> > may be a conflicting goal since it would mean having per-cpu per-node
> > page pools if any CPU is supposed to be able to allocate pages for use
> > as DMA buffers on any node.
> 
> Doesn't alloc_pages() automatically switches to alloc_pages_node() or
> alloc_pages_current()?

That's not what's wanted.  If you have a slow interconnect you always want
to allocate memory on the node the network device is attached to.

