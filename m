Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWHLPJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWHLPJL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 11:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWHLPJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 11:09:11 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:26301 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932541AbWHLPJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 11:09:09 -0400
Date: Sat, 12 Aug 2006 19:08:42 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060812150842.GA5638@2ka.mipt.ru>
References: <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru> <1155374390.13508.15.camel@lappy> <20060812093706.GA13554@2ka.mipt.ru> <44DDE857.3080703@redhat.com> <20060812144921.GA25058@2ka.mipt.ru> <44DDEC1F.6010603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44DDEC1F.6010603@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 12 Aug 2006 19:08:44 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 10:56:31AM -0400, Rik van Riel (riel@redhat.com) wrote:
> >Yep. Socket allocations end up with alloc_skb() which is essentialy the
> >same as what is being done for receiving path skbs.
> >If you really want to separate critical from non-critical sockets, it is
> >much better not to play with alloc_skb() but directly forbid it in
> >appropriate socket allocation function like sock_alloc_send_skb().
> 
> The problem is the RECEIVE side.
>
> >What I suggested in previous e-mail is to separate networking
> >allocations from other system allocations, so problem in main allocator
> >and it's OOM would never affect network path.
> 
> That solves half of the problem.  We still need to make sure we
> do not allocate memory to non-critical sockets when the system
> is almost out of memory.

One must receive a packet to determine if that packet must be dropped
until tricky hardware with header split capabilities or MMIO copying is
used. Peter uses special pool to get data from when system is in OOM (at
least in his latest patchset), so allocations are separated and thus
network code is not affected by OOM condition, which allows to make
forward progress.
Critical flag can be setup through setsockopt() and checked in
tcp_v4_rcv().

-- 
	Evgeniy Polyakov
