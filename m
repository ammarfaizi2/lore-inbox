Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbUCCJyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUCCJyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:54:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:64991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262320AbUCCJyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:54:50 -0500
Date: Wed, 3 Mar 2004 01:54:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: per-cpu blk_plug_list
Message-Id: <20040303015448.749a87d2.akpm@osdl.org>
In-Reply-To: <20040303094509.GA8779@cistron.nl>
References: <cistron.B05667366EE6204181EABE9C1B1C0EB50211E5C8@scsmsx401.sc.intel.com>
	<cistron.20040302211309.500f43fb.akpm@osdl.org>
	<20040303094509.GA8779@cistron.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>
> According to Andrew Morton:
>  >  And also having looked at Miquel's (currently slightly defective)
>  >  implementation of the any_congested() API for devicemapper:
>  > 
>  >  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm1/broken-out/queue-congestion-dm-implementation.patch
>  > 
>  >  I am thinking that an appropriate way of solving the blk_run_queues() lock
>  >  contention problem is to nuke the global plug list altogther and make the
>  >  unplug function a method in struct backing_device_info.
>  > 
>  >  This is conceptually the appropriate place to put it - it is almost always
>  >  the case that when we run blk_run_queues() it is on behalf of an
>  >  address_space, and the few remaining case can be simply deleted -
>  >  mm/mempool.c is the last one I think.
>  > 
>  >  The implementation of backing_dev_info.unplug() would have to run the
>  >  unplug_fn of every queue which contributes to the top-level queue (the
>  >  thing which the address_space is sitting on top of).
> 
>  But then you need a pointer to the queue. In that case,
>  you might as well put the congested_fn pointer in the request_queue
>  too.

It already is.  backing_dev_info is a member of struct request_queue.

> Then you get something like
>  https://www.redhat.com/archives/linux-lvm/2004-February/msg00203.html
>  (though I'd replace "rw" with "bdi_bits" like in the current patch).

Sure.  This is all nice and simple stuff, except for the locking, which
needs serious work.

