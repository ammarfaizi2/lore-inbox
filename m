Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVKGExR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVKGExR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVKGExQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:53:16 -0500
Received: from verein.lst.de ([213.95.11.210]:2016 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932257AbVKGExQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 23:53:16 -0500
Date: Mon, 7 Nov 2005 05:53:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v
Message-ID: <20051107045300.GA17265@lst.de>
References: <20051102233020.27835.89951.sendpatchset@volauvent.pdx.zabbo.net> <20051105002406.GA11235@lst.de> <436C04FE.6000708@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436C04FE.6000708@oracle.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 05:03:58PM -0800, Zach Brown wrote:
> > So
> > as part of the patch (it'll probably grow into a series) we should
> > remove the aio non-vectored and maybe even the plain vectored
> > operations.
> 
> What sort of time line are you thinking for this?  Removing the plain vectored
> operation sounds pretty aggressive :) I'll admit to fearing that the simple aio
> vectored api addition will get backed up behind a grand api reorganization.

I plan to get this done soonish.  It really depends on how fast akpm
sends the first steps to Linus and on what kind of feedback I get.
Probably not 2.6.15 but soon after if everything goes well.

> If we're going down this path, and find ourselves touching every vectored
> implementation in the world, I wonder if we shouldn't consider that iovec
> container.  The desire is to avoid the duplicated iovec walking that happens at
> the various layers by storing the result of a single walk.  An ext3 O_DIRECT
> write walks the iovec no fewer than 7 times:
> 
>  do_readv_writev
>  __generic_file_aio_write_nolock
>  generic_file_direct_IO (via iov_length)
>  ext3_direct_IO (via_iov_length)
>  __blockdev_direct_IO
>  direct_io_worker (twice)
> 
> That's the pathological case.  Buffered ext3 only gets 3 walks, 2 is somewhat
> obviously the minimum.  Maybe we don't care about the cache pressure of huge
> vectored o_direct writes?  I just thought we might be sad if we realized we
> *did* care about avoiding those duplicated walks after having just spent weeks
> shuffling the vectored fs ops around.

As we discussed a while ago adding some kinds of fs_iovec or kern_iovec
structure that records useful addition information could help this.
Would you mind prototyping it?
The nice part about the consolidation work I'm doing now is that we'd
need to touch much fewer places for this than before.
