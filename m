Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbUKWUqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbUKWUqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbUKWUmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:42:13 -0500
Received: from ns.suse.de ([195.135.220.2]:46982 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261544AbUKWUko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:40:44 -0500
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
Cc: ltd@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning   and  sickness
References: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel>
	<419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel>
	<419E6B44.8050505@devicelogics.com.suse.lists.linux.kernel>
	<5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14.suse.lists.linux.kernel>
	<5.1.0.14.2.20041123094109.04003720@171.71.163.14.suse.lists.linux.kernel>
	<41A2862A.2000602@devicelogics.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Nov 2004 21:40:41 +0100
In-Reply-To: <41A2862A.2000602@devicelogics.com.suse.lists.linux.kernel>
Message-ID: <p73k6sc1epi.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@devicelogics.com> writes:
> I can sustain full line rate gigabit on two adapters at the tsame time
> with a 12 CLK interpacket gap time and 0 dropped packets at 64
> byte sizes from a Smartbits to Linux provided the adapter ring buffer
> is loaded with static addresses. This demonstrates that it is
> possible to sustain 64 byte packet rates at full line rate with
> current DMA architectures on 400 Mhz buses with Linux.
> (which means it will handle any network loading scenario). The
> bottleneck from my measurements appears to be the
> overhead of serializing writes to the adapter ring buffer IO
> memory. The current drivers also perform interrupt
> coalescing very well with Linux. What's needed is a method for
> submission of ring buffer entries that can be sent in large
> scatter gather listings rather than one at a time. Ring buffers

Batching would also decrease locking overhead on the Linux side (less
spinlocks taken)

We do it already for TCP using TSO for upto 64K packets when
the hardware supports it. There were some ideas some time back
to do it also for routing and other protocols - basically passing 
lists of skbs to hard_start_xmit instead of always single ones - 
but nobody implemented it so far.

It was one entry in the "ideas to speed up the network stack" 
list i posted some time back.

With TSO working fine it doesn't seem to be that pressing.

One problem with the TSO implementation is that TSO only works for a
single connection. If you have hundreds that chatter in small packets
it won't help batching that up. Problem is that batching data from
separate sockets up would need more global lists and add possible SMP
scalability problems from more locks and more shared state. This 
is a real concern on Linux now - 512 CPU machines are really unforgiving.

However in practice it doesn't seem to be that big a problem because
it's extremly unlikely that you'll sustain even a gigabit ethernet
with such a multi process load. It has far more non network CPU
overhead than a simple packet generator or pktgen.

So overall I agree with Lincoln that the small packet case is not
that interesting except perhaps for DOS testing.

-Andi
