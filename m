Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWFSSvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWFSSvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWFSSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:51:19 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:39321 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964843AbWFSSuv
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:50:51 -0400
Date: Mon, 19 Jun 2006 12:50:49 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, "Vladimir V. Saveliev" <vs@namesys.com>,
       hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: batched write
Message-ID: <20060619185049.GH5817@schatzie.adilger.int>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Andrew Morton <akpm@osdl.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>, hch@infradead.org,
	Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero> <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de> <1149766000.6336.29.camel@tribesman.namesys.com> <20060608121006.GA8474@infradead.org> <1150322912.6322.129.camel@tribesman.namesys.com> <20060617100458.0be18073.akpm@osdl.org> <20060619162740.GA5817@schatzie.adilger.int> <4496D606.8070402@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4496D606.8070402@namesys.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 19, 2006  09:51 -0700, Hans Reiser wrote:
> Andreas Dilger wrote:
> >With the caveat that I didn't see the original patch, if this can be a step
> >down the road toward supporting delayed allocation at the VFS level then
> >I'm all for such changes.
>
> What do you mean by supporting delayed allocation at the VFS level?  Do
> you mean calling to the FS or maybe just not stepping on the FS's toes
> so much or?  Delayed allocation is very fs specific in so far as I can
> imagine it.

Currently the VM/VFS call into the filesystem in ->prepare_write for each
page to do block allocation for the filesystem.  This is the filesystem's
chance to return -ENOSPC, etc, because after that point the dirty pages
are written asynchronously and there is no guarantee that the application
will even be around when they are finally written to disk.

If the VFS supported delayed allocation it would call into the filesystem
on a per-sys_write basis to allow the filesystem to RESERVE space for all
of the pages in the write call, and then later (under memory pressure,
page aging, or even "pull" from the fs) submit a whole batch of contiguous
pages to the fs efficiently (via ->fill_pages() or whatever).

The fs can know at that time the final file size (if the file isn't still
being dirtied), can allocate all these blocks in a contiguous chunk, can
submit all of the IO in a single bio to the block layer or RPC/RDMA to net.

As you well know, while it is possible to do this now by copying all of the
generic_file_write() logic into the filesystem *_file_write() method, in
practise it is hard to do this from a code maintenance point of view.


Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

