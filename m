Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbVLXAOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbVLXAOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 19:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161148AbVLXAOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 19:14:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44178 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161145AbVLXAOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 19:14:20 -0500
Date: Fri, 23 Dec 2005 16:13:47 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       nippung@calsoftinc.com
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded
 process at getrusage()
In-Reply-To: <20051223231549.GA3848@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0512231605390.14255@schroedinger.engr.sgi.com>
References: <20051221182320.GA4514@localhost.localdomain>
 <Pine.LNX.4.62.0512211209300.2829@schroedinger.engr.sgi.com>
 <20051221211135.GB4514@localhost.localdomain>
 <Pine.LNX.4.62.0512211318070.3443@schroedinger.engr.sgi.com>
 <20051223231549.GA3848@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please put the copy_to_user() invocation into sys_getrusage. That is the 
only function that needs to deal with user space issues includding 
the transfer of the contents of struct rusage. Define 
a local rusage in sys_getrusage. Pass that address to the other functions
and only copy on success to user space.

copy_to_user occurs repeatedly:

On Fri, 23 Dec 2005, Ravikiran G Thirumalai wrote:


>  	if (unlikely(!p->signal))
> -		return;
> +		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
>  
> +	cputime_to_timeval(utime, &r.ru_utime);
> +	cputime_to_timeval(stime, &r.ru_stime);
> +
> +	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> +}
> +
> +
> +	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
>  }
>  
> +	if (unlikely(!p->signal))
> +		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> +

But its  only needed here:

>  asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
>  {
> -	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
> -		return -EINVAL;
> -	return getrusage(current, who, ru);
> +	switch (who) {
> +		case RUSAGE_SELF:
> +			return getrusage_self(ru);
> +		case RUSAGE_CHILDREN:
> +			return getrusage_children(ru);
> +		default:
> +			break;
> +	}
> +	return -EINVAL;
>  }
