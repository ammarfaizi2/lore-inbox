Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUCIFkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUCIFkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:40:03 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:6086 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261238AbUCIFjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:39:07 -0500
Message-ID: <404D5874.2060108@cyberone.com.au>
Date: Tue, 09 Mar 2004 16:39:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 4/4] vm-mapped-x-active-lists
References: <404D56D8.2000008@cyberone.com.au> <404D5784.9080004@cyberone.com.au>
In-Reply-To: <404D5784.9080004@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>@@ -714,14 +737,27 @@ shrink_zone(struct zone *zone, int max_s
> 	 * just to make sure that the kernel will slowly sift through the
> 	 * active list.
> 	 */
>-	ratio = (unsigned long)SWAP_CLUSTER_MAX * zone->nr_active /
>-				((zone->nr_inactive | 1) * 2);
>+	nr_active = zone->nr_active_mapped + zone->nr_active_unmapped;
>+	ratio = (unsigned long)SWAP_CLUSTER_MAX * nr_active /
>+				(zone->nr_inactive * 2 + 1);
>+	mapped_ratio = (unsigned long long)ratio * nr_active;
>+	do_div(mapped_ratio, zone->nr_active_mapped+1);
>

Just for information, this is where you would balance mapped vs unmapped
pages:    do_div(mapped_ratio, 16); /* mapped pages are worth 16 times 
more */

>+
>+	ratio = ratio - mapped_ratio;
>+	atomic_add(ratio+1, &zone->nr_scan_active_unmapped);
>+	count = atomic_read(&zone->nr_scan_active_unmapped);
>+	if (count >= SWAP_CLUSTER_MAX) {
>+		atomic_set(&zone->nr_scan_active_unmapped, 0);
>+		shrink_active_list(zone, &zone->active_unmapped_list,
>+					&zone->nr_active_unmapped, count, ps);
>+	}
> 
>-	atomic_add(ratio+1, &zone->nr_scan_active);
>-	count = atomic_read(&zone->nr_scan_active);
>+	atomic_add(mapped_ratio+1, &zone->nr_scan_active_mapped);
>+	count = atomic_read(&zone->nr_scan_active_mapped);
> 	if (count >= SWAP_CLUSTER_MAX) {
>-		atomic_set(&zone->nr_scan_active, 0);
>-		shrink_active_list(zone, &zone->active_list, count, ps);
>+		atomic_set(&zone->nr_scan_active_mapped, 0);
>+		shrink_active_list(zone, &zone->active_mapped_list,
>+					&zone->nr_active_mapped, count, ps);
> 	}
> 
> 	atomic_add(max_scan, &zone->nr_scan_inactive);
>
>  
>

