Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270823AbRIAQoc>; Sat, 1 Sep 2001 12:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270818AbRIAQoW>; Sat, 1 Sep 2001 12:44:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41630 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270800AbRIAQoN>;
	Sat, 1 Sep 2001 12:44:13 -0400
Date: Sat, 1 Sep 2001 12:44:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <20010901164238.P9870@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0109011226580.18705-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Sep 2001, Ingo Oeser wrote:

> On Sat, Sep 01, 2001 at 12:23:05AM -0400, Alexander Viro wrote:
> > > 2) I'd like to see a readonly mount state defined as "the filesystem will
> > > not change.  Period."  Not for system calls in progress, not for cache
> > > synchronization, not to set an "unmounted" flag, not for writes that are
> > > queued in the device driver or device.  (That last one may stretch
> > > feasability, but it's a worthy goal anyway).
> > 
> > It doesn't work.  Think of r/o mounting of remote filesystem.  Do you
> > suggest that it should make it impossible to change from other clients?
> 
> It's sufficient for local file systems. Or see it this way: The
> machine, that mounted it r/o will NOT write to it until it is
> mounted r/w again.

That's _also_ not true for remote filesystems.  We can mount the same
filesystem over NFS again without unmounting the old instance.  Always
could.

IMO a part of the problem is that we are mixing "I'm not asking that
to be writable" with "I won't let you write".  The former belongs
to the mounting side, the latter - to filesystem.

Notice that setups along the lines "mount /dev/sda5 read-only on /home/jail/pub
and read-write on /home/ftp/pub" are not that unreasonable, so even for local
filesystems it might make sense.

IOW, I suspect that right solution would have two separate layers -
	* does anyone get write access under that mountpoint? (VFS)
	* is this fs asked to handle write access and had it agreed with that?
(filesystem)

