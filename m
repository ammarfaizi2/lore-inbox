Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWHLPXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWHLPXb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 11:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWHLPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 11:23:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:23187 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S964868AbWHLPX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 11:23:29 -0400
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
In-Reply-To: <20060812150842.GA5638@2ka.mipt.ru>
References: <1155127040.12225.25.camel@twins>
	 <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins>
	 <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru>
	 <1155374390.13508.15.camel@lappy> <20060812093706.GA13554@2ka.mipt.ru>
	 <44DDE857.3080703@redhat.com> <20060812144921.GA25058@2ka.mipt.ru>
	 <44DDEC1F.6010603@redhat.com>  <20060812150842.GA5638@2ka.mipt.ru>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 17:22:40 +0200
Message-Id: <1155396161.13508.55.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 19:08 +0400, Evgeniy Polyakov wrote:

> One must receive a packet to determine if that packet must be dropped
> until tricky hardware with header split capabilities or MMIO copying is
> used. 

True, that is done, but we then discard this packet at the very first
moment we know it's not for a special socket. This way we know this
piece of memory will not get stuck waiting on some unimportant blocked
process. So even though we allocate the packet we do not loose the
memory.

> Peter uses special pool to get data from when system is in OOM (at
> least in his latest patchset), so allocations are separated and thus
> network code is not affected by OOM condition, which allows to make
> forward progress.

I've done that throughout the patches, in various forms of brokenness.
Only with this full allocator could I implement all the semantics needed
for all skb operations though.

Previous attempts had some horrors build on alloc_pages() in there.

> Critical flag can be setup through setsockopt() and checked in
> tcp_v4_rcv().

I have looked at setsockopt(), but since I'm not sure I want to expose
this to userspace I chose to not do that.


