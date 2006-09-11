Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWIKXgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWIKXgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWIKXgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:36:55 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21189 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965081AbWIKXgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:36:53 -0400
Message-ID: <4505F311.7050901@garzik.org>
Date: Mon, 11 Sep 2006 19:36:49 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 02/19] raid5: move write operations to a workqueue
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231746.4737.82707.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231746.4737.82707.stgit@dwillia2-linux.ch.intel.com>
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
> Enable handle_stripe5 to pass off write operations to
> raid5_do_soft_blocks_ops (which can be run as a workqueue).  The operations
> moved are reconstruct-writes and read-modify-writes formerly handled by
> compute_parity5.
> 
> Changelog:
> * moved raid5_do_soft_block_ops changes into a separate patch
> * changed handle_write_operations5 to only initiate write operations, which
> prevents new writes from being requested while the current one is in flight
> * all blocks undergoing a write are now marked locked and !uptodate at the
> beginning of the write operation
> * blocks undergoing a read-modify-write need a request flag to distinguish
> them from blocks that are locked for reading. Reconstruct-writes still use
> the R5_LOCKED bit to select blocks for the operation
> * integrated the work queue Kconfig option
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  drivers/md/Kconfig         |   21 +++++
>  drivers/md/raid5.c         |  192 ++++++++++++++++++++++++++++++++++++++------
>  include/linux/raid/raid5.h |    3 +
>  3 files changed, 190 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index bf869ed..2a16b3b 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -162,6 +162,27 @@ config MD_RAID5_RESHAPE
>  	  There should be enough spares already present to make the new
>  	  array workable.
>  
> +config MD_RAID456_WORKQUEUE
> +	depends on MD_RAID456
> +	bool "Offload raid work to a workqueue from raid5d"
> +	---help---
> +	  This option enables raid work (block copy and xor operations)
> +	  to run in a workqueue.  If your platform has a high context
> +	  switch penalty say N.  If you are using hardware offload or
> +	  are running on an SMP platform say Y.
> +
> +	  If unsure say, Y.
> +
> +config MD_RAID456_WORKQUEUE_MULTITHREAD
> +	depends on MD_RAID456_WORKQUEUE && SMP
> +	bool "Enable multi-threaded raid processing"
> +	default y
> +	---help---
> +	  This option controls whether the raid workqueue will be multi-
> +	  threaded or single threaded.
> +
> +	  If unsure say, Y.

In the final patch that gets merged, these configuration options should 
go away.  We are very anti-#ifdef in Linux, for a variety of reasons. 
In this particular instance, code complexity increases and 
maintainability decreases as the #ifdef forest grows.

	Jeff



