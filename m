Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVCJBy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVCJBy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVCJBuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:50:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:29901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262705AbVCJBe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:34:26 -0500
Date: Wed, 9 Mar 2005 17:33:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050309173351.0d69de25.akpm@osdl.org>
In-Reply-To: <200503100111.j2A1BBg27931@unix-os.sc.intel.com>
References: <20050309144458.2cbc554e.akpm@osdl.org>
	<200503100111.j2A1BBg27931@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Andrew Morton wrote on Wednesday, March 09, 2005 2:45 PM
>  > >
>  > > > Did you generate a kernel profile?
>  > >
>  > >  Top 40 kernel hot functions, percentage is normalized to kernel utilization.
>  > >
>  > >  _spin_unlock_irqrestore		23.54%
>  > >  _spin_unlock_irq			19.27%
>  >
>  > Cripes.
>  >
>  > Is that with CONFIG_PREEMPT?  If so, and if you disable CONFIG_PREEMPT,
>  > this cost should be accounting the the spin_unlock() caller and we can see
>  > who the culprit is.   Perhaps dio->bio_lock.
> 
>  CONFIG_PREEMPT is off.
> 
>  Sorry for all the confusion, I probably shouldn't post the first profile
>  to confuse people.  See 2nd profile that I posted earlier (copied here again).
> 
>  scsi_request_fn		7.54%
>  finish_task_switch	6.25%
>  __blockdev_direct_IO	4.97%
>  __make_request		3.87%
>  scsi_end_request		3.54%
>  dio_bio_end_io		2.70%
>  follow_hugetlb_page	2.39%
>  __wake_up			2.37%
>  aio_complete		1.82%

What are these percentages?  Total CPU time?  The direct-io stuff doesn't
look too bad.  It's surprising that tweaking the direct-io submission code
makes much difference.

hm.  __blockdev_direct_IO() doesn't actually do much.  I assume your damn
compiler went and inlined direct_io_worker() on us.

