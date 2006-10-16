Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWJPOc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWJPOc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWJPOc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:32:56 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:25767 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750742AbWJPOcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:32:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=1DYYW3GRdWfdekv9PqhQviPRZxoekAxUBKz9h11IG8D13bPmmKBRp/Pkp4NL9xkBlkRGgafmH9mDGFh40nwS68eHEtORxvK4Sp/et1/p26onnrXSqYF02k/3O5ZfOEIAt97UH+VuhUiOZvD/T0MjnGfeCiDwcfJJc8eqjmsnInU=  ;
Message-ID: <4533980C.10403@yahoo.com.au>
Date: Tue, 17 Oct 2006 00:32:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "alpha @ steudten Engineering" <alpha@steudten.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: INFO: possible circular locking dependency detected
References: <453391A4.5090100@steudten.org>
In-Reply-To: <453391A4.5090100@steudten.org>
Content-Type: multipart/mixed;
 boundary="------------060409000803000108080106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060409000803000108080106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

alpha @ steudten Engineering wrote:
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.18-1.2189self #1
> -------------------------------------------------------
> kswapd0/186 is trying to acquire lock:
>  (&inode->i_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
> 
> but task is already holding lock:
>  (iprune_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
> 
> which lock already depends on the new lock.

Thanks. __grab_cache_page wants to clear __GFP_FS, because it is
holding the i_mutex so we don't want to reenter the filesystem in
page reclaim.

This would be an easy two liner, except those funny page_cache_alloc
routines which take a mapping rather than a gfp_t argument :P

Anyway, I'll get around to writing the real patch and queue it up
with my other buffered write deadlock fixes. It should be fairly
unlikely to cause you a deadlock. You could give this quick patch a
try, though. Does it fix your problem?

-- 
SUSE Labs, Novell Inc.

--------------060409000803000108080106
Content-Type: text/plain;
 name="mm-write-deadlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-write-deadlock.patch"

Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h	2006-10-17 00:29:40.000000000 +1000
+++ linux-2.6/include/linux/pagemap.h	2006-10-17 00:29:50.000000000 +1000
@@ -57,7 +57,7 @@ extern struct page *page_cache_alloc_col
 #else
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return alloc_pages(mapping_gfp_mask(x), 0);
+	return alloc_pages(mapping_gfp_mask(x)&~__GFP_FS, 0);
 }
 
 static inline struct page *page_cache_alloc_cold(struct address_space *x)
Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c	2006-10-17 00:29:49.000000000 +1000
+++ linux-2.6/mm/filemap.c	2006-10-17 00:29:50.000000000 +1000
@@ -471,9 +471,9 @@ struct page *page_cache_alloc(struct add
 {
 	if (cpuset_do_page_mem_spread()) {
 		int n = cpuset_mem_spread_node();
-		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
+		return alloc_pages_node(n, mapping_gfp_mask(x)&~__GFP_FS, 0);
 	}
-	return alloc_pages(mapping_gfp_mask(x), 0);
+	return alloc_pages(mapping_gfp_mask(x)&~__GFP_FS, 0);
 }
 EXPORT_SYMBOL(page_cache_alloc);
 
@@ -1864,7 +1864,7 @@ repeat:
 				return NULL;
 		}
 		err = add_to_page_cache(*cached_page, mapping,
-							index, GFP_KERNEL);
+						index, GFP_KERNEL&~__GFP_FS);
 		if (err == -EEXIST)
 			goto repeat;
 		if (err == 0) {

--------------060409000803000108080106--
Send instant messages to your online friends http://au.messenger.yahoo.com 
