Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031330AbWKUTSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031330AbWKUTSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031331AbWKUTSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:18:01 -0500
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:14863 "EHLO
	sentry.sandia.gov") by vger.kernel.org with ESMTP id S1031330AbWKUTSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:18:00 -0500
X-Server-Uuid: 0D2F78EE-7D53-4621-AAFC-6A86EB50E29B
Subject: Re: splice/vmsplice performance test results
From: "Jim Schutt" <jaschut@sandia.gov>
To: "Jens Axboe" <jens.axboe@oracle.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061121135454.GV8055@kernel.dk>
References: <1163700539.2672.14.camel@sale659.sandia.gov>
 <20061116202529.GH7164@kernel.dk>
 <1163784110.8170.8.camel@sale659.sandia.gov>
 <20061120075941.GF4077@kernel.dk> <20061120082426.GG4077@kernel.dk>
 <1164037743.19613.5.camel@sale659.sandia.gov>
 <20061121135454.GV8055@kernel.dk>
Date: Tue, 21 Nov 2006 12:17:49 -0700
Message-ID: <1164136669.4265.65.camel@sale659.sandia.gov>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6)
X-TMWD-Spam-Summary: TS=20061121191755; SEV=2.2.0; DFV=B2006112109;
 IFV=2.0.4,4.0-9; AIF=B2006112109; RPD=5.02.0004; ENG=IBF; RPDID=NA;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2006112109_5.02.0004_4.0-9
X-WSS-ID: 697D8F6A26S4631936-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 14:54 +0100, Jens Axboe wrote: 
> On Mon, Nov 20 2006, Jim Schutt wrote:
> > On Mon, 2006-11-20 at 09:24 +0100, Jens Axboe wrote:
> > > On Mon, Nov 20 2006, Jens Axboe wrote:
> > > > On Fri, Nov 17 2006, Jim Schutt wrote:
> > > > > On Thu, 2006-11-16 at 21:25 +0100, Jens Axboe wrote:
> > > > > > On Thu, Nov 16 2006, Jim Schutt wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > 
> > > > > > > My test program can do one of the following:
> > > > > > > 
> > > > > > > send data:
> > > > > > >  A) read() from file into buffer, write() buffer into socket
> > > > > > >  B) mmap() section of file, write() that into socket, munmap()
> > > > > > >  C) splice() from file to pipe, splice() from pipe to socket
> > > > > > > 
> > > > > > > receive data:
> > > > > > >  1) read() from socket into buffer, write() buffer into file
> > > > > > >  2) ftruncate() to extend file, mmap() new extent, read() 
> > > > > > >       from socket into new extent, munmap()
> > > > > > >  3) read() from socket into buffer, vmsplice() buffer to 
> > > > > > >      pipe, splice() pipe to file (using the double-buffer trick)
> > > > > > > 
> > > > > > > Here's the results, using:
> > > > > > >  - 64 KiB buffer, mmap extent, or splice
> > > > > > >  - 1 MiB TCP window
> > > > > > >  - 16 GiB data sent across network
> > > > > > > 
> > > > > > > A) from /dev/zero -> 1) to /dev/null : 857 MB/s (6.86 Gb/s)
> > > > > > > 
> > > > > > > A) from file      -> 1) to /dev/null : 472 MB/s (3.77 Gb/s)
> > > > > > > B) from file      -> 1) to /dev/null : 366 MB/s (2.93 Gb/s)
> > > > > > > C) from file      -> 1) to /dev/null : 854 MB/s (6.83 Gb/s)
> > > > > > > 
> > > > > > > A) from /dev/zero -> 1) to file      : 375 MB/s (3.00 Gb/s)
> > > > > > > A) from /dev/zero -> 2) to file      : 150 MB/s (1.20 Gb/s)
> > > > > > > A) from /dev/zero -> 3) to file      : 286 MB/s (2.29 Gb/s)
> > > > > > > 
> > > > > > > I had (naively) hoped the read/vmsplice/splice combination would 
> > > > > > > run at the same speed I can write a file, i.e. at about 450 MB/s
> > > > > > > on my setup.  Do any of my numbers seem bogus, so I should look 
> > > > > > > harder at my test program?
> > > > > > 
> > > > > > Could be read-ahead playing in here, I'd have to take a closer look at
> > > > > > the generated io patterns to say more about that. Any chance you can
> > > > > > capture iostat or blktrace info for such a run to compare that goes to
> > > > > > the disk?
> > > > > 
> > > > > I've attached a file with iostat and vmstat results for the case
> > > > > where I read from a socket and write a file, vs. the case where I
> > > > > read from a socket and use vmsplice/splice to write the file.
> > > > > (Sorry it's not inline - my mailer locks up when I try to
> > > > > include the file.)
> > > > > 
> > > > > Would you still like blktrace info for these two cases?
> > > > 
> > > > No, I think the iostat data is fine, I don't think the blktrace info
> > > > would give me any more insight on this problem. I'll set up a test to
> > > > reproduce it here, looks like the write out path could be optimized some
> > > > more.
> > 
> > Great, let me know if you need testing from me.
> 
> I found some suboptimal behaviour in your test app - you don't check for
> short reads and splice would really like things to be aligned for the
> best performance. I did some testing with the original app here, and I
> get 114.769MB/s for read-from-socket -> write-to-file and 109.878MB/s
> for read-from-socket -> vmsplice-splice-to-file. If I fix up the read to
> always get the full buffer size before doing the vmsplice+splice, the
> performance is up to the same as the read/write.

