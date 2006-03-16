Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752414AbWCPQws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbWCPQws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbWCPQws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:52:48 -0500
Received: from mx.pathscale.com ([64.160.42.68]:28098 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752414AbWCPQwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:52:46 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20060315213813.747b5967.akpm@osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 08:52:30 -0800
Message-Id: <1142527950.25297.101.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 21:38 -0800, Andrew Morton wrote:

> You need to decide who "owns" these pages.  Once that's decided, it tells
> you who should release them.

OK, I've made some interesting progress here.

The driver is now doing all of its allocations of DMAable memory using
dma_alloc_coherent.  We do a get_page right after the allocation in
every case, and a put_page right before the free.  In the cases where
I'm allocating memory that I know or think might be greater than a page
in size, I'm using __GFP_COMP.

The nopage handler always does a get_page.

We now have a rational-looking set of VM_* flags, instead of a random
heap of whatever seemed to work.  And we're not touching PG_reserved.

And now everything works.  I have yet to examine /proc/meminfo in
microscopic detail after 100,000 runs to be sure we don't have a leak of
some kind, but I no longer get oopses or crashes after 20 repeated runs,
where before I didn't survive even one.

Whew!  What a relief.

Hugh, Andrew, Linus and Roland: thanks very much.  This has been a
tremendous help.

	<b

