Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUGWRvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUGWRvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 13:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267861AbUGWRvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 13:51:46 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:38625 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S267860AbUGWRvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 13:51:35 -0400
To: linux-kernel@vger.kernel.org
cc: Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk, Steven.Hand@cl.cam.ac.uk
Subject: [RFC] Blkdev request merging over discontiguous DMA memory
Date: Fri, 23 Jul 2004 18:51:33 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1Bo4Cj-00013Z-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

As a developer of the Xen virtual machine monitor, I'm finding that
our approach to physical memory management is causing us headaches in
integrating with Linux's physical block-device drivers. The problem is
the request-merging code in the IDE and SCSI layers, which assume that
adjacent requests in 'physical' memory can be merged, even when the
merged buffer straddles a page boundary.  This is a problem when
running over Xen, as the underlying machine pages allocated to the OS
are not necessarily contiguous.

We can see a few possible approaches to resolving this problem; our
current stop-gap fix is to check for invalidly-merged scatter-gather
lists within pci_map_sg/dma_map_sg(), and to return 0 (a fairly
widely-recognised error return for this function) to the caller if a
bad multi-page element is found.

We're not sure whether this is the best possible solution to the
problem, and we've thought up some other possibilites which we list
below (appended to this email). Does anyone have any comments on
these, or can anyone point out a better existing solution to this
problem in 2.4 or 2.6? Help would be greatly appreciated! :-)

Please CC any responses to my personal email address as I am not
subscribed to linux-kernel.

Thanks in advance for any comments/help/insight that anyone can
provide!

 -- Keir Fraser

 1. Add an arch-specific compile macro (e.g.,
 BLKDEV_NO_MULTIPAGE_MERGE) that would prevent request merging across
 page boundaries in the various blkdev drivers.

 2. Allow pci_map_sg() to /increase/ the number of sg elements in
 cases where arch-specific code determines that multi-page elements
 need to be split.

 3. Ensure that all callers to pci_map_sg() can handle an error return
 (return 0) in a safe manner. This si what we currently rely on, and I
 believe it is a safe fix for IDE devices, which should fall back to PIO
 mode for that sg list. However, I think the merging problem may also
 exist for SCSI devices, and most of those do not seem to correctly
 pick up and handle a 0 return value as meaning 'could not map the sg
 list to DMA addresses'. Am I mistaken in my reading of the code?
 
 4. Define that individual elements of the generic scatter-gather list
 structure must each reside entirely within a single memory page (i.e.,
 elements should not span page boundaries). This would avoid
 overzealous merging in the blkdev drivers (since it would be
 disallowed). My guess is that performance would hardly be affected in
 most cases as the chances of allocating adjacent memory pages for
 blkdev transfers are pretty small. In any case, pci_map_sg/dma_map_sg
 could then be allowed to merge across page boundaries in an
 arch-specific and -safe manner.

