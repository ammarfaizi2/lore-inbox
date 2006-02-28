Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWB1KUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWB1KUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWB1KUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:20:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16971 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750881AbWB1KUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:20:36 -0500
Date: Tue, 28 Feb 2006 11:20:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060228102005.GU24981@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393BFB8@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270393BFB8@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28 2006, Andy Chittenden wrote:
> With Andi's patch (and Jens' printk patch), I haven't seen a OOM but I'm
> now seeing lots of "hda: DMA table too small" messages in dmesg. Is that
> anything to worry about? Here's the complete output:

Oops, that's definitely _not_ a good thing. The IDE driver recovers by
using PIO for that case, but it's something that really should not
happen.

This usually happens because the block layer thinks the iommu will
coalesce certain segments which it then does not. Do the messages go
away if you do:

> Looks like a VIA chipset. Disabling IOMMU. Overwrite with
> "iommu=allowed"

like that suggests?

It might also be that a page gets bounced and thus forms a new segment
and we weren't conservative enough in gauging that. We do check for that
in blk_recount_segments(), though...

If the iommu work-around doesn't help, we probably need to add some
debug code in ide-dma.c to dump the scatterlist so we can see where it
went wrong.

-- 
Jens Axboe

