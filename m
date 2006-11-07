Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753734AbWKGPLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbWKGPLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbWKGPLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:11:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29911 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753734AbWKGPLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:11:00 -0500
Date: Tue, 7 Nov 2006 09:10:20 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       chris friedhoff <chris@friedhoff.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] security: introduce file posix caps
Message-ID: <20061107151020.GA18660@sergelap.austin.ibm.com>
References: <20061107034550.GA13693@sergelap.austin.ibm.com> <1162911403.3009.33.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162911403.3009.33.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Mon, 2006-11-06 at 21:45 -0600, Serge E. Hallyn wrote:
> > Implement file posix capabilities.  This allows programs to be given
> > a subset of root's powers regardless of who runs them, without
> > having to use setuid and giving the binary all of root's powers.
> 
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index b200b98..ea631ee 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -53,6 +53,10 @@ extern int cap_inode_setxattr(struct den
> >  extern int cap_inode_removexattr(struct dentry *dentry, char *name);
> >  extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
> >  extern void cap_task_reparent_to_init (struct task_struct *p);
> > +extern int cap_task_kill(struct task_struct *p, struct siginfo *info, int sig, u32 secid);
> > +extern int cap_task_setscheduler (struct task_struct *p, int policy, struct sched_param *lp);
> > +extern int cap_task_setioprio (struct task_struct *p, int ioprio);
> > +extern int cap_task_setnice (struct task_struct *p, int nice);
> >  extern int cap_syslog (int type);
> >  extern int cap_vm_enough_memory (long pages);
> >  
> > @@ -2594,12 +2598,12 @@ static inline int security_task_setgroup
> >  
> >  static inline int security_task_setnice (struct task_struct *p, int nice)
> >  {
> > -	return 0;
> > +	return cap_task_setnice(p, nice);
> >  }
> >  
> >  static inline int security_task_setioprio (struct task_struct *p, int ioprio)
> >  {
> > -	return 0;
> > +	return cap_task_setioprio(p, ioprio);
> >  }
> >  
> >  static inline int security_task_getioprio (struct task_struct *p)
> 
> setscheduler change seems to be missing here.

I'm confused - my kernel version already had selinux_task_setscheduler()
calling a secondary_ops->task_setscheduler().

I don't know where that came from then.

> > @@ -2634,7 +2638,7 @@ static inline int security_task_kill (st
> >  				      struct siginfo *info, int sig,
> >  				      u32 secid)
> >  {
> > -	return 0;
> > +	return cap_task_kill(p, info, sig, secid);
> >  }
> >  
> >  static inline int security_task_wait (struct task_struct *p)
> 
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 5a5ef5c..0eae004 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > +int cap_task_kill(struct task_struct *p, struct siginfo *info,
> > +				int sig, u32 secid)
> > +{
> > +	if (info != SEND_SIG_NOINFO && (is_si_special(info) || SI_FROMKERNEL(info)))
> > +		return 0;
> > +
> > +	if (secid)
> > +		/*
> > +		 * Signal sent as a particular user.
> > +		 * Capabilities are ignored.  May be wrong, but it's the
> > +		 * only thing we can do at the moment.
> > +		 * Used only by usb drivers?
> > +		 */
> > +		return 0;
> > +	if (capable(CAP_KILL))
> > +		return 0;
> 
> This will trigger spurious audit messages; should only be checked if
> next test fails.
> 

I see, will swap, thanks.

> > +	if (cap_issubset(p->cap_permitted, current->cap_permitted))
> > +		return 0;
> > +
> > +	return -EPERM;
> > +}
> > +
> >  void cap_task_reparent_to_init (struct task_struct *p)
> >  {
> >  	p->cap_effective = CAP_INIT_EFF_SET;
> 
> -- 
> Stephen Smalley
> National Security Agency
