Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275235AbTHGInV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275238AbTHGInV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:43:21 -0400
Received: from dyn-ctb-203-221-72-79.webone.com.au ([203.221.72.79]:39174 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275235AbTHGInS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:43:18 -0400
Message-ID: <3F321115.80606@cyberone.com.au>
Date: Thu, 07 Aug 2003 18:43:01 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
References: <20030806223716.26af3255.akpm@osdl.org>	<28050000.1060237907@[10.10.2.4]> <20030807000542.5cbf0a56.akpm@osdl.org> <3F320DFC.6070400@cyberone.com.au> <3F32108A.2010000@cyberone.com.au>
In-Reply-To: <3F32108A.2010000@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------000109060805050101070104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000109060805050101070104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

> Andrew and or Martin, please test attached patch.
> Thanks.
>

Well, one of the WARN conditions I put in there is clearly
redundant...



--------------000109060805050101070104
Content-Type: text/plain;
 name="as-mm5-fix-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-mm5-fix-2"

--- linux-2.6/drivers/block/as-iosched.c.orig	2003-08-07 18:33:06.000000000 +1000
+++ linux-2.6/drivers/block/as-iosched.c	2003-08-07 18:41:50.000000000 +1000
@@ -1198,8 +1198,10 @@ static int as_dispatch_request(struct as
 			 */
 			goto dispatch_writes;
 
- 		if (ad->batch_data_dir == REQ_ASYNC)
+ 		if (ad->batch_data_dir == REQ_ASYNC) {
+			WARN_ON(ad->new_batch);
  			ad->changed_batch = 1;
+		}
 		ad->batch_data_dir = REQ_SYNC;
 		arq = list_entry_fifo(ad->fifo_list[ad->batch_data_dir].next);
 		ad->last_check_fifo[ad->batch_data_dir] = jiffies;
@@ -1214,8 +1216,16 @@ static int as_dispatch_request(struct as
 dispatch_writes:
 		BUG_ON(RB_EMPTY(&ad->sort_list[REQ_ASYNC]));
 
- 		if (ad->batch_data_dir == REQ_SYNC)
+ 		if (ad->batch_data_dir == REQ_SYNC) {
  			ad->changed_batch = 1;
+
+			/*
+			 * new_batch might be 1 when the queue runs out of
+			 * reads. A subsequent submission of a write might
+			 * cause a change of batch before the read is finished.
+			 */
+			ad->new_batch = 0;
+		}
 		ad->batch_data_dir = REQ_ASYNC;
 		ad->current_write_count = ad->write_batch_count;
 		ad->write_batch_idled = 0;

--------------000109060805050101070104--

