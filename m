Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTDOVN2 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264078AbTDOVN2 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:13:28 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:1272 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264077AbTDOVN1 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:13:27 -0400
Date: Tue, 15 Apr 2003 15:24:21 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.66-mm3 -  bad ext2 performance ?
Message-ID: <20030415152421.X26054@schatzie.adilger.int>
Mail-Followup-To: Badari Pulavarty <pbadari@us.ibm.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <200304151356.24323.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304151356.24323.pbadari@us.ibm.com>; from pbadari@us.ibm.com on Tue, Apr 15, 2003 at 02:00:05PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 15, 2003  14:00 -0700, Badari Pulavarty wrote:
> This is kind of extreem. But  I have 1070 LUNS and I mkfs/mounted (ext2) all
> these and running "fsx" on all of them. 
> 
> I see very bad IO rate on the machine.  fsx with O_DIRECT seems to be
> doing okay. Any ideas on why regular filesystem (buffered) IO sucks ?
> I dont' see even cache increasing ..

Depending on what parameters you have passed to fsx, it isn't necessarily
going to be doing a lot of I/O.  The default for the fsx I have is to max
the file size out at 256kB (on average it will be about half of that), and
you have 1070 instances running, so that agrees with the ~110MB of cache
difference between O_DIRECT and non-O_DIRECT.

Also, in the non-O_DIRECT case fsx will be doing reads from cache and not
disk, so there is no reason to see anything in "bi".  The writes may or
may not be a problem, as fsx is "truncate happy", so some large amounts of
data that are "written" are immediately truncated again.  For O_DIRECT,
everything is going straight to/from disk, hence much higher IO numbers.

What you should really be checking is how many "ops per second" you are
getting from fsx with and without O_DIRECT.  It would be my guess that
the O_DIRECT fsx is actually _slower_ because it is doing more I/O (and
waiting for it to complete).  Run each fsx with some fixed number of ops
(-N <num ops>) and see how long it takes for both tests to complete.

> vmstat:
> ======
> 
>    procs                      memory      swap          io     system      cpu
>  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
> 1089  0  3    0 2597396 169324 219896   0    0     0  2304 1221   330 68 32  0
> 
> vmstat output for O_DIRECT (fsx):
> ===========================
>    procs                      memory      swap          io     system      cpu
>  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
> 36 1034  5    0 2756980 150676  83844   0    0 43269 57496 9446  8861 70 30  0

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

