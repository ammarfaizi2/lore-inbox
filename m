Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWIMJb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWIMJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 05:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWIMJb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 05:31:56 -0400
Received: from brick.kernel.dk ([62.242.22.158]:8032 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750715AbWIMJbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 05:31:55 -0400
Date: Wed, 13 Sep 2006 11:30:09 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Modify blk_rq_map_user to support large requests
Message-ID: <20060913093009.GF23515@kernel.dk>
References: <1157835221.4543.10.camel@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157835221.4543.10.camel@max>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09 2006, Mike Christie wrote:
> Currently, there is some duplication between bsg, scsi_ioctl.c
> and scsi_lib.c/sg/st in its mapping code. This patch modifies
> the block layer blk_rq_map_user code to support large requests so
> that the scsi and block drivers can use this common code. The
> changes also make it so the callers do not have to account for
> the bio to be unmapped and bounce buffers.
> 
> The next patch then coverts bsg.c, scsi_ioctl.c and cdrom.c
> to use the updated functions. For scsi_ioctl.c and cdrom.c
> the only thing that changes is that they no longer have
> to do the bounce buffer management and pass in the len for
> the unmapping. The bsg change is a little larger since that
> code was duplicating a lot of code that is now common
> in the block layer. The bsg conversions als should fix
> a memory leak caused when unmapping a hdr with iovec_count=0.
> 
> Patch was made over Jens's block tree and the bsg branch

Generally it looks good - two comments:

- I see some advantages to having biohead_orig to avoid keeping track of
  it and passing it around, but there's also good reasons for _not_
  adding more stuff to struct request. Any particular reason you chose
  to do that?

- blk_get_bounced_bio() looks redundant. BIO_BOUNCED should only be set
  on a bounced bio, and ->bi_private should always hold that bounced
  bio.

-- 
Jens Axboe

