Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTK0IbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbTK0Iax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:30:53 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:18174 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S264451AbTK0Iao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:30:44 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Robert White <rwhite@casabyte.com>,
       "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Florian Weimer'" <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Date: Thu, 27 Nov 2003 01:15:19 -0800 (PST)
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <3FC5A7F0.8080507@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0311270106430.6400@dlang.diginsite.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com>
 <3FC5A7F0.8080507@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003, Nick Piggin wrote:

> Robert White wrote:
>
> >(Among the other N objections, add things like the lack of any sort of
> >control or option parameters)
> >...
> >N += 1: Sparse Copying (e.g. seeking past blocks of zeros)
> >N += 1: Unlink or overwrite or what?
> >N += 1: In-Kernel locking and resolution for pages that are mandatory
> >lock(ed)
> >N += 1: No fine-grained control for concurrency issues (multiple writers)
> >
> >Start with doing a cp --help and move on from there for an unbounded list of
> >issues that sys_copy(int fd1, int fd2) does not even come close to
> >addressing.
> >
> >
>
> To be fair, sys_copy is never intended to replace cp or try to be
> very smart. I don't think it is semantically supposed to do much more
> than replace a read, write loop (of course, the syscall also has an
> offset and count).
>
> sparse copying would be implementation dependant. If cp wanted to do
> something special it would not use one big copy call. I think unlink
> / overwrite is irrelevant if its semantically a read write loop.
>

actually if this syscall is allowed to do a COW at the filesystem level
(which I think is one of the better reasons for implementing this) then
sparse files would produce sparse copies.

if the destination exists it would need to be unlinked (overwrite doesn't
make sense in the COW context)

I don't understand the in-kernel page locking issues refered to above

the concurrancy issues are a good question, but I would suggest that the
syscall fully setup the copy and then create the link to it. this would
make the final creation an atomic operation (or as close to it as a
particular filesystem allows) and if you have multiple writers doing a
copy to the same destination then the last one wins, the earlier copies
get unlinked and deleted

I definantly don't see it being worth it to make a syscall to just
implement the read/write loop, but a copy syscall designed from the outset
to do a COW copy that falls back to a read/write loop for filesystems that
don't do COW has some real benifits

David Lang



-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
