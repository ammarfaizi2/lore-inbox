Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbRENCZO>; Sun, 13 May 2001 22:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbRENCZD>; Sun, 13 May 2001 22:25:03 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59543 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262067AbRENCYx>; Sun, 13 May 2001 22:24:53 -0400
Date: Sun, 13 May 2001 20:24:44 -0600
Message-Id: <200105140224.f4E2OiE08257@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com>
In-Reply-To: <200105140117.f4E1HqN07362@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On Sun, 13 May 2001, Richard Gooch wrote:
> >
> >   Hi, Linus. I've been thinking more about trying to warm the page
> > cache with blocks needed by the bootup process. What is currently
> > missing is (AFAIK) a mechanism to find out what inodes and blocks have
> > been accessed. Sure, you can use bmap() to convert from file block to
> > device block, but first you need to figure out the file blocks
> > accessed. I'd like to find out what kind of patch you'd accept to
> > provide the missing functionality.
> 
> Why would you use bmap() anyway? You CANNOT warm up the page cache
> with the physical map nr as discussed. So there's no real point in
> using bmap() at any time.

Think about it:-) You need to generate prefetch accesses in ascending
device bnum order. So the bmap() is there to tell you those device
bnums. You'd still prefetch using file bnums, the the *ordering* is
done based on device bnum. In fact, once the list is sorted, you can
chuck out the device bnums. You only need to store inum/path and file
bnum in the database.

> > One approach would be to create a new ioctl(2) for a FS that would
> > read out inum,bnum pairs.
> 
> Why not just "path,pagenr" instead? You make your instrumentation save
> away the whole pathname, by just using the dentry pointer. Many
> filesystems don't even _have_ a "inum", so anything less doesn't work
> anyway.

Sure, this would work too. I'm a bit worried about the increased
amount of traffic this will generate.

> Example acceptable approach:
> 
>  - save away full dentry and page number. Don't make it an ioctl. Think
>    "profiling" - this is _exactly_ the same thing, and profiling uses a
> 	(a) command line argument to turn it on
> 	(b) /proc/profile
>    (and because you have the full pathname, you should just make the dang
>    /proc/fsaccess file be ASCII)

So on every page fault or read(2) call, we have to generate the full
path from the dentry? Isn't that going to add a fair bit of overhead?
Remember, we want to do this on every boot (to keep the database as
up-to-date as possible).

>  - add a "prefetch()" system call that does all the same things
>    "read()" does, but doesn't actually wait for (or transfer) the
>    data. Basically just a read-ahead thing. So you'd basically end up
>    doing
> 
> 	foreach (filename in /proc/fsaccess)
> 		fd = open(filename);
> 		foreach (sorted pagenr for filename in /proc/fsaccess)
> 			prefetch(fd, pagenr);
> 		end
> 	end

I don't see the advantage of the prefetch(2) system call. It seems to
me I can get the same effect by just making read(2) calls in another
task. Of course, I'd need to use bmap() to generate the sort key, but
I don't see why that's a bad thing.

> Forget about all these crappy "ioctl" ideas. Basic rule of thumb: if
> you think an ioctl is a good idea, you're (a) being stupid and (b)
> thinking wrong and (c) on the wrong track.

Don't hold back now. Tell us what you really think :-)

> And notice how there's not a single bmap anywhere, and not a single
> "raw device open" anywhere.

I don't mind the /proc/fsaccess approach, I'm just worried about the
overhead of doing the denty->pathname conversions on each fault/read.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
