Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWJDRva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWJDRva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWJDRv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:51:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:26329 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030685AbWJDRv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:51:27 -0400
Subject: Re: Directories > 2GB
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <20061004165655.GD22010@schatzie.adilger.int>
References: <20061004165655.GD22010@schatzie.adilger.int>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 12:51:20 -0500
Message-Id: <1159984281.10427.7.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 10:56 -0600, Andreas Dilger wrote:
> For ext4 we are exploring the possibility of directories being larger
> than 2GB in size.  For ext3/ext4 the 2GB limit is about 50M files, and
> the 2-level htree limit is about 25M files (this is a kernel code and not
> disk format limit).
> 
> Amusingly (or not) some users of very large filesystems hit this limit
> with their HPC batch jobs because they have 10,000 or 128,000 processes
> creating files in a directory on an hourly basis (job restart files,
> data dumps for visualization, etc) and it is not always easy to change
> the apps.
> 
> My question (esp. for XFS folks) is if anyone has looked at this problem
> before, and what kind of problems they might have hit in userspace and in
> the kernel due to "large" directory sizes (i.e. > 2GB).  It appears at
> first glance that 64-bit systems will do OK because off_t is a long
> (for telldir output), but that 32-bit systems would need to use O_LARGEFILE
> when opening the file in order to be able to read the full directory
> contents.  It might also be possible to return -EFBIG only in the case
> that telldir is used beyond 2GB (the LFS spec doesn't really talk about
> large directories at all).

ext3 directory entries are always multiples of 4 bytes in length.  So
the lowest 2 bits of the offset are always zero.  Right?  Why not shift
the returned offset and f_pos 2 bits right?

JFS uses an index into an array for the position (which isn't even in
the directory traversal order) so it can handle about 2G files in a
directory (although deleted entries aren't reused).
-- 
David Kleikamp
IBM Linux Technology Center

