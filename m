Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262271AbTCHWjV>; Sat, 8 Mar 2003 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbTCHWjV>; Sat, 8 Mar 2003 17:39:21 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:39824 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S262271AbTCHWjU>; Sat, 8 Mar 2003 17:39:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] Re: [Bug 417] New: htree much slower than regular ext3
Date: Sun, 9 Mar 2003 23:54:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: tytso@mit.edu, bzzz@tmi.comex.ru, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <11490000.1046367063@[10.10.2.4]> <20030307214833.00a37e35.akpm@digeo.com> <20030308010424.Z1373@schatzie.adilger.int>
In-Reply-To: <20030308010424.Z1373@schatzie.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030308224956.E1E4FF1859@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 08 Mar 03 09:04, Andreas Dilger wrote:
> I was testing this in UML-over-loop in 2.4, and the difference in speed
> for doing file creates vs. directory creates is dramatic.  For file
> creates I was running 3s per 10000 files, and for directory creates I
> was running 12s per 10000 files.

And  on a 10K scsi disk I'm running 35s per 10,000 directories, which is way, 
way slower than it ought to be.  There are two analysis tools we're hurting 
for badly here:

   - We need to see the physical allocation maps for directories, preferably
     in a running kernel.  I think the best way to do this is a little 
     map-dumper hooked into ext3/dir.c and exported through /proc.

  - We need block-access traces in a nicer form than printks (or nobody
    will ever use them).  IOW, we need LTT or something very much like
    it.

> Depending on the size of the journal vs. how many block/inode bitmaps and
> directory blocks are dirtied, you will likely wrap the journal before you
> return to the first block group, so you might write 20kB * 32000 for the
> directory creates instead of 8kB for the file creates.  You also have a
> lot of seeking to each block group to write out the directory data, instead
> of nearly sequential IO for the inode create case.

Yes, I think that's exactly what's happening.  There are some questions 
remaining, such as why doesn't it happen to akpm.  Another question: why does 
it happen to the directory creates, where the only thing being accessed 
randomly is the directory itself - the inode table is supposedly being 
allocated/dirtied sequentially.

Regards,

Daniel
