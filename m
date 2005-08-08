Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVHHNZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVHHNZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbVHHNZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:25:26 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:55732 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750882AbVHHNZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:25:26 -0400
Subject: Re: Is it a process?
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: lab liscs <liscs.lab@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508080838260.18088@yvahk01.tjqt.qr>
References: <1132fcd6050805060216a03fb6@mail.gmail.com>
	 <1123255059.18332.54.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508080838260.18088@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 08 Aug 2005 09:25:15 -0400
Message-Id: <1123507515.18332.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 08:39 +0200, Jan Engelhardt wrote:
> >> when linux kernel receives a packet from the netcard and the forwards it .
> >> the process can be viewed as a kernel process ?
> >> and if this process can be interrupted ?
> >
> >When a packet is received from the kernel, this is first done by an
> >interrupt handler to just get the packet. Then the rest (forwarding) is
> 
> Do you mean forwarding from NIC to kernel space, or already the iptables 
> FORWARD chain? What about packets destined for the local machine that just hit 
> INPUT?

When the interrupt goes off upon receiving a packet. The driver
"forwards" it from the NIC to the kernel space. Note, this most likely
already happened via DMA but the driver manages the memory that was
used.  Then the driver (still in the interrupt) calls netif_rx which
queues the packet on the input queue and wakes up the NET_RX_SOFTIRQ
tasklet. This tasklet will handle the processing of the packet, until it
can find a task that this packet belongs to and then it "forwards" the
packet off to that task.

> 
> >done by a tasklet. This tasklet can be run either by the softirqd (a
> >kernel thread) or at certain locations in the kernel. So this is not a
> 
> What is the name of this tasklet? ksoftirqd shows up in "ps", but no childs 
> for it.

The tasklet is named NET_RX_SOFTIRQ.  No it is not a task, which I said
that it wasn't in my last email. I said that the softirqd (ksoftirqd)
may execute the code for that tasklet, or it may be handled on return
from an interrupt.  This is _not_ a task that would show up in ps
(unless you are running Ingo Molnar's RT patch, which does things
differently to this regard).

-- Steve


