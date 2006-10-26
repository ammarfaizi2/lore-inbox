Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752082AbWJZIJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWJZIJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 04:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWJZIJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 04:09:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32468 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752082AbWJZIJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 04:09:02 -0400
Date: Thu, 26 Oct 2006 10:09:39 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, greg@kroah.com
Subject: Re: +
 drivers-wait-for-threaded-probes-between-initcall-levels.patch added to -mm
 tree
Message-ID: <20061026100939.24bbf536@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <200610260212.k9Q2CYvw031387@shell0.pdx.osdl.net>
References: <200610260212.k9Q2CYvw031387@shell0.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2006 19:12:01 -0700,
akpm@osdl.org wrote:

> Subject: drivers: wait for threaded probes between initcall levels
> From: Andrew Morton <akpm@osdl.org>
> 
> The multithreaded-probing code has a problem: after one initcall level (eg,
> core_initcall) has been processed, we will then start processing the next
> level (postcore_initcall) while the kernel threads which are handling
> core_initcall are still executing.  This breaks the guarantees which the
> layered initcalls previously gave us.
> 
> IOW, we want to be multithreaded _within_ an initcall level, but not between
> different levels.
> 
> Fix that up by causing the probing code to wait for all outstanding probes at
> one level to complete before we start processing the next level.
> 
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Makes a lot of sense. I guess we could also get rid of
driver_probe_done() in prepare_namespace() with this patch...


> +#ifdef CONFIG_PCI_MULTITHREAD_PROBE
> +static int __init wait_for_probes(void)
> +{
> +	DEFINE_WAIT(wait);
> +
> +	if (!atomic_read(&probe_count))
> +		return 0;
> +	printk(KERN_INFO "%s: waiting for %d threads\n", __FUNCTION__,
> +			atomic_read(&probe_count));
> +	while (atomic_read(&probe_count)) {
> +		prepare_to_wait(&probe_waitqueue, &wait, TASK_UNINTERRUPTIBLE);
> +		if (atomic_read(&probe_count))
> +			schedule();
> +	}
> +	finish_wait(&probe_waitqueue, &wait);
> +	return 0;
> +}
> +
> +core_initcall_sync(wait_for_probes);
> +postcore_initcall_sync(wait_for_probes);
> +arch_initcall_sync(wait_for_probes);
> +subsys_initcall_sync(wait_for_probes);
> +fs_initcall_sync(wait_for_probes);
> +device_initcall_sync(wait_for_probes);
> +late_initcall_sync(wait_for_probes);
> +#endif

...if we get rid of this #ifdef.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
