Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWB0Pn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWB0Pn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWB0Pn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:43:58 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21738 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964795AbWB0Pn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:43:56 -0500
Message-ID: <44031DC7.20602@austin.ibm.com>
Date: Mon, 27 Feb 2006 09:41:59 -0600
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Bryan Fink <bfink@eventmonitor.com>,
       linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] readahead: fix initial window size calculation
References: <44020681.8F74CD53@tv-sign.ru>
In-Reply-To: <44020681.8F74CD53@tv-sign.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

>(I hope it is ok to send this patch without Steven's reply)
>  
>

Yes, It is fine.

>From: Steven Pratt <slpratt@austin.ibm.com>
>
>The current current get_init_ra_size is not optimal across different IO
>sizes and max_readahead values.  Here is a quick summary of sizes
>computed under current design and under the attached patch.  All of
>these assume 1st IO at offset 0, or 1st detected sequential IO.
>
>32k max, 4k request
>
>old         new
>-----------------
> 8k        8k
>16k       16k
>32k       32k
>
>128k max, 4k request
>old         new
>-----------------
>32k         16k
>64k         32k
>128k        64k
>128k       128k
>
>128k max, 32k request
>old         new
>-----------------
>32k         64k    <-----
>64k        128k
>128k       128k
>
>512k max, 4k request
>old         new
>-----------------
>4k         32k     <----
>16k        64k
>64k       128k
>128k      256k
>512k      512k
>
>--- 2.6.16-rc3/mm/readahead.c~	2006-02-27 00:53:17.881019192 +0300
>+++ 2.6.16-rc3/mm/readahead.c	2006-02-27 01:10:39.172718792 +0300
>@@ -83,10 +83,10 @@ static unsigned long get_init_ra_size(un
> {
> 	unsigned long newsize = roundup_pow_of_two(size);
> 
>-	if (newsize <= max / 64)
>-		newsize = newsize * newsize;
>+	if (newsize <= max / 32)
>+		newsize = newsize * 4;
> 	else if (newsize <= max / 4)
>-		newsize = max / 4;
>+		newsize = newsize * 2;
> 	else
> 		newsize = max;
> 	return newsize;
>  
>

