Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267242AbUGNFUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267242AbUGNFUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 01:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUGNFUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 01:20:24 -0400
Received: from holomorphy.com ([207.189.100.168]:17050 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267269AbUGNFUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 01:20:18 -0400
Date: Tue, 13 Jul 2004 22:20:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040714052010.GE3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Osterlund <petero2@telia.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org> <40ED049B.2020406@yahoo.com.au> <Pine.LNX.4.58.0407081126360.3104@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407081126360.3104@telia.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 11:30:45AM +0200, Peter Osterlund wrote:
> swappiness is set to 60.
> However, I realized that I had set /proc/sys/vm/laptop_mode to 1. If I set
> it to 0, 2.6.7-bk10 starts to work.

Probably not what will get merged, but does the following brutal hack
do anything for you?


Index: laptop-2.6.8-rc1/mm/vmscan.c
===================================================================
--- laptop-2.6.8-rc1.orig/mm/vmscan.c	2004-07-11 10:33:55.000000000 -0700
+++ laptop-2.6.8-rc1/mm/vmscan.c	2004-07-13 22:18:04.193959968 -0700
@@ -902,7 +902,7 @@
 	sc.may_writepage = 0;
 
 	inc_page_state(allocstall);
-
+retry:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->temp_priority = DEF_PRIORITY;
 
@@ -940,8 +940,14 @@
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
-	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory();
+	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+		if (!laptop_mode || sc.may_writepage)
+			out_of_memory();
+		else {
+			sc.may_writepage = 1;
+			goto retry;
+		}
+	}
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;
