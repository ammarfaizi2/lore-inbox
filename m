Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263952AbRFMUVb>; Wed, 13 Jun 2001 16:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264204AbRFMUVV>; Wed, 13 Jun 2001 16:21:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7181 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263952AbRFMUVQ>; Wed, 13 Jun 2001 16:21:16 -0400
Date: Wed, 13 Jun 2001 17:21:10 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <992460707.3b27bfa31aa98@eargle.com>
Message-ID: <Pine.LNX.4.33.0106131716510.1742-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Tom Sightler wrote:

> 1.  Transfer of the first 100-150MB is very fast (9.8MB/sec via 100Mb Ethernet,
> close to wire speed).  At this point Linux has yet to write the first byte to
> disk.  OK, this might be an exaggerated, but very little disk activity has
> occured on my laptop.
>
> 2.  Suddenly it's as if Linux says, "Damn, I've got a lot of data to flush,
> maybe I should do that" then the hard drive light comes on solid for several
> seconds.  During this time the ftp transfer drops to about 1/5 of the original
> speed.
>
> 3.  After the initial burst of data is written things seem much more reasonable,
> and data streams to the disk almost continually while the rest of the transfer
> completes at near full speed again.
>
> Basically, it seems the kernel buffers all of the incoming file up to nearly
> available memory before it begins to panic and starts flushing the file to disk.
>  It seems it should start to lazy write somewhat ealier.
> Perhaps some of this is tuneable from userland and I just don't
> know how.

Actually, it already does the lazy write earlier.

The page reclaim code scans up to 1/4th of the inactive_dirty
pages on the first loop, where it does NOT write things to
disk.

On the second loop, we start asynchronous writeout of data
to disk and and scan up to 1/2 of the inactive_dirty pages,
trying to find clean pages to free.

Only when there simply are no clean pages we resort to
synchronous IO and the system will wait for pages to be
cleaned.

After the initial burst, the system should stabilise,
starting the writeout of pages before we run low on
memory. How to handle the initial burst is something
I haven't figured out yet ... ;)

> Anyway, things are still much better, with older kernels things
> would almost seem locked up during those 10-15 seconds but now
> my apps stay fairly responsive (I can still type in AbiWord,
> browse in Mozilla, etc).

This is due to this smarter handling of the flushing of
dirty pages and due to a more subtle bug where the system
ended up doing synchronous IO on too many pages, whereas
now it only does synchronous IO on _1_ page per scan ;)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

