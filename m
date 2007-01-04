Return-Path: <linux-kernel-owner+w=401wt.eu-S1030240AbXADWSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbXADWSj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbXADWSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:18:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:25410 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030187AbXADWSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:18:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bEAwiSxYvTCIcshuokixoaHMwdr1OCx0c+82dxR3FY90FqGBhYNEMYAN3dYUGV5k/ofWmcpt2cgEZSZ9Ei/8xVbi1FT+Bf5HQ9YSokXVlWuRbIaUZOKdC9SwUN4jmk5cG/VSzQW6q8m6Hu0IUrBNDYhGVKZBriLBEZggwduaGuo=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: open(O_DIRECT) on a tmpfs?
Date: Thu, 4 Jan 2007 23:17:02 +0100
User-Agent: KMail/1.8.2
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com> <459D290B.1040703@tmr.com>
In-Reply-To: <459D290B.1040703@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701042317.02908.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 January 2007 17:19, Bill Davidsen wrote:
> Hugh Dickins wrote:
> In many cases the use of O_DIRECT is purely to avoid impact on cache 
> used by other applications. An application which writes a large quantity 
> of data will have less impact on other applications by using O_DIRECT, 
> assuming that the data will not be read from cache due to application 
> pattern or the data being much larger than physical memory.

But O_DIRECT is _not_ about cache. At least I think it was not about
cache initially, it was more about DMAing data directly from/to
application address space to/from disks, saving memcpy's and double
allocations. Why do you think it has that special alignment requirements?
Are they cache related? Not at all!

After that people started adding unrelated semantics on it -
"oh, we use O_DIRECT in our database code and it pushes EVERYTHING
else out of cache. This is bad. Let's overload O_DIRECT to also mean
'do not pollute the cache'. Here's the patch".

DB people from certain well-known commercial DB have zero coding
taste. No wonder their binaries are nearly 100 MB (!!!) in size...

In all fairness, O_DIRECT's direct-DMA makes is easier to implement
"do-not-cache-me" than to do it for generic read()/write()
(just because O_DIRECT is (was?) using different code path,
not integrated into VM cache machinery that much).

But _conceptually_ "direct DMAing" and "do-not-cache-me"
are orthogonal, right?

That's why we also have bona fide fadvise and madvise
with FADV_DONTNEED/MADV_DONTNEED:

http://www.die.net/doc/linux/man/man2/fadvise.2.html
http://www.die.net/doc/linux/man/man2/madvise.2.html

_This_ is the proper way to say "do not cache me".

I think tmpfs should just ignore O_DIRECT bit.
That won't require much coding.
--
vda
