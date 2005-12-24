Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVLXFfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVLXFfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 00:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVLXFfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 00:35:00 -0500
Received: from calsoftinc.com ([64.62.215.98]:20453 "HELO calsoftinc.com")
	by vger.kernel.org with SMTP id S932506AbVLXFfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 00:35:00 -0500
Message-Id: <1135402488.3684@cyclone.he.net>
Date: Fri, 23 Dec 2005 21:34:48 -0800
From: "Nippun Goel" <nippung@calsoftinc.com>
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Nippun Goel <nippung@calsoftinc.com>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threaded process at getrusage()
X-Mailer: WebMail 1.25
X-IPAddress: 59.95.2.67
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/24/05, Christoph Lameter <clameter@engr.sgi.com> wrote:
> Please put the copy_to_user() invocation into sys_getrusage. That is the 
> only function that needs to deal with user space issues includding 
> the transfer of the contents of struct rusage. Define 
> a local rusage in sys_getrusage. Pass that address to the other functions
> and only copy on success to user space.

rusage_both is called at various places in exit.c, all of which are in
turn called from sys_wait4 through do_wait. They pass a user space
rusage struct pointer and expect the results to be copied there.
Similarly, rusage_self and rusage_children are called from sysirix.c
which also seemingly passes a user space pointer to them. Hence, the
copy to user in all three functions.

n.

 
> copy_to_user occurs repeatedly:
> 
> On Fri, 23 Dec 2005, Ravikiran G Thirumalai wrote:
> 
> 
> >  	if (unlikely(!p->signal))
> > -		return;
> > +		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> >  
> > +	cputime_to_timeval(utime, &r.ru_utime);
> > +	cputime_to_timeval(stime, &r.ru_stime);
> > +
> > +	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> > +}
> > +
> > +
> > +	return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> >  }
> >  
> > +	if (unlikely(!p->signal))
> > +		 return copy_to_user(ru, &r, sizeof(r)) ? -EFAULT : 0;
> > +
> 
> But its  only needed here:
> 
> >  asmlinkage long sys_getrusage(int who, struct rusage __user *ru)
> >  {
> > -	if (who != RUSAGE_SELF && who != RUSAGE_CHILDREN)
> > -		return -EINVAL;
> > -	return getrusage(current, who, ru);
> > +	switch (who) {
> > +		case RUSAGE_SELF:
> > +			return getrusage_self(ru);
> > +		case RUSAGE_CHILDREN:
> > +			return getrusage_children(ru);
> > +		default:
> > +			break;
> > +	}
> > +	return -EINVAL;
> >  }
> 
> 


