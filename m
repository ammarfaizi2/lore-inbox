Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUHJSMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUHJSMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267613AbUHJSJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:09:37 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:16893 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S267519AbUHJSGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:06:08 -0400
Message-ID: <41190E8E.9050004@us.ibm.com>
Date: Tue, 10 Aug 2004 13:06:06 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] ibmveth bug fixes 2/4
Content-Type: multipart/mixed;
 boundary="------------080203080507080906060404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080203080507080906060404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

This patch fixes a race condition that would panic the kernel when 
replenishing a buffer pool.  Please apply.

Signed-off-by: Santiago Leon <santil@us.ibm.com>

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------080203080507080906060404
Content-Type: text/plain;
 name="ibmveth_race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_race.patch"

===== drivers/net/ibmveth.c 1.14 vs edited =====
--- 1.14/drivers/net/ibmveth.c	Tue Aug 10 11:56:29 2004
+++ edited/drivers/net/ibmveth.c	Tue Aug 10 11:57:09 2004
@@ -219,6 +219,7 @@
 
 		dma_addr = vio_map_single(adapter->vdev, skb->data, pool->buff_size, DMA_FROM_DEVICE);
 
+               pool->free_map[free_index] = 0xffff;
 		pool->dma_addr[index] = dma_addr;
 		pool->skbuff[index] = skb;
 
@@ -233,6 +234,7 @@
 		lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address, desc.desc);
 		    
 		if(lpar_rc != H_Success) {
+                       pool->free_map[free_index] = index;
 			pool->skbuff[index] = NULL;
 			pool->consumer_index--;
 			vio_unmap_single(adapter->vdev, pool->dma_addr[index], pool->buff_size, DMA_FROM_DEVICE);
@@ -240,7 +242,6 @@
 			adapter->replenish_add_buff_failure++;
 			break;
 		} else {
-			pool->free_map[free_index] = 0xffff;
 			buffers_added++;
 			adapter->replenish_add_buff_success++;
 		}

--------------080203080507080906060404--
