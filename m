Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTA0Vre>; Mon, 27 Jan 2003 16:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTA0Vre>; Mon, 27 Jan 2003 16:47:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:22974 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263321AbTA0Vr3>;
	Mon, 27 Jan 2003 16:47:29 -0500
Message-ID: <3E35AAE4.10204@us.ibm.com>
Date: Mon, 27 Jan 2003 13:55:48 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: kexec reboot code buffer
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
>>On my system, it appears to lock up in:
>>kimage_alloc_reboot_code_pages()
>>after the kexec -l.
> 
> 
> O.k. It should come out of it eventually from what I have
> seen described, the current algorithm is definitely inefficient on
> your machine.

It does appear to completely hang in the free loop.  Something funny is
happening there.  I'll try to provide more details later.  BTW, do you
mind updating your patches for 2.5.59?  I'm having some other problems
and I want to make sure it isn't my bad merging that's at fault :)

> And being able to allocate from 3GB instead of just 1GB is
> much more polite.  The question then is how do I specify the zones
> properly.

Actually, I think that using lowmem is OK.  The machine is going away
soon anyway, and the necessary memory is a very small portion,
especially on a machine with this much RAM.

>>What you want is RAM with physical addresses <3GB, right?
> 
> In this case, and then later I want to allocate from physical
> addresses < 4GB.  The rest of the allocations will suffer
> from the same problem on the NUMA-Q.
> 
> The problem is that I have not figured out how to tell the memory
> allocator just what I need, 
<snip>
> I guess I would make the standard zones something like:
> /*
>  * ZONE_DMA	  < 16 MB	ISA DMA capable memory
>  * ZONE_NORMAL  16-896 MB	direct mapped by the kernel
>  * ZONE_PHYSMEM 896-4096 MB	memory that is accessible with the
>                               MMU disabled.
>  * ZONE_HIGHMEM > 4096MB      only page cache and user processes
>  */

I think this might be overkill.  ZONE_NORMAL gives you what you want,
and I don't think it's worth it to introduce a new one just for the
relatively short timespan where you have the new kernel loaded, but
haven't actually shut down.  I think a little comment next to the
allocation explaining this will be more than enough.

Martin, any ideas?
-- 
Dave Hansen
haveblue@us.ibm.com

