Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWHLLlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWHLLlT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 07:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWHLLlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 07:41:19 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:41674 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750847AbWHLLlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 07:41:19 -0400
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
In-Reply-To: <20060812104224.GA12353@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins>
	 <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins>
	 <44DD4E3A.4040000@redhat.com> <20060812084713.GA29523@2ka.mipt.ru>
	 <1155374390.13508.15.camel@lappy> <20060812093706.GA13554@2ka.mipt.ru>
	 <1155377887.13508.27.camel@lappy>  <20060812104224.GA12353@2ka.mipt.ru>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 13:40:29 +0200
Message-Id: <1155382830.13508.38.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 14:42 +0400, Evgeniy Polyakov wrote:

> When network uses the same allocator, it depends on it, and thus it is
> possible to have (cut by you) a situation when reserve (which depends on
> SLAB and it's OOM too) is not filled or even does not exist.

No, the reserve does not depend on SLAB, and I totally short-circuit the
SLAB allocator for skbs and related on memory pressure.

The memalloc reserve is on the page allocator level and is only
accessable for PF_MEMALLOC processes or __GFP_MEMALLOC (new in my
patches) allocations. (arguably there could be some more deadlocks wrt.
PF_MEMALLOC where the code under PF_MEMALLOC is not properly bounded,
those would be bugs and should be fixed if present/found)

> If transferred to your implementation, then just steal some pages from
> SLAB when new network device is added and use them when OOM happens.
> It is much simpler and can help in the most of situations.

SLAB reclaim is painfull and has been tried by the time you OOM.

