Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWFFSDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWFFSDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWFFSDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:03:34 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:28042 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750738AbWFFSDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:03:34 -0400
Date: Tue, 6 Jun 2006 12:03:36 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: Question regarding ext3 extents+mballoc+delalloc
Message-ID: <20060606180336.GS5964@schatzie.adilger.int>
Mail-Followup-To: Holger Kiehl <Holger.Kiehl@dwd.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.61.0606061021330.31147@diagnostix.dwd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606061021330.31147@diagnostix.dwd.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 06, 2006  10:23 +0000, Holger Kiehl wrote:
> Looking at ways to increase write performance on my system using ext3
> Andreas Dilger pointed me to delalloc+mballoc+extent patches. Downloaded
> those from ftp://ftp.clusterfs.com/pub/people/alex/2.6.16.8 and run some
> benchmark, here some results using bonnie++:

[note: this is WITH extents,mballoc,delalloc enabled]

> Version  1.03 ------Sequential Output------ --Sequential Input-  --Random-
>                -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine   Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> 2.6.16.19  16G 59223  91 264155 45 111459 36  57313 99 317944 63  1478   7
>                58814  92 276803 47 110418 36  57105 99 317534 65  1525   5
>                58299  92 274523 48 110290 36  56723 99 318839 65  1502   4
> 
> And here the results when mounting without extents,mballoc,delalloc option:
I was confused initially until I saw ^^^^^^^

> Version  1.03 ------Sequential Output------ --Sequential Input-  --Random-
>                -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine   Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> 2.6.16.19  16G 38621  98 194816 94  87776 49  37921 92 239128 54  1402   5
>                47000  99 194276 94  89232 49  38628 92 240539 55  1399   5
>                45873  98 178195 90  89726 50  38482 92 240490 55  1381   4
> 
> So using delalloc+mballoc+extent gives an approx. 30% increase in 
> performance.

Note also that there is a 50% reduction in CPU usage for writes (27% for
rewrites).  This is important when you are trying to maximize IO from a
single server.  I'm not sure why the read CPU usage increased, though it
may just be a result of increased memcpy due to the higher read throughput
(32% increase in read performance, 18% increase in CPU usage).

> So the question is, why are these patches not included into the kernel?
> I did some very extensive testing for several days and could not discover
> any disadvantage using those patches. I must add that I did not test
> crashes to see if data is lost. Are there any disadvantages using these
> patches?

One of the main reasons this isn't in the kernel yet is that the extents
on-disk format is incompatible with the current ext3 on-disk format.
That is OK for Lustre because the storage servers are essentially
"appliances" that are used in well-controlled environments, but this
isn't so good when random users get involved.  The patches couldn't be
merged until there was some consensus reached about the extents on-disk
format.


There is work currently underway with Red Hat, IBM, CFS, and Bull
to merge the extents support into the kernel.org ext3 code and the
official e2fsprogs, and this will likely also be in the upcoming RHEL5.
Once this is done it will be possible to merge the mballoc and delalloc
changes also.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

