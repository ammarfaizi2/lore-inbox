Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbULBWwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbULBWwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbULBWwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:52:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:49054 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261799AbULBWwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:52:07 -0500
Date: Thu, 2 Dec 2004 14:56:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: xhejtman@mail.muni.cz, marcelo.tosatti@cyclades.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041202145610.49e27b49.akpm@osdl.org>
In-Reply-To: <20041202223146.GA31508@zaphods.net>
References: <20041111214435.GB29112@mail.muni.cz>
	<4194A7F9.5080503@cyberone.com.au>
	<20041113144743.GL20754@zaphods.net>
	<20041116093311.GD11482@logos.cnet>
	<20041116170527.GA3525@mail.muni.cz>
	<20041121014350.GJ4999@zaphods.net>
	<20041121024226.GK4999@zaphods.net>
	<20041202195422.GA20771@mail.muni.cz>
	<20041202122546.59ff814f.akpm@osdl.org>
	<20041202210348.GD20771@mail.muni.cz>
	<20041202223146.GA31508@zaphods.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Schmidt <zaphodb@zaphods.net> wrote:
>
> On Thu, Dec 02, 2004 at 10:03:48PM +0100, Lukas Hejtmanek wrote:
> > > > I found out that 2.6.6-bk4 kernel is OK. 
> > > That kernel didn't have the TSO thing.  Pretty much all of these reports
> > > have been against e1000_alloc_rx_buffers() since the TSO changes went in.
> > > Did you try disabling TSO, btw?
> > I did it. Allocation failure is still there :(
> I had no luck with/without TSO either but on tg3.
> I disabled the on-disk-caching component of the application and it now runs
> without page allocation errors. Currently it is running smoothly at ~500mbit/s
> and ~80kpps in each direction at ~44k interrupts/s, so the problematic
> combination seems to be many open files, high i/o transaction rate or
> troughput and heavy networking load. (tso currently on)
> Caching on ext2-fs in general seemed to generate less page allocation errors
> than on xfs and none of the traces i looked over so far showed involvement
> of the filesystem i.e. were all triggered by alloc_skb.

hm, OK, interesting.

It's quite possible that XFS is performing rather too many GFP_ATOMIC
allocations and is depleting the page reserves.  Although increasing
/proc/sys/vm/min_free_kbytes should help there.

Nathan, it would be a worthwhile exercise to consider replacing GFP_ATOMIC
with (GFP_ATOMIC & ~ __GFP_HIGH) where appropriate.  This is because
GFP_ATOMIC does two distinct things:

a) Don't sleep, so we can call it from within-spinlock and interrupt contexts.

b) Dip further into the page reserves.

If there are places in XFS where it only needs one of these two behaviours,
it would be good to select just that one.

