Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVH3Bom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVH3Bom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVH3Bom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:44:42 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:48308 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750722AbVH3Bol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:44:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=I8xV8+OVIQkzsXYjRlsNVsB94f+pLNGSej+vsUzyPoDa87CuecmOvmyjwbrEqT8B7Jg5iGCLMSdMh+GYtFdNz9piuuaeIaXIp/uXbGu1+bGKthTieBG/aKesAcyjSZ8nFDoAH5/a6FpsrQMbmObQCDyBQwIRKlYJUx9RUa8mwPE=  ;
Message-ID: <4313AEC9.3050406@yahoo.com.au>
Date: Tue, 30 Aug 2005 10:56:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sonny Rao <sonnyrao@us.ibm.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
References: <1125159996.5159.8.camel@mulgrave> <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave> <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave> <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave> <4312830C.8000308@yahoo.com.au> <20050829164144.GC9508@localhost.localdomain>
In-Reply-To: <20050829164144.GC9508@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:

>On Mon, Aug 29, 2005 at 01:37:48PM +1000, Nick Piggin wrote:
>
>>s/common/only ?
>>
>>But the page tree is indexed by file offset rather than virtual
>>address, and we try to span the file's pagecache with the smallest
>>possible tree. So it will tend to make the trees taller.
>>
>>
>
>I did some experiments with different map-shift values,
>interestingly overall read throughput didn't change much but the
>cpu-utilization of radix_tree_lookup (from oprofile) changed quite a
>bit, especially in the case of MAP_SHIFT == 4 :  
>
>http://www.linuxsymposium.org/2005/linuxsymposium_procv2.pdf 
>
>Look on page 80, where I have the table.
>
>

Nice. So we can see that 6 is a pretty good choice of shift,
4 is too low. That doesn't tell us much about 5, but if you
fit the curve, 5 should be between 14 and 15 ... so getting
expensive.

Of course, different systems and different workloads will
be different. But I'd be wary of going below 6 unless there
is a good reason.

>>I'm curious: what do the benchmarks say about your gang lookup?
>>
>
>Gang-lookup isn't used in the page-cache lookups presently, so I'm
>not sure why optimizing it is very important -- unless someone is
>planning on implementing gang-lookups for page-cache reads. This would
>also cut down on number times a lock is taken and released (expensive,
>in the case of rwlock).  Perhaps there is another reason?
>
>

Gang lookup is mainly used on IO paths but also on truncate,
which is a reasonably fast path on some workloads (James,
this is my suggestion for what you should test - truncate).

>I actually talk about this a little bit at the end of the paper as
>well. I think gang-lookup when readahead has been turned off is
>potentially a good way to go, since we are fairly confident that all
>the pages are in the cache, unfortunately I haven't had (and probably
>won't) have any time to implement it. 
>
>

It is fairly difficult to do gang lookups in the cached cases,
but probably not impossible. But the code around there is already
probably as complicated as we would want it to be, so it would be
nice if it could be cleaned up first (or maybe it is already as
simple as possible :( ).

>Of course, if we go the lockless path it's much less important.
>
>

Yep, that's what I'm thinking. The lockless patches I have can do
lockless gang lookup and use it for truncate. It should be usable
in the same way as the current locked gang lookup is.

But of course gang lookup is only useful if a single read() call
asks for more than 1 page - is that a performance critical path?

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
