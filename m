Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265599AbTFRXHz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbTFRXHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:07:55 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:62845 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265599AbTFRXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:07:52 -0400
Date: Wed, 18 Jun 2003 16:22:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: i/o benchmarks on 2.5.70* kernels
Message-Id: <20030618162242.115a68df.akpm@digeo.com>
In-Reply-To: <20030618225017.GA15635@rushmore>
References: <20030618225017.GA15635@rushmore>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jun 2003 23:21:49.0674 (UTC) FILETIME=[64D6FCA0:01C335F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> 
> > tiobench on SMP results are not very good, lots of
> > fragmentation
> 
> On uniprocessor with IDE disk, benchmarks look very
> different than SMP/SCSI. Recent -mm on uniprocessor 
> is frequently ahead of 2.5.70/2.5.71.
> 
> All numbers below are uniprocessor/ide.

Yes, there's a hge difference between SMP and UP with ext3, and a
significant difference with ext2.  This is because the block allocator is
borked: on SMP with multiple processes writing multiple files the blocks
get all interleaved.  It's most notable in tiobench - it affects both read
and write bandwidth (read, because the file is already poorly laid out).

This became more serious with the Orlov allocator, and its tendency to put
files closer together on disk.  But Orlov is a net win and no way can we
revert its changes just because the block allocator is stupid.  The XFS
allcoator is smarter, and the effects are clear.

I'm still thinking about the block allocation problem.  I don't like the
ext2 prealloc stuff and would prefer to not conceptually graft it into
ext3.

I don't think the tiobench scenario is a serious problem in real-life -
it's mainly a benchmarking problem.

But the block allocator problem also shows when multiple files are being
slowly grown, and we need to fix it for this real-world case.


> tiobench
> 2.4.21-rc8aa1       8   15.49 47.53%     5.969     3460.66  0.00000  0.00000     33
> 2.5.70-mm7          8   14.86 48.31%     6.171     1345.95  0.00000  0.00000     31
> 2.5.70-mm6          8   14.78 47.73%     6.147     1292.34  0.00000  0.00000     31
> 2.5.70-mm1          8   14.56 45.80%     6.234     1370.54  0.00000  0.00000     32
> 2.5.70-mm3          8   14.45 45.42%     6.277     1481.31  0.00000  0.00000     32
> 2.5.70-mm5          8   14.41 45.67%     6.326     1477.68  0.00000  0.00000     32
> 2.5.69-ac1          8   10.60 15.37%     8.765      791.57  0.00000  0.00000     69
> 2.5.70              8   10.53 14.77%     8.800      866.26  0.00000  0.00000     71
> 2.5.71              8   10.21 12.78%     9.086     1126.91  0.00000  0.00000     80

-aa's huge readahead window seems to be as affective as anticipatory
scheduling here.

> 2.5.70-mm6        128   13.24 37.65%    95.348    62124.61  2.36968  0.07667     35
> 2.5.70-mm5        128   13.05 36.58%    96.072    65599.84  2.24152  0.10757     36
> 2.5.70-mm3        128   13.01 37.47%    93.371   124939.92  2.02942  0.11635     35
> 2.5.70-mm7        128   12.65 39.38%   106.741    30835.10  1.99966  0.00152     32
> 2.5.70-mm1        128   12.57 33.23%    98.494   113042.54  2.30483  0.14649     38
> 2.4.21-rc8aa1     128    9.20 26.93%    95.763    80411.93  1.00212  0.14877     34
> 2.5.70            128    9.14 14.14%   152.896    47046.50  0.78164  0.01373     65
> 2.5.71            128    5.66  7.67%   209.858    36249.59  0.26436  0.00572     74

But as the number of threads is increased, -aa might have hit readahead thrashing.

> dbench ext2 64 processes         Average	High		Low (MB/sec)
> 2.4.21-rc8aa1           	 42.13		 42.51		 41.68
> 2.4.21-rc3               	 39.59		 40.16		 39.13
> 2.5.70                   	 31.47		 40.51		 18.76
> 2.5.70-mm3               	 27.97		 32.61		 21.67
> 2.5.70-mm6               	 27.41		 36.07		 21.19
> 2.5.70-mm7               	 27.06		 28.47		 25.08
> 2.5.69-ac1               	 26.45		 37.44		 20.19
> 2.5.70-mm5               	 26.31		 37.12		 21.88
> 2.5.70-mm1               	 18.59		 24.52		 14.06
> 2.5.71                   	  8.11		 14.62		  3.89

2.5's dbench throughput took a bullet ages ago, when I merged the below
fairness patch.

I don't have any plans to un-merge it.  The fact is, allowing one writer to
starve out all the others improves dbench throughput but worsens latency in
many other situations.   dbench can get stuffed.




When a throttled writer is performing writeback, and it encounters an inode
which is already under writeback it is forced to wait on the inode.  So that
process sleeps until whoever is writing it out finishes the writeout.

Which is OK - we want to throttle that process, and another process is
currently pumping data at the disk anyway.

But in one situations the delays are excessive.  If one process is performing
a huge linear write, other processes end up waiting for a very long time
indeed.  It appears that this is because the writing process just keeps on
hogging the CPU, returning to userspace, generating more dirty data, writing
it out, sleeping in get_request_wait, etc.  All other throttled dirtiers get
starved.

So just remove the wait altogether if it is just a memory-cleansing writeout.
 The calling process will then throttle in balance_dirty_pages()'s call to
blk_congestion_wait().


diff -puN fs/fs-writeback.c~dont-wait-on-inode fs/fs-writeback.c
--- 25/fs/fs-writeback.c~dont-wait-on-inode	2003-02-03 23:47:06.000000000 -0800
+++ 25-akpm/fs/fs-writeback.c	2003-02-03 23:47:06.000000000 -0800
@@ -185,11 +185,14 @@ static void
 __writeback_single_inode(struct inode *inode,
 			struct writeback_control *wbc)
 {
-	if (current_is_pdflush() && (inode->i_state & I_LOCK)) {
+	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		return;
 	}
 
+	/*
+	 * It's a data-integrity sync.  We must wait.
+	 */
 	while (inode->i_state & I_LOCK) {
 		__iget(inode);
 		spin_unlock(&inode_lock);

_


