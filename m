Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTL3Cnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 21:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTL3Cnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 21:43:37 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:57817 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S264257AbTL3Cng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 21:43:36 -0500
Date: Mon, 29 Dec 2003 18:43:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4] Is a negative rsect in /proc/partitions normal?
Message-ID: <20031230024331.GN1882@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031230014429.GL1882@matchmail.com> <20031229191106.I6209@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229191106.I6209@schatzie.adilger.int>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 07:11:06PM -0700, Andreas Dilger wrote:
> On Dec 29, 2003  17:44 -0800, Mike Fedyk wrote:
> > I'm running 2.4.23-rc5, and I've been running bonnie, burnMMX and burnK7 for
> > the last few days on my 3 drive md raid5 array, and I noticed that my
> > rsects[1] have gone negative.  I might consider this normal but /proc/stat
> > (which only shows hda) doesn't show any negative numbers for the same
> > stats[2]
> > 
> > Is this a bug?
> > 
> > [1]
> > major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
> > 
> >   56     0  160086528 hdi 240438349 1318355451 -414508366 16504630 101146331 1132637971 1281537580 24939164 -3 18108868 28693926
> >   56     3  159694132 hdi3 240438290 1318355420 -414508552 16503120 101146229 1132637930 1281537288 24937454 0 19884967 309062
> >   33     0  160086528 hde 240516418 1321486397 -388859454 40325686 90645794 1146603482 1312002136 18444936 -3 14785505 12315041
> >   33     2  159790522 hde2 240516417 1321486394 -388859462 40325686 90645794 1146603482 1312002136 18444936 0 24147141 26883069
> >    3     0  160086528 hda 240675036 1318323453 -412885008 27008859 110939441 1126008079 1306648420 28401642 -3 24294848 41908774
> >    3     3  159694132 hda3 240467546 1317699583 -419535288 24234589 110932078 1125988609 1306423136 28337002 0 4327510 10687939
> 
> Probably just somewhere printing out %ld instead of %lu or similar.  I'm
> sure a trivial patch to fix it would be accepted.

struct hd_struct in include/linux/genhd.h:61 has them all unsigned int.

How's this patch look against 2.4.23?

--- drivers/block/genhd.c.orig	2003-12-29 18:35:35.000000000 -0800
+++ drivers/block/genhd.c	2003-12-29 18:40:11.000000000 -0800
@@ -201,7 +201,7 @@
 
 			disk_round_stats(hd);
 			seq_printf(s, "%4d  %4d %10d %s "
-				      "%d %d %d %d %d %d %d %d %d %d %d\n",
+				      "%u %u %u %u %u %u %u %u %u %u %u\n",
 				      gp->major, n, gp->sizes[n],
 				      disk_name(gp, n, buf),
 				      hd->rd_ios, hd->rd_merges,
