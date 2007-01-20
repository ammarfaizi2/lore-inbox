Return-Path: <linux-kernel-owner+w=401wt.eu-S965152AbXATEDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbXATEDj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 23:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbXATEDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 23:03:39 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:27349 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965152AbXATEDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 23:03:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tnWFQoFLnyNmST2x5c9S1myW3RCrJ39Gd+ftYNHHbFAlez/UUYWluCEdOAphQrKEApxZYs9Q/1xxXRXqMpsV3eoy3PJW8rKgMyPfyZ3BglVBYI8Pqt8e66oPTaPEelmdwDg4EAJ+ggYqsg7pHnAxB8OIm3gGOEwNnJZxjfevEKs=  ;
X-YMail-OSG: blvKceQVM1nu2UYHM3eBf0c3HGGLvk2JnCYEIZkBBF88tCdD0p8SJkTOCAZln4Cn3wPSJy01Hw--
Message-ID: <45B19483.6010300@yahoo.com.au>
Date: Sat, 20 Jan 2007 15:03:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey Li <aubreylee@gmail.com>
CC: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Robin Getz <rgetz@blackfin.uclinux.org>,
       "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>	 <45B0DB45.4070004@linux.vnet.ibm.com>	 <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>	 <45B112B6.9060806@linux.vnet.ibm.com>	 <6d6a94c50701191804m79c70afdo1e664a072f928b9e@mail.gmail.com>	 <45B17D6D.2030004@yahoo.com.au> <6d6a94c50701191908i63fe7eebi9a97a4afb94f5df4@mail.gmail.com>
In-Reply-To: <6d6a94c50701191908i63fe7eebi9a97a4afb94f5df4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey Li wrote:

> So what's the right way to limit pagecache?

Probably something a lot more complicated... if you can say there
is a "right way".

>> Secondly, your patch isn't actually very good. It unconditionally
>> shrinks memory to below the given % mark each time a pagecache alloc
>> occurs, regardless of how much pagecache is in the system. Effectively
>> that seems to just reduce the amount of memory available to the system.
> 
> 
> It doesn't reduce the amount of memory available to the system. It
> just reduce the amount of memory available to the page cache. So that
> page cache is limited and the reserved memory can be allocated by the
> application.

But the patch doesn't do that, as I explained.

>> Luckily, there are actually good, robust solutions for your higher
>> order allocation problem. Do higher order allocations at boot time,
>> modifiy userspace applications, or set up otherwise-unused, or easily
>> reclaimable reserve pools for higher order allocations. I don't
>> understand why you are so resistant to all of these approaches?
>>
> 
> I think we have explained the reason too much. We are working on
> no-mmu arch and provide a platform running linux to our customer. They
> are doing very good things like mplayer, asterisk, ip camera, etc on
> our platform, some applications was migrated from mmu arch. I think
> that means in some cases no-mmu arch is somewhat better than mmu arch.
> So we are taking effort to make the migration smooth or make no-mmu
> linux stronger.
> It's no way to let our customer modify their applications, we also
> unwilling to do it. And we have not an existing mechanism to set up a
> pools for the complex applications. So I'm trying to do some coding
> hack in the kernel to satisfy these kinds of requirement.

Oh, maybe you misunderstand the reserve pools idea: that is an entirely
kernel based solution where you can preallocate a large, contiguous
pool of memory at boot time which you can use to satisfy your nommu
higher order anonymous memory allocations.

This is something that will not get fragmented by pagecache, nor will
it get fragmented by any other page allocation, slab allocation. Tt is
a pretty good solution provided that you size the pool correctly for
your application's needs.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
