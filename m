Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWGAA0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWGAA0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWGAA0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:26:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36262 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751189AbWGAA0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:26:53 -0400
Date: Fri, 30 Jun 2006 19:26:04 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] SELinux: Add security hook definition for getioprio and insert hooks
Message-ID: <20060701002604.GB18972@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606291702380.26876@d.namei> <20060630193730.GC17589@sergelap.austin.ibm.com> <1151697500.29428.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151697500.29428.71.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Fri, 2006-06-30 at 14:37 -0500, Serge E. Hallyn wrote:
> > Quoting James Morris (jmorris@namei.org):
> > ...
> > > +static int get_task_ioprio(struct task_struct *p)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = security_task_getioprio(p);
> > > +	if (ret)
> > > +		goto out;
> > > +	ret = p->ioprio;
> > > +out:
> > > +	return ret;
> > > +}
> > ...
> > >  			do_each_task_pid(who, PIDTYPE_PGID, p) {
> > > +				tmpio = get_task_ioprio(p);
> > > +				if (tmpio < 0)
> > > +					continue;
> > >  				if (ret == -ESRCH)
> > > -					ret = p->ioprio;
> > > +					ret = tmpio;
> > >  				else
> > > -					ret = ioprio_best(ret, p->ioprio);
> > > +					ret = ioprio_best(ret, tmpio);
> > ...
> > > + * @task_getioprio
> > > + *	Check permission before getting the ioprio value of @p.
> > > + *	@p contains the task_struct of process.
> > > + *	Return 0 if permission is granted.
> > 
> > A return value >0 is a problem here but isn't mentioned.  the
> > get_task_ioprio() helper will return the the security_task_getioprio()
> > return value in htat case, but the do_each_task_pid loop will take it
> > as a valid return value.
> 
> True, but that isn't limited to that hook - think what happens if
> inode_permission returns an arbitrary positive integer. 

Well I don't know whether it's worth fixing for all of the lsm hooks,
maybe it is.  But in this case in particular there is just no reason for
it, and the fix is trivial...   Just switch the quoted parts to:

> +static int get_task_ioprio(struct task_struct *p)
> +{
> +	int ret;
> +
> +	ret = security_task_getioprio(p);
> +	if (ret<0)
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
> + *	Return <0 if permission is denied, 0 if granted.

I'm not saying I'd expect this to be triggered, since most kernel and
lsm coders wouldn't think of returning >0 for error in any case...  Yet
you never know.  And again, there's just no reason for it.

-serge
