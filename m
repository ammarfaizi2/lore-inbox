Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTJJMhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTJJMhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:37:36 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:35211 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262098AbTJJMhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:37:34 -0400
Date: Fri, 10 Oct 2003 13:37:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010123732.GA28224@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <3F85ED01.8020207@redhat.com> <20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk> <20031010044909.GB26379@mail.shareable.org> <16262.17185.757790.524584@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16262.17185.757790.524584@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>      >     - are dnotify / lease / lock reliable indicators on this filesystem?
>      >       (i.e. dnotify is reliable on all local filesystems, but
>      >       not over any of the remote ones AFAIK).
> 
> Belongs in fcntl()... Just return ENOLCK if someone tries to set a
> lease or a directory notification on an NFS file...

Yes, that would make sense.  It should be a filesystem hook, so that
even remote filesystems like SMB can implement it, although it must be
understood that remote notification has different ordering properties
than local.

>      >     - is stat() reliable (local filesystems and many remote) or
>      >       potentially out of date without open/close (NFS due to
>      >       attribute cacheing)
> 
> There are many possible cache consistency models out there. Consider
> for instance AFS connected/disconnected modes, NFSv4 delegations or
> CIFS shares. How are you going to distinguish between them all and
> how do you propose that applications make use of this information?

The difference is that NFSv3 can return _stale_ data, while local
_cannot_.  I call stat(), and the information is up to date.

I don't care about the cache semantics at all; what I care about is
whether a returned stat() result may be stale.

Why?  This is the difference between "make" generating correct data,
and "make" generating incorrect data.[1]

The caching model isn't the issue.  That's the filesystem's problem.
I just want a way to get up to date data in my application.

My motivation isn't actually "make" although that's important;
generally, I need to know how to verify my in-application cache of a
file.  (Think fontconfig, ccache etc).  I use dnotify for similar
purposes, when it's local.  (dnotify is much faster than many stats
for a complex cache dependency).

Currently, I use statfs() and read /proc/mounts to determine whether
the filesystem is a known type or mounted on a block device, to decide
whether stat() and/or dnotify are reliable.  This is not ideal.  In
particular, I don't know of any way to _guarantee_ that I have the
latest file contents from remote filesystems short of F_SETLK, which
way too heavy.[2]

-- Jamie


[1] I have built programs, including kernels, which crashed due to
timestamps not appearing on a different computer after changing code
so make didn't compile everything.

[2] I have lost code I was editing due to saving it and then a
different computer updating the file by reading a stale version,
modifying it and writing it.

