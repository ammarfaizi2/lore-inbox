Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSFQAIk>; Sun, 16 Jun 2002 20:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316636AbSFQAIk>; Sun, 16 Jun 2002 20:08:40 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:22032 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316621AbSFQAIj>;
	Sun, 16 Jun 2002 20:08:39 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206170008.g5H08a0495705@saturn.cs.uml.edu>
Subject: Re: another new version of pageattr caching conflict fix for 2.4
To: ak@suse.de (Andi Kleen)
Date: Sun, 16 Jun 2002 20:08:36 -0400 (EDT)
Cc: ebiederm@xmission.com (Eric W. Biederman), ak@suse.de (Andi Kleen),
       andrea@suse.de (Andrea Arcangeli), bcrl@redhat.com (Benjamin LaHaise),
       linux-kernel@vger.kernel.org, richard.brunner@amd.com (Richard Brunner),
       mark.langsdorf@amd.com
In-Reply-To: <20020617013732.A14867@wotan.suse.de> from "Andi Kleen" at Jun 17, 2002 01:37:32 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

>> the same problems if the agp aperture was marked write-back, and the
>
> AGP aperture is uncacheable, not write-back.
>
>> memory was marked uncacheable.  My gut impression is to just make the
>> agp aperture write-back cacheable, and then we don't have to change
>> the kernel page table at all.  Unfortunately I don't expect the host
>
> That would violate the AGP specification.
>
>> bridge with the memory and agp controllers to like that mode,
>> especially as there are physical aliasing issues.
>
> exactly.

You can do whatever you want, as long as...

1. you have cache control instructions and use them
2. the bridge ignores the coherency protocol (no machine check)

Most likely you should make the AGP memory write-back
cacheable. This requires some care regarding cache lines,
but ought to be faster.

>>> Fixing the MTRRs is fine, but it is really outside the scope of my patch.
>>> Just changing the kernel map wouldn't be enough to fix wrong MTRRs,
>>> because it wouldn't cover highmem.
>>
>> My preferred fix is to use PAT, to override the buggy mtrrs.  Which
>> brings up the same aliasing issues.  Which makes it related but
>> outside the scope of the problem.
>
> I don't follow you here. IMHO it is much easier to fix the MTRRs in the
> MTRR driver for those rare buggy BIOS (if they exist - I've never seen one)
> than to hack up all of memory management just to get the right bits set.
> I see no disadvantage of using the MTRRs and it is lot simpler than
> PAT and pte bits.

For non-x86 one must "hack up all of memory management" anyway.

Example: There aren't any MTRRs on the PowerPC, but every page
has 4 memory type bits. It's not OK to map something more than
one way at the same time. Large "pages" (256 MB each) are used
to cover all of non-highmem physical memory.




