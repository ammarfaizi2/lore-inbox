Return-Path: <linux-kernel-owner+w=401wt.eu-S1751346AbXAIMRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbXAIMRv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 07:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXAIMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 07:17:51 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:51685 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbXAIMRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 07:17:50 -0500
Date: Tue, 9 Jan 2007 13:17:38 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Benjamin Gilbert <bgilbert@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org, vatsa@in.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Gautham shenoy <ego@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Failure to release lock after CPU hot-unplug canceled
Message-ID: <20070109121738.GC9563@osiris.boeblingen.de.ibm.com>
References: <20070108120719.16d4674e.bgilbert@cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108120719.16d4674e.bgilbert@cs.cmu.edu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 12:07:19PM -0500, Benjamin Gilbert wrote:
> If a module returns NOTIFY_BAD to a CPU_DOWN_PREPARE callback, subsequent
> attempts to take a CPU down cause the write into sysfs to wedge.
> 
> This is reproducible in 2.6.20-rc4, but was originally found in 2.6.18.5.
> 
> Steps to reproduce:
> 
> 1.  Load the test module included below
> 2.  Run the following shell commands as root:
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> The second echo command hangs in uninterruptible sleep during the write()
> call, and the following appears in dmesg:
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.20-rc4-686 #1
> -------------------------------------------------------
> bash/1699 is trying to acquire lock:
>  (cpu_add_remove_lock){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f
> 
> but task is already holding lock:
>  (workqueue_mutex){--..}, at: [<c03791eb>] mutex_lock+0x1c/0x1f
> 
> which lock already depends on the new lock.

There is something like this

raw_notifier_call_chain(&cpu_chain, CPU_DOWN_FAILED, (void *)(long)cpu);

missing in kernel cpu.c in _cpu_down() in case CPU_DOWN_PREPARE
returned with NOTIFY_BAD. However... this reveals that there is just a
more fundamental problem.

The workqueue code grabs a lock on CPU_[UP|DOWN]_PREPARE and releases it
again on CPU_DOWN_FAILED/CPU_UP_CANCELED. If something in the callchain
returns NOTIFY_BAD the rest of the entries in the callchain won't be
called anymore. But DOWN_FAILED/UP_CANCELED will be called for every
entry.
So we might even end up with a mutex_unlock(&workqueue_mutex) even if
mutex_lock(&workqueue_mutex) hasn't been called...

Maybe this will be addressed by somebody else since cpu hotplug locking
is being worked on (again).
