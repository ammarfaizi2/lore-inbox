Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261931AbSI3Fwf>; Mon, 30 Sep 2002 01:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbSI3Fwf>; Mon, 30 Sep 2002 01:52:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:20655 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261931AbSI3Fwd>;
	Mon, 30 Sep 2002 01:52:33 -0400
Message-ID: <3D97E7D7.442733ED@digeo.com>
Date: Sun, 29 Sep 2002 22:57:43 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
References: <200209291615.24158.l.allegrucci@tiscalinet.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 05:57:52.0172 (UTC) FILETIME=[5029EEC0:01C26846]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci wrote:
> 
> qsbench is a VM benchmark based on sorting a large array
> by quick sort.
> http://web.tiscali.it/allegrucci/qsbench-1.0.0.tar.gz
> 
> Below are some results of qsbench sorting a 350Mb array
> on a 256+400Mb RAM+swap machine.
> Tested kernels: 2.4.19, 2.5.38 and 2.5.39

Thanks for pointing this out.  It's happening because the VM in
2.5.39 tries to avoid stalling tasks for too long.

That works well, so qsbench just gets in and submits more reads
against the swapdevice much earlier than it used to.  The new IO
scheduler then obligingly promotes the swap reads ahead of the
swap writes and we end up doing a ton of seeking.

The -mm patchset has some kswapd improvements which pull most
of the difference back.

Stronger fixes for this would be a) penalise heavily-faulting
tasks and b) tag swap writeout as needing higher priority at the
block level.

I'll take a look at some preferential throttling later on.  But
I must say that I'm not hugely worried about performance regression
under wild swapstorms.  The correct fix is to go buy some more
RAM, and the kernel should not be trying to cater for underprovisioned
machines if that affects the usual case.
