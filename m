Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWFUQsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWFUQsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFUQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:48:15 -0400
Received: from thunk.org ([69.25.196.29]:63717 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932259AbWFUQsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:48:14 -0400
Date: Wed, 21 Jun 2006 12:48:23 -0400
From: Theodore Tso <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 0/8] Inode diet v2
Message-ID: <20060621164823.GB28159@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <20060621125146.508341000@candygram.thunk.org> <20060621084217.B7834@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621084217.B7834@openss7.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 08:42:17AM -0600, Brian F. G. Bidulock wrote:
> > Unfortunately, since these structures are used by a large amount of
> > kernel code, some of the patches are quite involved, and/or will
> > require a lot of auditing and code review, for "only" 4 or 8 bytes at
> > a time (maybe more on 64-bit platforms).  However, since there are
> > many, many copies of struct inode all over the kernel, even a small
> > reduction in size can have a large beneficial result, and as the old
> > Chinese saying goes, a journey of thousand miles begins with a single
> > step....
> 
> Can you grep inode_cache /proc/slabinfo to see whether you saved any
> memory at all?

I've been doing this continuously as I do my patches, and, yes, we're
definitely saving memory.  How much memory depends on the
configuration.  In particular, some people may not realize how much
memory CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_MUTEXES, et. al. consume.
They can make the difference between 300-odd bytes and 500-odd bytes
for the base struct inode.

Also, struct inode is part of a number of different
filesystem-specific inodes, so as we gradually slim down the inode, we
can sometimes win with one filsystem more than others.

But just so people can see the results, here they are on a UML system:

                      BEFORE         AFTER 
name               size obj/slab  size obj/slab 
isofs_inode_cache   308   13	   280   14	 
fat_inode_cache     332   12	   304   13	 
ext2_inode_cache    388   10	   360   11	 
ext3_inode_cache    424    9	   396   10	 
reiser_inode_cache  356   11	   328   12	 
shmem_inode_cache   372   10	   344   11	 
proc_inode_cache    296   13	   268   14	 
inode_cache         280   14	   252   15     

By going from 280 to 252 bytes, we've achieved a net savings of 10% on
struct inode, which is definitely not bad.  Is there more work to be
done?  Sure.  But we need to take the first step.

						- Ted

