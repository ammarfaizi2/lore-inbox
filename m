Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWCWI5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWCWI5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWCWI5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:57:16 -0500
Received: from poup.poupinou.org ([195.101.94.96]:25129 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S932573AbWCWI5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:57:15 -0500
Date: Thu, 23 Mar 2006 09:57:11 +0100
To: iss_storagedev@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] performance issues for cciss driver.
Message-ID: <20060323085711.GA1281@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The cciss driver set a too high default value for the number of read ahead
pages.  When a lot of read operation happens, then we enter into a
trash-like vm situation.

Below is what happens into such a situation:

The system is a HP Proliant 385, with a Debian sarge amd64 distribution.
It collect snmp values and stored into RRD files and therefore
perform a lot of small read and write operations.

# cat /sys/block/cciss\!c0d0/queue/read_ahead_kb
4096
# dstat 1
----total-cpu-usage---- -disk/total -net/total- ---paging-- ---system--
usr sys idl wai hiq siq|_read write|_recv _send|__in_ _out_|_int_ _csw_
  0   0  97   2   0   0|   0     0 |   0     0 |   0     0 |   0     0
  0   2  50  47   0   0|75.1M 4096B|1226B 4056B|   0     0 |1005   451
  0   1  48  50   0   0|32.6M 1766k|  70B  326B|   0     0 | 951   373
  0   2  49  49   0   0|57.8M   20k|  70B  326B|   0     0 | 873   487
  0   2  50  48   0   0|56.7M   24k| 184B  440B|   0     0 | 882   537
  0   2  48  50   0   0|55.1M   64k|  70B  326B|   0     0 | 877   532
  0   2  50  48   0   0|53.6M   20k|  70B  326B|   0     0 | 860   521
  0   0  50  50   0   0|31.1M 1464k|  70B  326B|   0     0 | 892   457
 18   3  31  48   0   0|45.7M   64k|  70B  326B|   0     0 |1075   594

...
# echo 128 > /sys/block/cciss\!c0d0/queue/read_ahead_kb

(wait 5 to 10 minutes)

# dstat 1
----total-cpu-usage---- -disk/total -net/total- ---paging-- ---system--
usr sys idl wai hiq siq|_read write|_recv _send|__in_ _out_|_int_ _csw_
  0   0  97   2   0   0|   0     0 |   0     0 |   0     0 |   0     0
  0   0 100   0   0   0|   0    12k| 140B 1004B|   0     0 | 258    16 
  0   0 100   0   0   0|   0  3072B| 204B  716B|   0     0 | 257    28 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    10 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    14 
  0   0  99   1   0   0|   0  1948k| 140B  652B|   0     0 | 742    86 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    14 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    30 
  2   1  98   0   0   0|   0     0 | 140B  652B|   0     0 | 255    30 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    10 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    25 
 14   0  86   0   0   0|   0     0 | 254B  766B|   0     0 | 436    49 
 12  12  77   0   0   0|   0   165k|32.4k 33.4k|   0     0 | 339  1773 
 10   6  84   1   0   0| 196k    0 | 140B  652B|   0     0 | 262    31 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    14 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 255    13 
  2   1  97   0   0   0|   0    20k| 576B 1898B|   0     0 | 269    40 
  0   0 100   0   0   0|   0   140k| 140B  652B|   0     0 | 264    39 
  0   0 100   0   0   0|   0     0 | 140B  652B|   0     0 | 257    17 
 10   4  86   0   0   0|   0     0 | 204B  716B|   0     0 | 255    25 


I think we should in fact totally kill the whole ra_pages stuff under the
cciss driver IMHO.

Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>

 linux-2.6.16/drivers/block/cciss.c |    3 ---
 1 files changed, 3 deletions(-)

--- linux-2.6.16/drivers/block/cciss.c	2006/03/22 12:06:30	1.1
+++ linux-2.6.16/drivers/block/cciss.c	2006/03/23 08:29:57
@@ -137,7 +137,6 @@ static struct board_type products[] = {
 /*define how many times we will try a command because of bus resets */
 #define MAX_CMD_RETRIES 3
 
-#define READ_AHEAD 	 1024
 #define NR_CMDS		 384 /* #commands that can be outstanding */
 #define MAX_CTLR	32
 
@@ -1238,7 +1237,6 @@ static void cciss_update_drive_info(int 
 		disk->queue = blk_init_queue(do_cciss_request, &h->lock);
 
 		/* Set up queue information */
-		disk->queue->backing_dev_info.ra_pages = READ_AHEAD;
 		blk_queue_bounce_limit(disk->queue, hba[ctlr]->pdev->dma_mask);
 
 		/* This is a hardware imposed limit. */
@@ -3217,7 +3215,6 @@ static int __devinit cciss_init_one(stru
 		}
 		drv->queue = q;
 
-		q->backing_dev_info.ra_pages = READ_AHEAD;
 		blk_queue_bounce_limit(q, hba[i]->pdev->dma_mask);
 
 		/* This is a hardware imposed limit. */

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