Sorry - I had assumed my network was so much faster than my
disk subsystem I'd never get a short read from a socket except at
the end of the transfer.   Pretty silly of me, in hindsight.

I can see now how even one short read early would screw up 
the alignment for splicing into a file for the rest of the 
transfer, right?

Here's some new results:

Run w/check for short read on socket in vmsplice case:
- /dev/zero -> /dev/null w/ socket read + file write: 1130 MB/s
   (Man, my network is running fast today.  I don't know why.)
- /dev/zero -> /dev/null w/ socket read + vmsplice/splice: 1028 MB/s
- /dev/zero -> file w/ socket read + vmsplice/splice: 336 MB/s

Rerun w/original:
- /dev/zero -> /dev/null w/ socket read + vmsplice/splice: 1026 MB/s
- /dev/zero -> file w/ socket read + vmsplice/splice: 285 MB/s
- /dev/zero -> file w/ socket read + file write: 382 MB/s

So I was losing 50 MB/s due to short reads on the socket 
screwing up the alignment for splice.  Sorry to waste your
time on that.

But, it looks like socket-read + file-write is still ~50 MB/s 
faster than socket-read + vmsplice/splice (assuming I didn't 
screw up my short read fix - see patch below). I assume that's 
still unexpected?

> 
> Since it's doing buffered writes, the results do vary a lot though (as
> you also indicated). A raw /dev/zero -> /dev/null is 3 times faster with
> vmsplice/splice.
> 

Hmmm.  Is it worth me trying to do some sort of kernel 
profiling to see if there is anything unexpected with 
my setup?  If so, do you have a preference as to what 
I would use?  

Here's how I fixed my app to fix up (I think) short reads.
Maybe I missed your point?

diff --git a/src/dnd.c b/src/dnd.c
index 01bd7b8..aa70102 100644
--- a/src/dnd.c
+++ b/src/dnd.c
@@ -773,18 +773,26 @@ uint64_t vmsplice_recv(const struct opti
 again:
 	i = (i + 1) & 1;
 	iov.iov_base = opts->buf + i * opts->buf_size;
+	l = 0;
 
 again2:
-	l = read(sd, iov.iov_base, opts->buf_size);
-	if (l < 0) {
+	m = read(sd, iov.iov_base + l, opts->buf_size - l);
+	if (m < 0) {
 		if (errno == EINTR)
 			goto again2;
 		perror("Read");
 		exit(EXIT_FAILURE);
 	}
-	if (l == 0) {
-		fdatasync(fd);
-		return bytes;
+	if (m == 0) {
+		if (l == 0) {
+			fdatasync(fd);
+			return bytes;
+		}
+	}
+	else {
+		l += m;
+		if (l != opts->buf_size)
+			goto again2;
 	}
 
 	while (l) {



