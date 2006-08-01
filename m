Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422762AbWHAIKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWHAIKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWHAIKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:10:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751288AbWHAIKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:10:43 -0400
Date: Tue, 1 Aug 2006 01:10:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org, neilb@suse.de,
       galak@kernel.crashing.org, christopher.leech@intel.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH rev2 1/4] dmaengine: enable mutliple clients and
 operations
Message-Id: <20060801011033.4c3484df.akpm@osdl.org>
In-Reply-To: <20060731.231158.91311705.davem@davemloft.net>
References: <20060728181618.5948.27138.stgit@dwillia2-linux.ch.intel.com>
	<20060731.231158.91311705.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 23:11:58 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

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

Please just delete the lock_cpu_hotplug()/unlock_cpu_hotplug() calls.  Any
code which runs inside preempt_disable() is automatically protected from
cpu hot-unplug.

It's not presently 100% protected against cpu hot-add, but it's good enough
for now: the setting of the flag in cpu_online_map is the last thing which
happens.  To make this 100% tight we should probably run __cpu_up() via
stop_machine_run().
