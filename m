Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135194AbRDLNyo>; Thu, 12 Apr 2001 09:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135196AbRDLNyf>; Thu, 12 Apr 2001 09:54:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6572 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135194AbRDLNyW>;
	Thu, 12 Apr 2001 09:54:22 -0400
Date: Thu, 12 Apr 2001 09:54:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Marcin Kowalski <kowalski@datrix.co.za>
cc: davem@redhat.com, jgarzik@mandrakesoft.com, adilger@turbolinux.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [CFT][PATCH] Re: Fwd: Re: memory usage - dentry_cache
In-Reply-To: <01041214272403.11986@webman>
Message-ID: <Pine.GSO.4.21.0104120931510.19944-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Marcin Kowalski wrote:

> Hi
> 
> Regarding the patch ....
> 
> I don't have experience with the linux kernel internals but could this patch 
> not lead to a run-loop condition as the only thing that can break our of the 
> for(;;) loop is the tmp==&dentry_unused statement. So if the required number 
> of dentries does not exist and this condition is not satisfied we would have 
> an infinate loop... sorry if this is a silly question.

Nope. Notice that "warned" dentries are not killed, but they are returned
to the list. If we meet them again - they are goners.

More formally, on each iteration you either decrement count or you
decrement the number of dentries that have DCACHE_REFERENCED. count
can't grow at all.  Number of dentries with DCACHE_REFERENCED can't grow
unless you release dcache_lock, which happens only in the branch that
decrements count. I.e. loop does terminate.

> Also the comment >/* If the dentry was recently referenced, don't free it. 
> */<, the code inside is excuted if the DCACHE_REFERENCED flags are set and in 
> the code is is reversing the DCACHE_REFERENCED flag on the dentry and adding 
> it to the dentry_unsed list??? So a Refrenched entry is set Not Referenced 
> and place in the unsed list?? I am unclear about that... is the comment 
> correct or is my understanding lacking (which is very probable :-))..

"referenced" as in "had been found by d_lookup, don't shoot me at sight".
When prune_dcache() picks it up it moves the thing on the other end of list
and removes the mark. Caught twice - too bad, it will be freed.
								Al

