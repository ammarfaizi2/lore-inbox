Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261974AbSJOAMa>; Mon, 14 Oct 2002 20:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSJOAMa>; Mon, 14 Oct 2002 20:12:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:45497 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261974AbSJOAM3>; Mon, 14 Oct 2002 20:12:29 -0400
Message-ID: <3DAB5DF2.5000002@us.ibm.com>
Date: Mon, 14 Oct 2002 17:14:42 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
References: <3DA4D3E4.6080401@us.ibm.com> <m165w6m12t.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Matthew Dobson <colpatch@us.ibm.com> writes:
>>Greetings & Salutations,
>>	Here's a wonderful patch that I know you're all dying for...  Memory
>>Binding!  It works just like CPU Affinity (binding) except that it binds a
>>processes memory allocations (just buddy allocator for now) to specific memory
>>blocks.
> Due we want this per numa area or simply per zone?  My suspicion is that
> internally at least we want this per zone.
I think that per memory block is better.  We already have a method for 
allocating from specific zones (GFP_* flags).  Also, using per zone 
binding would involve setting up some way of enumerating the zones, 
which would not be immediately obvious to the users of the API.  The 
memory block already has a straight-forward definition and an easy way 
for users to get the appropriate number for the appropriate block 
(in-kernel topology).  I'm not fanatically opposed to per zone binding, 
though, and if there is a general agreement that it would be better that 
way, I don't think it would be unreasonably difficult to change it.

> The API doesn't make much sense at the moment.
Hmm..  That is unfortunate, I'd aimed to make it as simple as possible.

> 1) You are operating on tasks and not mm's, or preferably vmas.
Correct.  There are plans (somewhere inside my cranium) to allow binding 
at that granularity.  For now, per task seemed an appropriate level.

> 2) sys_mem_setbinding does not move the mm to the new binding.
Also correct.  A task may wish to allocate several large data structures 
from one memory area, rebind, do more allocations, rebind, ad nauseum. 
There are plans to have a flag that, if set, would force relocation of 
all currently allocated memory.

> 3) You specify a pid and then change current task instead of
>    the specified one.
Yep... That was definitely a typo...  fixed.

> 4) An ordered zone list is probably the more natural mapping.
See my comments above about per zone/memblk.  And you reemphasize my 
point, how do we order the zone lists in such a way that a user of the 
API can easily know/find out what zone #5 is?

> 5) mprotect is the more natural model rather than set_cpu_affinity.
Well, I think that may be true for the API you are imagining (per zone, 
per mm/vma, etc), not the one that I've written.

> 6) The code belongs in mm/* not kernel/*
Possibly...  I just stuck it in with the vast majority of other syscalls 
in kernel/sys.c.  As those changes are just code additions, they can 
easily be moved if it is deemed appropriate.

Cheers!

-Matt

