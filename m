Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWEGNI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWEGNI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWEGNI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:08:29 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:1298 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932147AbWEGNI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:08:28 -0400
Message-ID: <445DF114.4090708@shadowen.org>
Date: Sun, 07 May 2006 14:07:32 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Dave Hansen <haveblue@us.ibm.com>, Bob Picco <bob.picco@hp.com>,
       Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>	 <20060504013239.GG19859@localhost>	 <1146756066.22503.17.camel@localhost.localdomain>	 <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu>	 <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>	 <20060505135503.GA5708@localhost>	 <1146839590.22503.48.camel@localhost.localdomain>	 <20060505145018.GI19859@localhost> <1146841064.22503.53.camel@localhost.localdomain> <445C5F36.3030207@yahoo.com.au>
In-Reply-To: <445C5F36.3030207@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Dave Hansen wrote:
> 
>> Ahhh.  I hadn't made the ia64 connection.  I wonder if it is worth
>> making CONFIG_HOLES_IN_ZONE say ia64 or something about vmem_map in it
>> somewhere.  Might be worth at least a comment like this:
>>
>> +               if (page_in_zone_hole(buddy)) /* noop on all but ia64 */
>> +                       break;
>> +               else if (page_zonenum(buddy) != page_zonenum(page))
>> +                       break;
>> +               else if (!page_is_buddy(buddy, order))
>>                         break;          /* Move the buddy up one
>> level. */
>>
>> BTW, wasn't the whole idea of discontig to have holes in zones (before
>> NUMA) without tricks like this? ;)
> 
> 
> Yes.
> 
> I don't like the patch much, because all that logic should be moved
> into page_is_buddy where I put it (surely it is more readable not to
> have the checks spilling out -- a page which is not in the correct
> zone or is a "hole" is by definition not a buddy, right?)
> 
> So, I agree with adding the zone check if any architecture needs it.
> But it would be something under CONFIG_HOLES_IN_ZONE, and the arch
> needs to *either* align zones correctly (as they've always had to),
> or turn this option on.

I agree that there is no need for these checks to leak out of
page_is_buddy().  If its not there or in another zone, its not my buddy.
 The allocator loop is nasty enough as it is.

I think we need to do a couple of things:

1) check the alignment of the zones matches the implied alignment
constraints and correct it as we go.
2) optionally allow an architecture to say its not aligning and doesn't
want to have to align its zone -- providing a config option to add the
zone index checks

I think the later is valuable for these test builds and potentially for
the embedded side where megabytes mean something.

I'm testing a patch for this at the moment and will drop it out when I'm
done.

-apw
