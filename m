Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWCIKxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWCIKxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWCIKxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:53:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9858 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750929AbWCIKxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:53:12 -0500
Date: Thu, 9 Mar 2006 02:57:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] capability: Fix bug in checking capabilties in ptrace system call
Message-ID: <20060309105754.GK27645@sorel.sous-sol.org>
References: <728201270603081252v3cb2743dwcb18d99f132cf531@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728201270603081252v3cb2743dwcb18d99f132cf531@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ram Gupta (ram.gupta5@gmail.com) wrote:
> This patch fixes a bug of ptrace for PTRACE_TRACEME request. In this
> case the call is made by the child process & code needs to check the
> capabilty of the parent process to trace the child process but code
> incorrectly makes check for the child process.

Actually, that check is never triggered, for slightly subtle reason.

> Signed-off-by: Ram Gupta <ram.gupta5@gmail.com>
> 
> --- linux-2.6.14-patch-2.6.15/security/commoncap.c.orig Wed Mar  8 13:54:06 2006
> +++ linux-2.6.14-patch-2.6.15/security/commoncap.c      Wed Mar  8 13:57:07 2006
> @@ -59,9 +59,13 @@ int cap_settime(struct timespec *ts, str
>  int cap_ptrace (struct task_struct *parent, struct task_struct *child)
>  {
>         /* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
> -       if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&

In the context of TRACEME, child == current.

Historically, there's been no default security check for TRACEME, so
a change here has some small chance of breaking things (which would
be fine for plugging a real security hole).  Parent less privileged
than child which did TRACEME is a bit of a contrived case, so security
implications aren't so worrisome.  Modules like SELinux will actually
check this case, and should properly restrict.  We can try a change in
-mm for a while.

> -           !capable(CAP_SYS_PTRACE))
> -               return -EPERM;
> +       if (!cap_issubset (child->cap_permitted, current->cap_permitted)){
> +               if(!security_ops->capable(parent,CAP_SYS_PTRACE)){

This is not valid when !CONFIG_SECURITY.

thanks,
-chris
--
