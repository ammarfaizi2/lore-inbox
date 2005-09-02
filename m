Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVIBLUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVIBLUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 07:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIBLUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 07:20:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25474 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751134AbVIBLUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 07:20:33 -0400
Date: Fri, 2 Sep 2005 13:20:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050902112034.GK4018@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de> <20050830234823.GF780@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830234823.GF780@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, Nathan Scott wrote:
> Hi Jens,
> 
> On Wed, Aug 24, 2005 at 11:28:39AM +0200, Jens Axboe wrote:
> > Ok, updated version.
> 
> One thing I found a bit awkward was the way its putting all inodes
> in the root of the relayfs namespace, with the cpuid tacked on the
> end of the bdevname - I was a bit confused at first when a trace of
> sdd on my 4P box spontaneously created files for "partitions" sdd0,
> sdd1, sdd2, and sdd3 ;).
> 
> I suppose if many more users of relayfs spring into existance, this
> is going to get quite ugly.  Below is a patch that aligns the names
> to the conventions used in sysfs; so, for example, when running two
> traces simultaneously on /dev/sdd and /dev/sdb, instead of this:
> 
> # find /relay
> /relay
> /relay/sdd3
> /relay/sdd2
> /relay/sdd1
> /relay/sdd0
> /relay/sdb3
> /relay/sdb2
> /relay/sdb1
> /relay/sdb0
> 
> it now uses this...
> 
> # find /relay
> /relay
> /relay/block
> /relay/block/sdd
> /relay/block/sdd/trace3
> /relay/block/sdd/trace2
> /relay/block/sdd/trace1
> /relay/block/sdd/trace0
> /relay/block/sdb
> /relay/block/sdb/trace3
> /relay/block/sdb/trace2
> /relay/block/sdb/trace1
> /relay/block/sdb/trace0
> 
> and does the correct dynamic setup and teardown of the hierarchy
> as the userspace tool starts and stops tracing.  I had to modify
> the relayfs rmdir code a bit to make this work properly, I'll
> send a separate patch for that shortly.
> 
> > http://www.kernel.org/pub/linux/kernel/people/axboe/tools/blktrace.c
> > 
> > has been updated as well, the protocol version was increased to
> > accomodate the trace structure changes.
> 
> I have the associated userspace change for this, as well as several
> other fixes and tweaks for your tool - if you could slap a copyright
> and license notice onto that source (pretty please? :) I'll send 'em
> right along.

I've committed this patch. However, there's an issue with it:


> +static struct dentry *blk_create_tree(const char *blk_name)
> +{
> +	struct dentry *dir;
> +
> +	spin_lock(&blk_tree_lock);
> +	if (!blk_tree_root) {
> +		blk_tree_root = relayfs_create_dir("block", NULL);
> +		if (!blk_tree_root) {
> +			spin_unlock(&blk_tree_lock);
> +			return NULL;
> +		}
> +	}
> +	dir = relayfs_create_dir(blk_name, blk_tree_root);
> +	if (!dir)
> +		blk_remove_root();
> +	spin_unlock(&blk_tree_lock);

That doesn't look very safe, relayfs_create_dir() could block. I've
changed the blk_tree_lock to be a simple mutex instead. The patch is
committed to the git repo.

-- 
Jens Axboe

