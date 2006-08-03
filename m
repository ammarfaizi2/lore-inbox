Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWHCJ4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWHCJ4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWHCJ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:56:16 -0400
Received: from web25815.mail.ukl.yahoo.com ([217.146.176.248]:33667 "HELO
	web25815.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932415AbWHCJ4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:56:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=QuV8scucabXXwMDvJeO/efkrY9JEO1MUdUP5yqM+zNeAiyFXRItp/XLxqSdZlZdlvSMgGu4jRMyHcKRYsBJGx5WgpRDbvTTvpCi3GMdN6OgK2lDRhgGKl9y6l7OhsMNhwCUDfFSGrq3uG8bMpVHVzPZhte1UqQe52ni1RdLHGkU=  ;
Message-ID: <20060803095615.27090.qmail@web25815.mail.ukl.yahoo.com>
Date: Thu, 3 Aug 2006 09:56:15 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : sparsemem usage
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44D0C671.7040709@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> When allocating we do not have a problem as we simply pull a free page 
> off the appropriately sizes free list.  Its when freeing we have an 
> issue, all the allocator has to work with is the page you are freeing. 
> As MAX_ORDER is >128K we can get to the situation where all but one page 
> is free.  When we free that page we then need to merge this 128Kb page 
> with its buddy if its free.   To tell if that one is free it has to look 
> at the page* for it, so that page* must also exist for this check to work.

Maybe in sparsemem code, we could mark a well chosen page as reserved if
the size of mem region is < MAX_ORDER. That way the buddy allocator
will never have to free a block of 128 KO...

> pfn_valid() will indeed say 'ok'.  But that is defined only to mean that 
> it is safe to look at the page* for that page.  It says nothing else 
> about the page itself.  Pages which are reserved never get freed into 
> the allocator so they are not there to be allocated so we should not be 
> refering to them.

wouldn't it be safer to mark these pages as "invalid" instead of "reserved"
with a special value stored in mem_map[] ?

> There are tradeoffs here.  The smaller the section size the better the 
> internal fragmentation will be.  However also the more of them there 
> will be, the more space that will be used tracking them, the more 
> cachelines touched with them.  Also as we have seen we can't have things 
> in the allocator bigger than the section size.  This can constrain the 
> lower bound on the section size.  Finally, on 32 bit systems the overall 
> number of sections is bounded by the available space in the fields 
> section of the page* flags field.

thanks for that.

> If your system has 256 1Gb sections and 1 128Kb section then it could 
> well make sense to have a 1GB section size or perhaps a 256Mb section 
> size as you are only wasting space in the last section.

> I read that as saying there was a major gap to 3Gb and then it was 
> contigious from there; but then I was guessing at the units :).

here is a updated version of my mapping, it should be clear now:

HOLE0: 0 - 3 Go
MEM1: 0xc000 0000 - 32 Mo
HOLE1: 0xc200 0000 - 224 Mo
MEM2: 0xd000 0000 - 8 Mo
HOLE2: 0xd080 0000 - 120 Mo
MEM3: 0xd800 0000 - 128 Ko
HOLE3: rest of mem

Francis



