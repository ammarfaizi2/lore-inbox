Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUHKBbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUHKBbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 21:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267865AbUHKBbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 21:31:06 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:47236 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267725AbUHKBbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 21:31:00 -0400
Message-ID: <411976CE.3030401@us.ibm.com>
Date: Tue, 10 Aug 2004 20:30:54 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santiago Leon <santil@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] ibmveth bug fixes 4/4
References: <41190E97.2050705@us.ibm.com> <41196AEA.1060700@us.ibm.com>
In-Reply-To: <41196AEA.1060700@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030200060006060401040309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030200060006060401040309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> I had discussion over email with Dave Hansen about this patch and after 
> I explained the bug and the fix, he recommended that I include a comment 
> in the patch.  So here's an updated patch. Please apply.

Ooops.. forgot the signed stuff... Here it goes again...

Signed-off-by: Santiago Leon <santil@us.ibm.com>

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------030200060006060401040309
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

--------------030200060006060401040309--
