Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287831AbSA2ARR>; Mon, 28 Jan 2002 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSA2ARD>; Mon, 28 Jan 2002 19:17:03 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:19972 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S287831AbSA2AQl>; Mon, 28 Jan 2002 19:16:41 -0500
Message-ID: <3C55E9E3.50207@namesys.com>
Date: Tue, 29 Jan 2002 03:16:35 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com> <3C55A58F.1070908@namesys.com> <E16VLZh-0000Dp-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On January 28, 2002 08:25 pm, Hans Reiser wrote:
>
>>If I understand you right, your scheme has the fundamental flaw that one 
>>dcache entry on a page can keep an entire page full of "slackers" in 
>>memory, and since there is little correlation in usage between dcache 
>>entries that happen to get stored on a page, the result is that the 
>>effectiveness per megabyte of the dcache is decreased by an order of 
>>magnitude.  It would be worse to have one dcache entry per page, but 
>>maybe not by as much as you might expect.
>>
>>When objects smaller than a page are stored on a page but not correlated 
>>in their usage, they need to be aged individually not as a page, and 
>>then garbage collected as needed.
>>
>
>I had the identical thought - i.e., that this is a job for object aging and 
>not lru, then I realized that a slight modification to lru can do the job, 
>that is:
>
>  - An access to any object on the page promotes the page to the hot end
>    of the lru list.
>
>  - When it's time to recover a page (or pages) scan from the cold end
>    towards the hot end, and recover the first page(s) on which all
>    objects are free.
>
>>Neither the current model nor your 
>>proposed scheme solve the fundamental problem Josh's measurements prove 
>>exists.  
>>
>
>My suggestion might.
>
This fails to recover an object (e.g. dcache entry) which is used once, 
and then spends a year in cache on the same page as an object which is 
hot all the time.  This means that the hot set of objects becomes 
diffused over an order of magnitude more pages than if garbage 
collection squeezes them all together.  That makes for very poor caching.

Hans

