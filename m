Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUCPAzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUCPAxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:53:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262960AbUCPAtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:49:22 -0500
Date: Mon, 15 Mar 2004 16:49:17 -0800
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: consistent_sync_for_cpu() and friends on ppc32
Message-Id: <20040315164917.6a85966b.davem@redhat.com>
In-Reply-To: <1079396621.1967.196.camel@gaston>
References: <20040315201616.GA31268@suse.de>
	<20040315123647.4ce943b7.davem@redhat.com>
	<1079396621.1967.196.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004 11:23:42 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> BTW, I missed your explanation in the first place, but why wouldn't
> the "direction" field be enough ? I'm not sure if I need a different
> implementation here...

Direction says something different.  It says which direction the DMA
goes, whilst these interfaces say who wishes to have ownership of the
buffer now.

Consider this example, and how one might implement this on a system with
cpu caches which are not coherent with main memory nor devices.

1) User prepares buffer X with data.
2) pci_map_single(X, TO_DEVICE)
3) Device does DMA, interrupts cpu.
4) pci_dma_sync_single_for_cpu(X)
5) Write new contents.
6) pci_dma_sync_single_for_device(X)
7) Device does DMA again, interrupts cpu.
8) ...

Step 2 would writeback flush the cpu cache, step 4 would be a NOP,
step 6 would writeback flush the cpu cache.

The direction does not provide enough information to do these operations
with the right amount of information.
