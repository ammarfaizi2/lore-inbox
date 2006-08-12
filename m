Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWHLKTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWHLKTD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 06:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWHLKS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 06:18:56 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:32801 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S932313AbWHLKSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 06:18:55 -0400
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
In-Reply-To: <20060812093706.GA13554@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins>
	 <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins>
	 <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru>
	 <1155374390.13508.15.camel@lappy>  <20060812093706.GA13554@2ka.mipt.ru>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 12:18:07 +0200
Message-Id: <1155377887.13508.27.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 13:37 +0400, Evgeniy Polyakov wrote:
> On Sat, Aug 12, 2006 at 11:19:49AM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > As you described above, memory for each packet must be allocated (either
> > > from SLAB or from reserve), so network needs special allocator in OOM
> > > condition, and that allocator should be separated from SLAB's one which 
> > > got OOM, so my purpose is just to use that different allocator (with
> > > additional features) for netroking always. Since every piece of
> > > networking is limited (socket queues, socket numbers, hardware queues,
> > > hardware wire speeds an so on) there is always a maximum amount of
> > > memory it can consume and can never exceed, so if network allocator will 
> > > get that amount of memory at the begining, it will never meet OOM, 
> > > so it will _always_ work and thus can allow to make slow progress for 
> > > OOM-capable things like block devices and swap issues. 
> > > There are no special reserve and no need to switch to/from it and 
> > > no possibility to have OOM by design.
> > 
> > I'm not sure if the network stack is bounded as you say; for instance
> > imagine you taking a lot of packets for blocked user-space processes,
> > these will just accumulate in the network stack and go nowhere. In that
> > case memory usage is very much unbounded.
> 
> No it is not. There are socket queues and they are limited. Things like
> TCP behave even better.
> 
> > Even if blocked sockets would only accept a limited amount of packets,
> > it would then become a function of the amount of open sockets, which is
> > again unbounded.
> 
> Does it? I though it is possible to only have 64k of working sockets per
> device in TCP.

65535 sockets * 128 packets * 16384 bytes/packet = 
1^16 * 1^7 * 1^14 = 1^(16+7+14) = 1^37 = 128G of memory per IP

And systems with a lot of IP numbers are not unthinkable.

I wonder what kind of system you have to feel that that is not a
problem. (I'm not sure on the 128 packets per socket, and the 16k per
packet is considering jumbo frames without scather gather receive)

> If system is limited enough to provide enough memory for network tree
> allocator, it is possible to create it's own drop condition inside NTA,
> but it must be saparated from the weakest chain element in that
> conditions - SLAB OOM.

Hence the alternative allocator to use on tight memory conditions.

