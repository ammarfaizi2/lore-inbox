Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVJZQrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVJZQrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbVJZQrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:47:32 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45764 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964816AbVJZQrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:47:25 -0400
Date: Wed, 26 Oct 2005 10:47:23 -0600
From: Santiago Leon <santil@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Santiago Leon <santil@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>
Message-Id: <20051026164609.21820.15714.sendpatchset@localhost.localdomain>
In-Reply-To: <20051026164532.21820.72673.sendpatchset@localhost.localdomain>
References: <20051026164532.21820.72673.sendpatchset@localhost.localdomain>
Subject: [PATCH 5/5] ibmveth fix failed addbuf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug that happens when the hypervisor can't add a
buffer.  The old code wrote IBM_VETH_INVALID_MAP into the free_map
array, so next time the index was used, a ibmveth_assert() caught it and
called BUG().  The patch writes the right value into the free_map array
so that the index can be reused.

Signed-off-by: Santiago Leon <santil@us.ibm.com>
---

 drivers/net/ibmveth.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ibmveth.c	2005-10-17 12:35:13.000000000 -0500
+++ b/drivers/net/ibmveth.c	2005-10-17 12:36:13.000000000 -0500
@@ -237,7 +237,7 @@
 		lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address, desc.desc);
 		    
 		if(lpar_rc != H_Success) {
-			pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
+			pool->free_map[free_index] = index;
 			pool->skbuff[index] = NULL;
 			pool->consumer_index--;
 			dma_unmap_single(&adapter->vdev->dev,
