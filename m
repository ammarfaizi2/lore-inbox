Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUBKSbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266064AbUBKSbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:31:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22706 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266055AbUBKSbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:31:02 -0500
Date: Wed, 11 Feb 2004 10:30:56 -0800
From: "David S. Miller" <davem@redhat.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: lists@mdiehl.de, dsaxena@plexity.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-Id: <20040211103056.69e4660e.davem@redhat.com>
In-Reply-To: <20040211111800.A5618@home.com>
References: <20040211061753.GA22167@plexity.net>
	<Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
	<20040211111800.A5618@home.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 11:18:00 -0700
Matt Porter <mporter@kernel.crashing.org> wrote:

> Sure, other non cache coherent arch's that I'm aware of (PPC, ARM, etc.)
> already implement the least expensive cache operations based on the
> direction parameter in pci_dma_sync_single(). On PPC, we do the right
> thing based on each of three valid directions, I don't yet see what
> additional information pci_dma_sync_to_device_single() provides. 

There are two points in time where you want to sync:

1) Right after the device has done a DMA transaction, and the cpu
   wishes to read/write the datum.

2) Right after the cpu has read/write the datum, and we like to let the
   device DMA to/from the thing again.

That is the distinction provided by the two interfaces.

Consider something like MIPS, cache flushes needed for both of the above
operations:

1) pci_map_single(), device DMA's from the buffer.

2) pci_dma_sync_single().  Cpu writes some new command or
   status flag into the buffer.

3) pci_dma_sync_to_device_single(), now device is asked to DMA from the buffer
   again.

Cache flushes are needed on MIPS for both step #2 and #3, and different kinds of
flushes in fact.

Do you understand the need for this now?
