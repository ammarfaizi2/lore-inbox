Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263348AbSJFGxv>; Sun, 6 Oct 2002 02:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263349AbSJFGxv>; Sun, 6 Oct 2002 02:53:51 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:33408 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263348AbSJFGxs> convert rfc822-to-8bit; Sun, 6 Oct 2002 02:53:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: load additions to contest
Date: Sun, 6 Oct 2002 16:56:44 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, rcastro@ime.usp.br, ciarrocchi@linuxmail.org
References: <20021005182850.31930.qmail@linuxmail.org> <200210061538.43778.conman@kolivas.net> <3D9FD407.D595BC49@digeo.com>
In-Reply-To: <3D9FD407.D595BC49@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210061656.47182.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 06 Oct 2002 4:11 pm, Andrew Morton wrote:
> Con Kolivas wrote:
> > ...
> >
> > tarc_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.19 [2]              88.0    74      50      25      1.31
> > 2.4.19-cc [1]           86.1    78      51      26      1.28
> > 2.5.38 [1]              91.8    74      46      22      1.37
> > 2.5.39 [1]              94.4    71      58      27      1.41
> > 2.5.40 [1]              95.0    71      59      27      1.41
> > 2.5.40-mm1 [1]          93.8    72      56      26      1.40
> >
> > This load repeatedly creates a tar of the include directory of the linux
> > kernel. You can see a decrease in performance was visible at 2.5.38
> > without a concomitant increase in loads, but this improved by 2.5.39.
>
> Well the kernel compile took 7% longer, but the tar got 10% more
> work done.  I expect this is a CPU scheduler artifact.  The scheduler
> has changed so much, it's hard to draw any conclusions.
>
> Everything there will be in cache.  I'd suggest that you increase the
> size of the tarball a *lot*, so the two activities are competing for
> disk.

Ok I'll go back to the original idea of tarring the whole kernel directory. It 
needs to be something constant size obviously.

>
> > tarx_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.19 [2]              87.6    74      13      24      1.30
> > 2.4.19-cc [1]           81.5    80      12      24      1.21
> > 2.5.38 [1]              296.5   23      54      28      4.41
> > 2.5.39 [1]              108.2   64      9       12      1.61
> > 2.5.40 [1]              107.0   64      8       11      1.59
> > 2.5.40-mm1 [1]          120.5   58      12      16      1.79
> >
> > This load repeatedly extracts a tar  of the include directory of the
> > linux kernel. A performance boost is noted by the compressed cache kernel
> > consistent with this data being cached better (less IO). 2.5.38 shows
> > very heavy writing and a performance penalty with that. All the 2.5
> > kernels show worse performance than the 2.4 kernels as the time taken to
> > compile the kernel is longer even though the amount of work done by the
> > load has decreased.
>
> hm, that's interesting.  I assume the tar file is being extracted
> into the same place each time?  Is tar overwriting the old version,
> or are you unlinking the destination first?

Into the same place and overwriting the original.

>
> It would be most interesting to rename the untarred tree, so nothing
> is getting deleted.

Ok, this is going to take up a lot of space though.

>
> Which filesystem are you using here?

ReiserFS (sorry dont have any other hardware/fs to test on)

>
> > read_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.19 [2]              134.1   54      14      5       2.00
> > 2.4.19-cc [2]           92.5    72      22      20      1.38
> > 2.5.38 [2]              100.5   76      9       5       1.50
> > 2.5.39 [2]              101.3   74      14      6       1.51
> > 2.5.40 [1]              101.5   73      13      5       1.51
> > 2.5.40-mm1 [1]          104.5   74      9       5       1.56
> >
> > This load repeatedly copies a file the size of the physical memory to
> > /dev/null. Compressed caching shows the performance boost of caching more
> > of this data in physical ram - caveat is that this data would be simple
> > to compress so the advantage is overstated. The 2.5 kernels show
> > equivalent performance at 2.5.38 (time down at the expense of load down)
> > but have better performance at 2.5.39-40 (time down with equivalent load
> > being performed). 2.5.40-mm1 seems to exhibit the same performance as
> > 2.5.38.
>
> That's complex.  I expect there's a lot of eviction of executable
> text happening here.  I'm working on tuning that up a bit.
>
> > lslr_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.19 [2]              83.1    77      34      24      1.24
> > 2.4.19-cc [1]           82.8    79      34      24      1.23
> > 2.5.38 [1]              74.8    89      16      13      1.11
> > 2.5.39 [1]              76.7    88      18      14      1.14
> > 2.5.40 [1]              74.9    89      15      12      1.12
> > 2.5.40-mm1 [1]          76.0    89      15      12      1.13
> >
> > This load repeatedly does a `ls -lR >/dev/null`. The performance seems to
> > be overall similar, with the bias towards the kernel compilation being
> > performed sooner.
>
> How many files were under the `ls -lR'?  I'd suggest "zillions", so
> we get heavily into slab reclaim, and lots of inode and directory
> cache thrashing and seeking...

The ls -lR was an entire kernel tree (to remain constant between runs). I dont 
think I can keep it constant and make it much bigger without creating some 
sort of fake dir tree unless you can suggest a different approach. I guess 
overall `ls -lr /` will not be much different in size between runs if you 
think that would be satisfactory.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9n96uF6dfvkL3i1gRAundAJ9YuHm4wPDw7OEWUgb3jOXk9oludgCfeslh
3aHxF8OcN1Cm8ep8g64K/ag=
=/f7y
-----END PGP SIGNATURE-----
