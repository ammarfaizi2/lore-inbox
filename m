Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWFSS2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWFSS2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWFSS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:28:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57804 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932215AbWFSS2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:28:34 -0400
Date: Mon, 19 Jun 2006 19:28:33 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060619182833.GJ27946@ftp.linux.org.uk>
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk> <20060619064721.GA6106@rain.homenetwork> <20060619073229.GI27946@ftp.linux.org.uk> <20060619131750.GA14770@rain.homenetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619131750.GA14770@rain.homenetwork>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 05:17:50PM +0400, Evgeniy Dushistov wrote:
> In case of 1k fragments, msync of two pages
> cause 8 calls of ufs's get_block_t with create == 1,
> they will be consequent because of synchronization.

_What_ synchronization?

To simplify the analysis, have one of those do msync() and another - write().
One triggers writeback, leading to ufs_writepage().  Another leads to call
of ufs_prepare_write().  Note that the latter call is process-synchronous,
so no implicit serialization could apply.

Now, which lock would, in your opinion, provide serialization between these
two calls?  They apply to different pages, so page locks do not help.

And yes, we do need some serialization between get_block_t here, indeed.
As it is, we don't have any.

Note that there is another problem with use of fs/buffer.c helpers.  They
assume that there are 3 states of buffer_head corresponding to fragment:
	* mapped to known disk block
	* known to be in hole
	* not known
And that's where we have a problem.  block_read_full_page() on page 0
will get all buffer_head on that page (one for each fragment) to
the second state.  block_prepare_write() will get all buffer_head on
page 1 to the first state after the callback allocates the first direct block
of file (they will be mapped to the fragments in that block, at offsets 4Kb
and further).

But now we have the buffer_heads on page 0 in the state inconsistent with
the reality - basically, fs/buffer.c helpers will assume that they are
_still_ in the second state (known to be in hole), while in the reality
they should be either in the first or in the third one (mapped to known
disk block or not known).

It's not a fundamental problem; however, it does mean that using these
helpers means using library functions in situation they'd never been designed
for.  IOW, you need very careful analysis of the assumptions made by
the entire bunch and, quite possibly, need versions modified for UFS.
