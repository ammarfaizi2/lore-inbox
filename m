Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281921AbRLAWgh>; Sat, 1 Dec 2001 17:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281914AbRLAWgV>; Sat, 1 Dec 2001 17:36:21 -0500
Received: from tnt1-161-74.cac.psu.edu ([130.203.161.74]:16777 "HELO
	funkmachine.cac.psu.edu") by vger.kernel.org with SMTP
	id <S281917AbRLAWgG>; Sat, 1 Dec 2001 17:36:06 -0500
Message-ID: <3C095B2F.AAE4E34C@psu.edu>
Date: Sat, 01 Dec 2001 17:35:27 -0500
From: Jason Holmes <jholmes@psu.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
In-Reply-To: <3C092CAB.4D1541F4@psu.edu> <3C094CDF.A3FF1D26@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Jason Holmes wrote:
> >
> > I saw in a previous thread that the interactivity improvements in
> > 2.4.17-pre2 had some adverse effect on IO throughput and since I was
> > already evaluating 2.4.16 for a somewhat large fileserving project, I
> > threw 2.4.17-pre2 on to see what has changed.  Throughput while serving
> > a large number of clients is important to me, so my tests have included
> > using dbench to try to see how things scale as clients increase.
> >
> > 2.4.16:
> >
> > ...
> > Throughput 210.989 MB/sec (NB=263.736 MB/sec  2109.89 MBit/sec)  16 procs
> > ...
> >
> > 2.4.17-pre2:
> >
> > ...
> > Throughput 153.672 MB/sec (NB=192.09 MB/sec  1536.72 MBit/sec)  16 procs
> > ...
> 
> This is expected, and tunable.
> 
> The thing about dbench is this:  it creates files and then it
> quickly deletes them.  It is really, really important to understand
> this!
> 
> If the kernel allows processes to fill all of memory with dirty
> data and to *not* start IO on that data, then this really helps
> dbench, because when the delete comes along, that data gets tossed
> away and is never written.
> 
> If you have enough memory, an entire dbench run can be performed
> and it will do no disk IO at all.

Yeah, I was basically treating the lower process runs (<64) as in-memory
performance and the higher process runs as a mix (since, for example,
the 128 run deals with ~8 GB of data and I only have 1.25 GB of RAM).

> ...
>
> You'll find that running
> 
>         echo 80 0 0 0 500 3000 90 0 0  > /proc/sys/vm/bdflush
> 
> will boost your dbench throughput muchly.

Yeah, actually, I've been sorta "brute-forcing" the bdflush and
max-readahead space (or the part of it that I chose for a start) over
the past few days for bonnie++ and dbench.  The idea was to use these
quicker-running benchmarks to get an general idea of good values to use
and then zero in on the final values with longer, more real-world load. 
I was thinking that bonnie++ would at least give me an idea of
sequential read/write performance for files larger than RAM (one part of
the typical workload I see is moving large files out to multiple [32-64
or so] machines at the same time) and that dbench would give me an idea
of performance for many small read/write operations, both for cached and
on-disk data (another aspect of the workload I see is reading/writing
many small files from multiple machines, such as postprocessing the
results of some large computational run).  Oh, I don't think I actually
mentioned that I'm looking to tune fileservers here for medium-sized
(100-200 node) computational clusters and that in the end there will be
something much more powerful than a single SCSI disk in the backend.

FWIW, the top 10 bdflush/max-readahead combinations for dbench (sorted
by 128 processes) that I've seen so far are:

                             16        32        64       128
                       --------  --------  --------  --------
70-900-1000-90-2047     208.056   159.598   144.721   122.514
30-100-1000-50-127      113.829   101.820   110.699   120.017
70-500-1000-90-2047     209.547   150.172   142.556   115.979
30-300-1000-90-63       108.862   118.443   109.060   112.901
30-100-1000-50-63       113.904    96.648   113.969   112.021
50-700-1000-90-63       208.062   137.579   134.504   111.656
30-500-1000-50-255      111.955    97.373   115.360   111.004
30-100-1000-70-1023     115.110    99.823   122.720   110.016
70-300-1000-90-1023     220.096   169.194   160.025   109.753
70-700-1000-90-255      208.468   146.202   140.098   109.618

(with the numbers on the left being
nfract-interval-age_buffer-nfract_sync-max_readahead, the column entries
being the non-adjusted MB/s that dbench reports, and the columns being
the number of processes).  Unfortunately, these are a bit bunk because I
haven't run the tests enough times to average the results to remove
variance between runs.

If you have any suggestions on better ways than dbench to somewhat
quickly simulate performance for many clients hitting a fileserver at
the same time, I'd love to hear it.

Thanks,

--
Jason Holmes
