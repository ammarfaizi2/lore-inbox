Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQJZSeZ>; Thu, 26 Oct 2000 14:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbQJZSeP>; Thu, 26 Oct 2000 14:34:15 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:56110 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129069AbQJZSeB>; Thu, 26 Oct 2000 14:34:01 -0400
Date: Thu, 26 Oct 2000 13:34:00 -0500 (CDT)
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
Message-Id: <200010261834.NAA09281@merlin.admin.navo.hpc.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: Topic for discussion: OS Design
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de>:
> On Thu, Oct 26, 2000 at 11:00:03AM -0500, Jesse Pollard wrote:
> > Keith Owens <kaos@ocs.com.au>:
> > > 
> > > On Thu, 26 Oct 2000 09:17:49 -0400 (EDT), 
> > > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> > [snip]
> > > >This shows that out of 34,678 bytes we needed, we wasted 6282, ~1.5
> > > >pages. Since there are 5 modules, we waste about 1/3 page per module.
> > > >
> > > >So I don't, as you say; "... waste 1/2 page or more per module".
> > > 
> > > Statistics say that the average loss will be 1/2 page per module.  Some
> > > will waste more, some will waste less, average is 1/2 the unit.
> > 
> > Only if the size of a random module can be between 0 and a full page....
> > 
> > Module sizes are skewed data... there is a minimum size for a module
> > (somewhere around 1k, I believe - didn't measure it), and if the module
> > is going to DO anything then it will be between 1-2K. This skews the data
> > sample such that you are only loosing 1/2 of (1 page - minimum) or 1/2 of
> > 3K = 1.5K. Hence the 1/3 measured loss will be closer to the correct
> > theoretical loss than 1/2.
> 
> You're forgetting that longer modules wrap at the end to a full page, which
> makes all values possible again.

You appear to be right....  I thought of them as anomalies, but there are
more of them than I believed. I was also thinking of the total number of
pages for the modules rather than the total number of modules.

The following is from my server (SCSI based, but does have IDE disks too):

module	    size				   pages	 loss
--------- ------                                  --------	--------
vfat        9116   0  (unused)			   2.22559	0.774414
smbfs      26232   0  (unused)			   6.4043	0.595703
msdos       5180   0  (unused)			   1.26465	0.735352
isofs      17432   0  (unused)			   4.25586	0.744141
fat        30240   0  [vfat msdos]		   7.38281	0.617188
3c509       6004   1  				   1.46582	0.53418
ide-probe   6244   0  				   1.52441	0.475586
ide-disk    5800   0  				   1.41602	0.583984
ide-cd     23028   0  				   5.62207	0.37793
ide-mod    44536   0  [ide-probe ide-disk ide-cd]  10.873	0.126953
sb         33876   0  				   8.27051	0.729492
uart401     5968   0  [sb]			   1.45703	0.542969
sound      57336   0  [sb uart401]		  13.998	0.00195312
soundlow     224   0  [sound]			   0.0546875	0.945312
soundcore   2308   5  [sb sound]		   0.563477	0.436523
serial     19284   0  (unused)			   4.70801	0.291992
lp          5180   0  				   1.26465	0.735352
parport_pc  5652   1  				   1.37988	0.620117
parport     7208   1  [lp parport_pc]		   1.75977	0.240234

averages:					   3.99423	0.532072

So the average size of a module is 3.9 pages and the average size of lost space in a
page IS close to .5 (actually a little greater).

If the two anomilies (ide-mod and sound) are dropped then the average size of lost space
is 0.525288, even close to .5.

The only remaining anomily is the soundlow module (size 224). If this one is dropped
too then the average size of lost page space is 0.475535.

Looking at this, the overall wasted space is a whopping 10.1 pages or 40K.
Not bad at all.

BTW, all values taken from a Linux 2.2.13.SMP system.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
