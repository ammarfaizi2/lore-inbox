Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWD3N4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWD3N4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 09:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWD3N4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 09:56:07 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:37053 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751118AbWD3N4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 09:56:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=4hPgSCnZMh2LGdi98CzT797SKoAFCl6wUyQnsYP3BJiWMAPNHnVqjhJn4DC/NJDeFRE8W4124rnR26Rh5htxRGDLqaYJLkwFMSkbFOCUruu75wRRamtsnje8w8B/qhdTcPwP0FNdvSlYQ3xgADICnVwZs1XjteymaDmbl8m0UTo=  ;
Message-ID: <4454A8CD.80907@yahoo.com.au>
Date: Sun, 30 Apr 2006 22:08:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: read_pages bug?
Content-Type: multipart/mixed;
 boundary="------------070501020905090501010308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070501020905090501010308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Speaking of read_pages(), doesn't the AOP_TRUNCATED_PAGE case
cause a dangling page which can't get cleaned up because it
is not on the lru (and the file has presumably already been
truncated)?

(also, let's not worry about pretending we propogate errors)

-- 
SUSE Labs, Novell Inc.

--------------070501020905090501010308
Content-Type: text/plain;
 name="mm-fix-ra-error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-fix-ra-error.patch"

Index: linux-2.6/mm/readahead.c
===================================================================
--- linux-2.6.orig/mm/readahead.c	2006-04-30 21:59:09.000000000 +1000
+++ linux-2.6/mm/readahead.c	2006-04-30 22:02:26.000000000 +1000
@@ -164,16 +164,15 @@ int read_cache_pages(struct address_spac
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static int read_pages(struct address_space *mapping, struct file *filp,
+static void read_pages(struct address_space *mapping, struct file *filp,
 		struct list_head *pages, unsigned nr_pages)
 {
 	unsigned page_idx;
 	struct pagevec lru_pvec;
-	int ret;
 
 	if (mapping->a_ops->readpages) {
-		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
-		goto out;
+		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
+		return;
 	}
 
 	pagevec_init(&lru_pvec, 0);
@@ -182,19 +181,13 @@ static int read_pages(struct address_spa
 		list_del(&page->lru);
 		if (!add_to_page_cache(page, mapping,
 					page->index, GFP_KERNEL)) {
-			ret = mapping->a_ops->readpage(filp, page);
-			if (ret != AOP_TRUNCATED_PAGE) {
-				if (!pagevec_add(&lru_pvec, page))
-					__pagevec_lru_add(&lru_pvec);
-				continue;
-			} /* else fall through to release */
-		}
-		page_cache_release(page);
+			mapping->a_ops->readpage(filp, page);
+			if (!pagevec_add(&lru_pvec, page))
+				__pagevec_lru_add(&lru_pvec);
+		} else
+			page_cache_release(page);
 	}
 	pagevec_lru_add(&lru_pvec);
-	ret = 0;
-out:
-	return ret;
 }
 
 /*

--------------070501020905090501010308--
Send instant messages to your online friends http://au.messenger.yahoo.com 
