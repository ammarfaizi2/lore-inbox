Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWF3Thm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWF3Thm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933148AbWF3Thm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:37:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:5779 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932288AbWF3Thl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:37:41 -0400
Date: Fri, 30 Jun 2006 14:37:30 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] SELinux: Add security hook definition for getioprio and insert hooks
Message-ID: <20060630193730.GC17589@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606291702380.26876@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291702380.26876@d.namei>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@namei.org):
...
> +static int get_task_ioprio(struct task_struct *p)
> +{
> +	int ret;
> +
> +	ret = security_task_getioprio(p);
> +	if (ret)
> +		goto out;
> +	ret = p->ioprio;
> +out:
> +	return ret;
> +}
...
>  			do_each_task_pid(who, PIDTYPE_PGID, p) {
> +				tmpio = get_task_ioprio(p);
> +				if (tmpio < 0)
> +					continue;
>  				if (ret == -ESRCH)
> -					ret = p->ioprio;
> +					ret = tmpio;
>  				else
> -					ret = ioprio_best(ret, p->ioprio);
> +					ret = ioprio_best(ret, tmpio);
...
> + * @task_getioprio
> + *	Check permission before getting the ioprio value of @p.
> + *	@p contains the task_struct of process.
> + *	Return 0 if permission is granted.

A return value >0 is a problem here but isn't mentioned.  the
get_task_ioprio() helper will return the the security_task_getioprio()
return value in htat case, but the do_each_task_pid loop will take it
as a valid return value.

-serge
