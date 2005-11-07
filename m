Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbVKGXHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVKGXHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbVKGXHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:07:07 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:24983 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030181AbVKGXHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:07:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sWe7DgdA9ayGnJnXJGcMAhJwjEQoCf6103Aej/t7ztMXhbuIK6nziWUIedjNlE0UbsXwWQt2RmLGdjzLOUdC9sC24rs+pJ420lRWTJ7/gz14RwLy3YIEYzOoLlt2cHB8vZQXFZQnWh67iMJIvG/uvK6tkhobiPnac9n7jzz4L9E=  ;
Message-ID: <436FDE85.9090205@yahoo.com.au>
Date: Tue, 08 Nov 2005 10:08:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] vm: kswapd incmin
References: <4366FA9A.20402@yahoo.com.au> <4366FAF5.8020908@yahoo.com.au> <20051107152816.GA17246@logos.cnet>
In-Reply-To: <20051107152816.GA17246@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi Nick,
> 
> Looks nice, much easier to read than before.
> 

Hi Marcelo,

Thanks! That was one of the main aims.

> One comment: you change the pagecache/slab scanning ratio by moving
> shrink_slab() outside of the zone loop. 
> 
> This means that for each kswapd iteration will scan "lru_pages" 
> SLAB entries, instead of "lru_pages*NR_ZONES" entries.
> 
> Can you comment on that?
> 

I believe I have tried to get it right, let me explain. lru_pages
is just used as the divisor for the ratio between lru scanning
and slab scanning. So long as it is kept constant across calls to
shrink_slab, there should be no change in behaviour.

The the nr_scanned variable is the other half of the equation that
controls slab shrinking. I have changed from:

   lru_pages = total_node_lru_pages;
   for each zone in node {
      shrink_zone();
      shrink_slab(zone_scanned, lru_pages);
   }

To:

   lru_pages = 0;
   for each zone in node {
      shrink_zone();
      lru_pages += zone_lru_pages;
   }
   shrink_slab(total_zone_scanned, lru_pages);

So the ratio remains basically the same
[eg. 10/100 + 20/100 + 30/100 = (10+20+30)/100]

2 reasons for doing this. The first is just efficiency and better
rounding of the divisions.

The second is that within the for_each_zone loop, we are able to
set all_unreclaimable without worrying about slab, because the
final shrink_slab at the end will clear all_unreclaimable if any
zones have had slab pages freed up.

I believe it generally should result in more consistent reclaim
across zones, and also matches direct reclaim better.

Hope this made sense,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
