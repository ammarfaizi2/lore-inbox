Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbVJSWtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbVJSWtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVJSWtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:49:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751617AbVJSWte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:49:34 -0400
Date: Wed, 19 Oct 2005 15:49:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Pifke <dave@bebo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about buffer usage
Message-Id: <20051019154940.55f18786.akpm@osdl.org>
In-Reply-To: <4356C1B2.3070401@bebo.com>
References: <4356C1B2.3070401@bebo.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Pifke <dave@bebo.com> wrote:
>
> I'm doing some performance tweaking on a web server and am curious about 
> a memory usage pattern I'm seeing.  After doing some Googling I'm still 
> not sure whether what I'm seeing is normal or is indicative of 
> suboptimal VM or VFS behavior.
> 
> The system has 2GB of RAM.  At the moment, ~117MB is free, ~1.5GB is 
> being used for buffers(!), and ~180MB is cached.  I would expect cache 
> to be much larger than buffers.

Maybe not, with lots of small files.  All the metadata associated with
those files (directory blocks, inode blocks, allocation maps, etc) is
cached in the blockdev pagecache (aka buffer cache).

> According to Documentation/filesystems/proc.txt:
> 
>       Buffers: Relatively temporary storage for raw disk blocks
>                shouldn't get tremendously large (20MB or so)
> 
> 75% of total RAM is seeming tremendously large to me. :)

The document is optimistic ;)

> I'm running Debian stable on a dual-Opteron system:
> 
> Linux file003b 2.6.8-11-amd64-k8-smp #1 SMP Wed Jun 1 00:01:27 CEST 2005 
> x86_64 GNU/Linux
> 
> (I can upgrade the kernel if this is a known issue with 2.6.8.)

I wouldn't expect later kernels would change this a lot.

> Perhaps of interest is that I have a 2TB JFS filesystem on a 3ware SATA 
> RAID controller.

It could be a JFS quirk - I don't know much about JFS.  It'd be interesting
to know if other filesystems behave in a similar manner.

>  The machine is running Apache (mpm_worker) and that's 
> about it.  It's all image files - a third thumbnails (<1kB), a third 
> resized to the 50-100kB range, and a third originals (max 1MB). 
> Thumbnails should be getting served much more frequently than the 
> others, so the disk access pattern is lots of small files.  Directories 
> are hashed year/month/day/hour with maybe 4000 files in each.
> 
> slabtop shows ~161MB total size (I think this counts against buffers?). 
>   Far and away the bigest users are buffer_head at ~50MB and 
> radix_tree_node at ~99MB.

I'd have expected more dentry_cache.

> The machine is fairly responsive, but I'm seeing a load average of 
> between 2 and 3 with about 250 concurrent Apache requests - I'm 
> obviously hoping for better performance.
> 
> Ideas?  Or is this about what one would expect given the system 
> configuration and workload?

One thing you could do is to (re)mount the filesystems with `-o noatime'.

When userspace reads a file the kernel will update the atime.  This
involves dirtying the in-core inode and later writing it to an on-disk
inode.  That write requires that the on-disk inode's block be in blockdev
pagecache.

With `-o noatime', the kernel will no longer need to write the inode atimes
and will satisfy all inode read requests from the separate inode cache. 
Hence the blockdev pagecache page which backs the inode will remain
untouched and will be reclaimed.

That should release _some_ of the blockdev pagecache, but not a lot, I
expect.  Maybe JFS is just metadata-intensive..

