Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWIFHf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWIFHf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWIFHf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:35:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:16109 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751625AbWIFHfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:35:23 -0400
Date: Wed, 6 Sep 2006 13:06:43 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
Message-ID: <20060906073643.GA27784@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 04:57:32PM -0700, Zach Brown wrote:
> There have been a lot of bugs recently due to the way direct_io_worker() tries
> to decide how to finish direct IO operations.  In the worst examples it has
> failed to call aio_complete() at all (hang) or called it too many times (oops).
> 
> This set of patches cleans up the completion phase with the goal of removing
> the complexity that lead to these bugs.  We end up with one path that
> calculates the result of the operation after all off the bios have completed.
> We decide when to generate a result of the operation using that path based on
> the final release of a refcount on the dio structure.

Very nice piece of work ! Thanks for taking this up :)

I have looked through all the patches and the completion path unification
logic looks sound to me (btw, the explanations and comments are very good too).
Not the usual bandaids that we often end up with, but a real cleanup that
should go some way in making at least the most errorprone part of the DIO
code more maintainable (I hope/wish we could also do something similar with
simplifying the locking as well).

Of course with this code, we have to await rigorous testing
... and more reviews, but please consider this as my ack for the approach.

Regards
Suparna

> 
> I tried to progress towards the final state in steps that were relatively easy
> to understand.  Each step should compile but I only tested the final result of
> having all the patches applied.
> 
> The patches result in a slight net decrease in code and binary size:
> 
>  2.6.18-rc4-dio-cleanup/fs/direct-io.c |    8
>  2.6.18-rc5-dio-cleanup/fs/direct-io.c |   94 +++++------
>  2.6.18-rc5-dio-cleanup/mm/filemap.c   |    4
>  fs/direct-io.c                        |  273 ++++++++++++++--------------------
>  4 files changed, 159 insertions(+), 220 deletions(-)
> 
>    text    data     bss     dec     hex filename
> 2592385  450996  210296 3253677  31a5ad vmlinux.before
> 2592113  450980  210296 3253389  31a48d vmlinux.after
> 
> The patches pass light testing with aio-stress, the direct IO tests I could
> manage to get running in LTP, and some home-brew functional tests.  It's still
> making its way through stress testing.  It should not be merged until we hear
> from that more rigorous testing, I don't think.
> 
> I hoped to get some feedback (and maybe volunteers for testing!) by sending the
> patches out before waiting for the stress tests.
> 
> - z
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

