Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282491AbRLQT13>; Mon, 17 Dec 2001 14:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282453AbRLQT1U>; Mon, 17 Dec 2001 14:27:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282491AbRLQT1E>; Mon, 17 Dec 2001 14:27:04 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: O_DIRECT wierd behavior..
Date: Mon, 17 Dec 2001 19:26:05 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9vlgsd$1b7$1@penguin.transmeta.com>
In-Reply-To: <20011217181840.G2431@athlon.random> <Pine.LNX.4.21.0112171757530.2812-100000@localhost.localdomain> <3C1E400B.A4D25F9D@zip.com.au>
X-Trace: palladium.transmeta.com 1008617215 22086 127.0.0.1 (17 Dec 2001 19:26:55 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Dec 2001 19:26:55 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C1E400B.A4D25F9D@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>
>SUS says: ( http://www.opengroup.org/onlinepubs/007908799/xsh/write.html )
>
> RETURN VALUE
>
>     Upon successful completion, write() and pwrite() will return the number of bytes
>     actually written to the file associated with fildes. This number will never be greater
>     than nbyte. Otherwise, -1 is returned and errno is set to indicate the error. 
>
>I take that to mean that if an error occurs, we return that
>error regardless of how much was written.

I disagree.

Note that writing 15 characters out of 30 is also a "successful write" -
it's just a _partial_ write.

So it is acceptable to return an intermediate value.

In particular, returning "error" when 15 bytes were written loses
information that the application _cannot_ recover from. 

Which is why Linux does what Linux does now:
 - if you get an error half-way, we return the number of bytes
   successfully written.
 - a well-written app will handle partial writes correctly (otherwise it
   can never handle things like sockets or pipes), so it will try to
   write the remaining chunk later,
 - if, at that later date, the error persists, and we cannot write any
   data, the application gets the error message.

this means:
 - good applications can recover gracefully from errors
 - you never lose "information" about what has happened

In contrast, if you wrote and committed 15 bytes, and an error occurs
when writing the 16th byte, and you return an error, the application is
now hosed. It has no way of knowing whether _any_ of the write was
successful or not.

>Which makes sense.  Consider this code:
>
>	open(file)
>	write(100k)
>	close(fd)
>
>if the write gets an IO error halfway through, it looks like
>the caller never gets to hear about it at present.

No, the caller _does_ get to hear about it. If the caller cares about
robust handling, it will notice "Hmm, I tried to write 100k bytes, but
the system only write 50k, what's up"?

Note that the caller _has_ to do this anyway, or it wouldn't be able to
handle things like interruptible NFS mounts, sockets, pipes, out-of-disk
errors etc etc.

And if the caller does _not_ care about robustness, then who cares?
It's going to ignore whatever we return anyway.

>						  Except via
>the short return value from the write.  But from my reading of SUS,
>a short return value from write implicitly means ENOSPC.

I disagree. A short write is _normal_ for a lot of file descriptors.

Yes, ENOSPC implies short write. But short write does not imply ENOSPC.

		Linus
