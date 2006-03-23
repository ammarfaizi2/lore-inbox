Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWCWDKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWCWDKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWCWDKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:10:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964949AbWCWDKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:10:03 -0500
Date: Wed, 22 Mar 2006 19:06:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
Subject: Re: [PATCH 10 of 18] ipath - support for userspace apps using core
 driver
Message-Id: <20060322190636.667d43c0.akpm@osdl.org>
In-Reply-To: <35c1d2f22ae1e2de483c.1143072303@eng-12.pathscale.com>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	<35c1d2f22ae1e2de483c.1143072303@eng-12.pathscale.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
>  +	/*
>  +	 * This code is present to allow a knowledgeable person to
>  +	 * specify the layout of processes to processors before opening
>  +	 * this driver, and then we'll assign the process to the "closest"
>  +	 * HT-400 to that processor (we assume reasonable connectivity,
>  +	 * for now).  This code assumes that if affinity has been set
>  +	 * before this point, that at most one cpu is set; for now this
>  +	 * is reasonable.  I check for both cpus_empty() and cpus_full(),
>  +	 * in case some kernel variant sets none of the bits when no
>  +	 * affinity is set.  2.6.11 and 12 kernels have all present
>  +	 * cpus set.  Some day we'll have to fix it up further to handle
>  +	 * a cpu subset.  This algorithm fails for two HT-400's connected
>  +	 * in tunnel fashion.  Eventually this needs real topology
>  +	 * information.  There may be some issues with dual core numbering
>  +	 * as well.  This needs more work prior to release.
>  +	 */
>  +	if (!cpus_empty(current->cpus_allowed) &&
>  +	    !cpus_full(current->cpus_allowed)) {
>  +		int ncpus = num_online_cpus(), curcpu = -1;
>  +		for (i = 0; i < ncpus; i++)
>  +			if (cpu_isset(i, current->cpus_allowed)) {
>  +				ipath_cdbg(PROC, "%s[%u] affinity set for "
>  +					   "cpu %d\n", current->comm,
>  +					   current->pid, i);
>  +				curcpu = i;
>  +			}
>  +		if (curcpu != -1) {
>  +			if (npresent) {
>  +				prefunit = curcpu / (ncpus / npresent);
>  +				ipath_dbg("%s[%u] %d chips, %d cpus, "
>  +					  "%d cpus/chip, select unit %d\n",
>  +					  current->comm, current->pid,
>  +					  npresent, ncpus, ncpus / npresent,
>  +					  prefunit);
>  +			}
>  +		}
>  +	}

CPU topology is available in sysfs - it shouild be possible to push policy
decisions like this up to userspace.  If the topology info is insufficient,
we can add to it.

