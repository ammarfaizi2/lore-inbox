Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUFTDsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUFTDsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 23:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUFTDsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 23:48:05 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:14514 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265828AbUFTDr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 23:47:59 -0400
Message-ID: <40D508E8.2050407@yahoo.com.au>
Date: Sun, 20 Jun 2004 13:47:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Grzegorz Kulewski <kangur@polcom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Memory and rsync problem with vanilla 2.6.7
References: <20040426013944.49a105a8.akpm@osdl.org> <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net> <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net> <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net> <Pine.LNX.4.58.0406191841050.6160@alpha.polcom.net> <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406191040170.6178@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070509060502030504040902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070509060502030504040902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Sat, 19 Jun 2004, Grzegorz Kulewski wrote:
> 
>>Is this bug or feature? Is there some wreid memmory leak? Where is my RAM?
> 
> 
> Your memory is apparently in dentry and inode memory:
> 
> 	ext3_inode_cache   62553  62553   4096		(244MB)
> 	dentry_cache       48768  48768   4096		(190MB)
> 
> and it really looks like you have enabled CONFIG_DEBUG_PAGEALLOC, which 
> just eats memory like mad (a dentry is normally ~200 bytes, but then when 
> it is rounded up to page-size, it takes 20 times the memory).
> 
> So don't enable DEBUG_PAGEALLOC unless you really want to debug some 
> strange problem.
> 

This could be it. But can you check whether your previous well-behaving
kernel also has CONFIG_DEBUG_PAGEALLOC on? If so, then it is possible
that VM behaviour has regressed.

Of course, DEBUG_PAGEALLOC is the wrong target to attempt to tune for:
without it, those above two items would take up a combined 40 megs.

> That said, there might be a memory balancing problem too, and
> DEBUG_PAGEALLOC just makes it more obvious.  Nick Piggin reports that an
> "obvious fix" by Andrew potentially causes problems, and if you're a BK
> user, you could try just backing out this cset:
> 
> 	ChangeSet@1.1722.88.2, 2004-06-03 07:58:03-07:00, akpm@osdl.org
> 	  [PATCH] shrink_all_memory() fixes
> 
> 	....
> 
> (check with "bk changes" what the revision is in your tree, and do a
> 
> 	bk cset -xX.XXX.XX.X
> 
> to try reverting it. Quite possibly that fix makes the VM much less likely
> to throw out the VM caches, which would make the debug problem much 
> worse).
> 

Well it doesn't seem to have caused too much trouble as yet... But it
is the obvious candidate if your problems continue. If you are not a
bk user, the attached patch will also revert that change.

--------------070509060502030504040902
Content-Type: text/x-patch;
 name="vm-revert-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-revert-fix.patch"

 linux-2.6-npiggin/mm/vmscan.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff -puN mm/vmscan.c~vm-revert-fix mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-revert-fix	2004-06-12 16:53:02.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-06-12 16:54:26.000000000 +1000
@@ -813,9 +813,8 @@ shrink_caches(struct zone **zones, int p
 		struct zone *zone = zones[i];
 		int max_scan;
 
-		zone->temp_priority = priority;
-		if (zone->prev_priority > priority)
-			zone->prev_priority = priority;
+		if (zone->free_pages < zone->pages_high)
+			zone->temp_priority = priority;
 
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
@@ -996,8 +995,6 @@ scan:
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
-			if (zone->prev_priority > priority)
-				zone->prev_priority = priority;
 			max_scan = (zone->nr_active + zone->nr_inactive)
 								>> priority;
 			reclaimed = shrink_zone(zone, max_scan, GFP_KERNEL,

_

--------------070509060502030504040902--
