Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWDEJJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWDEJJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDEJJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:09:48 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:25484 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751182AbWDEJJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:09:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=EUnXm4eWCcg90twpYG4dSeD3BsN7sBu2NK+/PvcfMWsbifeQfSnMKdS0sLBJI6/+bvlGEWz1qNU8WnPD5HzZULnV14Uj8zp2LZl1ReEjkfcemZUk94VXZ5aVj4mMpg+YbEIWQGKlOjbn7ZECne7AMSV9zFB9rLShs//p4p43ftw=  ;
Message-ID: <4432530A.70606@yahoo.com.au>
Date: Tue, 04 Apr 2006 21:05:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq01wwdppyc.fsf@jaguar.mkp.net>
In-Reply-To: <yq01wwdppyc.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Hi,
> 
> Ingo Oeser suggested reorganizing the hangle_pte_fault code in a way
> that simplifies the code deciding which fault handler to call. It
> makes the call to ->nopfn and ->nopage a lot clearer.
> 

Probably doesn't make much difference, but I'd rather do the nopage
check first, as that will obviously be the most common.

> It doesn't address Nick's suggestion as whether to recheck for someone
> else faulting it as I didn't see a consensus on that yet.
> 

I first thought this might be a good idea because some archs have a
pretty heavy-weight set_pte_at (eg. powerpc, which is even heavier if
it is to replace an existing entry). This is not going to be very
common, but there have been cases where multiple threads all try to
fault in a particular page, which has caused performance problems.

Other than that, you never know what a nopfn handler will want to do,
so I think it is better to be consistent with other faults. Shouldn't
need much more than a `if (pte_none()) { /* do it */ }`.

> Updated patch attached.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
