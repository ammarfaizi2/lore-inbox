Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUJQDFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUJQDFj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269017AbUJQDFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:05:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23496 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269015AbUJQDF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:05:28 -0400
Message-ID: <4171E16A.4020506@pobox.com>
Date: Sat, 16 Oct 2004 23:05:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org> <4171C20D.1000105@pobox.com> <4171C9CD.4000303@yahoo.com.au> <4171D5F8.8050504@pobox.com> <4171D6A0.4030200@yahoo.com.au>
In-Reply-To: <4171D6A0.4030200@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090208020502050004030605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208020502050004030605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does indeed seem to solve the problem.

Now (really) on to Andrew's patches...

	Jeff




--------------090208020502050004030605
Content-Type: text/x-patch;
 name="vm-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-fix.patch"

diff -Naurp -X /g/g/lib/dontdiff linux-2.6.9-rc3-bk4/localversion linux-2.6.9-rc3-bk4-np1/localversion
--- linux-2.6.9-rc3-bk4/localversion	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-rc3-bk4-np1/localversion	2004-10-17 01:58:33.000000000 +0000
@@ -0,0 +1 @@
+-np1
diff -Naurp -X /g/g/lib/dontdiff linux-2.6.9-rc3-bk4/mm/vmscan.c linux-2.6.9-rc3-bk4-np1/mm/vmscan.c
--- linux-2.6.9-rc3-bk4/mm/vmscan.c	2004-10-16 17:59:21.000000000 +0000
+++ linux-2.6.9-rc3-bk4-np1/mm/vmscan.c	2004-10-17 02:44:37.000000000 +0000
@@ -181,7 +181,7 @@ static int shrink_slab(unsigned long sca
 	struct shrinker *shrinker;
 
 	if (scanned == 0)
-		return 0;
+		scanned = 1;
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
@@ -1056,7 +1056,8 @@ scan:
 			total_reclaimed += sc.nr_reclaimed;
 			if (zone->all_unreclaimable)
 				continue;
-			if (zone->pages_scanned > zone->present_pages * 2)
+			if (zone->pages_scanned >= (zone->nr_active +
+							zone->nr_inactive) * 4)
 				zone->all_unreclaimable = 1;
 			/*
 			 * If we've done a decent amount of scanning and
@@ -1093,8 +1094,10 @@ out:
 
 		zone->prev_priority = zone->temp_priority;
 	}
-	if (!all_zones_ok)
+	if (!all_zones_ok) {
+		cond_resched();
 		goto loop_again;
+	}
 
 	return total_reclaimed;
 }

--------------090208020502050004030605--
