Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161489AbWAMHf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161489AbWAMHf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWAMHf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:35:28 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:41834 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932526AbWAMHf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:35:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SqxbcsjBXZ3z2Gfo1ZENNeEmXPaVU957v99wK0+zt+9bbUrVg90xKtstIDx1D6RT9wDn8xcZy2Vl1TkeaxwkOBCj8gO2C/w4yoVfnuLGMKN6JnIMf8UN+kzj6TlGLPNCpvemy0TzgzxVUMlAbEuQEDno4aWq53lNl4TaVYxwAPY=  ;
Message-ID: <43C75834.3040007@yahoo.com.au>
Date: Fri, 13 Jan 2006 18:35:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org> <20051213211441.GH3092@opteron.random> <20051216135147.GV5270@opteron.random> <20060110062425.GA15897@opteron.random> <43C484BF.2030602@yahoo.com.au> <20060111082359.GV15897@opteron.random> <20060111005134.3306b69a.akpm@osdl.org> <20060111090225.GY15897@opteron.random> <20060111010638.0eb0f783.akpm@osdl.org> <20060111091327.GZ15897@opteron.random> <Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 11 Jan 2006, Andrea Arcangeli wrote:
> 
>>On Wed, Jan 11, 2006 at 01:06:38AM -0800, Andrew Morton wrote:
>>
>>>Confused.  do_no_page() doesn't have a page to lock until it has called
>>>->nopage.
>>
>>yes, I mean doing lock_page after ->nopage returned it here:
>>
>>	lock_page(page);
>>	if (mapping && !page->mapping)
>>		goto bail_out;
>>	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
>>[..]
>>			page_add_file_rmap()
>>			unlock_page()
> 
> 
> I've rather chosen this mail at random from the thread, and can't
> come up with better than a few random remarks on it all, sorry.
> 
> Though using lock_page may solve more than one problem, without seeing
> a full implementation I'm less sure than the rest of you that it will
> really do the job.
> 
> And less confident than you and Nick that adding a sleeping lock here
> in nopage won't present a scalability issue.  Though it gives me a
> special thrill to see Nick arguing in favour of extra locking ;)
> 

I argue in favour of extra locking simply because the concept doesn't
fundamentally harm scalability ie. because it is very short held and
there are other unavoidable cacheline conflicts already there.

Having it a sleeping lock rather than spinning is another thing though.
However unless you imagine it running into other long held page lockers
(I guess reclaim might be one, but quite rare -- any other significant
lock_page users that we might hit?), then I don't think it would impact
scalability much on workloads that don't already hurt.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
