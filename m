Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUGMKl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUGMKl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUGMKlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:41:22 -0400
Received: from holomorphy.com ([207.189.100.168]:27540 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264826AbUGMKlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:41:04 -0400
Date: Tue, 13 Jul 2004 03:40:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       devenyga@mcmaster.ca, ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
Message-ID: <20040713104059.GW21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
	devenyga@mcmaster.ca, ck@vds.kolivas.org,
	linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca> <cone.1089687290.911943.12958.502@pc.kolivas.org> <20040712210107.1945ac34.akpm@osdl.org> <20040713100815.GU21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713100815.GU21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 09:01:07PM -0700, Andrew Morton wrote:
>> This is a false positive.  Nothing is setting need_resched(), so
>> unmap_vmas() doesn't bother dropping the lock.

On Tue, Jul 13, 2004 at 03:08:15AM -0700, William Lee Irwin III wrote:
> I guess I sent too many updates and the whole thing got dropped. The false
> positives were fixed in this way:

> -			if (!atomic && need_resched()) {
> +			zap_bytes = ZAP_BLOCK_SIZE;
> +			if (!atomic)
> +				continue;
> +			touch_preempt_timing();
> +			if (need_resched()) {

That's not quite right. Amazing it didn't catch might_sleep() warnings.

Index: mm7-2.6.7/mm/memory.c
===================================================================
--- mm7-2.6.7.orig/mm/memory.c	2004-07-13 03:06:12.784491200 -0700
+++ mm7-2.6.7/mm/memory.c	2004-07-13 03:39:45.843459720 -0700
@@ -568,16 +568,16 @@
 			if ((long)zap_bytes > 0)
 				continue;
 			zap_bytes = ZAP_BLOCK_SIZE;
-			if (!atomic)
+			if (atomic)
 				continue;
-			touch_preempt_timing();
 			if (need_resched()) {
 				int fullmm = tlb_is_full_mm(*tlbp);
 				tlb_finish_mmu(*tlbp, tlb_start, start);
 				cond_resched_lock(&mm->page_table_lock);
 				*tlbp = tlb_gather_mmu(mm, fullmm);
 				tlb_start_valid = 0;
-			}
+			} else
+				touch_preempt_timing();
 		}
 	}
 	return ret;
