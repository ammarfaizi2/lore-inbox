Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWEGE43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWEGE43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 00:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWEGE43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 00:56:29 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:22374 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751000AbWEGE42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 00:56:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=afu+kS0dN//ZZlTjsJ7eCp5J1z1DFrXaVcxfFDUxYtgcVsHK+19VTBLmjPqkxuKUOE0VL0AY+rbwiU6PHOyC8agY566QHA/Vjh2VPnCU4QQtVAgkz1jBgveQWOpxet8bEu9/gNdNEzKOCqBzTwiEphzpXJny7IpK3lXpQP1USYU=  ;
Message-ID: <445D75EB.5030909@yahoo.com.au>
Date: Sun, 07 May 2006 14:22:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Blaisorblade <blaisorblade@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it> <445CC949.7050900@redhat.com>
In-Reply-To: <445CC949.7050900@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Blaisorblade wrote:
> 
>>I've not seen the numbers indeed, I've been told of a problem with a "customer 
>>program" and Ingo connected my work with this problem. Frankly, I've been 
>>always astonished about how looking up a 10-level tree can be slow. Poor 
>>cache locality is the only thing that I could think about.
> 
> 
> It might be good if I explain a bit how much we use mmap in libc.  The
> numbers can really add up quickly.

[...]

Thanks. Very informative.

> Put all this together and non-trivial apps as written today (I don't say
> they are high-quality apps) can easily have a few thousand, maybe even
> 10,000 to 20,000 VMAs.  Firefox on my machine uses in the moment ~560
> VMAs and this is with only a handful of threads.  Are these the numbers
> the VM system is optimized for?  I think what our people running the
> experiments at the customer site saw is that it's not.  The VMA
> traversal showed up on the profile lists.

Your % improvement numbers are of course only talking about memory
usage improvements. Time complexity increases with the log of the
number of VMAs, so while search within 100,000 vmas might have a CPU
cost of 16 arbitrary units, it is only about 300% the cost in 40
vmas (and not the 2,500,000% that the number of vmas suggests).

Definitely reducing vmas would be good. If guard ranges around vmas
can be implemented easily and reduce vmas by even 20%, it would come
at an almost zero complexity cost to the kernel.

However, I think another consideration is the vma lookup cache. I need
to get around to looking at this again, but IMO it is inadequate for
threaded applications. Currently we have one last-lookup cached vma
for each mm. You get cacheline bouncing when updating the cache, and
the locality becomes almost useless.

I think possibly each thread should have a private vma cache, with
room for at least its stack vma(s), (and several others, eg. code,
data). Perhaps the per-mm cache could be dispensed with completely,
although it might be useful eg. for the heap. And it might be helped
with increased entries as well.

I've got patches lying around to implement this stuff -- I'd be
interested to have more detail about this problem, or distilled test
cases.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
