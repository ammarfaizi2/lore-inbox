Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUFXTCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUFXTCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUFXTAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:00:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:58836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264734AbUFXS6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:58:30 -0400
Date: Thu, 24 Jun 2004 11:57:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, limin@engr.sgi.com,
       pwil3058@bigpond.net.au
Subject: Re: [PATCH] Process Aggregates (PAGG) for 2.6.7
Message-ID: <20040624115704.O22989@build.pdx.osdl.net>
References: <Pine.SGI.4.53.0406241239400.340142@subway.americas.sgi.com> <200406241832.i5OIWeq03303@dbear.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200406241832.i5OIWeq03303@dbear.engr.sgi.com>; from limin@dbear.engr.sgi.com on Thu, Jun 24, 2004 at 11:32:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Limin Gu (limin@dbear.engr.sgi.com) wrote:
> Job has not received much feedback from the community yet, we welcome
> any comments/suggestions/criticism for you.

I recall seeing a bunch of syscall looking pieces in job that seemed odd
to be stuck behind a module.

Ah, yes...

> +/* Function prototypes */
> +static int job_sys_create(struct job_create *);
> +static int job_sys_getjid(struct job_getjid *);
> +static int job_sys_waitjid(struct job_waitjid *);
> +static int job_sys_killjid(struct job_killjid *);
> +static int job_sys_getjidcnt(struct job_jidcnt *);
> +static int job_sys_getjidlst(struct job_jidlst *);
> +static int job_sys_getpidcnt(struct job_pidcnt *);
> +static int job_sys_getpidlst(struct job_pidlst *);
> +static int job_sys_getuser(struct job_user *);
> +static int job_sys_getprimepid(struct job_primepid *);
> +static int job_sys_sethid(struct job_sethid *);
> +static int job_sys_detachjid(struct job_detachjid *);
> +static int job_sys_detachpid(struct job_detachpid *);
> +static int job_attach(struct task_struct *, struct pagg *, void *);
> +static void job_detach(struct task_struct *, struct pagg *);
> +static struct job_entry *job_getjob(u64 jid);
> +static int job_syscall(unsigned int, unsigned long);
> +
> +u64 job_getjid(struct task_struct *);
> +
> +int job_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
[snip]
> +/*
> + * job_syscall
> + *
> + * Function to handle job syscall requests.
> + *
> + * Returns 0 on success and -(ERRNO VALUE) upon failure.
> + */
> +int
> +job_syscall(unsigned int request, unsigned long data)

trivial...declared static above.

> +{                 
> +	int rc=0;
> +
> +	DBG_PRINTINIT("job_syscall");
> +
> +	DBG_PRINTENTRY();
> +
> +	switch (request) {
> +		case JOB_CREATE:
> +			rc = job_sys_create((struct job_create *)data);
> +			break;
> +		case JOB_ATTACH:
> +		case JOB_DETACH:
> +			/* RESERVED */
> +			rc = -EBADRQC;
> +			break;
> +		case JOB_GETJID:
> +			rc = job_sys_getjid((struct job_getjid *)data);
> +			break;
> +		case JOB_WAITJID:
> +			rc = job_sys_waitjid((struct job_waitjid *)data);
> +			break;
> +		case JOB_KILLJID:
> +			rc = job_sys_killjid((struct job_killjid *)data);
> +			break;
> +		case JOB_GETJIDCNT:
> +			rc = job_sys_getjidcnt((struct job_jidcnt *)data);
> +			break;
> +		case JOB_GETJIDLST:
> +			rc = job_sys_getjidlst((struct job_jidlst *)data);
> +			break;
> +		case JOB_GETPIDCNT:
> +			rc = job_sys_getpidcnt((struct job_pidcnt *)data);
> +			break;
> +		case JOB_GETPIDLST:
> +			rc = job_sys_getpidlst((struct job_pidlst *)data);
> +			break;
> +		case JOB_GETUSER:
> +			rc = job_sys_getuser((struct job_user *)data);
> +			break;
> +		case JOB_GETPRIMEPID:
> +			rc = job_sys_getprimepid((struct job_primepid *)data);
> +			break;
> +		case JOB_SETHID:
> +			rc = job_sys_sethid((struct job_sethid *)data);
> +			break;
> +		case JOB_DETACHJID:
> +			rc = job_sys_detachjid((struct job_detachjid *)data);
> +			break;
> +		case JOB_DETACHPID:
> +			rc = job_sys_detachpid((struct job_detachpid *)data);
> +			break;
> +		case JOB_SETJLIMIT:
> +		case JOB_GETJLIMIT:
> +		case JOB_GETJUSAGE:
> +		case JOB_FREE:
> +		default:
> +			rc = -EBADRQC;
> +			break;
> +	}
> +
> +	DBG_PRINTEXIT(rc);
> +	return rc;
> +}
> +
> +
> +/*
> + * job_ioctl
> + *
> + * Function to handle job ioctl call requests.
> + *
> + * Returns 0 on success and -(ERRNO VALUE) upon failure.
> + */
> +int
> +job_ioctl(struct inode *inode, struct file *file, unsigned int request,
> +	  unsigned long data)        
> +{                 
> +	return job_syscall(request, data);
> +}

So, this is really ioctl.  This should be exposed in fs interface, or
the primitives should be promoted to first class syscalls if others can
use this.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
