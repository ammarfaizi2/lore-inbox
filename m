Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUKBPKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUKBPKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUKBPJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:09:47 -0500
Received: from use.the.admin.shell.to.set.your.reverse.dns.for.this.ip ([80.68.90.175]:19211
	"EHLO hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261251AbUKBNxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:53:35 -0500
Message-ID: <41879145.7090309@shadowen.org>
Date: Tue, 02 Nov 2004 13:53:09 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org> <40860000.1099235861@[10.10.2.4]>
In-Reply-To: <40860000.1099235861@[10.10.2.4]>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --Andrew Morton <akpm@osdl.org> wrote (on Saturday, October 30, 2004 14:07:32 -0700):
> 
> 
>>Andrea Arcangeli <andrea@novell.com> wrote:
>>
>>>I think it's much better to have PG_zero in the main page allocator than
>>> to put the ptes in the slab. This way we can share available zero pages with
>>> all zero-page users and we have a central place where people can
>>> generate zero pages and allocate them later efficiently.
>>
>>Yup.
>>
>>
>>> This gives a whole internal knowledge to the whole buddy system and
>>> per-cpu subsystem of zero pages.
>>
>>Makes sense.  I had a go at this ages ago and wasn't able to demonstrate
>>much benefit on a mixed workload.
>>
>>I wonder if it would help if the page zeroing in the idle thread was done
>>with the CPU cache disabled.  It should be pretty easy to test - isn't it
>>just a matter of setting the cache-disable bit in the kmap_atomic()
>>operation?
> 
> 
> I looked at the basic problem a couple of years ago (based on your own code,
> IIRC Andrew) then Andy (cc'ed) did it again with cache writethrough. It 
> doesn't provide any benefit at all, no matter what we did, and it was 
> finally ditched. 
> 
> I wouldn't bother doing it again personally ... perhaps Andy still has
> the last set of results he can send to you.

I'll have a look out for the results, they should be around somewhere?

The work I did was based on the idea it _had_ to be more efficient to 
have pre-zero'd pages available instead of wasting the hot pages, 
scrubbing them on use.  I did a lot of work to introduce a new queue for 
these, per-cpu.  Scrubbing them using spare cycles, even trying a 
version where we didn't polute the cache with them using uncached 
write-combining.  The results all showed (on i386 machines at least) 
that the predominant cost was cache warmth.  It was slower to fetch the 
clean zero page from memory than it was to clean out all of the cache 
page for use.  The colder the page the slower the system went.

-apw

