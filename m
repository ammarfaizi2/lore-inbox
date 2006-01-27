Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWA0WvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWA0WvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWA0WvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:51:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:24041 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422651AbWA0Wu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:50:56 -0500
Message-ID: <43DAA3C9.9070105@us.ibm.com>
Date: Fri, 27 Jan 2006 16:50:49 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0601202020001.8821@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>On Thu, 5 Jan 2006, Dave McCracken wrote:
>  
>
>>Here's a new version of my shared page tables patch.
>>
>>The primary purpose of sharing page tables is improved performance for
>>large applications that share big memory areas between multiple processes.
>>It eliminates the redundant page tables and significantly reduces the
>>number of minor page faults.  Tests show significant performance
>>improvement for large database applications, including those using large
>>pages.  There is no measurable performance degradation for small processes.
>>
>>This version of the patch uses Hugh's new locking mechanism, extending it
>>up the page table tree as far as necessary for proper concurrency control.
>>
>>The patch also includes the proper locking for following the vma chains.
>>
>>Hugh, I believe I have all the lock points nailed down.  I'd appreciate
>>your input on any I might have missed.
>>
>>The architectures supported are i386 and x86_64.  I'm working on 64 bit
>>ppc, but there are still some issues around proper segment handling that
>>need more testing.  This will be available in a separate patch once it's
>>solid.
>>
>>Dave McCracken
>>    
>>
>
>The locking looks much better now, and I like the way i_mmap_lock seems
>to fall naturally into place where the pte lock doesn't work.  But still
>some raciness noted in comments on patch below.
>
>The main thing I dislike is the
> 16 files changed, 937 insertions(+), 69 deletions(-)
>(with just i386 and x86_64 included): it's adding more complexity than
>I can welcome, and too many unavoidable "if (shared) ... else ..."s.
>With significant further change needed, not just adding architectures.
>
>Worthwhile additional complexity?  I'm not the one to judge that.
>Brian has posted dramatic improvments (25%, 49%) for the non-huge OLTP,
>and yes, it's sickening the amount of memory we're wasting on pagetables
>in that particular kind of workload.  Less dramatic (3%, 4%) in the
>hugetlb case: and as yet (since last summer even) no profiles to tell
>where that improvement actually comes from.
>
>  
>
Hi,

We collected more granular performance data for the ppc64/hugepage case.

CPI decreased by 3% when shared pagetables were used.  Underlying this was a
7% decrease in the overall TLB miss rate.  The TLB miss rate for hugepages
decreased 39%.  TLB miss rates are calculated per instruction executed.

We didn't collect a profile per se, as we would expect a CPI improvement
of this nature to be spread over a significant number of functions,
mostly in user-space.

Cheers,
Brian


