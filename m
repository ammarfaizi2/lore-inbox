Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbULCAT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbULCAT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 19:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbULCAT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 19:19:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:58851 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261811AbULCATY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 19:19:24 -0500
Date: Thu, 2 Dec 2004 16:18:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
Cc: zaphodb@zaphods.net, marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041202161839.736352c2.akpm@osdl.org>
In-Reply-To: <20041202231837.GB15185@mail.muni.cz>
References: <20041113144743.GL20754@zaphods.net>
	<20041116093311.GD11482@logos.cnet>
	<20041116170527.GA3525@mail.muni.cz>
	<20041121014350.GJ4999@zaphods.net>
	<20041121024226.GK4999@zaphods.net>
	<20041202195422.GA20771@mail.muni.cz>
	<20041202122546.59ff814f.akpm@osdl.org>
	<20041202210348.GD20771@mail.muni.cz>
	<20041202223146.GA31508@zaphods.net>
	<20041202145610.49e27b49.akpm@osdl.org>
	<20041202231837.GB15185@mail.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz> wrote:
>
> On Thu, Dec 02, 2004 at 02:56:10PM -0800, Andrew Morton wrote:
> > It's quite possible that XFS is performing rather too many GFP_ATOMIC
> > allocations and is depleting the page reserves.  Although increasing
> > /proc/sys/vm/min_free_kbytes should help there.
> 
> Btw, how the min_free_kbytes works?

The page reclaim code and the page allocator will aim to keep that amount
of memory free for emergency, IRQ and atomic allocations.

> I have up to 1MB TCP windows. If I'm running out of memory then kswapd should
> try to free some memory (or bdflush).

yes, there's some latency involved.  Especially on uniprocessor - if the
CPU is stuck in an interrupt handler refilling a huge network Rx ring then
waking kswapd won't do anything and you will run out of memory.

> But on GE I can receive data faster then
> disk is able to swap or flush buffers. So I should keep min_free big enough to
> give time to disk to flush/swap data?

All I can say is "experiment with it".

It might be useful to renice kswapd so that userspace processes do not
increase its latency.

