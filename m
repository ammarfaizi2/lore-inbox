Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVAYWt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVAYWt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVAYWsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:48:19 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5316 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262143AbVAYWrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:47:00 -0500
Message-ID: <41F6BE24.1070300@austin.ibm.com>
Date: Tue, 25 Jan 2005 15:46:12 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/4] page_cache_readahead: remove duplicated code
References: <41F63493.309B0ADB@tv-sign.ru>
In-Reply-To: <41F63493.309B0ADB@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like this one, especially getting rid of the large duplicate comment.  
No functional difference.

Signed-off-by: Steven Pratt <slpratt@austin.bm.com>

Oleg Nesterov wrote:

>Cases "no ahead window" and "crossed into ahead window"
>can be unified.
>
>Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
>--- 2.6.11-rc2/mm/readahead.c~	2005-01-25 14:28:22.000000000 +0300
>+++ 2.6.11-rc2/mm/readahead.c	2005-01-25 15:17:13.000000000 +0300
>@@ -483,43 +483,24 @@ page_cache_readahead(struct address_spac
> 	 * occurence (ie we have an existing window)
> 	 */
> 
>-	if (ra->ahead_start == 0) {	 /* no ahead window yet */
>-		ra->ahead_size = get_next_ra_size(ra->size, max, min,
>-						  &ra->flags);
>-		ra->ahead_start = ra->start + ra->size;
>-		block = ((offset + newsize -1) >= ra->ahead_start);
>-		if (!blockable_page_cache_readahead(mapping, filp,
>-		    ra->ahead_start, ra->ahead_size, ra, block)) {
>-			/* A read failure in blocking mode, implies pages are
>-			 * all cached. So we can safely assume we have taken
>-			 * care of all the pages requested in this call. A read
>-			 * failure in non-blocking mode, implies we are reading
>-			 * more pages than requested in this call.  So we safely
>-			 * assume we have taken care of all the pages requested
>-			 * in this call.
>-			 *
>-			 * Just reset the ahead window in case we failed due to
>-			 * congestion.  The ahead window will any way be closed
>-			 * in case we failed due to exessive page cache hits.
>-			 */
>-			ra->ahead_start = 0;
>-			ra->ahead_size = 0;
>-			goto out;
>-		}
>-	}
> 	/*
>-	 * Already have an ahead window, check if we crossed into it.
>+	 * Check if we crossed into ahead window.
> 	 * If so, shift windows and issue a new ahead window.
> 	 * Only return the #pages that are in the current window, so that
> 	 * we get called back on the first page of the ahead window which
> 	 * will allow us to submit more IO.
> 	 */
> 	if ((offset + newsize - 1) >= ra->ahead_start) {
>-		ra->start = ra->ahead_start;
>-		ra->size = ra->ahead_size;
>-		ra->ahead_start = ra->ahead_start + ra->ahead_size;
>-		ra->ahead_size = get_next_ra_size(ra->ahead_size,
>-						  max, min, &ra->flags);
>+		/* Check if we already have an ahead window */
>+		if (ra->ahead_start != 0) {
>+			ra->start = ra->ahead_start;
>+			ra->size = ra->ahead_size;
>+		}
>+
>+		ra->ahead_size = get_next_ra_size(ra->size, max, min,
>+							&ra->flags);
>+		ra->ahead_start = ra->start + ra->size;
>+
> 		block = ((offset + newsize - 1) >= ra->ahead_start);
> 		if (!blockable_page_cache_readahead(mapping, filp,
> 			ra->ahead_start, ra->ahead_size, ra, block)) {
>  
>

