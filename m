Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265798AbUEZUz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265798AbUEZUz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUEZUz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:55:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265798AbUEZUzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:55:23 -0400
Date: Wed, 26 May 2004 13:54:36 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net_device->queue_lock contention on 32-way box
Message-Id: <20040526135436.657df321.davem@redhat.com>
In-Reply-To: <200405262047.i4QKlBF22744@unix-os.sc.intel.com>
References: <200405262047.i4QKlBF22744@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The net_tx_action() --> qdisc_run() --> qdisc_restart() code path
can hold the lock for a long time especially if lots of packets
have been enqueued before net_tx_action() had a chance to run.

For each enqueued packet, we go all the way into the device driver
to give the packet to the device.  Given that PCI PIO accesses are
likely in these paths, along with some memory accesses (to setup
packet descriptors and the like) this could take quite a bit of
time.

We do temporarily release the dev->queue_lock in between each
packet while we go into the driver.  It could be what you're
seeing is the latency to get the device's dev->xmit_lock because
we have to acquire that before we can release the dev->queue_lock

If you bind the device interrupts to one cpu, do things change?

