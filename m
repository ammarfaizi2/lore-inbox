Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVLLIcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVLLIcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVLLIcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:32:31 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:29119 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751132AbVLLIca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:32:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=RUjWyoNzcoVGV3ZaOObFdgajaGiKa8tA6WyGgnVv0b77oJ2SvWNvDfq9jPGVfQbV0UwVMTecp5eaVOjZs9fXCfFf9v5YTVjC47Lmx4v0C/krnKdr8Bqx1biyZKE0ZRgAVJfq587fBiqrqVmu4uK7a+9M4FhVYes5eWTr9KAUxuU=  ;
Message-ID: <439D3592.70100@yahoo.com.au>
Date: Mon, 12 Dec 2005 19:32:18 +1100
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
References: <439D224A.7080007@yahoo.com.au> <20051212081415.GT14936@mellanox.co.il>
In-Reply-To: <20051212081415.GT14936@mellanox.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:
> Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> 
>>>>>If that works, I can mostly do things directly,
>>>>>although I'm still stuck with the problem of an app performing
>>>>>a fork + write into the same page while I'm doing DMA there.
>>>>>
>>>>>I am currently solving this by doing a second get_user_pages after
>>>>>DMA is done and comparing the page lists, but this, of course,
>>>>>needs a task context ...
>>>>>
>>>>
>>>>Usually we don't care about these kinds of races happening. So long
>>>>as it doesn't oops the kernel or hang the hardware, it is up to
>>>>userspace not to do stuff like that.
>>>
>>>
>>>Note that I am, even, not necessarily talking about full pages
>>>here: an application could be writing to one part of a page
>>>while hardware DMAs another part of it.
>>>So the app is not necessarily buggy.
>>>
>>
>>Sorry, I might have misunderstdood: what's the race? And how does
>>a second get_user_pages solve it?
> 
> 
> Here's what I have in mind:
> 
> A multithreaded app calls recvmsg(2), (or io_submit with receive request),
> passing in a buffer that is not page aligned.
> This does get_user_pages on some page and blocks waiting for DMA to complete.
> 
> Another thread calls fork(2), marking the page for copy on write.
> After fork, it writes (even 1 byte) into one of the pages that were passed
> to recvmsg, possibly even outside the buffer passed to recvmsg.
> This triggers a page copy in the parent process.
> 

OK, yeah if a thread in the parent process writes into the buffer, then
yes this would leave the copy in the parent AFAIKS.

But this is going to do similar weird stuff when racing with copy_to_user
with ethernet recvmsg, is it not? (and direct-io and probably others). As
such, I don't think it would be something you in particular need to worry
about.

I guess to solve it, we could either retain mmap_sem for the duration to
prevent fork, or try to do something tricky with page_count to determine
if we need to do a copy in fork() rather than a COW.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
