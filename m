Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTK0JG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 04:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTK0JG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 04:06:26 -0500
Received: from [209.195.52.120] ([209.195.52.120]:44232 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S264454AbTK0JGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 04:06:25 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Robert White <rwhite@casabyte.com>,
       "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Florian Weimer'" <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       "'Daniel Gryniewicz'" <dang@fprintf.net>,
       "'linux-kernel mailing list'" <linux-kernel@vger.kernel.org>
Date: Thu, 27 Nov 2003 01:50:46 -0800 (PST)
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <3FC5BC43.8030209@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0311270143060.6400@dlang.diginsite.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAilRHd97CfESTROe2OYd1HQEAAAAA@casabyte.com>
 <3FC5A7F0.8080507@cyberone.com.au> <Pine.LNX.4.58.0311270106430.6400@dlang.diginsite.com>
 <3FC5BC43.8030209@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003, Nick Piggin wrote:
> >
> >if the destination exists it would need to be unlinked (overwrite doesn't
> >make sense in the COW context)
> >
>
> Well it would be implementation specific. Presumably it should keep
> the semantics of an overwrite.
>
> >
> >I don't understand the in-kernel page locking issues refered to above
> >
> >the concurrancy issues are a good question, but I would suggest that the
> >syscall fully setup the copy and then create the link to it. this would
> >make the final creation an atomic operation (or as close to it as a
> >particular filesystem allows) and if you have multiple writers doing a
> >copy to the same destination then the last one wins, the earlier copies
> >get unlinked and deleted
> >
>
> I don't think it should do any linking / unlinking it should just work
> with file descriptors. Concurrent writes to a file don't have many
> guarantees. sys_copy shouldn't have to be any stronger (read weaker).

I'm thinking that it may actually be easier to do this via file paths
instead of file descripters. with file paths something like COW or
zero-copy copy can be done trivially (and the kernel knows the user
credentials of the program issuing the command and can pass them on to the
filesystem to see if it's allowed). I don't see how this can be done with
file descripters (if all you have is a file descripter you can truncate
and write a file, but you don't know all the links to that file so you
can't reposition that first inode for example).

> >
> >I definantly don't see it being worth it to make a syscall to just
> >implement the read/write loop, but a copy syscall designed from the outset
> >to do a COW copy that falls back to a read/write loop for filesystems that
> >don't do COW has some real benifits
> >
>
> No I just mean the semantics.
>
>
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
