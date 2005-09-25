Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVIYBn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVIYBn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 21:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVIYBn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 21:43:56 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:9652 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750828AbVIYBn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 21:43:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Jj5igufCV7tjPvcfFlzhqcwe3LPYOaIVMQOiZPBsYPQju21D6YtMk5/pJqYzImm2Xi5ack0ySvoNb87foVUrU3Zj7yPJo04xuugVmwzqonysuXtirk42bzFeXURWgi8Zc0/UiavCEygONPgvYUwmRZzEJKdAGEbmsH3wzXZkvOk=  ;
Message-ID: <433600C2.6020007@yahoo.com.au>
Date: Sun, 25 Sep 2005 11:43:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] reduce sizeof(struct file)
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org> <4333CF4C.2000306@anagramm.de> <4333D2AA.6020009@cosmosbay.com> <20050923100541.GA18447@infradead.org> <4334CB49.3080703@cosmosbay.com>
In-Reply-To: <4334CB49.3080703@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

> --- linux-2.6.14-rc2-orig/include/linux/fs.h	2005-09-20 05:00:41.000000000 +0200
> +++ linux-2.6.14-rc2/include/linux/fs.h	2005-09-24 04:52:20.000000000 +0200
> @@ -574,7 +574,13 @@
>  #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
>  
>  struct file {
> -	struct list_head	f_list;
> +/*
> + * f_list and f_rcuhead can share the same memory location
> + */
> +	union {
> +		struct list_head	fu_list;
> +		struct rcu_head 	fu_rcuhead;
> +		} f_u;

I don't think you need to explain this basic C semantic to
the reader if they have gotten this far ;)

Instead, explain when fu_list and fu_rcuhead are used.
Something along the lines of

/*
  * fu_list becomes invalid after file_free is called
  * and queued via fu_rcuhead for RCU freeing
  */

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
