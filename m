Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUCLOPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 09:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCLOPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 09:15:42 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:58782 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262130AbUCLOPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 09:15:21 -0500
Message-ID: <4051C5F1.2050605@cyberone.com.au>
Date: Sat, 13 Mar 2004 01:15:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <404FACF4.3030601@cyberone.com.au> <200403111825.22674@WOLK> <40517E47.3010909@cyberone.com.au> <20040312012703.69f2bb9b.akpm@osdl.org> <pan.2004.03.12.11.08.02.700169@smurf.noris.de> <4051B0C6.2070302@cyberone.com.au>
In-Reply-To: <4051B0C6.2070302@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------000509030602080909050000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000509030602080909050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
> Well if nothing at all happens we don't swap out, but when something
> is happening, desktop users don't want any of their programs to be
> swapped out no matter how long they have been sitting idle. They don't
> want to wait 10 seconds to page something in even if it means they're
> waiting an extra 10 minutes throughout the day for their kernel greps
> and diffs to finish.
>
>

Just had a try of doing things like updatedb and dd if=/dev/zero of=./blah
It is pretty swappy I guess. The following patch I think makes things less
swappy. It still isn't true dropbehind because new unmapped pages still do
place some pressure on the more established pagecache, but not as much.

It is unclear whether full dropbehind is actually good or not. If you have
512MB of memory and a 256MB working set of file data (unmapped), with 400MB
of mapped memory doing nothing, after enough thrashing through your 256MB,
you'd expect some of that mapped memory to be swapped out.

By the way, I would be interested to know the rationale behind
mark_page_accessed as it is without this patch, also what is it doing in
rmap.c (I know hardly anything actually uses page_test_and_clear_young, but
still). It seems to me like it only serves to make VM behaviour harder to
understand, but I'm probably missing something. Andrew?


--------------000509030602080909050000
Content-Type: text/x-patch;
 name="vm-dropbehind.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-dropbehind.patch"

 linux-2.6-npiggin/mm/filemap.c |    3 +--
 linux-2.6-npiggin/mm/rmap.c    |    2 +-
 linux-2.6-npiggin/mm/swap.c    |    7 +------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff -puN mm/filemap.c~vm-dropbehind mm/filemap.c
--- linux-2.6/mm/filemap.c~vm-dropbehind	2004-03-13 00:14:56.000000000 +1100
+++ linux-2.6-npiggin/mm/filemap.c	2004-03-13 00:55:17.000000000 +1100
@@ -662,8 +662,7 @@ page_ok:
 		/*
 		 * Mark the page accessed if we read the beginning.
 		 */
-		if (!offset)
-			mark_page_accessed(page);
+		mark_page_accessed(page);
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
diff -puN mm/swap.c~vm-dropbehind mm/swap.c
--- linux-2.6/mm/swap.c~vm-dropbehind	2004-03-13 00:17:29.000000000 +1100
+++ linux-2.6-npiggin/mm/swap.c	2004-03-13 00:18:11.000000000 +1100
@@ -111,13 +111,8 @@ void fastcall activate_page(struct page 
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActiveMapped(page) && !PageActiveUnmapped(page)
-			&& PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
+	if (!PageReferenced(page))
 		SetPageReferenced(page);
-	}
 }
 
 EXPORT_SYMBOL(mark_page_accessed);
diff -puN mm/rmap.c~vm-dropbehind mm/rmap.c
--- linux-2.6/mm/rmap.c~vm-dropbehind	2004-03-13 01:08:00.000000000 +1100
+++ linux-2.6-npiggin/mm/rmap.c	2004-03-13 01:08:28.000000000 +1100
@@ -118,7 +118,7 @@ int fastcall page_referenced(struct page
 	int referenced = 0;
 
 	if (page_test_and_clear_young(page))
-		mark_page_accessed(page);
+		referenced++;
 
 	if (TestClearPageReferenced(page))
 		referenced++;

_

--------------000509030602080909050000--
