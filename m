Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUHJSuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUHJSuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUHJSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:48:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:33981 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267361AbUHJSnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:43:41 -0400
Subject: Re: [PATCH 2.6] ibmveth bug fixes 2/4
From: Dave Hansen <haveblue@us.ibm.com>
To: "Santiago A. Leon [imap]" <santil@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <41190E8E.9050004@us.ibm.com>
References: <41190E8E.9050004@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-80jhYVFp42Um6qhk3rig"
Message-Id: <1092162537.11212.27.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 11:28:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-80jhYVFp42Um6qhk3rig
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-08-10 at 11:06, Santiago Leon wrote:
> This patch fixes a race condition that would panic the kernel when 
> replenishing a buffer pool.  Please apply.

How about something like this that doesn't add more magic numbers?

I'm not so sure about the type, though.  Is that (u16) cast OK?

-- Dave

--=-80jhYVFp42Um6qhk3rig
Content-Disposition: attachment; filename=ibmveth-invalid_map.patch
Content-Type: text/x-patch; name=ibmveth-invalid_map.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- veth/drivers/net/ibmveth.h.orig	2004-08-10 11:34:05.000000000 -0700
+++ veth/drivers/net/ibmveth.h	2004-08-10 11:35:01.000000000 -0700
@@ -77,6 +77,8 @@
 #define IbmVethPool1DftCnt  256
 #define IbmVethPool2DftCnt  256
 
+#define IBM_VETH_INVALID_MAP ((u16)0xffff)
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
--- veth/drivers/net/ibmveth.c.orig	2004-08-10 11:35:17.000000000 -0700
+++ veth/drivers/net/ibmveth.c	2004-08-10 11:37:22.000000000 -0700
@@ -213,11 +213,12 @@ static void ibmveth_replenish_buffer_poo
 		free_index = pool->consumer_index++ % pool->size;
 		index = pool->free_map[free_index];
 	
-		ibmveth_assert(index != 0xffff);
+		ibmveth_assert(index != IBM_VETH_INVALID_MAP);
 		ibmveth_assert(pool->skbuff[index] == NULL);
 
 		dma_addr = vio_map_single(adapter->vdev, skb->data, pool->buff_size, DMA_FROM_DEVICE);
 
+		pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
 		pool->dma_addr[index] = dma_addr;
 		pool->skbuff[index] = skb;
 
@@ -232,6 +233,7 @@ static void ibmveth_replenish_buffer_poo
 		lpar_rc = h_add_logical_lan_buffer(adapter->vdev->unit_address, desc.desc);
 		    
 		if(lpar_rc != H_Success) {
+			pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
 			pool->skbuff[index] = NULL;
 			pool->consumer_index--;
 			vio_unmap_single(adapter->vdev, pool->dma_addr[index], pool->buff_size, DMA_FROM_DEVICE);
@@ -239,7 +241,6 @@ static void ibmveth_replenish_buffer_poo
 			adapter->replenish_add_buff_failure++;
 			break;
 		} else {
-			pool->free_map[free_index] = 0xffff;
 			buffers_added++;
 			adapter->replenish_add_buff_success++;
 		}

--=-80jhYVFp42Um6qhk3rig--

