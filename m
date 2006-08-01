Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWHASDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWHASDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWHASDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:03:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:9766 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750977AbWHASD3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:03:29 -0400
X-IronPort-AV: i="4.07,203,1151910000"; 
   d="scan'208"; a="100125073:sNHT16200786"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH rev2 1/4] dmaengine: enable mutliple clients and operations
Date: Tue, 1 Aug 2006 11:03:28 -0700
Message-ID: <BD524EA7912ED5469DFD0BAEF6BC752F296540@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH rev2 1/4] dmaengine: enable mutliple clients and operations
thread-index: Aca1MYiw2TM+oZoxT2qRGo1yllpmwwAXxAjQ
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "David Miller" <davem@davemloft.net>,
       "Williams, Dan J" <dan.j.williams@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <neilb@suse.de>,
       <galak@kernel.crashing.org>, <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 01 Aug 2006 18:03:29.0129 (UTC) FILETIME=[CAF21D90:01C6B594]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Dave,

The delay on that issue is my fault.  While Dan is an Intel employee,
he's in a totally separate part of the company (and a different state)
from me and the other networking folks.

I was trying to determine if reordering so that the spin_lock was inside
the lock_cpu_hotplug would work, or if something else was needed, Dan
suggested making the net_dma_event_lock a mutex, but then as Andrew
pointed out as long as a lock is being held preemption is disabled and
we're safe from cpu hotplug.

Simple patch to remove the lock_cpu_hotplug/unlock_cpu_hotplug calls as
Andrew suggested coming up.

- Chris

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net] 
> Sent: Monday, July 31, 2006 11:12 PM
> To: Williams, Dan J
> Cc: linux-kernel@vger.kernel.org; neilb@suse.de; 
> galak@kernel.crashing.org; Leech, Christopher; 
> alan@lxorguk.ukuu.org.uk
> Subject: Re: [PATCH rev2 1/4] dmaengine: enable mutliple 
> clients and operations
> 
> 
> 
> Can I ask that the known bugs in the I/O AT DMA code be fixed
> before we start adding new features to it?
> 
> Specifically, the lock_cpu_hotplug() call in net_dma_rebalance()
> is still there and being invoked with a spinlock held.  The
> spinlock is grabbed by the caller, netdev_dma_event() which
> grabs the net_dma_event_lock spinlock.
> 
> You cannot invoke lock_cpu_hotplug() while holding a spinlock
> because lock_cpu_hotplug(), as seen in kernel/cpu.c, takes
> a semaphore which can sleep.  Sleeping while holding a spinlock
> is not allowed.
> 
> This is the second time I have tried to make the Intel developers
> aware of this bug.  So please fix this problem.
> 
> Thanks a lot.
> 
