Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWBBSDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWBBSDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 13:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWBBSDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 13:03:20 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:48114 "EHLO
	mail.shipmail.org") by vger.kernel.org with ESMTP id S1751148AbWBBSDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 13:03:19 -0500
Message-ID: <43E24958.2000609@tungstengraphics.com>
Date: Thu, 02 Feb 2006 19:03:04 +0100
From: =?UTF-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8)
 Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mprotect() resets caching policy
References: <43DA1166.4040700@tungstengraphics.com>
 <Pine.LNX.4.61.0602021612370.8207@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602021612370.8207@goblin.wat.veritas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Spam: No (0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>>However, I noticed that mprotect() will, when run on a non-cached VMA, reset
>>the caching policy. The line in mm/mprotect.c causing this problem is
>>
>>newprot = protection_map[newflags & 0xf];
>>
>>So a user could potentially run mprotect() and create a conflicting mapping
>>which presumably is bad for stability on some architectures.
>>    
>>
>
>Perhaps: I think it already depends on what the architecture does.
>newprot is used (a) to set vm_page_prot and (b) for use in pte_modify
>(which change_protection applies to each pte present).
>
>Now I think vm_page_prot is irrelevant to the kinds of VMA you are
>interested in?  It's essential to provide the permissions/protections
>when faulting a new page in, but your VMAs are fully managed by the
>driver, and have all ptes already in place?  So wouldn't use vm_page_prot.
>
>  
>
The strategy I use for changing the protection in currently a bit ugly, 
since it
1) Flushes caches.
2) Invalidates all relevant PTE entries
3) Changes the kernel mapping caching policy.
4) Flushes tlb
5) Relies on nopage() to get called to map the page with the new caching 
policy.
Here I must set vm_page_prot, since that it what is used for the newly 
mapped page.

>And pte_modify is implemented per-architecture: looking just at the
>i386 implementation, yes, _PAGE_CHG_MASK looks like it'll mask off
>the bits you understandably want it to retain.
>  
>
Yes. I've tried running mprotect() and it does indeed reset the caching 
policy.

>>Since mprotect() only deals with rwx protection. I figure replacing the above
>>with something like
>>
>>newprot = (vm_page_prot & ~MPROT_MASK) | (protection_map[newflags & 0xf] &
>>MPROT_MASK)
>>
>>Where MPROT_MASK is a arch-dependent mask identifying the bits available to
>>mprotect().
>>    
>>
>
>I think it's the per-architecture implementations of pte_modify that
>you need to adjust.
>  
>
Agreed. That would work unless also nopage() uses pte_modify to set the 
original caching policy. Then it will get masked away.

>It might be nice, but probably irrelevant, to have vm_page_prot maintained
>in a similar way.  Whether every arch can do that with a straightforward
>MPROT_MASK or _PAGE_CHG_MASK is not obvious to me: would more likely
>need a pte_modify-like macro to do it.
>
>But would that even be correct?  The same vm_page_prot would be applied
>also to anonymous COWed pages from the mapping.  Very exceptional in the
>case that interests you; but perhaps it's simpler to keep vm_page_prot
>just for the rwx part of it.
>  
>
I'm not sure it will work in my case, since the caching policy is a 
per-page attribute and I rely totally on nopage() to get called for 
every new page attached to a vma mapping the region.

>  
>
>>Alternatively, is there a way to disable mprotect() for a VMA?
>>    
>>
>
>Not at present.  It would be easier to add a VM_flag for that,
>than to correct every architecture's pte_modify.  I'm not sure
>whether "easier" amounts to "better" here.
>
>  
>
>>Finally, is there a chance to get protection_map[] exported to modules?
>>    
>>
>
>I very much doubt that.  Exporting a functional interface to it would
>be preferable; but even that, I think the core mm would strongly resist
>- the less of the pte business we export the better.  What were you
>wanting it exported for?
>
>  
>
When nopage() gets called, I set vm_page_prot to 

modify_for_caching( protection_map[vma-> vm_flags & 0x0f])

Again, since someone might have called mprotect() to change vm_flags and 
I can't rely on previous values of vm_page_prot since it's changing all 
the time.

Anyway, thanks for looking at this and if there is something I can do 
(patch maybe) to
correct this behaviour plese let me know.

/Thomas


>Hugh
>


