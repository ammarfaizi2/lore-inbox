Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVBBVl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVBBVl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVBBVlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:41:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:24296 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262813AbVBBVhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:37:22 -0500
Message-ID: <42014825.1040400@austin.ibm.com>
Date: Wed, 02 Feb 2005 15:37:41 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/4] readahead: factor out duplicated code
References: <41FB6F45.848CEFF6@tv-sign.ru>
In-Reply-To: <41FB6F45.848CEFF6@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

>This patch introduces make_ahead_window() function for
>simplification of page_cache_readahead.
>
>Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
>--- 2.6.11-rc2/mm/readahead.c~	2005-01-27 22:14:39.000000000 +0300
>+++ 2.6.11-rc2/mm/readahead.c	2005-01-29 15:51:04.000000000 +0300
>@@ -406,6 +406,37 @@ blockable_page_cache_readahead(struct ad
> 	return check_ra_success(ra, nr_to_read, actual);
> }
> 
>+static int make_ahead_window(struct address_space *mapping, struct file *filp,
>+		struct file_ra_state *ra, int force)
>+{
>+	int block, ret;
>+
>+	ra->ahead_size = get_next_ra_size(ra);
>+	ra->ahead_start = ra->start + ra->size;
>+
>+	block = force || (ra->prev_page >= ra->ahead_start);
>+	ret = blockable_page_cache_readahead(mapping, filp,
>+			ra->ahead_start, ra->ahead_size, ra, block);
>+
>+	if (!ret && !force) {
>  
>
This really needs to be

    if (!ret && !block) {

otherwise we can have an aheadwindow which was never populated which 
will cause slow reads which we want to avoid in all cases.

>+		/* A read failure in blocking mode, implies pages are
>+		 * all cached. So we can safely assume we have taken
>+		 * care of all the pages requested in this call.
>+		 * A read failure in non-blocking mode, implies we are
>+		 * reading more pages than requested in this call.  So
>+		 * we safely assume we have taken care of all the pages
>+		 * requested in this call.
>+		 *
>+		 * Just reset the ahead window in case we failed due to
>+		 * congestion.  The ahead window will any way be closed
>+		 * in case we failed due to excessive page cache hits.
>+		 */
>  
>

Hmmm..  I realize that this piece is not really new, but I don't like 
the fact that we can zero out the ahead window just because of a 
complete cache hit.   This will screw up logic for closing the window on 
repeated cache hits by possibly repeatedly getting hits on the same 
pages over and over again.

I guess this raises the question in my mind, which is "Is all of the 
congestion code really worth it?"  It is pretty much a corner case that 
we don't want to block, plus that fact that we might block anyway even 
with the congestion code (timing hole), and more than likely since we 
are in sequential read pattern already and the device is really slow(ie 
congested) we will most likely block soon anyway when we come back for 
these pages.  Just a thought.

>+		ra->ahead_start = 0;
>+		ra->ahead_size = 0;
>+	}
>+
>+	return ret;
>+}
> /*
>  * page_cache_readahead is the main function.  If performs the adaptive
>  * readahead window size management and submits the readahead I/O.
>@@ -415,9 +446,8 @@ page_cache_readahead(struct address_spac
> 		     struct file *filp, unsigned long offset,
> 		     unsigned long req_size)
> {
>-	unsigned long max;
>-	unsigned long newsize = req_size;
>-	unsigned long block;
>+	unsigned long max, newsize = req_size;
>+	int sequential = (offset == ra->prev_page + 1);
> 
> 	/*
> 	 * Here we detect the case where the application is performing
>@@ -428,6 +458,7 @@ page_cache_readahead(struct address_spac
> 	if (offset == ra->prev_page && req_size == 1 && ra->size != 0)
> 		goto out;
> 
>+	ra->prev_page = offset;
> 	max = get_max_readahead(ra);
> 	newsize = min(req_size, max);
> 
>@@ -435,13 +466,16 @@ page_cache_readahead(struct address_spac
> 		newsize = 1;
> 		goto out;	/* No readahead or file already in cache */
> 	}
>+
>+	ra->prev_page += newsize - 1;
>+
> 	/*
> 	 * Special case - first read.  We'll assume it's a whole-file read if
> 	 * at start of file, and grow the window fast.  Or detect first
> 	 * sequential access
> 	 */
> 	if ((ra->size == 0 && offset == 0)	/* first io and start of file */
>-	    || (ra->size == -1 && ra->prev_page == offset - 1)) {
>+	    || (ra->size == -1 && sequential)) {
> 		/* First sequential */
> 		ra->size = get_init_ra_size(newsize, max);
> 		ra->start = offset;
>@@ -457,12 +491,9 @@ page_cache_readahead(struct address_spac
> 		 * IOs,* thus preventing stalls. so issue the ahead window
> 		 * immediately.
> 		 */
>-		if (req_size >= max) {
>-			ra->ahead_size = get_next_ra_size(ra);
>-			ra->ahead_start = ra->start + ra->size;
>-			blockable_page_cache_readahead(mapping, filp,
>-				 ra->ahead_start, ra->ahead_size, ra, 1);
>-		}
>+		if (req_size >= max)
>+			make_ahead_window(mapping, filp, ra, 1);
>+
> 		goto out;
> 	}
> 
>@@ -471,7 +502,7 @@ page_cache_readahead(struct address_spac
> 	 * partial page reads and first access were handled above,
> 	 * so this must be the next page otherwise it is random
> 	 */
>-	if ((offset != (ra->prev_page+1) || (ra->size == 0))) {
>+	if (!sequential || (ra->size == 0)) {
> 		ra_off(ra);
> 		blockable_page_cache_readahead(mapping, filp, offset,
> 				 newsize, ra, 1);
>@@ -484,27 +515,8 @@ page_cache_readahead(struct address_spac
> 	 */
> 
> 	if (ra->ahead_start == 0) {	 /* no ahead window yet */
>-		ra->ahead_size = get_next_ra_size(ra);
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
>+		if (!make_ahead_window(mapping, filp, ra, 0))
> 			goto out;
>-		}
> 	}
> 	/*
> 	 * Already have an ahead window, check if we crossed into it.
>@@ -513,33 +525,13 @@ page_cache_readahead(struct address_spac
> 	 * we get called back on the first page of the ahead window which
> 	 * will allow us to submit more IO.
> 	 */
>-	if ((offset + newsize - 1) >= ra->ahead_start) {
>+	if (ra->prev_page >= ra->ahead_start) {
> 		ra->start = ra->ahead_start;
> 		ra->size = ra->ahead_size;
>-		ra->ahead_start = ra->start + ra->size;
>-		ra->ahead_size = get_next_ra_size(ra);
>-		block = ((offset + newsize - 1) >= ra->ahead_start);
>-		if (!blockable_page_cache_readahead(mapping, filp,
>-			ra->ahead_start, ra->ahead_size, ra, block)) {
>-			/* A read failure in blocking mode, implies pages are
>-			 * all cached. So we can safely assume we have taken
>-			 * care of all the pages requested in this call.
>-			 * A read failure in non-blocking mode, implies we are
>-			 * reading more pages than requested in this call.  So
>-			 * we safely assume we have taken care of all the pages
>-			 * requested in this call.
>-			 *
>-			 * Just reset the ahead window in case we failed due to
>-			 * congestion.  The ahead window will any way be closed
>-			 * in case we failed due to excessive page cache hits.
>-			 */
>-			ra->ahead_start = 0;
>-			ra->ahead_size = 0;
>-		}
>+		make_ahead_window(mapping, filp, ra, 0);
> 	}
> 
> out:
>-	ra->prev_page = offset + newsize - 1;
> 	return newsize;
> }
>  
>
The rest of this loks ok, but I have not convinced myself that it 
doesn't change the behavior somewhere. I need to actually do some 
testing on this just to be certain.

Steve
