Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWEYGQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWEYGQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWEYGQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:16:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20708 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965018AbWEYGQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:16:33 -0400
Date: Thu, 25 May 2006 16:15:53 +1000
From: David Chinner <dgc@sgi.com>
To: Balbir Singh <balbir@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]  Per-superblock unused dentry LRU lists V2
Message-ID: <20060525061553.GC8069029@melbourne.sgi.com>
References: <20060524110001.GU1331387@melbourne.sgi.com> <20060525040604.GB25185@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060525040604.GB25185@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:36:04AM +0530, Balbir Singh wrote:
> > +/*
> > + * Shrink the dentry LRU on æ given superblock.
> 			      ^^^
> This character (ae) looks strange.

Fixed. It slipped through when I switched to the -mm tree.

> The other changes look fine. Do you have any performance numbers, any
> results from stress tests (for version 2 of the patch)?

Not yet - I've just started the stress tests now. I had to wait for
the storage and then reconfigure it which took some time.  It's
currently running a create/unlink workload across 8 filesystems in
parallel.  I'll run some dbench loads after this has run for a few
hours.

FWIW, this create/unlink load has been triggering reliable "Busy
inodes after unmount" errors that I've slowly been tracking down.
After I fixed the last problem in XFS late last week, I've
been getting a failure that i think is the unmount/prune_dcache
races that you and Neil have recently fixed.

Basically, I'm seeing a transient elevated reference  count on
the root inode of the XFS filesystem during the final put_super()
in generic_shutdown_super(). If I trigger a BUG_ON() when that
elevated reference count is detected, byt he time al the cpus
are stopped and I'm in kdb, the reference count on the root inode
is only 1. The next thing I was going to track was where the dentry
for the root inodes was.

I'll know if this really is the same race soon, as the create/unlink
test would trip it under an hour.....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
