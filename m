Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVKGDky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVKGDky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVKGDky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:40:54 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:41643 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932289AbVKGDkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:40:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1ZkDPJD84wyO4TlSlA9MK0OUYcK9PgUxJpi+wWaMA8mWay8jEAJz0wVDoIcRE3AejOgP+/7YtHRwI/NMgXfmSYwzjInwNAcpVNL8AYQgNYQS7t26NEuVBpp7uIH+CfxKRoz33QE1FTWvInGB5BO9O3Q1bRZ4DmBBdZs2jNGvwps=  ;
Message-ID: <436ECD47.4050808@yahoo.com.au>
Date: Mon, 07 Nov 2005 14:43:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/14] mm: opt rmqueue
References: <436DBAC3.7090902@yahoo.com.au> <p73br0x3ceq.fsf@verdi.suse.de> <436EA88C.3050104@yahoo.com.au> <200511070423.45306.ak@suse.de>
In-Reply-To: <200511070423.45306.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 07 November 2005 02:06, Nick Piggin wrote:
> 
> 
>>Yes, all this turning on and off of interrupts does have a
>>significant cost here.
> 
> 
> How did you find out? 
> 

Measuring the actual performance improvement on kbuild.
Not to mention that profiles for things like mod_page_state
go dramatically down, but you can't use that alone to be sure
of an improvement.

> 
>>With the full patchset applied, most of the hot path statistics
>>get put under areas that already require interrupts to be off,
>>however there are still a few I didn't get around to doing.
>>zone_statistics on CONFIG_NUMA, for example.
> 
> 
> These should just be local_t 
> 

Yep.

> 
>>I wonder if local_t is still good on architectures like ppc64
>>where it still requires an ll/sc sequence?
> 
> 
> The current default fallback local_t doesn't require that. It uses
> different fields indexed by !!in_interrupt()
> 

Right I didn't see that. ppc(32), then.

I think maybe for struct page_state there is not so much point
in using local_t because the hot page allocator paths can easily
be covered under the interrupt critical sections.

The other fields aren't very hot, and using local_t would bloat
this up by many cachelines on 64-bit architectures like ppc64,
and would make them probably noticably more expensive on 32s
like ppc.

Actually, the NUMA fields in the pcp lists can probably also
just be put under the interrupt-off section that the page
allocator uses. At least it should be much easier to do when
Seth's __alloc_pages cleanup goes in. I'll keep it in mind.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
