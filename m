Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbRENBcy>; Sun, 13 May 2001 21:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262043AbRENBco>; Sun, 13 May 2001 21:32:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:61964 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262048AbRENBca>; Sun, 13 May 2001 21:32:30 -0400
Date: Sun, 13 May 2001 18:32:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <200105140117.f4E1HqN07362@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 May 2001, Richard Gooch wrote:
>
>   Hi, Linus. I've been thinking more about trying to warm the page
> cache with blocks needed by the bootup process. What is currently
> missing is (AFAIK) a mechanism to find out what inodes and blocks have
> been accessed. Sure, you can use bmap() to convert from file block to
> device block, but first you need to figure out the file blocks
> accessed. I'd like to find out what kind of patch you'd accept to
> provide the missing functionality.

Why would you use bmap() anyway? You CANNOT warm up the page cache with
the physical map nr as discussed. So there's no real point in using
bmap() at any time.

> One approach would be to create a new ioctl(2) for a FS that would
> read out inum,bnum pairs.

Why not just "path,pagenr" instead? You make your instrumentation save
away the whole pathname, by just using the dentry pointer. Many
filesystems don't even _have_ a "inum", so anything less doesn't work
anyway.

Example acceptable approach:

 - save away full dentry and page number. Don't make it an ioctl. Think
   "profiling" - this is _exactly_ the same thing, and profiling uses a
	(a) command line argument to turn it on
	(b) /proc/profile
   (and because you have the full pathname, you should just make the dang
   /proc/fsaccess file be ASCII)

 - add a "prefetch()" system call that does all the same things
   "read()" does, but doesn't actually wait for (or transfer) the
   data. Basically just a read-ahead thing. So you'd basically end up
   doing

	foreach (filename in /proc/fsaccess)
		fd = open(filename);
		foreach (sorted pagenr for filename in /proc/fsaccess)
			prefetch(fd, pagenr);
		end
	end

Forget about all these crappy "ioctl" ideas. Basic rule of thumb: if you
think an ioctl is a good idea, you're (a) being stupid and (b) thinking
wrong and (c) on the wrong track.

And notice how there's not a single bmap anywhere, and not a single "raw
device open" anywhere.

		Linus

