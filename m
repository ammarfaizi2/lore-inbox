Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267576AbUHJSVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbUHJSVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUHJSH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:07:56 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:52910 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267556AbUHJSGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:06:19 -0400
Message-ID: <41190E97.2050705@us.ibm.com>
Date: Tue, 10 Aug 2004 13:06:15 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] ibmveth bug fixes 4/4
Content-Type: multipart/mixed;
 boundary="------------010603080400060706000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603080400060706000204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

This patch adds a memory barrier to ensure synchronization with the 
hypervisor (and avoid a panic when the hypervisor is halfway through 
writing to the descriptor). It also removes an unnecessary check that is 
flawed anyway because the value can change between the atomic_inc() and 
the assert. Please apply.

Signed-off-by: Santiago Leon <santil@us.ibm.com>

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------010603080400060706000204
Content-Type: text/plain;
 name="ibmveth_rmb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_rmb.patch"

===== drivers/net/ibmveth.c 1.16 vs edited =====
--- 1.16/drivers/net/ibmveth.c	Tue Aug 10 12:00:57 2004
+++ edited/drivers/net/ibmveth.c	Tue Aug 10 12:01:46 2004
@@ -271,7 +271,6 @@
 	adapter->rx_no_buffer = *(u64*)(((char*)adapter->buffer_list_addr) + 4096 - 8);
 
 	atomic_inc(&adapter->not_replenishing);
-	ibmveth_assert(atomic_read(&adapter->not_replenishing) == 1);
 }
 
 /* kick the replenish tasklet if we need replenishing and it isn't already running */
@@ -733,6 +732,8 @@
 
 		if(ibmveth_rxq_pending_buffer(adapter)) {
 			struct sk_buff *skb;
+
+			rmb();
 
 			if(!ibmveth_rxq_buffer_valid(adapter)) {
 				wmb(); /* suggested by larson1 */

--------------010603080400060706000204--
