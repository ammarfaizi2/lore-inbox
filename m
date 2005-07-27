Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVG0B1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVG0B1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVG0B1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:27:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262323AbVG0B1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:27:38 -0400
Date: Tue, 26 Jul 2005 18:26:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726182631.668e2da2.akpm@osdl.org>
In-Reply-To: <194200000.1122427210@flay>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	<20050726111110.6b9db241.akpm@osdl.org>
	<1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	<20050726114824.136d3dad.akpm@osdl.org>
	<20050726121250.0ba7d744.akpm@osdl.org>
	<1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com>
	<20050726142410.4ff2e56a.akpm@osdl.org>
	<1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com>
	<20050726151003.6aa3aecb.akpm@osdl.org>
	<1122418089.6433.62.camel@dyn9047017102.beaverton.ibm.com>
	<20050726160728.55245dae.akpm@osdl.org>
	<1122420376.6433.68.camel@dyn9047017102.beaverton.ibm.com>
	<20050726173126.5368266b.akpm@osdl.org>
	<194200000.1122427210@flay>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> 
> > It happens here, a bit.  My machine goes up to 60% dirty when it should be
> > clamping at 40%.
> > 
> > The variable `total_pages' in page-writeback.c (from
> > nr_free_pagecache_pages()) is too high.  I trace it back to here:
> > 
> > On node 0 totalpages: 1572864
> >   DMA zone: 4096 pages, LIFO batch:1
> >   Normal zone: 1568768 pages, LIFO batch:31
> >   HighMem zone: 0 pages, LIFO batch:1
> > 
> > This machine only has 4G of memory, so the platform code is overestimating
> > the number of pages by 50%.  Can you please check your dmesg, see if your
> > system is also getting this wrong?
> 
> I think we're repeatedly iterating over the same zones by walking the 
> zonelists:
> 
> static unsigned int nr_free_zone_pages(int offset)
> {
>         pg_data_t *pgdat;
>         unsigned int sum = 0;
>         int i;
> 
>         for_each_pgdat(pgdat) {
>                 struct zone *zone;
> 
>                 for (i = 0; i < MAX_NR_ZONES; i++) {
>                         unsigned long size, high;
> 
>                         zone = pgdat->node_zones[i];
>                         size = zone->present_pages;
>                         high = zone->pages_high;
> 
>                         if (size > high)
>                                 sum += size - high;
>                 }
>         }
> }

I don't think so.  We're getting the wrong answer out of
calculate_zone_totalpages() which is an init-time thing.

Maybe nr_free_zone_pages() is supposed to fix that up post-facto somehow,
but calculate_zone_totalpages() sure as heck shouldn't be putting 1568768
into my ZONE_NORMAL's ->node_present_pages.

