Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUDSMMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbUDSMMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:12:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57259 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264379AbUDSMM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:12:29 -0400
Date: Mon, 19 Apr 2004 14:12:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Warren Togami <wtogami@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
Message-ID: <20040419121225.GT1966@suse.de>
References: <4083BA03.1090606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4083BA03.1090606@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2004, Warren Togami wrote:
> Test Systems:
> x86 AMD Duron with PM3754 DPT controller, Two disks
> x86-64 2x Opteron with ASR-3010S Adaptec controller, Four disks
> 
> Software:
> Gentoo 1.4.3.13 x86 with gcc-3.3.2
> Fedora Core 2 x86-64 development with gcc-3.3.3-7
> 
> The i2o_block driver currently in kernel-2.6.5 has a problem when there
> is more than one logical block device on the I2O controller. Two or
> more devices causes kernel memory corruption,[1] sometimes accompanied
> by an oops, sometimes fatally in IRQ context and livelocks. In SMP mode
> this tended to cause panic=5 reboot to fail.
> 
> http://lwn.net/Articles/58199/
> Markus finally figured out what was going wrong when he read in this LWN
> article that in the 2.6 kernel, the generic block layer handles
> partition code and there is almost nothing the individual drivers have
> to do. The attached patch from Markus removes this unused partition
> logic and seemed to make things work extremely well.
> 
> After some testing we began to realize why the kernel memory corruption
> that we saw with 2 or more block arrays was happening. The first array
> always had a valid partition table, while second and more arrays never
> did after they were split from the original single large array. The
> unused partition logic was copying the corrupted partition table from
> the 2nd and higher arrays into kernel memory, causing the trouble in
> kernel-2.6.5.
> 
> Subsequent testing was going extremely well, with simultaneous heavy
> disk usage on two I2O block devices with bonnie++ going stable. We then
> chopped the controller into four I2O block devices, but unfortunately
> this ran us into trouble. bonnie++ on three devices simultaneously
> would panic. Below is a photo of the call trace from this panic.
> 
> http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.jpg
> 
> I noticed that the call trace contained "cfq_next_request", so I was
> curious what would happened if we changed to the deadline scheduler.
> Booted with the same kernel but with "elevator=deadline". To our
> surprise, bonnie++ ran simultaneously on all four I2O block devices
> without crashing the server. For another test we tried "elevator=as"
> and it too remained stable.
> 
> Possible CFQ I/O scheduler problem?

That looks pretty damn strange. Any chance you can capture a full oops,
with a serial console or similar?

A quick look at i2o_block doesn't show anything that should cause this.
There are a number of request handling badnesses in there, though:

- kill check fo RQ_INACTIVE, it's pointless. even if it wasn't, the
  inactive check return is buggy.

- you must not just clear req->waiting! remove that code.

- ->queue_depth should not be an expensive atomic type, you have the
  device lock when you look at/inc/dec it.

>  	/*
> +	 *	Set up the queue
> +	 */
> +	for(i = 0; i < MAX_I2O_CONTROLLERS; i++)
> +	{
> +		i2ob_queues[i] = NULL;
> +		i2ob_init_iop(i);
> +	}

Only initialize queues that will be used. Each allocated but unusued
queues wastes memory.

-- 
Jens Axboe

