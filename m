Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbUJ0Fku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUJ0Fku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUJ0Fkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:40:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:15300 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbUJ0Fkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:40:43 -0400
Date: Tue, 26 Oct 2004 22:33:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-Id: <20041026223335.6a1dad18.akpm@osdl.org>
In-Reply-To: <20041027044445.GV14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au>
	<Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com>
	<20041027005425.GO14325@dualathlon.random>
	<417F025F.5080001@yahoo.com.au>
	<20041027022920.GS14325@dualathlon.random>
	<417F0FA2.4090800@yahoo.com.au>
	<20041027032338.GU14325@dualathlon.random>
	<417F1746.2080607@yahoo.com.au>
	<20041026204308.73ee438b.akpm@osdl.org>
	<20041027044445.GV14325@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@novell.com> wrote:
>
> So after allocating the highmem pages we invoke kswapd
>  again

Nope.  We don't wake kswapd until the lower zones are below pages_low as
well.  Then we rebalance all the zones which are below pages_high.

As I say: run a workload mix and monitor /proc/vmstat:

	pgscan_kswapd_high
	pgscan_kswapd_normal
	pgscan_kswapd_dma

These should be increasing at rates which are proportional to their size,
if most allocations have __GFP_HIGHMEM.

The lower-zone protection thing means that the scanning rate really should
be proportional to (zone size - (protection from __GFP_HIGHMEM
allocations)), but it's not too far off at present.

The balancing of the zone scanning rates is subtle and easy to break.  As is
the balancing of that against slab scanning.
