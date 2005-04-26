Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVDZCV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVDZCV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 22:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDZCV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 22:21:28 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:46237 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261278AbVDZCVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 22:21:23 -0400
Message-ID: <426DA58F.3020508@ammasso.com>
Date: Mon, 25 Apr 2005 21:21:03 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Roland Dreier <roland@topspin.com>, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com>	<20050423194421.4f0d6612.akpm@osdl.org>	<426BABF4.3050205@ammasso.com>	<52is2bvvz5.fsf@topspin.com>	<20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com>	<20050425151459.1f5fb378.akpm@osdl.org>	<426D6D68.6040504@ammasso.com>	<20050425153256.3850ee0a.akpm@osdl.org>	<52vf6atnn8.fsf@topspin.com>	<20050425171145.2f0fd7f8.akpm@osdl.org>	<52acnmtmh6.fsf@topspin.com> <20050425173757.1dbab90b.akpm@osdl.org>
In-Reply-To: <20050425173757.1dbab90b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> RLIMIT_MEMLOCK sounds like the appropriate mechanism.  We cannot rely upon
> userspace running mlock(), so perhaps it is appropriate to run sys_mlock()
> in-kernel because that gives us the appropriate RLIMIT_MEMLOCK checking.

I don't see what's wrong with relying on userspace to call mlock().  First all, all RDMA 
apps call a third-party API, like DAPL or MPI, to register memory.  The memory needs to be 
registered in order for the driver and adapter to know where it is.  During this 
registration, the memory is also pinned.  That's when we call mlock().

> 
> However an hostile app can just go and run munlock() and then allocate
> some more pinned-by-get_user_pages() memory.

Isn't mlock() on a per-process basis anyway?  How can one process call munlock() on 
another process' memory?

> umm, how about we
> 
> - force the special pages into a separate vma
> 
> - run get_user_pages() against it all
> 
> - use RLIMIT_MEMLOCK accounting to check whether the user is allowed to
>   do this thing
> 
> - undo the RMLIMIT_MEMLOCK accounting in ->release

Isn't this kinda what mlock() does already?  Create a new VMA and then VM_LOCK it?

> This will all interact with user-initiated mlock/munlock in messy ways. 
> Maybe a new kernel-internal vma->vm_flag which works like VM_LOCKED but is
> unaffected by mlock/munlock activity is needed.
> 
> A bit of generalisation in do_mlock() should suit?

Yes, but do_mlock() needs to prevent pages from being moved during memory hotswap.
