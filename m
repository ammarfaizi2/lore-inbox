Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVBXWab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVBXWab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVBXWab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:30:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:43231 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262518AbVBXWaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:30:06 -0500
Message-ID: <421E55E5.3010404@austin.ibm.com>
Date: Thu, 24 Feb 2005 16:32:05 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/4][RESEND] readahead: cleanup	blockable_page_cache_readahead()
References: <421E2CE9.8B5E4DE7@tv-sign.ru> <1109271683.6140.120.camel@localhost>
In-Reply-To: <1109271683.6140.120.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:

>Andrew, 
>	I have verified the patches against my standard benchmarks
>	and did not see any bad effects.
>
>	Also I have reviewd the patch and it looked clean and correct.
>
>RP
>  
>

I have not had a chance to benchmark, but visual inspection looks good.

Steve

>On Thu, 2005-02-24 at 11:37, Oleg Nesterov wrote:
>  
>
>>I think that do_page_cache_readahead() can be inlined
>>in blockable_page_cache_readahead(), this makes the
>>code a bit more readable in my opinion.
>>
>>Also makes check_ra_success() static inline.
>>
>>Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>>
>>--- 2.6.11-rc5/mm/readahead.c~	2005-01-29 15:51:04.000000000 +0300
>>+++ 2.6.11-rc5/mm/readahead.c	2005-01-29 16:37:05.000000000 +0300
>>@@ -348,8 +348,8 @@ int force_page_cache_readahead(struct ad
>>  * readahead isn't helping.
>>  *
>>  */
>>-int check_ra_success(struct file_ra_state *ra, unsigned long nr_to_read,
>>-				 unsigned long actual)
>>+static inline int check_ra_success(struct file_ra_state *ra,
>>+			unsigned long nr_to_read, unsigned long actual)
>> {
>> 	if (actual == 0) {
>> 		ra->cache_hit += nr_to_read;
>>@@ -394,15 +394,11 @@ blockable_page_cache_readahead(struct ad
>> {
>> 	int actual;
>> 
>>-	if (block) {
>>-		actual = __do_page_cache_readahead(mapping, filp,
>>-						offset, nr_to_read);
>>-	} else {
>>-		actual = do_page_cache_readahead(mapping, filp,
>>-						offset, nr_to_read);
>>-		if (actual == -1)
>>-			return 0;
>>-	}
>>+	if (!block && bdi_read_congested(mapping->backing_dev_info))
>>+		return 0;
>>+
>>+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
>>+
>> 	return check_ra_success(ra, nr_to_read, actual);
>> }
>>    
>>

