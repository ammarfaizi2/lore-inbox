Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUI1Bu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUI1Bu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 21:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUI1Bu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 21:50:59 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63381 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267447AbUI1Bux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 21:50:53 -0400
Message-ID: <4158C45B.8090409@sgi.com>
Date: Mon, 27 Sep 2004 20:54:35 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: piggin@cyberone.com.au
CC: William Lee Irwin III <wli@holomorphy.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet> <413F5EE7.6050705@sgi.com> <20040908193036.GH4284@logos.cnet> <413FC8AC.7030707@sgi.com> <20040909030916.GR3106@holomorphy.com>
In-Reply-To: <20040909030916.GR3106@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------020107030000040702070403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107030000040702070403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick,

As reported to you elsewhere (and duplicated here to get on this thread),
application of the patch you sent (attached) dramatically changes the
swappiness behavior of the 2.6.9-rc1 (and presumably the rc2) kernel.

Here are the updated results:

Previously:

Kernel Version 2.6.9-rc1-mm3:
         Total I/O   Avg Swap   min    max     pg cache    min    max
        ----------- --------- ------- ------  --------- ------- -------
    0   274.80 MB/s  10511 MB (  5644, 14492)  13293 MB (  8596, 17156)
   20   267.02 MB/s  12624 MB (  5578, 16287)  15298 MB (  8468, 18889)
   40   267.66 MB/s  13541 MB (  6619, 17461)  16199 MB (  9393, 20044)
   60   233.73 MB/s  18094 MB ( 16550, 19676)  20629 MB ( 19103, 22192)
   80   213.64 MB/s  20950 MB ( 15844, 22977)  23450 MB ( 18496, 25440)
  100   164.58 MB/s  26004 MB ( 26004, 26004)  28410 MB ( 28327, 28455)

With Nick Piggin et al fix:

Kernel Version: linux-2.6.9-rc1-mm3-kswapdfix

         Total I/O   Avg Swap   min    max     pg cache    min    max
        ----------- --------- ------- ------  --------- ------- -------
    0   279.97 MB/s     89 MB (    12,   265)   3062 MB (  2947,  3267)
   20   283.55 MB/s    161 MB (    15,   372)   3190 MB (  3011,  3427)
   40   282.32 MB/s    204 MB (     6,   407)   3187 MB (  2995,  3331)
   60   279.42 MB/s     72 MB (    15,   171)   3091 MB (  3027,  3155)
   80   283.34 MB/s    920 MB (   144,  3028)   3904 MB (  3106,  5957)
  100   160.55 MB/s  26008 MB ( 26007, 26008)  28473 MB ( 28455, 28487)

(The drop at swappiness of 60 may just be randomness, not sure it
is significant, but these results are all based on 5 trials.)

At any rate, this patch appears to fix the problems I was seeing before.
(See
	http://marc.theaimsgroup.com/?l=linux-kernel&m=109449778320333&w=2

for further details of the benchmark and the test environment).
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

--------------020107030000040702070403
Content-Type: text/plain;
 name="vm-no-wild-kswapd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-no-wild-kswapd.patch"




---

 linux-2.6-npiggin/mm/vmscan.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -puN mm/vmscan.c~vm-no-wild-kswapd mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-no-wild-kswapd	2004-09-25 10:09:16.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-09-25 10:15:58.000000000 +1000
@@ -993,10 +993,13 @@ static int balance_pgdat(pg_data_t *pgda
 	int to_free = nr_pages;
 	int priority;
 	int i;
-	int total_scanned = 0, total_reclaimed = 0;
+	int total_scanned, total_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 
+loop_again:
+	total_scanned = 0;
+	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
@@ -1095,6 +1098,15 @@ scan:
 		 */
 		if (total_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
+
+		/*
+		 * We do this so kswapd doesn't build up large priorities for
+		 * example when it is freeing in parallel with allocators. It
+		 * matches the direct reclaim path behaviour in terms of impact
+		 * on zone->*_priority.
+		 */
+		if (total_reclaimed >= 32)
+			goto loop_again;
 	}
 out:
 	for (i = 0; i < pgdat->nr_zones; i++) {

_

--------------020107030000040702070403--

