Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUH1Eg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUH1Eg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 00:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbUH1Efy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 00:35:54 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:3005 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268168AbUH1Ef1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 00:35:27 -0400
Message-ID: <41300B82.8080203@yahoo.com.au>
Date: Sat, 28 Aug 2004 14:35:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>
CC: Hugh Dickins <hugh@veritas.com>, Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain> <1093640668.11648.50.camel@dyn319181.beaverton.ibm.com>
In-Reply-To: <1093640668.11648.50.camel@dyn319181.beaverton.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090609000206020400040704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090609000206020400040704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ram Pai wrote:
> 
> got it!  Everything got changed to the new convention except that
> the calculation of 'nr' just before the check "nr <= offset" .
> 
> I have generated this patch which takes care of that and hence fixes the
> data loss problem as well. I guess it is cleaner too. 
> 
> This patch is generated w.r.t 2.6.8.1. If everybody blesses this patch I
> will forward it to Andrew.

It looks like it should be OK... but at what point does it become
simpler to use my patch which just moves the original calculation
up, and does it again if we have to ->readpage()?

(assuming you agree that it solves the problem)


--------------090609000206020400040704
Content-Type: text/x-patch;
 name="mm-gmr-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-gmr-fix.patch"




---

 linux-2.6-npiggin/mm/filemap.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff -puN mm/filemap.c~mm-gmr-fix mm/filemap.c
--- linux-2.6/mm/filemap.c~mm-gmr-fix	2004-08-28 14:14:02.000000000 +1000
+++ linux-2.6-npiggin/mm/filemap.c	2004-08-28 14:32:59.000000000 +1000
@@ -724,6 +724,15 @@ void do_generic_mapping_read(struct addr
 		struct page *page;
 		unsigned long nr, ret;
 
+		/* nr is the maximum number of bytes to copy from this page */
+		nr = PAGE_CACHE_SIZE;
+		if (index == end_index) {
+			nr = isize & ~PAGE_CACHE_MASK;
+			if (nr <= offset)
+				goto out;
+		}
+		nr = nr - offset;
+
 		cond_resched();
 		page_cache_readahead(mapping, &ra, filp, index);
 
@@ -736,17 +745,6 @@ find_page:
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
-		/* nr is the maximum number of bytes to copy from this page */
-		nr = PAGE_CACHE_SIZE;
-		if (index == end_index) {
-			nr = isize & ~PAGE_CACHE_MASK;
-			if (nr <= offset) {
-				page_cache_release(page);
-				goto out;
-			}
-		}
-		nr = nr - offset;
-
 		/* If users can be writing to this page using arbitrary
 		 * virtual addresses, take care about potential aliasing
 		 * before reading the page on the kernel side.
@@ -826,6 +824,15 @@ readpage:
 			page_cache_release(page);
 			goto out;
 		}
+		nr = PAGE_CACHE_SIZE;
+		if (index == end_index) {
+			nr = isize & ~PAGE_CACHE_MASK;
+			if (nr <= offset) {
+				page_cache_release(page);
+				goto out;
+			}
+		}
+		nr = nr - offset;
 		goto page_ok;
 
 readpage_error:

_

--------------090609000206020400040704--
