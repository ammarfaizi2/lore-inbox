Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVADWXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVADWXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVADWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:18:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:34950 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262386AbVADWRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:17:19 -0500
Date: Tue, 4 Jan 2005 14:17:12 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, chrisw@osdl.org,
       sds@epoch.ncsc.mil
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
Message-ID: <20050104141712.E469@build.pdx.osdl.net>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Tue, Jan 04, 2005 at 03:48:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:

I'm fine with this with a few nits.  Although I don't think it will apply
to current bk which has merge error in this area right now.  Stephen,
are you ok with the way this one generates audit messages?

> +	return __vm_enough_memory(pages,
> +			(cap_capable(current, CAP_SYS_ADMIN) == 0));

A temp variable isn't going to be costly and makes it easier to read.

> +	return __vm_enough_memory(pages,
> +			(dummy_capable(current, CAP_SYS_ADMIN) == 0));

same here

> + * Note that secondary_ops->capable and task_has_perm return 0 if
> + * the capability is granted, but __vm_enough_memory requires 1 if
> + * the capability is granted.
>   */
>  static int selinux_vm_enough_memory(long pages)
>  {
> -	unsigned long free, allowed;
> -	int rc;
> +	int rc, cap_sys_admin = 0;
<snip>
> +	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
> +	if (rc == 0)
> +		cap_sys_admin = avc_has_perm_noaudit(tsec->sid, tsec->sid,
> +					SECCLASS_CAPABILITY,
> +					CAP_TO_MASK(CAP_SYS_ADMIN),
> +					NULL);
>  
> -	vm_unacct_memory(pages);
> +	if (rc == 0)
> +		cap_sys_admin = 1;

This sure looks wrong.  Did you mean rc = avc_has_perm_noaudit()?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
