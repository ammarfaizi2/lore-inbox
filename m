Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVG0Acv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVG0Acv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVG0Act
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:32:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262408AbVG0Acc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:32:32 -0400
Date: Tue, 26 Jul 2005 17:31:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726173126.5368266b.akpm@osdl.org>
In-Reply-To: <1122420376.6433.68.camel@dyn9047017102.beaverton.ibm.com>
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
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Tue, 2005-07-26 at 16:07 -0700, Andrew Morton wrote:
>  > Badari Pulavarty <pbadari@us.ibm.com> wrote:
>  > >
>  > > Here is the data with 5 ext2 filesystems. I also collected /proc/meminfo
>  > > every 5 seconds. As you can see, we seem to dirty 6GB of data in 20
>  > > seconds of starting the test. I am not sure if its bad, since we have
>  > > lots of free memory..
>  > 
>  > It's bad.  The logic in balance_dirty_pages() should block those write()
>  > callers as soon as we hit 40% dirty memory or whatever is in
>  > /proc/sys/vm/dirty_ratio.  So something is horridly busted.
>  > 
>  > Can you try reducing the number of filesystems even further?
> 
>  Single ext2 filesystem. We still dirty pretty quickly (data collected
>  every 5 seconds).

It happens here, a bit.  My machine goes up to 60% dirty when it should be
clamping at 40%.

The variable `total_pages' in page-writeback.c (from
nr_free_pagecache_pages()) is too high.  I trace it back to here:

On node 0 totalpages: 1572864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1568768 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1

This machine only has 4G of memory, so the platform code is overestimating
the number of pages by 50%.  Can you please check your dmesg, see if your
system is also getting this wrong?
