Return-Path: <linux-kernel-owner+w=401wt.eu-S1762448AbWLKFAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762448AbWLKFAR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 00:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762450AbWLKFAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 00:00:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:40397 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762449AbWLKFAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 00:00:15 -0500
Date: Mon, 11 Dec 2006 10:28:31 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-ID: <20061211045830.GB5339@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200612061726.14587.bjorn.helgaas@hp.com> <20061207105148.20410b83.akpm@osdl.org> <20061207113700.dc925068.akpm@osdl.org> <20061208025301.GA11663@in.ibm.com> <20061207205407.b4e356aa.akpm@osdl.org> <20061209102652.GA16607@elte.hu> <20061209114723.138b6e89.akpm@osdl.org> <20061210082616.GB14057@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210082616.GB14057@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 09:26:16AM +0100, Ingo Molnar wrote:
> something like the pseudocode further below - when applied to a data
> structure it has semantics and scalability close to that of
> preempt_disable(), but it is still preemptible and the lock is specific.

Ingo,
	The psuedo-code you have provided can still fail to avoid
the deadlock reported by Bjorn Helgaas earlier in this thread:

	http://lkml.org/lkml/2006/12/6/352

Thread1->flush_workqueue->mutex_lock(cpu4's hotplug_lock)

Thread2(keventd)->run_workqueue->som_work_fn-> ..
		flush_workqueue->mutex_lock(cpu4's hotplug_lock)

Both deadlock with each other.

All this mess could easily be avoided if we implement a reference-count
based cpu_hotplug_lock(), as suggested by Arjan and Linus before and
implemented by Gautham here:

	http://lkml.org/lkml/2006/10/26/65

-- 
Regards,
vatsa
