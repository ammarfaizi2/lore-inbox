Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVEUGMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVEUGMw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVEUGMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:12:52 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:16649 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261670AbVEUGMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:12:41 -0400
To: jamie@shareable.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050520231312.GD29155@mail.shareable.org> (message from Jamie
	Lokier on Sat, 21 May 2005 00:13:12 +0100)
Subject: Re: [PATCH] FUSE: don't allow restarting of system calls
References: <E1DZ3Mx-0003ST-00@dorka.pomaz.szeredi.hu> <20050520231312.GD29155@mail.shareable.org>
Message-Id: <E1DZNDc-0006aR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 21 May 2005 08:12:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Caching and prefetching would solve that probem much more usefully.
> 
> Does sshfs not cache or prefetch any of the data?

It does.

It doesn't try to eliminate setattr, etc. calls though.  That's a bit
dangerous, because anything can change on the other end anytime, so I
feel safer if these calls go through every single time.

Here it was truncate (from O_TRUNC) that was holding up open.

> IMHO, caching and prefetching makes a lot of sense for this situation
> - in fact, it does for any kind of filesystem operation during a
> sequence of file operations where a program does not use locks (flock
> etc.), fsyncs, or open/close.
> 
> Surely caching and prefetching should be a generic feature of FUSE for
> all its filesystems unless disabled.  Is there a reason why this is
> not done, or is it just not implemented?

There are all kinds of caching: name cache (dcache), attribute cache
(icache), file cache (page cache), directory cache (no support in
VFS).  FUSE deals with each differently:

On lookup the userspace filesystem can specify a timeout for caching
the name.  On getattr (built into lookup as well) it can specify the
timeout for caching the attributes.  There's no explicit invalidate
callback.  Names/attributes are automatically invalidated on certain
other operations (see source for more info).  The library always sets
these timeouts to 1s, but it's only a question of making a nice
low-level API for all these little features.

For the page cache there's a mount option: "kernel_cache" which if
turned on the page cache is never invalidated.  This should only be
used by filesystems for which the file data may never change
externally.  If the option is not specified, the file pages are always
invalidated on open().  This is very crude, and could be done much
better.  I have been plannig to add explicit control by the filesystem
if open should invalidate the data or not (and the library could do
this automatically for example by checking mtime/size).  But it has
not yet happened

Sshfs does it's own caching of directory contents and attributes.
Actually the kernel attribute cache is not all that useful here, since
sftp returns file attributes with a readdir.

> > The problem can be solved just by making open() uninterruptible,
> > because in this case it was the truncate operation that slowed down
> > the progress.  But it's better to solve this by simply not allowing
> > interrupts at all (except SIGKILL), because applications don't expect
> > file operations to be interruptible anyway.  As an added bonus the
> > code is simplified somewhat.
> 
> NFS makes file operations interruptible when they're mounted with
> "intr".
> 
> It's a life-saver, when the server or network gets wedged, to be able
> to Control-C a program instead of it being stuck in D-state and
> requiring a reboot.

If you read the FUSE kernel source carefully, you'll notice that it
never does uninterruptible sleep (only for _limited_ time).  So it
never ever gets stuck in a D-state.  SIGKILL will always kill the the
offender, and if task didn't override default handler for SIGINT, that
will also generate a SIGKILL, and happily kill off the blocked task.

> Having a program be stuck in read/write ignoring signals, so that
> Control-C, Control-Z and kill don't work on it, while it's waiting for
> some network operation, is a horrible thing.

Yes.  If there's no chance that the thing will come back to life, you
can also kill the fuse daemon.  That will make all operations return
an error.

So FUSE is actually very nice in this respect.

Miklos
