Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSHKFyM>; Sun, 11 Aug 2002 01:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSHKFyM>; Sun, 11 Aug 2002 01:54:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45573 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317752AbSHKFyK>;
	Sun, 11 Aug 2002 01:54:10 -0400
Message-ID: <3D55FF30.6164040D@zip.com.au>
Date: Sat, 10 Aug 2002 23:07:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <20020810201027.E306@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101529490.2401-100000@home.transmeta.com> <20020811031705.GA13878@netnation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby wrote:
> 
> On Sat, Aug 10, 2002 at 03:42:29PM -0700, Linus Torvalds wrote:
> 
> > I _suspect_ that the common behaviour is to read just a few kB at a time
> > and that is basically doesn't ever really pay to play VM games.
> >
> > (The "repeated read of a few kB" case is also likely to be the
> > best-performing behaviour, simply because it's usually _better_ to do many
> > small reads that re-use the cache than it is to do one large read that
> > blows your cache and TLB. Of course, that all depends on what your
> > patterns are after the read - do you want to have the whole file
> > accessible or not).
> 
> This is only somewhat related, but I'm wondering if the cache effects
> also apply to readahead block sizes.  Sequential page-sized read()s from
> a file causes readahead to kick in and grow in size.  Over time, it ends
> up using very large blocks.  Would it be beneficial to keep the readahead
> size smaller so that it still stays in cache?
> 
> Also, this use of large blocks shouldn't really matter, but I'm seeing a
> problem where the process ends up sleeping for most of the time,
> switching between CPU and I/O rather than simply having the I/O for the
> next read() occur in advance of the current read().
> 
> The problem appears to be that readahead isn't awakening the process to
> present partial results.  The blocks get so large that the process
> switches between running and being blocked in I/O, which decreases
> overall performance (think of a "grep" process that at 100% CPU can just
> saturate the disk I/O).  Working correctly, readahead would not get in
> the way, it would just have blocks ready for "grep" to use, and grep
> would use all of the CPU not being used for I/O.  Currently, grep sleeps
> 50% of the time waiting on I/O.

This is interesting.

The 2.5 readahead sort-of does the wrong thing for you.  Note how fs/mpage.c:mpage_end_io_read() walks the BIO's pages backwards when
unlocking the pages.  And also note that the BIOs are 64kbytes, and
the readahead window is up to 128k, etc.

See, a boring old commodity disk drive will read 10,000 pages per
second.  The BIO code there is designed to *not* result in 10,000
context-switches per second in the common case.  If the reader is
capable of processing the data faster than the disk then hold
them off and present them with large chunks of data.

And that's usually the right thing to do, because most bulk readers
read fast - if your grep is really spending 50% of its time not
asleep then you either have a very slow grep or a very fast IO
system.  It's applications such as gzip, which perform a significant
amount of work crunching on the data which are interesting to study,
and which benefit from readahead.

But that's all disks.  You're not talking about disks.

> This problem is showing up with NFS over a slow link, causing streaming
> audio to be unusable.  On the other end of the speed scale, it probably
> also affects "grep" and other applications reading from hard disks, etc.

Well, the question is "is the link saturated"?  If so then it's not
solvable.  If is is not then that's a bug.

> To demonstrate the problem reliably, I've used "strace -r cat" on a
> floppy, which is a sufficiently slow medium. :)  This is on a 2.4.19
> kernel, but 2.5 behaves similarly.  Note how the readahead starts small
> and gets very large.  Also, note how the start of the first larger
> readahead occurs shortly after a previous read, and that it blocks early
> even though the data should already be there (4.9 seconds).  It also
> appears to stumble a bit later on.  read() times show up as the relative
> time for the following write() (which is going /dev/null):

OK, it's doing 128k of readahead there, which is a bit gross for a floppy.
You can tune that down with `blockdev --setra N /dev/floppy'.  The
defaults are not good, and I do intend to go through the various block
drivers and teach them to set their initial readahead size to something
appropriate.

But in this example, where the test is `cat', there is nothing to be gained,
I expect.  The disk is achieving its peak bandwidth.

However if the application was encrypting the data, or playing it
through loudspeakers then this may not be appropriate behaviour.
The design goal for readahead is that if an application is capable
of processing 10 megabytes/second and the disk sustains 11 megabytes/sec
then the application should never sleep. (I was about to test this,
but `mke2fs /dev/fd0' oopses in 2.5.30.  ho hum)

Tuning the readahead per-fd is easy to do in 2.5.  It would be in
units of pages, even though for many requirements, milliseconds
is a more appropriate unit for readahead.  The basic unit of wakeup
granularity is 64kbytes - the max size of a BIO.  Reducing that
to 4k for floppies would fix it up for you.  We need some more BIO
infrastructure for that, and that will happen.  Then we can go and
wind back the max bio size for floppies.

With some additional radix tree work we can implement the posix_fadvise
system call nicely, and its POSIX_FADV_WILLNEED could be beneficial.

The infrastructure is in place for network filesystems to be able to
tune their own readahead and expose that to user space, although none
of that has been done.

I don't think fiddling with readahead either in the application, the
system setup or the kernel is a satisfactory way of fixing all this.

It needs asynchronous IO.  Then the time-sensitive application
can explicitly manage its own readahead to its own requirements.
(Could do this with POSIX_FADV_WILLNEED as well).

So hmm.  Good point, thanks.  I'll go play some MP3's off floppies.
  
(Holy crap.  2.5.31!  I'm outta here)
