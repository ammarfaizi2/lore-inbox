Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTE3Rci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTE3Rci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:32:38 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:16885 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263834AbTE3Rch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:32:37 -0400
Date: Fri, 30 May 2003 11:44:44 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, jacobs@penguin.theopalgroup.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 meta-data performance
Message-ID: <20030530114443.Z29153@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	jacobs@penguin.theopalgroup.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305290923330.11990-100000@penguin.theopalgroup.com> <3ED772F5.8060100@cyberone.com.au> <20030530092111.5bdadf5c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530092111.5bdadf5c.akpm@digeo.com>; from akpm@digeo.com on Fri, May 30, 2003 at 09:21:11AM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2003  09:21 -0700, Andrew Morton wrote:
> So the workload is a `cp -Rl' of a 500,000 file tree?
> 
> Vast amounts of metadata.  ext2 will fly through that.  Poor old ext3 has
> to write everything twice, and has to keep on doing seek-intensive
> checkpointing when the journal fills.
> 
> When we get Andreas's "dont bother reading empty inode blocks" speedup
> going it will help both filesystems quite a bit.

Yes, that code is specifically a win for creating lots of files at once
and also reading large chunks of itable at once, so it will help on both
sides.  The difficulty is that it checks the inode bitmap to decide if
it should read/zero the inode table block, but with the advent of Alex's
no-lock inode allocation this is racy.

I'm thinking that what needs to be done is to lock the inode table buffer
head if we think all of the bits for that block are empty (before setting
a bit there).  Then, we re-check the bitmap before making the read/zero
decision if the itable block is not up-to-date, and zero the buffer and
mark it up-to-date if we again find the corresponding bits are zero, and
mark one bit in-use for our current inode allocation.  Other threads that
are trying to allocate in that region will wait on the buffer head when
they find it not up-to-date, and wake after it has been set up appropriately.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

