Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVHEHJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVHEHJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVHEHJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:09:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46027 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262890AbVHEHJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:09:15 -0400
Date: Fri, 5 Aug 2005 15:14:15 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050805071415.GC14880@redhat.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122968724.3247.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 09:45:24AM +0200, Arjan van de Ven wrote:

> * +static const uint32_t crc_32_tab[] = .....
> why do you duplicate this? The kernel has a perfectly good set of
> generic crc32 tables/functions just fine

The gfs2_disk_hash() function and the crc table on which it's based are a
part of gfs2_ondisk.h: the ondisk metadata specification.  This is a bit
unusual since gfs uses a hash table on-disk for its directory structure.
This header, including the hash function/table, must be included by user
space programs like fsck that want to decipher a fs, and any change to the
function or table would effectively make the fs corrupted.  Because of
this I think it's best for gfs to keep it's own copy as part of its ondisk
format spec.

> * Why are you using bufferheads extensively in a new filesystem?

bh's are used for metadata, the log, and journaled data which need to be
written at the block granularity, not page.

> why do you use a rwsem and not a regular semaphore? You are aware that
> rwsems are far more expensive than regular ones right?  How skewed is
> the read/write ratio?

Aware, yes, it's the only rwsem in gfs.  Specific skew, no, we'll have to
measure that.

> * +++ b/fs/gfs2/fixed_div64.h	2005-08-01 14:13:08.009808200 +0800
> ehhhh why?

I'm not sure, actually, apart from the comments:

do_div: /* For ia32 we need to pull some tricks to get past various versions
           of the compiler which do not like us using do_div in the middle
           of large functions. */

do_mod: /* Side effect free 64 bit mod operation */

fs/xfs/linux-2.6/xfs_linux.h (the origin of this file) has the same thing,
perhaps this is an old problem that's now fixed?

> * int gfs2_copy2user(struct buffer_head *bh, char **buf, unsigned int offset,
> +		   unsigned int size)
> +{
> +	int error;
> +
> +	if (bh)
> +		error = copy_to_user(*buf, bh->b_data + offset, size);
> +	else
> +		error = clear_user(*buf, size);
> 
> that looks to be missing a few kmaps.. whats the guarantee that b_data
> is actually, like in lowmem?

This is only used in the specific case of reading a journaled-data file.
That seems to effectively be the same as reading a buffer of fs metadata.

> The diaper device is a block device within gfs that gets transparently
> inserted between the real device the and rest of the filesystem.
> 
> hmmmm why not use device mapper or something? Is this really needed?

This is needed for the "withdraw" feature (described in the comment) which
is fairly important.  We'll see if dm could be used instead.

Thanks,
Dave

