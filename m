Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVAYWx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVAYWx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVAYWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:51:59 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:44733 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262200AbVAYWvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:51:06 -0500
Message-ID: <41F6BF18.9000402@austin.ibm.com>
Date: Tue, 25 Jan 2005 15:50:16 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/4] blockable_page_cache_readahead() cleanup
References: <41F63498.72DB416F@tv-sign.ru>
In-Reply-To: <41F63498.72DB416F@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No problem with this patch either.  Again, not sure it buys much but it 
should work fine.

Steve

Oleg Nesterov wrote:

>I think that do_page_cache_readahead() can be inlined
>in blockable_page_cache_readahead(), this makes the
>code a bit more readable in my opinion.
>
>Also makes check_ra_success() static inline.
>
>Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
>--- 2.6.11-rc2/mm/readahead.c~	2005-01-25 17:26:34.000000000 +0300
>+++ 2.6.11-rc2/mm/readahead.c	2005-01-25 17:29:26.000000000 +0300
>@@ -349,8 +349,8 @@ int force_page_cache_readahead(struct ad
>  * readahead isn't helping.
>  *
>  */
>-int check_ra_success(struct file_ra_state *ra, unsigned long nr_to_read,
>-				 unsigned long actual)
>+static inline int check_ra_success(struct file_ra_state *ra,
>+			unsigned long nr_to_read, unsigned long actual)
> {
> 	if (actual == 0) {
> 		ra->cache_hit += nr_to_read;
>@@ -395,15 +395,11 @@ blockable_page_cache_readahead(struct ad
> {
> 	int actual;
> 
>-	if (block) {
>-		actual = __do_page_cache_readahead(mapping, filp,
>-						offset, nr_to_read);
>-	} else {
>-		actual = do_page_cache_readahead(mapping, filp,
>-						offset, nr_to_read);
>-		if (actual == -1)
>-			return 0;
>-	}
>+	if (block && bdi_read_congested(mapping->backing_dev_info))
>+		return 0;
>+
>+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
>+
> 	return check_ra_success(ra, nr_to_read, actual);
> }
>  
>

