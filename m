Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279614AbRKIHPu>; Fri, 9 Nov 2001 02:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279603AbRKIHPl>; Fri, 9 Nov 2001 02:15:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:58888 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279596AbRKIHPW>; Fri, 9 Nov 2001 02:15:22 -0500
Message-ID: <3BEB8147.10AC41ED@zip.com.au>
Date: Thu, 08 Nov 2001 23:09:59 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Alexander Viro <viro@math.psu.edu>, ext2-devel@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext2/ialloc.c cleanup
In-Reply-To: <20011108154311.E9043@lynx.no> <Pine.GSO.4.21.0111081802250.8052-100000@weyl.math.psu.edu> <3BEB7464.245FBB23@zip.com.au>,
		<3BEB7464.245FBB23@zip.com.au>; from akpm@zip.com.au on Thu, Nov 08, 2001 at 10:15:00PM -0800 <20011108235632.D907@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> > Tree  Stock   Stock/ideal     Patched Patched/stock   Orlov   Orlov/ideal
> >       (secs)                  (secs)                  (secs)
> 
> Andrew, could you stick with a single metric (either /ideal or /stock)?

yup.
 
> > 12    54      4.15            101     187.04%         76      5.85
> > 13    82      6.31            104     126.83%         78      6
> > 14    89      6.85            103     115.73%         77      5.92
> > 15    88      6.77            95      107.95%         77      5.92
> > 16    106     8.15            99      93.40%          77      5.92
> 
> What else would be useful here is percent full for the filesystem.
> Since stock ext2 preallocates up to 7 blocks for each file, this is good
> for reducing fragmentation, but as the filesystem gets full it makes
> fragmentation worse in the end.

After the 17th iteration the fs was 75% full, so at iteration 8
we're at 37%, etc.

> > So I just don't know at this stage.  Even after a single pass of the Smith
> > workload, we're running at 3x to 5x worse than ideal.  If that's simply
> > the best we can do, then we need to compare stock 2.4.14 with Orlov
> > partway through the progress of the Smith workload to evaluate how much
> > more serious the fragmentation is.   That's easy enough - I'll do it.
> >
> > The next task is to work out why a single pass of the Smith workload
> > fragments the filesystem so much, and whether this can be improved.
> 
> After reading the paper, one possible cause of skewed results may be
> a result of their "reverse engineering" of the filesystem layout from
> the inode numbers.  They state that they were not able to capture the
> actual pathnames of the files in the workload, so they invented pathnames
> that would put the files in the same cylinder groups based on the FFS
> allocation algorithms then in use, assuming the test filesystem had an
> identical layout.

Their attempt to put each top-level dir in its own cylinder group
_may_ work with ext2 on pass zero, but it'll come unstuck on passes
one to sixteen.  I've been treating this as basically random fs
activity.   Any conclusions need to verified with Constantin's
test code.

> ...
> Have you ever looked at the resulting data from a Smith test?  Does it do
> more than simply create 27 directories (the number of cylinder groups) and
> dump files directly therein, as opposed to creating more subdirectories?
> Remember that they were strictly concerned with block allocation for files,
> and not cylinder group selection for directories.
> 

True.  At the end of the run, we end up with 62 directories and
8757 files.  So under

/mountpoint/NN/

we end up with 61 directories and 474 files.  The remainder of the
files are immediately under thos 61 directories.  It's a wide and
shallow layout.
