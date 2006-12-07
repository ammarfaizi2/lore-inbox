Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031651AbWLGGTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031651AbWLGGTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 01:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031654AbWLGGTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 01:19:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50826 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031651AbWLGGTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 01:19:11 -0500
Date: Thu, 7 Dec 2006 11:47:01 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Myron Stowe <myron.stowe@hp.com>, Jens Axboe <axboe@kernel.dk>,
       Dipankar <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061207061701.GA25744@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200612061726.14587.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061726.14587.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 05:26:14PM -0700, Bjorn Helgaas wrote:
> loadkeys is holding the cpu_hotplug lock (acquired in flush_workqueue())
> and waiting in flush_cpu_workqueue() until the cpu_workqueue drains.
> 
> But events/4 is responsible for draining it, and it is blocked waiting
> to acquire the cpu_hotplug lock.
> 
> In current upstream, the cpu_hotplug lock has been replaced with
> workqueue_mutex, but it looks to me like the same deadlock is still
> possible.

Yes I think so too.

> Is there some rule that workqueue functions shouldn't try to
> flush a workqueue?  

In general, workqueue functions wanting to flush workqueue seems wierd
to me. But in this case, I think the requirement is to block until all
queued work is complete, which is what flush_workqueue is supposed to
do. Hence I dont see any way to avoid it ..

> Or should flush_workqueue() be smarter by
> releasing the workqueue_mutex once in a while?

IMHO, rehauling lock_cpu_hotplug() to support scenarios like this is a
better approach. 

	- Make it rw-sem
	- Make it per-cpu mutex, which could be either:

		http://lkml.org/lkml/2006/11/30/110 - Ingo's suggestion
		http://lkml.org/lkml/2006/10/26/65 - Gautham's work based on RCU

In Ingo's suggestion, I really dont know if the task_struct
modifications is a good thing (to support recursive requirements).
Gautham's patches avoid modifications to task_struct, is fast but can
starve writers (who want to bring down/up a CPU).

-- 
Regards,
vatsa
