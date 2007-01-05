Return-Path: <linux-kernel-owner+w=401wt.eu-S1030335AbXAEFa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbXAEFa4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 00:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbXAEFa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 00:30:56 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:35341 "HELO
	smtp103.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030335AbXAEFa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 00:30:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=il7QAzRZR3Vnaz95zs2WrcEoIr736b+FDj8Qb28AocWG1C2+t/v3MxGMynYzIm8g6f0plHzUMqThzWidl+2/2HFHCEpI2uZbIuR3oYpEY6EO++Za2mNZSNfFBROT23XiXdzbVZP9PSB1IDud0QjsBNKvDRzLoj9758sWuw3aDG4=  ;
X-YMail-OSG: sbC0sjcVM1kaE5SGoW6CyW1Y2iUuUX.Z0wYSvuw_tp6mCuGeQrEw17liDyAUq2v0D7YEe9ePIGjvEnWbR0iOd3h_OdwZPGQqbPRVAgSuoI.PIGNVay7IjccoCkycTSKq9U8ADxuGgpa_Jn8uVsSBacauRtPDgRxCIsYRvouofsih7OPd8RNYPNnx95A5
Message-ID: <459DE26F.4040103@yahoo.com.au>
Date: Fri, 05 Jan 2007 16:30:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Bill Davidsen <davidsen@tmr.com>, Hugh Dickins <hugh@veritas.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com> <459D290B.1040703@tmr.com> <200701042317.02908.vda.linux@googlemail.com>
In-Reply-To: <200701042317.02908.vda.linux@googlemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Thursday 04 January 2007 17:19, Bill Davidsen wrote:
> 
>>Hugh Dickins wrote:
>>In many cases the use of O_DIRECT is purely to avoid impact on cache 
>>used by other applications. An application which writes a large quantity 
>>of data will have less impact on other applications by using O_DIRECT, 
>>assuming that the data will not be read from cache due to application 
>>pattern or the data being much larger than physical memory.
> 
> 
> But O_DIRECT is _not_ about cache. At least I think it was not about
> cache initially, it was more about DMAing data directly from/to
> application address space to/from disks, saving memcpy's and double
> allocations. Why do you think it has that special alignment requirements?
> Are they cache related? Not at all!

I don't know whether that is the case. The two issues are related -- the
IO is be done zero-copy because there is no cache involved, and due to
there being no cache, there are alignment restrictions.

I think IRIX might have implemented O_DIRECT first, and although the
semantics are a bit vague, I think it has always been to do zero copy
IO _and_ to bypass cache (ie. no splice-like tricks).

> After that people started adding unrelated semantics on it -
> "oh, we use O_DIRECT in our database code and it pushes EVERYTHING
> else out of cache. This is bad. Let's overload O_DIRECT to also mean
> 'do not pollute the cache'. Here's the patch".

It is because they already do their own caching, so going through
another, dumber, cache of same or less size (the pagecache) is useless.
fadvise does not change that.

That said, tmpfs's page are not really a cache (except when they are
swapcache, but let's not complicate things). So O_DIRECT on tmpfs
may not exactly be wrong.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
