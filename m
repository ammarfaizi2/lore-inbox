Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSJAUkc>; Tue, 1 Oct 2002 16:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262489AbSJAUkb>; Tue, 1 Oct 2002 16:40:31 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:19191 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262302AbSJAUkH>; Tue, 1 Oct 2002 16:40:07 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 1 Oct 2002 14:43:30 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021001204330.GO3000@clusterfs.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20021001195914.GC6318@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001195914.GC6318@stingr.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01, 2002  23:59 +0400, Paul P Komkoff Jr wrote:
> This is the stupidiest testcase I've done but it worth seeing (maybe)
> 
> We create 300000 files named from 00000000 to 000493E0 in one
> directory, then delete it in order.
> 
> Tests taken on ext3+htree and reiserfs. ext3 w/o htree hadn't
> evaluated because it will take long long time ...
> 
> both filesystems was mounted with noatime,nodiratime and ext3 was
> data=writeback to be somewhat fair ...

Why do you think data=writeback is better than data=journal?  If the
files have no data then it should not make a difference.

> 	       	real 	      	user  		sys
> reiserfs:
> Creating: 	3m13.208s	0m4.412s	2m54.404s
> Deleting:	4m41.250s	0m4.206s	4m17.926s
> 
> Ext3:
> Creating:	4m9.331s	0m3.927s	2m21.757s
> Deleting:	9m14.838s	0m3.446s	1m39.508s
> 
> htree improved this a much but it still beaten by reiserfs. seems odd
> to me - deleting taking twice time then creating ...

This is a known issue with the current htree code (not the algorithm
or the on-disk format, luckily).  The problem is that inodes are being
allocated essentially sequentially on disk.  If you are deleting in
creation order (as you are) then you are randomly dirtying directory
leaf blocks, and if you are deleting in readdir() order, then you are
randomly dirtying inode blocks.

As a result, if the size of the directory + inode table blocks is larger
than memory, and also larger than 1/4 of the journal, you are essentially
seek-bound because of random block dirtying.

This can be fixed by changing the inode allocation routines to allocate
inodes in "chunks" which correspond to the leaf page for which the
dirent is being allocated.  This will try to keep the inodes for a given
directory block relatively close together on disk and greatly improve
delete performance.

You should see what the size of the directory is at its peak (probably
16 bytes * 300k ~= 5MB, and add in the size of the directory blocks
(128 bytes * 300k ~= 38MB) and make the journal 4x as large as that,
so 192MB (mke2fs -j -J size=192) and re-run the test (I assume you have
at least 256MB+ of RAM on the test system).

What is very interesting from the above results is that the CPU usage
is _much_ smaller for ext3+htree than for reiserfs.  It looks like
reiserfs is nearly CPU-bound by the tests, so it is unlikely that they
can run much faster.  In theory, ext3+htree run at the CPU time if we
fixed the allocation and/or seeking issues.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

