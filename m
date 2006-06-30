Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWF3Tzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWF3Tzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWF3Tzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:55:52 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:63958 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751241AbWF3Tzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:55:51 -0400
Subject: Re: [PATCH] SELinux: Add security hook definition for getioprio
	and insert hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       David Quigley <dpquigl@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <20060630193730.GC17589@sergelap.austin.ibm.com>
References: <Pine.LNX.4.64.0606291702380.26876@d.namei>
	 <20060630193730.GC17589@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 30 Jun 2006 15:58:20 -0400
Message-Id: <1151697500.29428.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 14:37 -0500, Serge E. Hallyn wrote:
> Quoting James Morris (jmorris@namei.org):
> ...
> > +static int get_task_ioprio(struct task_struct *p)
> > +{
> > +	int ret;
> > +
> > +	ret = security_task_getioprio(p);
> > +	if (ret)
> > +		goto out;
> > +	ret = p->ioprio;
> > +out:
> > +	return ret;
> > +}
> ...
> >  			do_each_task_pid(who, PIDTYPE_PGID, p) {
> > +				tmpio = get_task_ioprio(p);
> > +				if (tmpio < 0)
> > +					continue;
> >  				if (ret == -ESRCH)
> > -					ret = p->ioprio;
> > +					ret = tmpio;
> >  				else
> > -					ret = ioprio_best(ret, p->ioprio);
> > +					ret = ioprio_best(ret, tmpio);
> ...
> > + * @task_getioprio
> > + *	Check permission before getting the ioprio value of @p.
> > + *	@p contains the task_struct of process.
> > + *	Return 0 if permission is granted.
> 
> A return value >0 is a problem here but isn't mentioned.  the
> get_task_ioprio() helper will return the the security_task_getioprio()
> return value in htat case, but the do_each_task_pid loop will take it
> as a valid return value.

True, but that isn't limited to that hook - think what happens if
inode_permission returns an arbitrary positive integer. 

-- 
Stephen Smalley
National Security Agency

