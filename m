Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVHZRgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVHZRgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbVHZRgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:36:21 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:20644 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S965139AbVHZRgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:36:21 -0400
Date: Fri, 26 Aug 2005 10:31:51 -0700
From: Tony Jones <tonyj@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH 2/5] Rework stubs in security.h
Message-ID: <20050826173151.GA1350@immunix.com>
References: <20050825012028.720597000@localhost.localdomain> <20050825012148.690615000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825012148.690615000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 06:20:30PM -0700, Chris Wright wrote:

>  static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
>  {
> +#ifdef CONFIG_SECURITY
>  	return security_ops->ptrace (parent, child);
> +#else
> +	return cap_ptrace (parent, child);
> +#endif
> +
>  }

The discussion about composing with commoncap made me think about whether
this is the best way to do this.   It seems that we're heading towards a
requirement that every module internally compose with commoncap.  

If so (apart from the obvious correctness issues when they don't) it's work
for each module and composing N of them under stacker obviously creates 
overhead.

Would the following not be a better approach?

static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
{
int ret;
	ret=cap_ptrace (parent, child);
#ifdef CONFIG_SECURITY
	if (!ret && security_ops->ptrace)
		ret=security_ops->ptrace(parent, child);
#endif
	return ret;
}

If every module is already internally composing, there shouldn't be a 
performance cost for the additional branch inside the #ifdef.

I havn't looked at every single hook and it's users to see if this would
cause a problem.  I noticed SELinux calls sec->capget() post rather than pre 
it's processing which may be an issue.

Tony
