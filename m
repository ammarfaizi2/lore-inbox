Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936596AbWLFRC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936596AbWLFRC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936561AbWLFRBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:01:52 -0500
Received: from 40.150.104.212.access.eclipse.net.uk ([212.104.150.40]:53770
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S936919AbWLFRBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:01:20 -0500
Date: Wed, 6 Dec 2006 17:01:05 +0000
To: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Mel Gorman <mel@csn.ul.ie>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] lumpy take the other active inactive pages in the area
Message-ID: <4fe113c0c99477e6ccb24e1d848e7ae5@pinky>
References: <exportbomb.1165424343@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1165424343@pinky>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lumpy: take the other active/inactive pages in the area

When we scan an order N aligned area around our tag page take any
other pages with a matching active state to that of the tag page.
This will tend to demote areas of the order we are interested from
the active list to the inactive list and from the end of the inactive
list, increasing the chances of such areas coming free together.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 85f626b..fc23d87 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -710,7 +710,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 			case 0:
 				list_move(&tmp->lru, dst);
 				nr_taken++;
-				continue;
+				break;
 
 			case -EBUSY:
 				/* else it is being freed elsewhere */
@@ -718,7 +718,6 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 			default:
 				break;
 			}
-			break;
 		}
 	}
 
