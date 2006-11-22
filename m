Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755616AbWKVKCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbWKVKCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620AbWKVKCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:02:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:52578 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755616AbWKVKCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:02:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sCSbOREtaOU127XeVlTH7xq7xup66t7IW5M7PVDzkUkPRRLPg809R4Z3Ib+CxiBnEabkOdConJndQ8rvwbyN++5KAxwMriACU9t+DVR/DVA6NdZf20fYvCYUpkBi6wVEpnO1To2QMcuxvfxhBPrUdKcTlqnIhuCI2+ozRT5jcug=
Message-ID: <6d6a94c50611220202t1d076b4cye70dcdcc19f56e55@mail.gmail.com>
Date: Wed, 22 Nov 2006 18:02:30 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: The VFS cache is not freed when there is not enough free memory to allocate
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1164185036.5968.179.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50611212351if1701ecx7b89b3fe79371554@mail.gmail.com>
	 <1164185036.5968.179.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> Please see the
> threads on Mel Gorman's Anti-Fragmentation and Linear/Lumpy reclaim in
> the linux-mm archives.
>

Thanks to point this. Is it already included in Linus' git tree?

> > The patch drop the page cache and slab and then give a new chance to
> > get more free pages. Applied this patch, my test application can
> > allocate memory sucessfully and drop the cache and slab as well. See
> > below:
> > ================================
> > root:/mnt> ./t
> > Alloc 8 MB !
> > alloc successful
>
> Pure luck, there are workloads where there just would not have been any
> order 9 contiguous block freeable (think where each 9th order block
> would contain at least one active inode).
>
> > I know performance is important for linux, and VFS cache obviously
> > improve the performance when implement file operation. But for
> > embedded system, we'll try our best to make the application executable
> > rather than hanging system to guarantee the system performance.
> >
> > Any suggestions and solutions are really appreciated!
>
> Try Mel's patches and wait for the next Lumpy reclaim posting.
>
> The lack of a MMU on your system makes it very hard not to rely on
> higher order allocations, because even user-space allocs need to be
> physically contiguous. But please take that into consideration when
> writing software.

Well, the test application just use an exaggerated way to replicate the issue.

Actually, In the real work, the application such as mplayer, asterisk,
etc will run into
the above problem when run them at the second time. I think I have no
reason to modify those kind of applications.

My patch let kernel drop VFS cache in the low memory situation when
the application requests more memory allocation, I don't think it's
luck. You know, the application just wants to allocate 8
1Mbyte-blocks(order =9) and releasing VFS cache we can get almost
50Mbyte free memory.

The patch indeedly enabled many failed test cases on our side. But
yes, I don't think it's the final solution. I'll try Mel's patch and
update the results.

Thanks,
-Aubrey
