Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWIAHte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWIAHte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 03:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWIAHtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 03:49:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWIAHtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 03:49:33 -0400
Date: Fri, 1 Sep 2006 00:49:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Hobein <ah2@delair.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
Message-Id: <20060901004920.7643a40e.akpm@osdl.org>
In-Reply-To: <200609010936.39015.ah2@delair.de>
References: <200608312305.47515.ah2@delair.de>
	<200609010936.39015.ah2@delair.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 09:36:38 +0200
Andreas Hobein <ah2@delair.de> wrote:

> On Friday 01 September 2006 03:39, Andrew Morton wrote:
> > I'm unable to identify what patch you're referring to here.  Please be more
> > specific so we can ask the person who developed it.
> 
> I assume the attached patch from Linus Torvalds causes my problem, since the 
> condition was changed from "if (task == current)" to "if (task->tgid == 
> current->tgid)" it breaks my application code. There may be other parts of 
> the ptrace() kernel code that where changed accordingly that I'm not aware. 
> 
> There is also a reply from Roland McGrath (see 
> http://lkml.org/lkml/2005/11/9/460) who mentioned that there may occur some 
> problems in "some real programs out there". May be I'm the first one who is 
> affected by this new behaviour.

When you have names, please cc them..

> To summarise my questions:
> - Why should a thread not be allowed to ptrace_attach to a sibling thread
> - while a forked child of this thread may do this ?
> - Is there any other way to suspend sibling threads at arbitrary points like 
> phread_suspend_np() does for example on AIX?
> 
> Thanks, Andreas
> 
> ---------------------------
> >From torvalds@osdl.org Wed Nov  9 12:04:07 2005
> Date: Wed, 9 Nov 2005 11:37:57 -0800 (PST)
> From: Linus Torvalds <torvalds@osdl.org>
> Subject: Fix ptrace self-attach rule
> 
> Before we did CLONE_THREAD, the way to check whether we were attaching
> to ourselves was to just check "current == task", but with CLONE_THREAD
> we should check that the thread group ID matches instead.
> 
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ---
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 5b8dd98..b88d418 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -155,7 +155,7 @@ int ptrace_attach(struct task_struct *ta
>  	retval = -EPERM;
>  	if (task->pid <= 1)
>  		goto bad;
> -	if (task == current)
> +	if (task->tgid == current->tgid)
>  		goto bad;
>  	/* the same process cannot be attached many times */
>  	if (task->ptrace & PT_PTRACED)
