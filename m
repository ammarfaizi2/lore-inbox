Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVLLHKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVLLHKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVLLHKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:10:15 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:35684 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751108AbVLLHKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:10:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ysR0orY6/kQetsKirqmEFQ31EoggwtKIl5zVUucxefsNaGkdTqZ0euPqs1szJ+kNHNu8wy4QcnK8Xv8gUqnfJ5ZFa1hme7WrbsaVaBTa0CoEfzZ9IAE+xkXB/mqisWnGO6rI9xJruLD6UGEyRB4/AaLEkgwpF0ackVMxwWIZpaY=  ;
Message-ID: <439D224A.7080007@yahoo.com.au>
Date: Mon, 12 Dec 2005 18:10:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
References: <439CEE50.2060803@yahoo.com.au> <20051212063521.GB24168@mellanox.co.il>
In-Reply-To: <20051212063521.GB24168@mellanox.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:
> Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> 

>>I think you can do that - provided you ensure the page mapping hasn't
>>disappeared after locking it.
> 
> 
> Ugh. I dont really know how to do that.
> Isnt this sufficient?
> 
> if (TestSetPageLocked(page))
> 	schedule_work(...)
> set_page_dirty(page)
> unlock_page(page)
> 
> Thats all there seems to be set_page_dirty_lock does if it is called when
> PG_Locked bit is clear.
> 

Oh yeah you are right - set_page_dirty does the check for you. Sorry
for the misinformation.

> 
>>However, I think you should try to the simplest way first.
> 
> 
> Thanks, Nick, thats what I have now, this already works for me here
> https://openib.org/svn/gen2/trunk/src/linux-kernel/infiniband/ulp/sdp/sdp_iocb.c
> I'm looking at ways to improve performance, though.
> 

Oh good :)

> 
>>>If that works, I can mostly do things directly,
>>>although I'm still stuck with the problem of an app performing
>>>a fork + write into the same page while I'm doing DMA there.
>>>
>>>I am currently solving this by doing a second get_user_pages after
>>>DMA is done and comparing the page lists, but this, of course,
>>>needs a task context ...
>>>
>>
>>Usually we don't care about these kinds of races happening. So long
>>as it doesn't oops the kernel or hang the hardware, it is up to
>>userspace not to do stuff like that.
> 
> 
> Note that I am, even, not necessarily talking about full pages
> here: an application could be writing to one part of a page
> while hardware DMAs another part of it.
> So the app is not necessarily buggy.
> 

Sorry, I might have misunderstdood: what's the race? And how does
a second get_user_pages solve it?

> It seems to me people really dont want to change their applications.
> They just want to load a library and have it go faster.
> Given that I'm implementing a socket protocol, we are talking about
> an awful lot of applications that currently work fine on top of TCP.
> 

Understandable.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
