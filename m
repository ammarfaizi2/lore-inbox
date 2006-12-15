Return-Path: <linux-kernel-owner+w=401wt.eu-S932503AbWLOBB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWLOBB5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWLOBB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:01:57 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:46008 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503AbWLOBB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:01:56 -0500
Date: Thu, 14 Dec 2006 17:02:29 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Zack Weinberg <zackw@panix.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
Message-Id: <20061214170229.d0f06a57.randy.dunlap@oracle.com>
In-Reply-To: <20061215002334.039728000@panix.com>
References: <20061215001639.988521000@panix.com>
	<20061215002334.039728000@panix.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 16:16:41 -0800 Zack Weinberg wrote:

> As suggested by Stephen Smalley: map the various sys_syslog operations
> to a smaller set of privilege codes before calling security modules.
> This patch changes the security module interface!  There should be no
> change in the actual security semantics enforced by dummy, capability,
> nor SELinux (with one exception, clearly marked in sys_syslog).
> 
> Change from previous version of patch: the privilege codes are now
> in linux/security.h instead of linux/klog.h, and use the LSM_* naming
> convention used for other such constants in that file.
> 
> 
> Index: linux-2.6/kernel/printk.c
> ===================================================================
> --- linux-2.6.orig/kernel/printk.c	2006-12-13 16:06:22.000000000 -0800
> +++ linux-2.6/kernel/printk.c	2006-12-13 16:08:30.000000000 -0800
> @@ -164,6 +164,12 @@
>  
>  __setup("log_buf_len=", log_buf_len_setup);
>  
> +#define security_syslog_or_fail(type) do {		\
> +		int error = security_syslog(type);	\
> +		if (error)				\
> +			return error;			\
> +	} while (0)
> +

>From Documentation/CodingStyle:

Things to avoid when using macros:

1) macros that affect control flow: ...


>  /* See linux/klog.h for the command numbers passed as the first argument.  */
>  int do_syslog(int type, char __user *buf, int len)
>  {
> @@ -172,16 +178,15 @@
>  	char c;
>  	int error = 0;
>  
> -	error = security_syslog(type);
> -	if (error)
> -		return error;
> -
>  	switch (type) {
>  	case KLOG_CLOSE:
> +		security_syslog_or_fail(LSM_KLOG_READ);
>  		break;
>  	case KLOG_OPEN:
> +		security_syslog_or_fail(LSM_KLOG_READ);
>  		break;
>  	case KLOG_READ:
> +		security_syslog_or_fail(LSM_KLOG_READ);
>  		error = -EINVAL;
>  		if (!buf || len < 0)
>  			goto out;
> @@ -213,9 +218,11 @@
>  			error = i;
>  		break;
>  	case KLOG_READ_CLEAR_HIST:
> +		security_syslog_or_fail(LSM_KLOG_CLEARHIST);
>  		do_clear = 1;
>  		/* FALL THRU */
>  	case KLOG_READ_HIST:
> +		security_syslog_or_fail(LSM_KLOG_READHIST);
>  		error = -EINVAL;
>  		if (!buf || len < 0)
>  			goto out;
> @@ -269,15 +276,19 @@
>  		}
>  		break;
>  	case KLOG_CLEAR_HIST:
> +		security_syslog_or_fail(LSM_KLOG_CLEARHIST);
>  		logged_chars = 0;
>  		break;
>  	case KLOG_DISABLE_CONSOLE:
> +		security_syslog_or_fail(LSM_KLOG_CONSOLE);
>  		console_loglevel = minimum_console_loglevel;
>  		break;
>  	case KLOG_ENABLE_CONSOLE:
> +		security_syslog_or_fail(LSM_KLOG_CONSOLE);
>  		console_loglevel = default_console_loglevel;
>  		break;
>  	case KLOG_SET_CONSOLE_LVL:
> +		security_syslog_or_fail(LSM_KLOG_CONSOLE);
>  		error = -EINVAL;
>  		if (len < 1 || len > 8)
>  			goto out;
> @@ -287,9 +298,18 @@
>  		error = 0;
>  		break;
>  	case KLOG_GET_UNREAD:
> +		security_syslog_or_fail(LSM_KLOG_READ);
>  		error = log_end - log_start;
>  		break;


---
~Randy
