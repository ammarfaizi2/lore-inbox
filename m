Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWIKXeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWIKXeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbWIKXeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:34:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:15301 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965081AbWIKXeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:34:10 -0400
Message-ID: <4505F26B.3040003@garzik.org>
Date: Mon, 11 Sep 2006 19:34:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 01/19] raid5: raid5_do_soft_block_ops
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231740.4737.48922.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231740.4737.48922.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> raid5_do_soft_block_ops consolidates all the stripe cache maintenance
> operations into a single routine.  The stripe operations are:
> * copying data between the stripe cache and user application buffers
> * computing blocks to save a disk access, or to recover a missing block
> * updating the parity on a write operation (reconstruct write and
> read-modify-write)
> * checking parity correctness
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  drivers/md/raid5.c         |  289 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/raid/raid5.h |  129 +++++++++++++++++++-
>  2 files changed, 415 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 4500660..8fde62b 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -1362,6 +1362,295 @@ static int stripe_to_pdidx(sector_t stri
>  	return pd_idx;
>  }
>  
> +/*
> + * raid5_do_soft_block_ops - perform block memory operations on stripe data
> + * outside the spin lock.
> + */
> +static void raid5_do_soft_block_ops(void *stripe_head_ref)

This function absolutely must be broken up into multiple functions, 
presumably one per operation.

	Jeff



