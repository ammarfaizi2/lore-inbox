Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTIRFFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 01:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTIRFFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 01:05:45 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15746
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262965AbTIRFFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 01:05:43 -0400
Date: Thu, 18 Sep 2003 07:06:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: nr_free_buffer_pages 2.4.23pre4
Message-ID: <20030918050612.GA1368@velociraptor.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

this patch corrects two bugs in nr_free_buffer_pages (they weren't fatal
but it's better to get them right of course ;)

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.23pre4/nr_free_buffer_pages-fixes-1

the first bug is the zonep++ before dereferencing it, the second bug is
the free variable that has to be unsigned to handle empty zones
correctly (thanks to Bjorn Helgaas for noticing the latter sign issue).

diff -urNp --exclude CVS --exclude BitKeeper 2.4.23pre4/mm/page_alloc.c x/mm/page_alloc.c
--- 2.4.23pre4/mm/page_alloc.c	2003-09-13 00:08:04.000000000 +0200
+++ x/mm/page_alloc.c	2003-09-18 06:42:15.000000000 +0200
@@ -512,14 +512,12 @@ unsigned int nr_free_buffer_pages (void)
 		class_idx = zone_idx(zone);
 
 		sum += zone->nr_cache_pages;
-		do {
-			unsigned int free = zone->free_pages - zone->watermarks[class_idx].high;
-			zonep++;
-			zone = *zonep;
+		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++) {
+			int free = zone->free_pages - zone->watermarks[class_idx].high;
 			if (free <= 0)
 				continue;
 			sum += free;
-		} while (zone);
+		}
 	}
 
 	return sum;


(this had more prio than the waterkmark fixes, they will came next)

According to the kernel CVS you didn't merge this yet, so please merge
the below too, it will remove a not necessary branch that also generates
a gcc false positive (all harmless of course but it's more correct to
remove it):

--- 2.4.23pre4/mm/page_alloc.c.~1~	2003-09-13 00:08:04.000000000 +0200
+++ 2.4.23pre4/mm/page_alloc.c	2003-09-14 01:05:24.000000000 +0200
@@ -258,8 +258,6 @@ static struct page * balance_classzone(z
 	struct page * page = NULL;
 	int __freed;
 
-	if (!(gfp_mask & __GFP_WAIT))
-		goto out;
 	if (in_interrupt())
 		BUG();
 
thanks,

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
