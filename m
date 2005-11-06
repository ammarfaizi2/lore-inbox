Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVKFIXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVKFIXD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVKFIXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:23:02 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:52075 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932322AbVKFIXA (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:23:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=r4KddLK9Cixp3eJ8Fx/S3S+fINZvGjkrbGZtk+0AhYXknuA9ADKtlQ35my4B8/kgNfQPcHRgESaPPGQhRZR1yrsLbwYRTbGAxsaCAQNV4I5XPqddJRu/gj5hqk5zL9QUtApqaaHadn0yxUeQ6bGUyHdv48gPAsG7C6iAEoabl9I=  ;
Message-ID: <436DBDE5.2010405@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:25:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 8/14] mm: remove pcp_low
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au>
In-Reply-To: <436DBDC8.5090308@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090507030109080602060102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507030109080602060102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

8/14

-- 
SUSE Labs, Novell Inc.


--------------090507030109080602060102
Content-Type: text/plain;
 name="mm-remove-pcp-low.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-remove-pcp-low.patch"

pcp->low is useless.

Index: linux-2.6/include/linux/mmzone.h
===================================================================
--- linux-2.6.orig/include/linux/mmzone.h
+++ linux-2.6/include/linux/mmzone.h
@@ -46,7 +46,6 @@ struct zone_padding {
 
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
-	int low;		/* low watermark, refill needed */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
 	struct list_head list;	/* the list of pages */
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -712,7 +712,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
-		if (pcp->count <= pcp->low)
+		if (!pcp->count)
 			pcp->count += rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
 		if (likely(pcp->count)) {
@@ -1324,10 +1324,9 @@ void show_free_areas(void)
 			pageset = zone_pcp(zone, cpu);
 
 			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: low %d, high %d, batch %d used:%d\n",
+				printk("cpu %d %s: high %d, batch %d used:%d\n",
 					cpu,
 					temperature ? "cold" : "hot",
-					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch,
 					pageset->pcp[temperature].count);
@@ -1765,14 +1764,12 @@ inline void setup_pageset(struct per_cpu
 
 	pcp = &p->pcp[0];		/* hot */
 	pcp->count = 0;
-	pcp->low = 0;
-	pcp->high = 6 * batch;
+	pcp->high = 4 * batch;
 	pcp->batch = max(1UL, 1 * batch);
 	INIT_LIST_HEAD(&pcp->list);
 
 	pcp = &p->pcp[1];		/* cold*/
 	pcp->count = 0;
-	pcp->low = 0;
 	pcp->high = 2 * batch;
 	pcp->batch = max(1UL, batch/2);
 	INIT_LIST_HEAD(&pcp->list);
@@ -2169,12 +2166,10 @@ static int zoneinfo_show(struct seq_file
 				seq_printf(m,
 					   "\n    cpu: %i pcp: %i"
 					   "\n              count: %i"
-					   "\n              low:   %i"
 					   "\n              high:  %i"
 					   "\n              batch: %i",
 					   i, j,
 					   pageset->pcp[j].count,
-					   pageset->pcp[j].low,
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
 			}

--------------090507030109080602060102--
Send instant messages to your online friends http://au.messenger.yahoo.com 
