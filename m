Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSGVETD>; Mon, 22 Jul 2002 00:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGVETD>; Mon, 22 Jul 2002 00:19:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48904 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315971AbSGVETC>;
	Mon, 22 Jul 2002 00:19:02 -0400
Message-ID: <3D3B8A4E.78944941@zip.com.au>
Date: Sun, 21 Jul 2002 21:30:06 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT read and holes in 2.5.26
References: <3D3B6D57.BB5C0F38@zip.com.au> <5.1.0.14.2.20020722040423.042eb710@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Hi Andrew,
> 
> At 03:26 22/07/02, Andrew Morton wrote:
> >Stephen Lord wrote:
> > > Did you realize that the new O_DIRECT code in 2.5 cannot read over holes
> > > in a file.
> >
> >Well that was intentional, although I confess to not having
> >put a lot of thought into the decision.  The user wants
> >O_DIRECT and we cannot do that.  The CPU has to clear the
> >memory by hand.  Bad.
> >
> >Obviously it's easy enough to put in the code to clear the
> >memory out.  Do you think that should be done?
> 
> I would vote for yes because whether a file is sparse or not cannot be
> trivially controlled by the file creator (unless you actually write the
> whole file with non-zero content) but is dependent on the underlying file
> system...

O_DIRECT tends to be used in specialised applications.  They're
being silly if they're reading from holes.

> And on the grounds that a memset() is going to be a lot faster
> than a read from device I don't see why it shouldn't be done.

It's actually tons more expensive - wiping the page by hand
goes against the whole reason for using O_DIRECT.

But it is the expected behaviour of the read() system call
so yeah, I'll do it.

> ...
> [ get_blocks() stuff ]
>

This is going to be fairly involved.  Probably the top-level
IO code gets ripped up and redone to expect a get_blocks()
interface.  A default implementation of get_blocks() would
be provided for naive filesystems - it just calls get_block()
a lot.  Quite possibly, we say to heck with purity and get_block()
and get_blocks() become a_ops, too.

I'd really like to see a solid reason for doing all this.
That means numbers ;)  Even good old ext2 would be able to show
benefit from batching up the get_block() work, but not a lot.

You won't buy much on writes, I expect - 8k write requests
will probably remain the ideal size.

-
