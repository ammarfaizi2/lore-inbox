Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVJKOht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVJKOht (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVJKOht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:37:49 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:24729 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932068AbVJKOht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:37:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AurotL6t8Ry6BpfIkQjuomq36BOUU1xIiBw7+WFzexxPqnoSZZQE7dNONQn0yoaP6cU2U4uOAp162uAvQYl+G3U1l7Y3861LQgqpYS9yfzkbc5W9l5o5KBc0p6DOqa3aFyloIP82Lzw2cJaPTrCAZNbAZh3MZKHEtKF0Yxb9a5c=  ;
Message-ID: <434BCDF5.2080707@yahoo.com.au>
Date: Wed, 12 Oct 2005 00:36:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rc2-mm2] core remove PageReserved
References: <434B7F19.5040808@yahoo.com.au> <1129035883.23677.48.camel@localhost.localdomain> <434BC095.4050305@yahoo.com.au> <Pine.LNX.4.61.0510111454530.2950@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0510111454530.2950@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 11 Oct 2005, Nick Piggin wrote:
> 
>>Alan Cox wrote:
>>
>>>32000 processes each with 2G mapped as zero pages appears to allow the
>>>refcount to overflow ?
>>
>>That's right (though I count only 8192 required with 4K page size) -
>>close to impossible on 32-bit architectures, though not so the 64-bit
>>ones, which still use 32-bits for count and mapcount.
> 
> 
> It needs 16GB of page table space to get the mapcount to go negative,
> or if we refine the atomic_add_negative test, 32GB of page table space
> to wrap (I'm assuming an 8-byte PAE page table entries for each unit
> of mapcount, since we're well beyond the 4GB non-PAE limit).
> 
> Do we actually need to worry about i386 above 32GB in the x86_64 era?
> 

Considering we already run on 64-bit systems with terabytes of
memory and people don't seem to be breaking down your door for
a fix (that I know of), I'd say no :)

> 
>>I was a bit worried about this too, but Hugh didn't think it was a
>>really big a deal - I guess because the real solution for the refcount
>>overflow on 64-bit is to expand the refcount type.
> 
> 
> Yes, and I'm imagining some scheme of sharing _count and _mapcount in
> a single atomic64, since we don't want to expand struct page for this.
> Implement that shortly, unless we find a way to eliminate _mapcount
> instead.
> 
> But Alan's overflow issue is not new, it's not brought on refcounting
> the ZERO_PAGE: sys_remap_file_pages already allows a file page to be
> mapped multiple times in single process, without the constriction of
> needing lots of vm_area_struct space.  ZERO_PAGE is just more obvious.
> 

Right. As a security issue it is nothing new, though probably it will
be eaiser for big 64-bit systems to _unintentionally_ wrap the ZERO_PAGE
refcount.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
