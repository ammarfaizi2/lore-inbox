Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbSJNS61>; Mon, 14 Oct 2002 14:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSJNS61>; Mon, 14 Oct 2002 14:58:27 -0400
Received: from MEREDITH.DEMENTIA.ORG ([128.2.120.216]:7953 "EHLO
	meredith.dementia.org") by vger.kernel.org with ESMTP
	id <S262099AbSJNS6Z>; Mon, 14 Oct 2002 14:58:25 -0400
Date: Mon, 14 Oct 2002 15:04:15 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
X-X-Sender: shadow@trafford.andrew.cmu.edu
To: Alexander Viro <viro@math.psu.edu>
cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes
 for 2.4.19-pre5-ac3)
In-Reply-To: <Pine.GSO.4.21.0210141427410.6505-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44L-027.0210141435100.18909-100000@trafford.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should say I wasn't intending to pick on nfsservctl, but since it was
the interface this was modelled on, more or less per the suggestion made
in April, I was using it as a reference.

On Mon, 14 Oct 2002, Alexander Viro wrote:

> On Mon, 14 Oct 2002, Derrick J Brashear wrote:
>
> > Incidentally, nothing in the kernel source tree provides an example
> > "explanation of the usage of nfsservctl"; I'll be happy to work out the
> > new interface and provide appropriate information, but is there some place
> > in particular such things end up being documented? I'm not averse to
> > submitting information to go in /Documentation but it doesn't appear
> > there's precedent for that.
>
> Notice that in 2.5 (and that's backportable to 2.4 - I'll do that after
> Oct 31) nfsservctl() is a trivial wrapper around open/write/read/close.
> IOW, mountd and friends could stop using that syscall - all functionality
> is available for userland without it.
>
> See fs/nfsctl.c and fs/nfsd/nfsctl.c for example of doing that.
>
> What things are done by afs_syscall()?  If you are passing some requests
> to the afs driver - just tell what these requests are, writing that
> stuff is a matter of an hour...

One is the "afs operation" call, which includes items which historically
donated contexts to the kernel by making the system calls at startup, but
as of our last release we made changes that make most of this obsolete,
switching to kernel threads, so this could be simplified to basically one
operation to start and another to stop.

One of the operations, however, is an upcall, particularly, the afsd
daemon donates a child which stays in a syscall until a DNS lookup
(of AFSDB resource records to find new cells) is needed, then it returns.

Another two are used for adding new cells and cell aliases while AFS is
running.

The other things which exist at this point (under that umbrella) are all
startup items for the client and can probably be rewritten to work other
ways. However, one possible answer for dealing with kerberos v5 is
another upcall interface involving a donated child, because ideally you
want not just a single kerberos credential as essentially happens now,
but instead the ability to use a single credential per server host, and
there's no way of knowing at startup what all server hosts you'll access
during operation, because new servers can be registered and put in
service on the fly.

Then there are the things which might properly be additional system calls,
except that their possible generic use never caught on, hence they are
still under the AFS umbrella.

-pioctl, which works like ioctl except instead of taking an open
file descriptor, it takes a path. Dealing with this would be troublesome.

-setpag, which may be able to be changed in the Linux Security Module
universe, but again we don't know yet how to support RedHat 8's not quite
2.4.19, which doesn't have this and yet doesn't export sys_call_table

-"icl", basically a mechanism to pass messages between userspace and the
AFS kernel trace facility.

-icreate/iopen/idec/iinc, which we don't actually use on Linux, and thus
don't need to consider in this proposal.

I'm open to reworking this as much as I can but it does leave the sticking
point of RedHat 8, which is unfortunate, since if we could do this purely
in terms of new interfaces I think we could be much cleaner. Instead I
think we have to make some compromise to make something which will also
work with whatever portions they've already backported. Most of our users
seem to use RedHat or Debian, so basically we'd like to continue
supporting those people.







