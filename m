Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265816AbUEZVrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUEZVrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265824AbUEZVrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:47:33 -0400
Received: from fmr03.intel.com ([143.183.121.5]:25255 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265816AbUEZVrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:47:25 -0400
Message-Id: <200405262147.i4QLlFF23657@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David S. Miller'" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: net_device->queue_lock contention on 32-way box
Date: Wed, 26 May 2004 14:47:15 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRDY8RXbZLeHU+wSKuPpMjoTngKSQAAMbyA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20040526135436.657df321.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> David S. Miller wrote on Wednesday, May 26, 2004 1:55 PM
> The net_tx_action() --> qdisc_run() --> qdisc_restart() code path
> can hold the lock for a long time especially if lots of packets
> have been enqueued before net_tx_action() had a chance to run.
>
> For each enqueued packet, we go all the way into the device driver
> to give the packet to the device.  Given that PCI PIO accesses are
> likely in these paths, along with some memory accesses (to setup
> packet descriptors and the like) this could take quite a bit of
> time.
>
> We do temporarily release the dev->queue_lock in between each
> packet while we go into the driver.  It could be what you're
> seeing is the latency to get the device's dev->xmit_lock because
> we have to acquire that before we can release the dev->queue_lock
>

That's where I'm having trouble in interpreting the lockmeter
data.  qdisc_restart() does a trylock on dev->xmit_lock, if it gets
it, unlock queue_lock right away. If it didn't get it, queue the
packet and return, then qdisc_run terminates and the caller to
qdisc_run will unlock queue_lock.  Don't see that as a long operation
at all.  Could netif_schedule() take long time to run?


> If you bind the device interrupts to one cpu, do things change?

We always bind network interrupt to one cpu, haven't tried with
non-bound configuration.


