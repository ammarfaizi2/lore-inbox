Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVBXSdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVBXSdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVBXSck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:32:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:6284 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261619AbVBXScV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:32:21 -0500
Message-ID: <421E2CDE.B3DD5886@tv-sign.ru>
Date: Thu, 24 Feb 2005 22:37:02 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ram Pai <linuxram@us.ibm.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/4][RESEND] readahead: unneeded prev_page assignments
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in setting ra->prev_page before 'goto out',
it will be overwritten anyway.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc5/mm/readahead.c~	Wed Jan 12 11:44:55 2005
+++ 2.6.11-rc5/mm/readahead.c	Mon Jan 24 20:19:38 2005
@@ -432,7 +432,6 @@ page_cache_readahead(struct address_spac
 
 	if (newsize == 0 || (ra->flags & RA_FLAG_INCACHE)) {
 		newsize = 1;
-		ra->prev_page = offset;
 		goto out;	/* No readahead or file already in cache */
 	}
 	/*
@@ -443,7 +442,6 @@ page_cache_readahead(struct address_spac
 	if ((ra->size == 0 && offset == 0)	/* first io and start of file */
 	    || (ra->size == -1 && ra->prev_page == offset - 1)) {
 		/* First sequential */
-		ra->prev_page  = offset + newsize - 1;
 		ra->size = get_init_ra_size(newsize, max);
 		ra->start = offset;
 		if (!blockable_page_cache_readahead(mapping, filp, offset,
@@ -475,7 +473,6 @@ page_cache_readahead(struct address_spac
 	 */
 	if ((offset != (ra->prev_page+1) || (ra->size == 0))) {
 		ra_off(ra);
-		ra->prev_page  = offset + newsize - 1;
 		blockable_page_cache_readahead(mapping, filp, offset,
 				 newsize, ra, 1);
 		goto out;
@@ -545,7 +542,7 @@ page_cache_readahead(struct address_spac
 
 out:
 	ra->prev_page = offset + newsize - 1;
-	return(newsize);
+	return newsize;
 }
 
 /*
