Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWCBED4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWCBED4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 23:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWCBED4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 23:03:56 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:41135 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750795AbWCBEDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 23:03:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=x1BXX625Q6kXxtJCjPgMlkGVzn3UWjA92fuXRNoWO2wJIMvna2xcfb3RWzrP+CfuPuKt6xXFTbLqKnx8/q/qdLlK/Ez6M/5yiJ5WRYZTt3DYkn6fV0OxIkmEkfxafDgxIt3wo9FKYPW/s86FbfS8xmRkBGR1dW26Dz6ra9TCaVA=  ;
Message-ID: <44066E9E.1090007@yahoo.com.au>
Date: Thu, 02 Mar 2006 15:03:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: page allocation failure when cached memory is close to the total
 memory.
References: <6d6a94c50603010154hbbcdb68n8cd7e05f7f30aba5@mail.gmail.com>	 <20060301023604.76ce5658.akpm@osdl.org> <6d6a94c50603011937p61bea6ddl691ee1cdb309d14d@mail.gmail.com>
In-Reply-To: <6d6a94c50603011937p61bea6ddl691ee1cdb309d14d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> On 3/1/06, Andrew Morton <akpm@osdl.org> wrote:
> 
>>You mean 10MB.
> 
> Sorry for the typo.
> 
> 
>>The chances of finding 10MB of contiguous free pages are basically nil, so
>>the page allocator doesn't even try to free up pages to attempt to satisfy
>>such a large request.  If it can't find the 10MB of free memory
>>immediately, it just gives up.
> 
> 
> Nope. I've tested the case on the host. See below. The allocation for
> 300MB was sucessful when the cached memory was close to the total
> memory.
> 
> Any thoughts why?
> 

At a guess, this machine is using an mmu and a kernel compiled with
CONFIG_MMU, while the previous one wasn't?

Having an mmu means that all userspace allocations can be satisfied
with arbitrary collections of pages, not having one means you need
a linear area of physical memory of the required size.

I've never used one of those nommu systems, but I imagine that there
are conventions that need to be used that don't exist with general
purpose systems.

To start with: I'd try really hard to keep allocations <= 4k, even
if that means inefficiencies (eg building your own "page tables" in
the form of a radix tree, or using a list or other data structure to
allocate even a simple vector like you have there).

If you really need a big linear area, allocate this once when your
system boots and keep it allocated forever. You could even write
a custom allocator to manage this area, for example.

But asking on the uclinux list would probably be your best bet.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
