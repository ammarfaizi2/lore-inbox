Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUI2AgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUI2AgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUI2AgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:36:23 -0400
Received: from mail-07.iinet.net.au ([203.59.3.39]:41670 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S268107AbUI2AgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:36:18 -0400
Message-ID: <415A0378.9030007@cyberone.com.au>
Date: Wed, 29 Sep 2004 10:36:08 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ray Bryant <raybry@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet> <413F5EE7.6050705@sgi.com> <20040908193036.GH4284@logos.cnet> <413FC8AC.7030707@sgi.com> <20040909030916.GR3106@holomorphy.com> <4158C45B.8090409@sgi.com> <4158DC27.9010603@yahoo.com.au>
In-Reply-To: <4158DC27.9010603@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------000109030708060001060607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000109030708060001060607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
> Thanks Ray. From looking over your old results, it appears that 
> -kswapdfix
> probably has the nicest swappiness ramp, which is probably to be 
> expected,
> as the problem that is being fixed did exist in all other kernels you 
> tested,
> but the later ones just had other aggrivating changes.
>
> The swappiness=60 weirdness might just be some obscure interaction 
> with the
> workload. If that is the case, it is probably not too important, 
> however it
> could be due to a possible oversight in my patch....
>

Here is a patch on top of the last one - if you can give it a test
some time, that would be great.

Thanks
Nick


--------------000109030708060001060607
Content-Type: text/x-patch;
 name="vm-no-wild-kswapd2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-no-wild-kswapd2.patch"




---

 linux-2.6-npiggin/mm/vmscan.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -puN mm/vmscan.c~vm-no-wild-kswapd2 mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-no-wild-kswapd2	2004-09-29 10:30:49.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-09-29 10:34:00.000000000 +1000
@@ -991,6 +991,7 @@ out:
 static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
 {
 	int to_free = nr_pages;
+	int all_zones_ok;
 	int priority;
 	int i;
 	int total_scanned, total_reclaimed;
@@ -1013,10 +1014,11 @@ loop_again:
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		int all_zones_ok = 1;
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
 
+		all_zones_ok = 1;
+
 		if (nr_pages == 0) {
 			/*
 			 * Scan in the highmem->dma direction for the highest
@@ -1106,7 +1108,7 @@ scan:
 		 * on zone->*_priority.
 		 */
 		if (total_reclaimed >= SWAP_CLUSTER_MAX)
-			goto loop_again;
+			break;
 	}
 out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
@@ -1114,6 +1116,9 @@ out:
 
 		zone->prev_priority = zone->temp_priority;
 	}
+	if (!all_zones_ok)
+		goto loop_again;
+
 	return total_reclaimed;
 }
 

_

--------------000109030708060001060607--
