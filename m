Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291086AbSBSKce>; Tue, 19 Feb 2002 05:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291082AbSBSKcY>; Tue, 19 Feb 2002 05:32:24 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9746 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291086AbSBSKcH>; Tue, 19 Feb 2002 05:32:07 -0500
Message-Id: <200202191029.g1JAT7m11177@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Paco Martinez" <pmartinez@heraldo.es>,
        "kernel list" <linux-kernel@vger.kernel.org>
Subject: Re: OOM killer
Date: Tue, 19 Feb 2002 12:29:09 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <032801c1b92c$d0991f00$ef01a8c0@PCZ014>
In-Reply-To: <032801c1b92c$d0991f00$ef01a8c0@PCZ014>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 February 2002 08:02, Paco Martinez wrote:
> Do you know any newer kernel that solves problem about "OOM Killer" ??
>
> Thank you !!!!

Dont know whether it is in 2.4 mainline, but I use this small patch
--
vda



Author: M.H.VanLeeuwen <vanl@megsinet.net>
--- linux.virgin/mm/vmscan.c	Mon Dec 31 12:46:25 2001
+++ linux/mm/vmscan.c	Fri Jan 11 18:03:05 2002
@@ -394,9 +394,9 @@
 		if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping) {
 			/*
 			 * It is not critical here to write it only if
-			 * the page is unmapped beause any direct writer
+			 * the page is unmapped because any direct writer
 			 * like O_DIRECT would set the PG_dirty bitflag
-			 * on the phisical page after having successfully
+			 * on the physical page after having successfully
 			 * pinned it and after the I/O to the page is finished,
 			 * so the direct writes to the page cannot get lost.
 			 */
@@ -480,11 +480,14 @@

 			/*
 			 * Alert! We've found too many mapped pages on the
-			 * inactive list, so we start swapping out now!
+			 * inactive list.
+			 * Move referenced pages to the active list.
 			 */
-			spin_unlock(&pagemap_lru_lock);
-			swap_out(priority, gfp_mask, classzone);
-			return nr_pages;
+			if (PageReferenced(page) && !PageLocked(page)) {
+				del_page_from_inactive_list(page);
+				add_page_to_active_list(page);
+			}
+			continue;
 		}

 		/*
@@ -521,6 +524,9 @@
 	}
 	spin_unlock(&pagemap_lru_lock);

+	if (max_mapped <= 0 && (nr_pages > 0 || priority < DEF_PRIORITY))
+		swap_out(priority, gfp_mask, classzone);
+
 	return nr_pages;
 }

