Return-Path: <linux-kernel-owner+w=401wt.eu-S932807AbXATCZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807AbXATCZN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 21:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932844AbXATCZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 21:25:13 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:47057 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932807AbXATCZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 21:25:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ENl0HjkXpnQ0n3GbwjUXbJY9XDtQwQgFg4C14RuK6vKvwYTQ+bE8TSjtvSbs1GfZDynOepelYxEmDsE5vSWepoq5PPEccw/dJWG9VKMty4js13uocxF2fJHXocVXMEuRuQw82uc5RTlIslHxtvfZ4I109KzBReYXCGdkeG+YI88=  ;
X-YMail-OSG: FzZInEIVM1kwCb9znpQoWroPF.WrInFNbP3I9V82qpJXk3Wai.sIWGAKPiQukw5BqsdmLBfZuJhtXslShHdwvuBt.1SGGukCSDZ056EX_x5xPMo7Fmo-
Message-ID: <45B17D6D.2030004@yahoo.com.au>
Date: Sat, 20 Jan 2007 13:24:45 +1100
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
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>	 <45B0DB45.4070004@linux.vnet.ibm.com>	 <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>	 <45B112B6.9060806@linux.vnet.ibm.com> <6d6a94c50701191804m79c70afdo1e664a072f928b9e@mail.gmail.com>
In-Reply-To: <6d6a94c50701191804m79c70afdo1e664a072f928b9e@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey Li wrote:
> On 1/20/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:

>> If pagecache is overlimit, we expect old (cold) pagecache pages to
>> be thrown out and reused for new file data.  We do not expect to
>> drop a few text or data pages to make room for new pagecache.
>>
> Well, actually I think this probably not necessary. Because the
> reclaimer has no way to predict the behavior of user mode processes,
> how do you make sure the pagecache will not be access again in a short

It is not about predicting behaviour, it is about directing the reclaim
effort at the actual resource that is under pressure.

Even given a pagecache limiting patch which does the proper accounting
to keep pagecache pages under a % limit (unlike yours), kicking off an
undirected reclaim could (in theory) reclaim all slab and anonymous
memory pages before bringing pagecache under the limit. So I think
you need to be a bit more thorough than just assuming everything will
be OK. Page reclaim behaviour is pretty strange and complex.

Secondly, your patch isn't actually very good. It unconditionally
shrinks memory to below the given % mark each time a pagecache alloc
occurs, regardless of how much pagecache is in the system. Effectively
that seems to just reduce the amount of memory available to the system.

Luckily, there are actually good, robust solutions for your higher
order allocation problem. Do higher order allocations at boot time,
modifiy userspace applications, or set up otherwise-unused, or easily
reclaimable reserve pools for higher order allocations. I don't
understand why you are so resistant to all of these approaches?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
