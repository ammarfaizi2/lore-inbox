Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUEMTkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUEMTkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbUEMTjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:39:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:23497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264515AbUEMTaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:30:10 -0400
Date: Thu, 13 May 2004 12:29:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.6.6-mm2
Message-Id: <20040513122940.0d281f52.akpm@osdl.org>
In-Reply-To: <20040513121850.B22989@build.pdx.osdl.net>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<20040513114520.A8442@infradead.org>
	<20040513035134.2e9013ea.akpm@osdl.org>
	<20040513121850.B22989@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > > +hugetlb_shm_group-sysctl-gid-0-fix.patch
> > > > 
> > > >  Don't make gid 0 special for hugetlb shm.
> > > 
> > > As Oracle has agreed on fixing their DB to use hugetlbfs could we
> > > please stop doctoring around on this broken patch and revert it.
> > 
> > Once I'm convinced that kernel.org kernels will be able to run applications
> > which vendor kernels will run, sure.
> 
> What about something that's just simple and generic?  This is similar to
> Andrea's disable_cap_mlock patch and the disabling capabilities patch
> that wli produced back in that thread.  It would remove the hack, and
> buy us some time to find better solutions.  Downside of course (as all
> of these have) is reduced security value.


-ENODOCCO.

I assume one does

	modprobe capability mask=32768

and this squashes CAP_IPC_LOCK system-wide?

> Against -mm2, thoughts?

Seems feasible, thanks.  It replaces /proc/sys/vm/disable-mlock.

What does Andrea think?

> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> 
> 
> --- linux-2.6.6-mm2/security/capability.c	2004-05-13 11:19:44.000000000 -0700
> +++ linux-2.6.6-mm2-cap_mask_disable/security/capability.c	2004-05-13 12:01:04.167511552 -0700
> @@ -24,12 +24,24 @@
>  #include <linux/ptrace.h>
>  #include <linux/moduleparam.h>
>  
> +static int capability_mask;
> +module_param_named(mask, capability_mask, int, 0);
> +MODULE_PARM_DESC(mask, "Mask of capability checks to ignore");
> +
> +static int capability_capable(struct task_struct *task, int cap)
> +{
> +	if (CAP_TO_MASK(cap) & capability_mask)
> +		return 0;
> +	else
> +		return cap_capable(task, cap);
> +}
> +
>  static struct security_operations capability_ops = {
>  	.ptrace =			cap_ptrace,
>  	.capget =			cap_capget,
>  	.capset_check =			cap_capset_check,
>  	.capset_set =			cap_capset_set,
> -	.capable =			cap_capable,
> +	.capable =			capability_capable,
>  	.netlink_send =			cap_netlink_send,
>  	.netlink_recv =			cap_netlink_recv,
>  
