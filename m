Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWHHVGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWHHVGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbWHHVGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:06:05 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:51923 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S965040AbWHHVGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:06:03 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
In-Reply-To: <20060808135721.5af713fb@localhost.localdomain>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060808193345.1396.16773.sendpatchset@lappy>
	 <20060808135721.5af713fb@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 23:05:21 +0200
Message-Id: <1155071122.23134.31.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 13:57 -0700, Stephen Hemminger wrote:
> On Tue, 08 Aug 2006 21:33:45 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > 
> > The core of the VM deadlock avoidance framework.
> > 
> > From the 'user' side of things it provides a function to mark a 'struct sock'
> > as SOCK_MEMALLOC, meaning this socket may dip into the memalloc reserves on
> > the receive side.
> > 
> > From the net_device side of things, the extra 'struct net_device *' argument
> > to {,__}netdev_alloc_skb() is used to attribute/account the memalloc usage.
> > Converted drivers will make use of this new API and will set NETIF_F_MEMALLOC
> > to indicate the driver fully supports this feature.
> > 
> > When a SOCK_MEMALLOC socket is marked, the device is checked for this feature
> > and tries to increase the memalloc pool; if both succeed, the device is marked
> > with IFF_MEMALLOC, indicating to {,__}netdev_alloc_skb() that it is OK to dip
> > into the memalloc pool.
> > 
> > Memalloc sk_buff allocations are not done from the SLAB but are done using 
> > alloc_pages(). sk_buff::memalloc records this exception so that kfree_skbmem()
> > can do the right thing.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Signed-off-by: Daniel Phillips <phillips@google.com>
> > 
> 
> How much of this is just building special case support for large allocations
> for jumbo frames? Wouldn't it make more sense to just fix those drivers to
> do scatter and add the support hooks for that?

Only some of the horrors in __alloc_skb(), esp those related to the
order argument. OTOH, yes I would very much like all the jumbo capable
driver to do proper scather/gather on fragments, alas drivers are not my
storng point.

If someone (preferably the maintainers) will contribute patches....

