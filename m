Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267851AbTAMVx5>; Mon, 13 Jan 2003 16:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267971AbTAMVx5>; Mon, 13 Jan 2003 16:53:57 -0500
Received: from AMarseille-201-1-3-195.abo.wanadoo.fr ([193.253.250.195]:40816
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267851AbTAMVxz>; Mon, 13 Jan 2003 16:53:55 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: root@chaos.analogic.com, Jeff Garzik <jgarzik@pobox.com>
Cc: Ross Biro <rossb@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030113162939.30920A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030113162939.30920A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042495337.587.27.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Jan 2003 23:02:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> ...but, at the same time, who knows how long the write posting may
take,
> so one doesn't know how long the delay really needs to be.
> 
> It would be nice if there was an arch-specific flush-posted-writes
hook
> [wmb_mmio() ?], if that was possible on write-posting CPUs.  Currently
> right now the canonical solution ("MMIO read") doesn't work in some
> situations, and I do think we have a solution at all for those "some
> situations."

What situations a read from the same bus path won't work ? wmb_mmio
can't work, it's really a matter of bus path, you have to read from the
same bus segment your device is on, preferably the same device.

On Mon, 2003-01-13 at 22:40, Richard B. Johnson wrote:

> There is a well-defined procedure for this. Any "read" anywhere
> in the PCI address space, will force all posted writes to complete.
> However, the "read" will not be the data one would obtain after
> the write completes. Therefore, to guarantee that all posted
> writes complete before you read, for instance, status that could
> be affected by that write, you execute a dummy read anywhere in
> PCI address space, somewhere that will not screw up your
> status. In other words, you don't read your device status twice,
> once to post the writes and once to get the status because some
> hardware will detect the read and fail to give you the correct
> status on the second read. Instead, you read some 'harmless' register
> that your hardware will decode, but not muck up the status. You
> don't want to read a nonexistant register because this will cause
> a lonnnnnnng bus-timeout. It will work to flush pending writes, but
> it's slow.

Hrm, in fact that's definitely not generic ;) A nonexistant register
on some archs will send you right to Machine Check -> Ooops ;)

Also, you a read from "anywhere on PCI" won't do the trick, you have to
read from the exact same bus path, crossing the same host & P2P bridges.

The problem is more generic than just MMIO on PCI, for example, even
with IO, I don't think we can guarantee anything, IO is basically MMIO
(we have some error recovery stuff in ppc32 that might make it +/- sync,
but that's not something that I would count on). Also, the CPU itself
may well have a store queue acting as a "all busses" write posting. On
PPC (again ;) we guarantee ordering, so if you do a read next, you'll
flush previous writes to the bus, but without that read, the write might
well stay a few cycles in your CPU store queue.

Ben.
 

