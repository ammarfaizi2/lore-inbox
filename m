Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbRGMR0g>; Fri, 13 Jul 2001 13:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267508AbRGMR0Z>; Fri, 13 Jul 2001 13:26:25 -0400
Received: from [204.94.214.22] ([204.94.214.22]:14612 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S267507AbRGMR0Q>; Fri, 13 Jul 2001 13:26:16 -0400
Message-Id: <200107131727.f6DHRXp08659@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Mike Black <mblack@csihq.com>, Andrew Morton <andrewm@uow.edu.au>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246 
In-Reply-To: Message from "Stephen C. Tweedie" <sct@redhat.com> 
   of "Fri, 13 Jul 2001 17:30:07 BST." <20010713173007.G13419@redhat.com> 
Date: Fri, 13 Jul 2001 12:27:33 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> On Fri, Jul 13, 2001 at 09:54:56AM -0400, Mike Black wrote:
> > I give up!  I'm getting file system corruption now on the ext3 partition...
> > and I've got a kernel oops (soon to be decoded)
> 
> Please, do send details.  We already know that the VM has a hard job
> under load, and journaling exacerbates that --- ext3 cannot always
> write to disk without first allocating more memory, and the VM simply
> doesn't have a mechanism for dealing with that reliably.  It seems to
> be compounded by (a) 2.4 having less write throttling than 2.2 had,
> and (b) the zoned allocator getting confused about which zones
> actually need to be recycled.

We seem to have managed to keep XFS going without the memory reservation
scheme - and the way we do I/O on metadata right now means there is always
a memory allocation in that path. At the moment the only thing I can kill
the system with is make -j bzImage it eventually grinds to a halt with
the swapper waiting for a request slot in the block layer but the system
is in such a mess that I have not been able to diagnose it further than
that.

A lot of careful use of GFP flags on memory allocation was necessary to
get to this point, the GFP_NOIO and GFP_NOFS finally made this deadlock
clean.

Steve


> 
> It's not just ext3 --- highmem bounce buffering and soft raid buffers
> have the same problem, and work around it by doing their own internal
> preallocation of emergency buffers.  Loop devices and nbd will have a
> similar problem if you use those for swap or writable mmaps, as will
> NFS.
> 
> One proposed suggestion is to do per-zone memory reservations for the
> VM's use: Ben LaHaise has prototype code for that and we'll be testing
> to see if it makes for an improvement when used with ext3.
> 
> Cheers,
>  Stephen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


