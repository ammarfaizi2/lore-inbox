Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbUCCJpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbUCCJpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:45:21 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:60392 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S262290AbUCCJpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:45:15 -0500
Date: Wed, 3 Mar 2004 10:45:10 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list
Message-ID: <20040303094509.GA8779@cistron.nl>
References: <cistron.B05667366EE6204181EABE9C1B1C0EB50211E5C8@scsmsx401.sc.intel.com> <cistron.20040302211309.500f43fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302211309.500f43fb.akpm@osdl.org>
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
>  And also having looked at Miquel's (currently slightly defective)
>  implementation of the any_congested() API for devicemapper:
> 
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm1/broken-out/queue-congestion-dm-implementation.patch
> 
>  I am thinking that an appropriate way of solving the blk_run_queues() lock
>  contention problem is to nuke the global plug list altogther and make the
>  unplug function a method in struct backing_device_info.
> 
>  This is conceptually the appropriate place to put it - it is almost always
>  the case that when we run blk_run_queues() it is on behalf of an
>  address_space, and the few remaining case can be simply deleted -
>  mm/mempool.c is the last one I think.
> 
>  The implementation of backing_dev_info.unplug() would have to run the
>  unplug_fn of every queue which contributes to the top-level queue (the
>  thing which the address_space is sitting on top of).

But then you need a pointer to the queue. In that case,
you might as well put the congested_fn pointer in the request_queue
too. Then you get something like
https://www.redhat.com/archives/linux-lvm/2004-February/msg00203.html
(though I'd replace "rw" with "bdi_bits" like in the current patch).

Mike.
