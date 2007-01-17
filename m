Return-Path: <linux-kernel-owner+w=401wt.eu-S1751326AbXAQX16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXAQX16 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 18:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAQX16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 18:27:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26950 "EHLO virtualhost.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbXAQX15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 18:27:57 -0500
Date: Thu, 18 Jan 2007 10:18:47 +1100
From: Jens Axboe <jens.axboe@oracle.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH: 2.6.20-rc4-mm1] JFS: Avoid deadlock introduced by explicit  I/O plugging
Message-ID: <20070117231847.GH3508@kernel.dk>
References: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17 2007, Dave Kleikamp wrote:
> Jens,
> Can you please take a look at this patch, and if you think it's sane,
> add it to your explicit i/o plugging patchset?  Would it make sense in
> any of these paths to use io_schedule() instead of schedule()?

I'm glad you bring that up, actually. One of the "downsides" of the new
unplugging is that it really requires anyone waiting for IO in a path
like the file system or device driver to use io_schedule() instead of
schedule() to get the blk_replug_current_nested() done to avoid
deadlocks. While it is annoying that it could introduce some deadlocks
until we get things fixed it, I do consider it a correctness fix even in
the generic kernel, as you are really waiting for IO and as such should
use io_schedule() in the first place.

Perhaps I should add a WARN_ON() check for this to catch these bugs
upfront.

> I hadn't looked at your patchset until I discovered that jfs was easy to
> hang in the -mm kernel.  I think jfs may be able to add explicit
> plugging and unplugging in a couple of places, but I'd like to fix the
> hang right away and take my time with any later patches.

Can you try io_schedule() and verify that things just work?

-- 
Jens Axboe

