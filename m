Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVHZSDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVHZSDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVHZSDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:03:24 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:57246 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S965154AbVHZSDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:03:23 -0400
Subject: Re: [PATCH 2/5] Rework stubs in security.h
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tony Jones <tonyj@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050826173151.GA1350@immunix.com>
References: <20050825012028.720597000@localhost.localdomain>
	 <20050825012148.690615000@localhost.localdomain>
	 <20050826173151.GA1350@immunix.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 26 Aug 2005 14:00:56 -0400
Message-Id: <1125079256.8692.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 10:31 -0700, Tony Jones wrote:
> On Wed, Aug 24, 2005 at 06:20:30PM -0700, Chris Wright wrote:
> 
> >  static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
> >  {
> > +#ifdef CONFIG_SECURITY
> >  	return security_ops->ptrace (parent, child);
> > +#else
> > +	return cap_ptrace (parent, child);
> > +#endif
> > +
> >  }

With the third patch applied, it looks like this instead:
static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
{
#ifdef CONFIG_SECURITY
        if (security_ops->ptrace)
                return security_ops->ptrace(parent, child);
#endif
        return cap_ptrace (parent, child);

}

> The discussion about composing with commoncap made me think about whether
> this is the best way to do this.   It seems that we're heading towards a
> requirement that every module internally compose with commoncap.
>   
> 
> If so (apart from the obvious correctness issues when they don't) it's work
> for each module and composing N of them under stacker obviously creates 
> overhead.

Only matters if there are two or more modules that need to be used
together and both need to override/supplement the capability logic for a
given hook.  

> Would the following not be a better approach?
> 
> static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
> {
> int ret;
> 	ret=cap_ptrace (parent, child);
> #ifdef CONFIG_SECURITY
> 	if (!ret && security_ops->ptrace)
> 		ret=security_ops->ptrace(parent, child);
> #endif
> 	return ret;
> }

That makes capability part of the core kernel again, just like DAC,
which means that you can never override a capability denial in your
module.  We sometimes want to override the capability implementation,
not just apply further restrictions after it.  cap_inode_setxattr and
cap_inode_removexattr are examples; they prohibit any access to _all_
security attributes without CAP_SYS_ADMIN, whereas SELinux wants to
allow access to security.selinux if you pass a certain set of its own
permission checks.  vm_enough_memory is another problem area due to vm
accounting handled internally.

> If every module is already internally composing, there shouldn't be a 
> performance cost for the additional branch inside the #ifdef.
> 
> I havn't looked at every single hook and it's users to see if this would
> cause a problem.  I noticed SELinux calls sec->capget() post rather than pre 
> it's processing which may be an issue.

That one isn't so much an issue as the xattr ones and vm_enough_memory
case.  But more generally, if you think about moving toward a place
where one can grant privileges to processes based solely on their
role/domain, you'll need the same ability for capable and other hooks
too.  Naturally, that can't be done safely without a lot more work on
userspace and policy, but it is a long term goal.

-- 
Stephen Smalley
National Security Agency

