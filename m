Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753918AbWKGO6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbWKGO6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbWKGO6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:58:54 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:16311 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1753876AbWKGO6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:58:53 -0500
Subject: Re: [PATCH 1/1] security: introduce file posix caps
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       James Morris <jmorris@namei.org>, chris friedhoff <chris@friedhoff.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061107034550.GA13693@sergelap.austin.ibm.com>
References: <20061107034550.GA13693@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 07 Nov 2006 09:56:43 -0500
Message-Id: <1162911403.3009.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 21:45 -0600, Serge E. Hallyn wrote:
> Implement file posix capabilities.  This allows programs to be given
> a subset of root's powers regardless of who runs them, without
> having to use setuid and giving the binary all of root's powers.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index b200b98..ea631ee 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -53,6 +53,10 @@ extern int cap_inode_setxattr(struct den
>  extern int cap_inode_removexattr(struct dentry *dentry, char *name);
>  extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
>  extern void cap_task_reparent_to_init (struct task_struct *p);
> +extern int cap_task_kill(struct task_struct *p, struct siginfo *info, int sig, u32 secid);
> +extern int cap_task_setscheduler (struct task_struct *p, int policy, struct sched_param *lp);
> +extern int cap_task_setioprio (struct task_struct *p, int ioprio);
> +extern int cap_task_setnice (struct task_struct *p, int nice);
>  extern int cap_syslog (int type);
>  extern int cap_vm_enough_memory (long pages);
>  
> @@ -2594,12 +2598,12 @@ static inline int security_task_setgroup
>  
>  static inline int security_task_setnice (struct task_struct *p, int nice)
>  {
> -	return 0;
> +	return cap_task_setnice(p, nice);
>  }
>  
>  static inline int security_task_setioprio (struct task_struct *p, int ioprio)
>  {
> -	return 0;
> +	return cap_task_setioprio(p, ioprio);
>  }
>  
>  static inline int security_task_getioprio (struct task_struct *p)

setscheduler change seems to be missing here.

> @@ -2634,7 +2638,7 @@ static inline int security_task_kill (st
>  				      struct siginfo *info, int sig,
>  				      u32 secid)
>  {
> -	return 0;
> +	return cap_task_kill(p, info, sig, secid);
>  }
>  
>  static inline int security_task_wait (struct task_struct *p)

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 5a5ef5c..0eae004 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> +int cap_task_kill(struct task_struct *p, struct siginfo *info,
> +				int sig, u32 secid)
> +{
> +	if (info != SEND_SIG_NOINFO && (is_si_special(info) || SI_FROMKERNEL(info)))
> +		return 0;
> +
> +	if (secid)
> +		/*
> +		 * Signal sent as a particular user.
> +		 * Capabilities are ignored.  May be wrong, but it's the
> +		 * only thing we can do at the moment.
> +		 * Used only by usb drivers?
> +		 */
> +		return 0;
> +	if (capable(CAP_KILL))
> +		return 0;

This will trigger spurious audit messages; should only be checked if
next test fails.

> +	if (cap_issubset(p->cap_permitted, current->cap_permitted))
> +		return 0;
> +
> +	return -EPERM;
> +}
> +
>  void cap_task_reparent_to_init (struct task_struct *p)
>  {
>  	p->cap_effective = CAP_INIT_EFF_SET;

-- 
Stephen Smalley
National Security Agency

