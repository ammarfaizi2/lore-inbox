Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUFXX7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUFXX7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUFXX7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:59:15 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:3343 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S265916AbUFXX7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:59:09 -0400
Date: Fri, 25 Jun 2004 00:58:39 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix GFP zone modifier interators
Message-ID: <06D24C955C2FBF2BB53AFC93@[192.168.0.7]>
In-Reply-To: <20040624152333.79b36a90.akpm@osdl.org>
References: <200406242140.i5OLeZV4028038@voidhawk.shadowen.org>
 <20040624152333.79b36a90.akpm@osdl.org>
X-Mailer: Mulberry/3.1.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 24 June 2004 15:23 -0700 Andrew Morton <akpm@osdl.org> wrote:

> Andy Whitcroft <apw@shadowen.org> wrote:
>>
>> For each node there are a defined list of MAX_NR_ZONES zones.
>> These are selected as a result of the __GFP_DMA and __GFP_HIGHMEM
>> zone modifier flags being passed to the memory allocator as part of
>> the GFP mask.  Each node has a set of zone lists, node_zonelists,
>> which defines the list and order of zones to scan for each flag
>> combination.  When initialising these lists we iterate over
>> modifier combinations 0 .. MAX_NR_ZONES.  However, this is only
>> correct when there are at most ZONES_SHIFT flags.  If another flag
>> is introduced zonelists for it would not be initialised.
>
> I don't get it.  If you were going to add a new zone, identified by
> __GFP_WHATEVER then you'd need to increase MAX_NR_ZONES
> anyway, wouldn't you?
>
> I'm sure you're right, but I haven't worked on this stuff in months and
> it's obscure.  Care to explain a little more?

If you added a new zone you would increase MAX_NR_ZONES from 3 to 4, you 
would add __GFP_NEWONE as 0x4 as those are bit flags and GFP_ZONEMASK to 
0x7.  Now to build the zonelists we need to scan from 0-7 in 'Zone 
Modifier' space to cover all the combinations, but MAX_NR_ZONES is only 4. 
So we don't build the zonelists for them.

There is a question of whether we should be scanning 0..MAX_NR_ZONES and 
assuming the selector is 1<<N.  That would mean that there would be no 
support for the use of more than one such 'Zone Modifier' at a time. 
Currently there is no such usage.  My gut feeling is to not rule them out 
and to build the zonelists for all combinations (even if they are empty).

>> This patch introduces GFP_ZONEMODS (based on GFP_ZONEMASK) as a
>> bound for the number of modifier combinations.
>
> The "ZONEMODS" identifier doesn't really grab me.  ZONETYPES, or
> something?

Zone types is fine with me.  I took the name from the comments in mmzone.h, 
I have no attachment to it.

> Either way, please add a big fat comment over it, explaining to the poor
> reader what its semantic meaning is.

I'll add some more commentary and see how it looks.

-apw


