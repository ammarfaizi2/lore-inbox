Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUEZUrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUEZUrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 16:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265798AbUEZUrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 16:47:23 -0400
Received: from fmr04.intel.com ([143.183.121.6]:19668 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265799AbUEZUrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 16:47:17 -0400
Message-Id: <200405262047.i4QKlBF22744@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: net_device->queue_lock contention on 32-way box
Date: Wed, 26 May 2004 13:47:11 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRDYp5Fn+4sLufbQo2RyoPAsbRrJA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hitting a very strange lock contention that I can't explain.  The
lock in question is net_device->queue_lock, some of the holding time
measured by lockmeter are as long as 36ms !! (it's very pathetic if
I may add my feeling to it).

The workload by no mean is exercising any network component on purpose.
In fact it's a db workload.  The network gets involved only because the
db server has to transmit query data back to the client.  The xmit rate
on the server side should be around 120 megabit / sec and we are using
gigabit NIC and gigabit switch.

So far we have tried both tigon3 and e1000 NIC, both has the same amount
of lock contention.  Total system time just in the spin is around 10% on
32-way numa machine.

Looked up the code in dev_queue_xmit and qdisc_restart, this lock is
used to enqueue/dequeue xmit packets.  Don't see how it is possible
that some process hold on to it for 36ms!  Possible a numa related
issue? or something I missed in the kernel network xmit path?

Thoughts, comments?


SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
  7.5% 52.0%  1.7us( 257us)  175us(  29ms)( 4.7%)   2666132 48.0% 19.0% 33.1%  net_device->queue_lock
  1.2% 78.5%  0.7us( 125us)    0us                  1124063 21.5%    0% 78.5%    net_tx_action+0x240
  6.2% 32.8%  2.4us( 257us)  175us(  29ms)( 4.7%)   1542069 67.2% 32.8%    0%    qdisc_restart+0x450

 14.3% 26.2%  5.5us( 333us)  268us(  36ms)( 5.7%)   1542071 73.8% 26.2%    0%    dev_queue_xmit+0x1a0




