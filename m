Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTDEDeI (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 22:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTDEDeI (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 22:34:08 -0500
Received: from franka.aracnet.com ([216.99.193.44]:38033 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261754AbTDEDeG (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 22:34:06 -0500
Date: Fri, 04 Apr 2003 19:45:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <8390000.1049514313@[10.10.2.4]>
In-Reply-To: <20030405024414.GP16293@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm not convinced that we can't do something with nonlinear mappings for
>> this ... we just need to keep a list of linear areas within the nonlinear
>> vmas, and use that to do the objrmap stuff with. Dave and I talked about
>> this yesterday ... we both had different terminology, but I think the
>> same underlying fundamental concept ... I was calling them "sub-vmas"
>> for each linear region within the nonlinear space. 
> 
> that's wasted memory IMHO, if you need nonlinear, you don't want to
> waste further metadata, you only want to pin pages in the pagetables,
> the 'window' over the pagecache (incidentally shm)
> 
> the vm shouldn't know about it.

OK, but this is only for the case when the things aren't memlocked anyway,
which in Oracle's case is never. Seems like we're thrashing a lot of time
and effort over sys_remap_file_pages considering it's never actually
desirable to scan the chains for pageout anyway.

And does anyone *really* start off with a linear vma and them convert
it to a linear one after using it? Can't we just fail that call? Would
result in orders of magnitude of reduction in complexity if we could
just narrow the scope of this beastie a bit.

If you have a *non-memlocked* VMA that you've *previously used* as linear,
then the sys_remap_file_pages stuff would fail with an error code. Is 
that too painful? Maybe you can't "un-memlock" a non-linear VMA once
it's memlocked either. I'm quite possibly missing something but if someone
could point out what that is ... ?

>> The fundamental problem I came to (and I think Dave had the same problem) 
>> is that I couldn't see what problem remap_file_pages was trying to solve,
> 
> Oh that's clear, it's only the avoidance of the mmap calls that walks
> the rbtree with many vmas allocated. Which is another reason for not
> having any kind of metadata associated with the pages attached to the
> nonlinear vma. Taking a linearity inside the non-linearity sounds
> not worthwhile.

Well, it's an order of magnitude less expensive than mem_map still.
No, not perfect, but the world's a compromise ;-) And we don't need
this at all for memlocked ones.
 
>> eh? Not sure what you mean by that. It helped massively ...
>> diffprofile from kernbench showed:
> 
> Indeed. objrmap is the only way to avoid the big rmap waste. Infact I'm
> not even convinced about the hybrid approch, rmap should be avoided even
> for the anon pages. 

Right, but they seem to be mostly singletons (non-shared), so the 
pte_direct stuff takes care of those mostly anyway. Would be nice eventually,
but I thinking taking one step at a time is maybe helpful ;-)

M
