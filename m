Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267846AbUHKAk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267846AbUHKAk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267855AbUHKAk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:40:28 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:48116 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267846AbUHKAkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:40:17 -0400
Message-ID: <41196AEA.1060700@us.ibm.com>
Date: Tue, 10 Aug 2004 19:40:10 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] ibmveth bug fixes 4/4
References: <41190E97.2050705@us.ibm.com>
In-Reply-To: <41190E97.2050705@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050801020709060209070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050801020709060209070107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew...

I had discussion over email with Dave Hansen about this patch and after 
I explained the bug and the fix, he recommended that I include a comment 
in the patch.  So here's an updated patch. Please apply.

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------050801020709060209070107
Content-Type: text/plain;
 name="ibmveth_rmb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_rmb.patch"

===== drivers/net/ibmveth.c 1.14 vs edited =====
--- 1.14/drivers/net/ibmveth.c	Tue Aug 10 19:09:45 2004
+++ edited/drivers/net/ibmveth.c	Tue Aug 10 19:30:10 2004
@@ -271,7 +271,6 @@
 	adapter->rx_no_buffer = *(u64*)(((char*)adapter->buffer_list_addr) + 4096 - 8);
 
 	atomic_inc(&adapter->not_replenishing);
-	ibmveth_assert(atomic_read(&adapter->not_replenishing) == 1);
 }
 
 /* kick the replenish tasklet if we need replenishing and it isn't already running */
@@ -733,6 +732,14 @@
 
 		if(ibmveth_rxq_pending_buffer(adapter)) {
 			struct sk_buff *skb;
+
+			/* This barrier is necessary because we might be 
+			   reading a control dword and then reading an old 
+			   cached correlator dword. Also, the hypervisor
+			   guarantees that the control field will be globally
+			   visible after all the other fields are visible, 
+			*/
+			rmb();
 
 			if(!ibmveth_rxq_buffer_valid(adapter)) {
 				wmb(); /* suggested by larson1 */

--------------050801020709060209070107--
