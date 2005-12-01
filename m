Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVLAVlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVLAVlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLAVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:41:45 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:18076 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932491AbVLAVln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:41:43 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Date: Thu, 1 Dec 2005 22:42:44 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20051201173649.GA22168@hexapodia.org>
In-Reply-To: <20051201173649.GA22168@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512012242.44995.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 1 of December 2005 18:36, Andy Isaacson wrote:
> My Thinkpad X40 (1.25 GB, ipw2200) has had fairly reliable swsusp since
> 2.6.13 or thereabouts, and as recently as 2.6.15-rc1-mm1 I had about 20
> successful suspend/resume cycles.  But now that I'm running
> 2.6.15-rc3-mm1 I'm seeing intermittent failures like this:

Thanks a lot for the report.

The problem is apparently caused by my recent patch intended to speed up
suspend.  Could you please apply the appended debug patch, try to reproduce
the problem and send full dmesg output back to me?

Rafael


Index: linux-2.6.15-rc3-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/swsusp.c	2005-12-01 22:13:17.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/swsusp.c	2005-12-01 22:24:56.000000000 +0100
@@ -635,12 +635,18 @@
 	printk("Shrinking memory...  ");
 	do {
 #ifdef FAST_FREE
-		tmp = count_data_pages() + count_highmem_pages();
+		tmp = count_data_pages();
+		printk("Data pages: %ld\n", tmp);
+		tmp += count_highmem_pages();
+		printk("Data and highmem pages: %ld\n", tmp);
 		tmp += (tmp + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;
+		printk("Total pages: %ld\n", tmp);
 		for_each_zone (zone)
-			if (!is_highmem(zone))
+			if (!is_highmem(zone)) {
 				tmp -= zone->free_pages;
+				printk("Pages to free: %ld\n", tmp);
+			}
 		if (tmp > 0) {
 			tmp = shrink_all_memory(SHRINK_BITE);
 			if (!tmp)
Index: linux-2.6.15-rc3-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-01 22:13:58.000000000 +0100
+++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-01 22:39:01.000000000 +0100
@@ -437,8 +437,14 @@
 
 static int enough_free_mem(unsigned int nr_pages)
 {
-	pr_debug("swsusp: available memory: %u pages\n", nr_free_pages());
-	return nr_free_pages() > (nr_pages + PAGES_FOR_IO +
+	struct zone *zone;
+	unsigned int n = 0;
+
+	for_each_zone (zone)
+		if (!is_highmem(zone))
+			n += zone->free_pages;
+	printk("swsusp: available memory: %u pages\n", n);
+	return n > (nr_pages + PAGES_FOR_IO +
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
