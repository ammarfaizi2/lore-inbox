Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVA1AED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVA1AED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVA0Xvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:51:40 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:4546
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261286AbVA0Xfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:35:44 -0500
Date: Thu, 27 Jan 2005 15:31:14 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       greg@kroah.com, akpm@osdl.org
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100,
 xircom_tulip_cb, iph5526
Message-Id: <20050127153114.72be03e2.davem@davemloft.net>
In-Reply-To: <20050127225725.F3036@flint.arm.linux.org.uk>
References: <41F952F4.7040804@pobox.com>
	<20050127225725.F3036@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005 22:57:25 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Has e100 actually been fixed to use the PCI DMA API correctly yet?

It seems to be doing the right thing.  I see the DMA sync calls
(properly using cpu vs. device syncing variants) at the right
spots, and the only thing the chip really relies upon is ordering
of visibility and this is achieved via a combination of cpu memory
barriers and the correct DMA sync calls.

For example, a pci_dma_sync_single_for_cpu() is always performed before
peeking at the descriptors at RX interrupt time (see e100_rx_indicate).

When new descriptors are written to, then linked into the chain it
memory barriers the cpu writes then DMA syncs the previous descriptor
to the device.  This is occuring in e100_alloc_skb().

Therefore the only missing sync would be of the new RX descriptor
when linking things in like that, ie. at the end of e100_rx_alloc_skb()
if rx->prev->skb is non-NULL.
