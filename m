Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbUEYRxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbUEYRxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUEYRxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:53:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17792 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265008AbUEYRwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:52:20 -0400
Date: Tue, 25 May 2004 13:51:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mark Frazer <mark@mjfrazer.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] scatter-gather ops within host memory on a PC
In-Reply-To: <20040525170931.GE10775@mjfrazer.org>
Message-ID: <Pine.LNX.4.53.0405251337210.1989@chaos>
References: <20040525170931.GE10775@mjfrazer.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004, Mark Frazer wrote:

> I'd like to aggregate a bunch of ethernet packet payloads into a single
> large buffer after examining the packet headers to determine the order of
> the packets.  The data volume makes offloading this to a DMA controller
> desirable.
>
> Do PC chipsets have DMA controllers on them to do these scatter-gather
> operations?  I know a lot of embedded SoC processors do, but am not
> to familiar with the current PC chipsets.
>
> I've glanced at the NFS code but haven't studied it a lot.
> rxrpc/transport.c seems to copy some data around, so I assume that linux
> uses the host processor to gather the individual ethernet packets into
> pages that go into the page cache.
>
> Are there any good books anyone would recommend on PC architecture?
>
> thanks
> -mark
> --

Scatter-lists with DMA operations are quite common. Many Ethernet
controllers that perform bus-master DMA use a chip that is either
a (PLX) PCI 9080 or pretty-much a clone.

The problem is that DMA does data-transfer to physical locations.
If you only have one physical location (a page in DMA-able memory)
its virtual to physical translation needs to be done only once.
But, if you expect to write to/from user-mode buffers, the translation
needs to be done every time the scatter-list is built. This is not
some simple operation since user's pages are assembled from anywhere
into what looks like contiguous space to the user, but physically
can be anywhere. So somebody has got to scan a bunch of page-tables
looking for the user's pages every time you build the scatter-list,
i.e., every DMA transfer. This will surely take much more time than
the current scheme.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


