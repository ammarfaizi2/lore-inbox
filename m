Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWDZU2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWDZU2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWDZU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:28:39 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:8313 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964868AbWDZU2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:28:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=diEjBElmOlZk7bVukJ0WeH538rcL/szpbKiZnqHhzmog8+1NqM7Gor45C/DmGSyTKfryvvBIL1zgAcYmOe2+2SgMx40hyf9TSbX2HFDOY8px5VYgIsN+rxIUcO07NOzf9I9y/LUn2ZCZhm9RvkEDdtrg3Y3+Vgpn/He0w8+YsqA=  ;
Message-ID: <444F98B2.8020003@yahoo.com.au>
Date: Thu, 27 Apr 2006 01:58:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: Hugh Dickins <hugh@veritas.com>, Jan Beulich <jbeulich@novell.com>,
       Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
References: <444F95D8.76E4.0078.0@novell.com> <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com> <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk>
In-Reply-To: <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> 
> On 26 Apr 2006, at 15:46, Hugh Dickins wrote:
> 
>> If that's so (I don't trust my judgement on matters of speculative
>> execution), then I think you'd do better to replace the *ptep = __pte(0)
>> by pte_clear(mm, addr, ptep), and so avoid your ugly #ifdef'ing: please
>> check, but I think you'll find that reduces to just the barrier you want.
>> CC'ed Zach since it's his optimization, and he'll judge that spexecution.
> 
> 
> In more detail the problem is that, since we're still running on the 
> page tables while clearing them, the CPU may choose to prefetch a 
> half-cleared pte into its TLB, and then execute speculative memory 
> accesses based on that mapping (including ones that may write-allocate 
> cachelines, leading to problems like the AMD AGP GART deadlock Linux had 
> a year or so back).

What do you mean, you're still running on the page tables? The CPU can
still walk the pagetables?

Because if ptep_get_and_clear_full is passed non zero in the full
argument, then that specific translation should never see another
access. I didn't know CPUs now actually resolve TLB misses as part of
speculative prefetching... does this really happen?

Do you have a pointer to where the AMD AGP GART deadlock was discussed?
Google is having some trouble finding it.

> 
> The barrier is needed to ensure that the bottom half is cleared before 
> the top half. In fact it probably ought to be wmb() -- that's clearer in 
> intent and actually reduces to barrier() on all PAE-capable platforms.

I think barrier is correct there.

The full argument means that the mm is being torn down and we are the
last thread in the mm. So these pagetables can't be visible to other CPUs,
can they?

> 
> We cannot use pte_clear() unless we redefine it for PAE. Currently it 
> reduces to set_pte() which explicitly uses the wrong ordering (sets high 
> *then* low, because it's normally used to introduce a mapping).

Presumably you would redefine it for PAE also (in this case you may
actually need an smp_wmb rather than just barrier).

Unless you can explain why this is a problem and not the other pte_clear
callers.

> 
> Also, I think wmb() should be used in PAE's set_pte(), rather than the 
> current smp_wmb(). They reduce to the same thing, but wmb() makes it 
> clear this is is not an issue specific to SMP systems.

That is what smp_wmb() means. wmb() means it should also order io memory.
Clear as mud?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
