Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVJMTTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVJMTTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVJMTTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:19:49 -0400
Received: from fmr24.intel.com ([143.183.121.16]:13701 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750825AbVJMTTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:19:48 -0400
Message-Id: <200510131919.j9DJJkg07781@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Jens Axboe'" <axboe@suse.de>
Subject: [patch] optimize disk_round_stats
Date: Thu, 13 Oct 2005 12:19:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXQKwT9OvqwVfFNQvyRPpY8jWoG5Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following the same idea, it occurs to me that we should only update
disk stat when "now" is different from disk->stamp.  Otherwise, we
are again needlessly adding zero to the stats.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./drivers/block/ll_rw_blk.c.orig	2005-10-13 11:54:07.474907379 -0700
+++ ./drivers/block/ll_rw_blk.c	2005-10-13 11:54:39.074516367 -0700
@@ -2433,6 +2433,9 @@ void disk_round_stats(struct gendisk *di
 {
 	unsigned long now = jiffies;
 
+	if (now == disk->stamp)
+		return;
+
 	if (disk->in_flight) {
 		__disk_stat_add(disk, time_in_queue,
 				disk->in_flight * (now - disk->stamp));



