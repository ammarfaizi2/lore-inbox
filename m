Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbULAFWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbULAFWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbULAFWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:22:34 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:58868 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261181AbULAFWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:22:31 -0500
From: kernel-stuff@comcast.net
To: linux-kernel@vger.kernel.org
Subject: OHCI1394:sleeping function called from invalid context [need idea for fixing]
Date: Wed, 01 Dec 2004 05:22:25 +0000
Message-Id: <120120040522.5745.41AD55110001E46E00001671220074818400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Nov 22 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to debug  a problem with the OHCI1394 module. Basically i get "sleeping function called from invalid context" in dmesg whenever I capture video from my camcorder. Looking at the stack trace - dma_pool_create is called from within IRQ handler - or so it seems. Similarly the ohci1394 module also calls dma_pool_destroy in IRQ. This happens when I connect and disconnect the camcorder.
I am thinking of ways to fix this - and have no clue so far. I fixed couple other similar but easy-to-fix ones in ohci1394.c - by changing from GFP_KERNEL to GFP_ATOMIC but this one looks more complicated - DMA Pool needs to be freed when device disconnects - how to do this outside of the IRQ? More complicated (to me of course :) is the allocaction part - driver needs a DMA pool on device connect - no idea how to get it outside of the IRQ path.

Can anyone give an idea how to go about fixing this? Normally what's the correct place for a module to call dma_pool_create/destroy?

Below is a sample stack trace -

Parry.

=======================================================
Debug: sleeping function called from invalid context at include/asm/semaphore.h:107
in_atomic():0[expected: 0], irqs_disabled():1
 [<0211cbcb>] __might_sleep+0x7d/0x8a
 [<02245065>] dma_pool_destroy+0x1a/0x114
 [<32c1cb6a>] free_dma_rcv_ctx+0x9f/0xc8 [ohci1394]
 [<32c1a649>] ohci_devctl+0x778/0x799 [ohci1394]
 [<32b9f657>] hpsb_unlisten_channel+0x3b/0x3e [ieee1394]
 [<32dae33b>] handle_iso_listen+0x1ab/0x268 [raw1394]
 [<32db1c47>] state_connected+0xf1/0x1c7 [raw1394]
 [<32db1d9b>] raw1394_write+0x7e/0x92 [raw1394]
 [<02165c82>] vfs_write+0xb6/0xe2
 [<02165d4c>] sys_write+0x3c/0x62
Debug: sleeping function called from invalid context at mm/slab.c:2063
in_atomic():0[expected: 0], irqs_disabled():1
 [<0211cbcb>] __might_sleep+0x7d/0x8a
 [<0214bc76>] kmem_cache_alloc+0x1d/0x4c
 [<02244e80>] dma_pool_create+0x70/0x17e
 [<021757cb>] do_lookup+0x1f/0x8f
 [<32c1cd29>] alloc_dma_rcv_ctx+0x196/0x3a3 [ohci1394]
 [<02154106>] handle_mm_fault+0xe4/0x21e
 [<32c1a0ad>] ohci_devctl+0x1dc/0x799 [ohci1394]
 [<0215222e>] follow_page_pte+0xec/0xfd
 [<32b9f615>] hpsb_listen_channel+0x3f/0x46 [ieee1394]
 [<32dae2ac>] handle_iso_listen+0x11c/0x268 [raw1394]
 [<32db1c47>] state_connected+0xf1/0x1c7 [raw1394]
 [<32db1d9b>] raw1394_write+0x7e/0x92 [raw1394]
 [<02165c82>] vfs_write+0xb6/0xe2
 [<02165d4c>] sys_write+0x3c/0x62
