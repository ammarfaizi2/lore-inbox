Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWHRUQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWHRUQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWHRUQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:16:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1460 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932496AbWHRUQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:16:53 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 4/7] UBC: syscalls (user interface)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E33C3F.3010509@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Aug 2006 13:13:34 -0700
Message-Id: <1155932014.26155.78.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 19:39 +0400, Kirill Korotaev wrote:

<snip>

> +/*
> + *	The setbeanlimit syscall
> + */
> +asmlinkage long sys_setublimit(uid_t uid, unsigned long resource,
> +		unsigned long *limits)
> +{
> +	int error;
> +	unsigned long flags;
> +	struct user_beancounter *ub;
> +	unsigned long new_limits[2];
> +
> +	error = -EPERM;
> +	if(!capable(CAP_SYS_RESOURCE))
> +		goto out;
> +
> +	error = -EINVAL;
> +	if (resource >= UB_RESOURCES)
> +		goto out;
> +
> +	error = -EFAULT;
> +	if (copy_from_user(&new_limits, limits, sizeof(new_limits)))
> +		goto out;
> +
> +	error = -EINVAL;
> +	if (new_limits[0] > UB_MAXVALUE || new_limits[1] > UB_MAXVALUE)
> +		goto out;
> +
> +	error = -ENOENT;
> +	ub = beancounter_findcreate(uid, NULL, 0);
> +	if (ub == NULL)
> +		goto out;
> +
> +	spin_lock_irqsave(&ub->ub_lock, flags);
> +	ub->ub_parms[resource].barrier = new_limits[0];
> +	ub->ub_parms[resource].limit = new_limits[1];

>From my understanding it appear that barrier <= limit. But, the check is
missing here.
> +	spin_unlock_irqrestore(&ub->ub_lock, flags);
> +
> +	put_beancounter(ub);
> +	error = 0;
> +out:
> +	return error;
> +}
> +#endif
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


