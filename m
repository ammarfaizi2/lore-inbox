Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVADWTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVADWTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVADWTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:19:19 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:17387 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262385AbVADWQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:16:33 -0500
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>
In-Reply-To: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1104876635.20724.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 17:10:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 16:48, Serge E. Hallyn wrote:
> The attached patch introduces a __vm_enough_memory function in
> security/security.c which is used by cap_vm_enough_memory,
> dummy_vm_enough_memory, and selinux_vm_enough_memory.  This has
> been discussed on the lsm mailing list.

> + * Note that secondary_ops->capable and task_has_perm return 0 if
> + * the capability is granted, but __vm_enough_memory requires 1 if
> + * the capability is granted.

Should be avc_has_perm_noaudit, right?

> +	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
> +	if (rc == 0)
> +		cap_sys_admin = avc_has_perm_noaudit(tsec->sid, tsec->sid,
> +					SECCLASS_CAPABILITY,
> +					CAP_TO_MASK(CAP_SYS_ADMIN),
> +					NULL);

Shouldn't this be 'rc = avc_has_perm...'?  And I'd suggest retaining the
comment from the original about why we don't want to audit here.

> -	vm_unacct_memory(pages);
> +	if (rc == 0)
> +		cap_sys_admin = 1;
>  
> -	return -ENOMEM;
> +	return __vm_enough_memory(pages, cap_sys_admin);
>  }

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

