Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVKEBEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVKEBEX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVKEBEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:04:22 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:31929 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751394AbVKEBEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:04:22 -0500
Message-ID: <436C04FE.6000708@oracle.com>
Date: Fri, 04 Nov 2005 17:03:58 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v
References: <20051102233020.27835.89951.sendpatchset@volauvent.pdx.zabbo.net> <20051105002406.GA11235@lst.de>
In-Reply-To: <20051105002406.GA11235@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Nov 02, 2005 at 03:27:29PM -0800, Zach Brown wrote:
>
>>vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v
>
> The aio.c portion looks nice.  I'm not happy about the filesystems bits.
> The last thing we want is another set of read/write file operations.

Yeah, I can't possibly disagree.

> So
> as part of the patch (it'll probably grow into a series) we should
> remove the aio non-vectored and maybe even the plain vectored
> operations.

What sort of time line are you thinking for this?  Removing the plain vectored
operation sounds pretty aggressive :) I'll admit to fearing that the simple aio
vectored api addition will get backed up behind a grand api reorganization.

But, in any case, I'm happy to lend some time to the mechanical API shuffling
and testing.  Let me know how we can coordinate efforts effectively.

If we're going down this path, and find ourselves touching every vectored
implementation in the world, I wonder if we shouldn't consider that iovec
container.  The desire is to avoid the duplicated iovec walking that happens at
the various layers by storing the result of a single walk.  An ext3 O_DIRECT
write walks the iovec no fewer than 7 times:

 do_readv_writev
 __generic_file_aio_write_nolock
 generic_file_direct_IO (via iov_length)
 ext3_direct_IO (via_iov_length)
 __blockdev_direct_IO
 direct_io_worker (twice)

That's the pathological case.  Buffered ext3 only gets 3 walks, 2 is somewhat
obviously the minimum.  Maybe we don't care about the cache pressure of huge
vectored o_direct writes?  I just thought we might be sad if we realized we
*did* care about avoiding those duplicated walks after having just spent weeks
shuffling the vectored fs ops around.

- z
