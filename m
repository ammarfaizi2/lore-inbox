Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVAYW6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVAYW6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVAYW4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:56:11 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41926 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262207AbVAYWsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:48:14 -0500
Message-ID: <41F6BE6F.5040405@austin.ibm.com>
Date: Tue, 25 Jan 2005 15:47:27 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] cleanup ahead window calculation
References: <41F63495.7E254A6E@tv-sign.ru>
In-Reply-To: <41F63495.7E254A6E@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure how much better this is, but it doesn't hurt anything.

Steve

Oleg Nesterov wrote:

>This patch moves some code into the get_next_ra_size()
>and renames it into 'set_next_ahead_window'.
>
>Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
>--- 2.6.11-rc2/mm/readahead.c~	2005-01-25 15:17:13.000000000 +0300
>+++ 2.6.11-rc2/mm/readahead.c	2005-01-25 16:51:50.000000000 +0300
>@@ -85,20 +85,23 @@ static unsigned long get_init_ra_size(un
>  * not for each call to readahead.  If a cache miss occured, reduce next I/O
>  * size, else increase depending on how close to max we are.
>  */
>-static unsigned long get_next_ra_size(unsigned long cur, unsigned long max,
>-				unsigned long min, unsigned long * flags)
>+static void set_next_ahead_window(struct file_ra_state *ra,
>+				unsigned long max, unsigned long min)
> {
> 	unsigned long newsize;
>+	unsigned long cur = ra->size;
> 
>-	if (*flags & RA_FLAG_MISS) {
>+	ra->ahead_start = ra->start + cur;
>+
>+	if (ra->flags & RA_FLAG_MISS) {
>+		ra->flags &= ~RA_FLAG_MISS;
> 		newsize = max((cur - 2), min);
>-		*flags &= ~RA_FLAG_MISS;
>-	} else if (cur < max / 16) {
>+	} else if (cur < max / 16)
> 		newsize = 4 * cur;
>-	} else {
>+	else
> 		newsize = 2 * cur;
>-	}
>-	return min(newsize, max);
>+
>+	ra->ahead_size = min(newsize, max);
> }
> 
> #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
>@@ -457,9 +460,7 @@ page_cache_readahead(struct address_spac
> 		 * immediately.
> 		 */
> 		if (req_size >= max) {
>-			ra->ahead_size = get_next_ra_size(ra->size, max, min,
>-							  &ra->flags);
>-			ra->ahead_start = ra->start + ra->size;
>+			set_next_ahead_window(ra, max, min);
> 			blockable_page_cache_readahead(mapping, filp,
> 				 ra->ahead_start, ra->ahead_size, ra, 1);
> 		}
>@@ -497,9 +498,7 @@ page_cache_readahead(struct address_spac
> 			ra->size = ra->ahead_size;
> 		}
> 
>-		ra->ahead_size = get_next_ra_size(ra->size, max, min,
>-							&ra->flags);
>-		ra->ahead_start = ra->start + ra->size;
>+		set_next_ahead_window(ra, max, min);
> 
> 		block = ((offset + newsize - 1) >= ra->ahead_start);
> 		if (!blockable_page_cache_readahead(mapping, filp,
>  
>

