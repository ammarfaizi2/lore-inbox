Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131966AbQLOHbC>; Fri, 15 Dec 2000 02:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLOHaw>; Fri, 15 Dec 2000 02:30:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35526 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129267AbQLOHar>;
	Fri, 15 Dec 2000 02:30:47 -0500
Date: Fri, 15 Dec 2000 02:00:19 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <Pine.LNX.4.10.10012142208420.1308-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012150150570.11106-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Linus Torvalds wrote:

> Good point. 
> 
> This actually looks fairly nasty to fix. The obvious fix would be to not
> put such buffers on the dirty list at all, and instead rely on the VM
> layer calling "writepage()" when it wants to push out the pages.
> That would be the nice behaviour from a VM standpoint.
> 
> However, that assumes that you don't have any "anonymous" buffers, which
> is probably an unrealistic assumption.
> 
> The problem is that we don't have any per-buffer "writebuffer()" function,
> the way we have them per-page. It was never needed for any of the normal
> filesystems, and XFS just happened to be able to take advantage of the
> b_end_io behaviour.
> 
> Suggestions welcome. 

Just one: any fs that really cares about completion callback is very likely
to be picky about the requests ordering. So sync_buffers() is very unlikely
to be useful anyway.

In that sense we really don't have anonymous buffers here. I seriously
suspect that "unrealistic" assumption is not unrealistic at all. I'm
not sufficiently familiar with XFS code to say for sure, but...

What we really need is a way for VFS/VM to pass the pressure on filesystem.
That's it. If fs wants unusual completions for requests - let it have its
own queueing mechanism and submit these requests when it finds that convenient.

Stephen, you probably already thought about that area. Could you comment on
that?
								Cheers,
									Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
